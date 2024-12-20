use std::error::Error;
use std::thread;
use std::time::Duration;

use rstest::rstest;
use sqlx::{Pool, Postgres, query, Row};

use lib::cache_manager::CacheManager;
use lib::db_cache::DbCache;
use lib::db_cache_config::DbCacheConfig;
use lib::db_commands::DbCommands;

use crate::containers;

#[derive(Default)]
pub struct GameDbCommands;
impl DbCommands for GameDbCommands {
    type Key = i64;
    type Value = Game;
    type Db = Postgres;

    async fn get(db_pool: &Pool<Self::Db>, key: &Self::Key) -> Option<Self::Value> {
        query("SELECT game_id, name FROM game.game where game_id = $1")
            .bind(key)
            .fetch_one(&*db_pool)
            .await.ok().map(|val| {
            Game::new(val.try_get::<i64, &str>("game_id").unwrap() as u64
                      , val.try_get("name").unwrap())
        })
    }

    async fn put(db_pool: &Pool<Self::Db>, key: Self::Key, value: Self::Value) -> Result<(), Box<dyn Error + Send + Sync>> {
        todo!()
    }
}

#[derive(Clone, Debug)]
pub struct Game {
    id: u64,
    title: String,
}

impl Game {
    pub fn new(id: u64, title: String) -> Self {
        Self { id, title }
    }
}

const INVALIDATION_MARGIN_TIME: u64 = 100;

#[tokio::test]
#[rstest]
#[case(47530, "The Legend of Zelda: Ocarina of Time 3D", 1000)]
#[case(47557, "The Last of Us", 2500)]
#[case(47573, "American Truck Simulator", 5000)]
#[case(47577, "Euro Truck Simulator 2", 10000)]
async fn should_get_successfully(#[case] game_id: i64, #[case] title: &str, #[case] exp_time: u64) {
    let db_pool = containers::get_db_pool().await;
    let mut cache_manager = CacheManager::default();
    let game_repo = DbCache::<GameDbCommands>::build(&mut cache_manager, DbCacheConfig::new("game_repo", exp_time), db_pool);

    cache_manager.start();

    // Cache miss
    assert_eq!(true, game_repo.cache().get(&game_id).is_none());

    let result = game_repo.get(&game_id).await.unwrap();
    assert_eq!(game_id as u64, result.id);
    assert_eq!(title, result.title);

    // Cache hit
    assert_eq!(true, game_repo.cache().get(&game_id).is_some());

    let result = game_repo.get(&game_id).await.unwrap();
    assert_eq!(game_id as u64, result.id);
    assert_eq!(title, result.title);

    // Wait invalidation
    thread::sleep(Duration::from_millis(exp_time as u64 + INVALIDATION_MARGIN_TIME));

    // Cache miss
    assert_eq!(true, game_repo.cache().get(&game_id).is_none());

    let result = game_repo.get(&game_id).await.unwrap();
    assert_eq!(game_id as u64, result.id);
    assert_eq!(title, result.title);
}


#[tokio::test]
#[rstest]
#[case(47530, "The Legend of Zelda: Ocarina of Time 3D", 1000)]
#[case(47557, "The Last of Us", 2500)]
#[case(47573, "American Truck Simulator", 5000)]
#[case(47577, "Euro Truck Simulator 2", 10000)]
async fn should_put_successfully(#[case] game_id: i64, #[case] title: &str, #[case] exp_time: u64) {
    let mut cache_manager = CacheManager::default();
    let game_repo = DbCache::<GameDbCommands>::build(&mut cache_manager, DbCacheConfig::new("game_repo", exp_time), containers::get_db_pool()
        .await);

    cache_manager.start();

}

