use std::error::Error;
use std::fmt::Display;
use std::hash::Hash;

use sqlx::{Database, Pool};

type GenericError = Box<dyn Error + Send + Sync>;

pub trait DbCommands: Default + Send + Sync
{
    type Key: Eq + Hash + Clone + Display + Send + Sync;
    type Value: Clone + Send + Sync;
    type Db: Database;

    async fn get(db_pool: &Pool<Self::Db>, key: &Self::Key) -> Option<Self::Value>;
    async fn put(db_pool: &Pool<Self::Db>, key: Self::Key, value: Self::Value) -> Result<(), GenericError>;
}