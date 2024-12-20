use std::collections::HashMap;
use std::sync::{Arc, mpsc};
use std::thread;
use std::time::Duration;

use crate::cache_task::CacheTask;
use crate::db_cache::CacheInvalidator;

pub struct CacheManager {
    invalidators: HashMap<&'static str, Arc<dyn CacheInvalidator>>,
    rx: mpsc::Receiver<CacheTask>,
    tx: mpsc::Sender<CacheTask>,
}


impl Default for CacheManager {
    fn default() -> Self {
        let (tx, rx) = mpsc::channel();
        Self { invalidators: HashMap::default(), rx, tx }
    }
}

impl CacheManager {
    pub fn register<T>(&mut self, invalidator: Arc<T>)
    where
        T: CacheInvalidator + 'static,
    {
        if self.invalidators.contains_key(invalidator.cache_id()) {
            panic!("#{} cache currently registered!", invalidator.cache_id());
        }
        self.invalidators.insert(invalidator.cache_id(), invalidator);
    }

    pub fn sender(&self) -> mpsc::Sender<CacheTask> {
        self.tx.clone()
    }

    pub fn start(self) {
        thread::spawn(move || {
            while let Ok(task) = self.rx.recv() {
                if task.expires_in() > 0 {
                    thread::sleep(Duration::from_millis(task.expires_in()));
                }

                match task {
                    CacheTask::INVALIDATION { cache_id, key, .. } => {
                        if let Some(task) = self.invalidators.get(cache_id) {
                            task.invalidate(key);
                        }
                    }
                }
            }
        });
    }
}






