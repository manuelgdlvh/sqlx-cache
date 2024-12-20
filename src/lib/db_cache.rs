use std::any::Any;
use std::error::Error;
use std::marker::PhantomData;
use std::sync::Arc;
use std::sync::mpsc::Sender;

use dashmap::DashMap;
use sqlx::{ Pool};

use crate::cache_manager::CacheManager;
use crate::cache_task::CacheTask;
use crate::db_cache_config::DbCacheConfig;
use crate::db_commands::DbCommands;

struct CacheEventProcessor<DBC>
where
    DBC: DbCommands + 'static,
{
    db_cache_config: DbCacheConfig,
    tx: Sender<CacheTask>,
    _phantom: PhantomData<DBC>,
}

impl<DBC> CacheEventProcessor<DBC>
where
    DBC: DbCommands + 'static,
{
    pub fn new(db_cache_config: DbCacheConfig, tx: Sender<CacheTask>) -> Self {
        Self { db_cache_config, tx, _phantom: Default::default() }
    }
    pub fn invalidate(&self, key: DBC::Key) {
        let task = CacheTask::invalidation(self.db_cache_config.expires_in(), self.db_cache_config.cache_id(), Box::new(key));
        self.tx.send(task).unwrap();
    }
}

pub struct DbCache<DBC>
where
    DBC: DbCommands + 'static,
{
    db_pool: Pool<DBC::Db>,
    cache_event_processor: CacheEventProcessor<DBC>,
    db_storage: DashMap<DBC::Key, DBC::Value>,
    config: DbCacheConfig,
}

impl<DBC> DbCache<DBC>
where
    DBC: DbCommands + 'static,
{
    pub fn build(cache_manager: &mut CacheManager, config: DbCacheConfig, db_pool: Pool<DBC::Db>) -> Arc<DbCache<DBC>> {
        let self_ = Arc::new(Self {
            db_pool,
            cache_event_processor: CacheEventProcessor::new(config, cache_manager.sender()),
            db_storage: DashMap::default(),
            config,
        });
        cache_manager.register(self_.clone());
        self_
    }
    pub async fn get(&self, key: &DBC::Key) -> Option<DBC::Value> {
        return match self.db_storage.get(key) {
            None => {
                println!("cache miss for #{key} key");
                let val = match DBC::get(&self.db_pool, key).await {
                    None => {
                        return None;
                    }
                    Some(val) => {
                        val
                    }
                };

                self.db_storage.insert(key.clone(), val.clone());
                self.cache_event_processor.invalidate(key.clone());
                Some(val)
            }
            Some(val) => {
                println!("cache hit for #{key} key");
                Some(val.value().clone())
            }
        };
    }


    pub async fn put(&self, key: DBC::Key, value: DBC::Value) -> Result<(), Box<dyn Error + Send + Sync>> {
        DBC::put(&self.db_pool, key.clone(), value.clone()).await?;
        self.db_storage.insert(key, value);
        Ok(())
    }

    pub fn remove(&self, key: &DBC::Key) {
        self.db_storage.remove(key);
    }


    pub fn cache(&self) -> &DashMap<DBC::Key, DBC::Value> {
        &self.db_storage
    }
}


pub trait CacheInvalidator: Send + Sync {
    fn invalidate(&self, key: Box<dyn Any + Send>);
    fn cache_id(&self) -> &'static str;
}


impl<DBC> CacheInvalidator for DbCache<DBC>
where
    DBC: DbCommands,
{
    fn invalidate(&self, key: Box<dyn Any + Send>) {
        let val = match key.downcast::<DBC::Key>() {
            Ok(val) => {
                val
            }
            Err(_) => {
                println!("Error executing invalidation for #{} cache", self.cache_id());

                println!("error");
                return;
            }
        };

        println!("Executing invalidation for #{val} key and #{} cache", self.cache_id());

        self.remove(&val);
    }

    fn cache_id(&self) -> &'static str {
        self.config.cache_id()
    }
}

