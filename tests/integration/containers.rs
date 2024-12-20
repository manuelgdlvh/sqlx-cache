use std::env;
use std::error::Error;
use std::sync::LazyLock;
use std::time::Duration;

use ctor::{ctor, dtor};
use sqlx::{Pool, Postgres};
use sqlx::postgres::PgPoolOptions;
use testcontainers::{Container, GenericImage, ImageExt};
use testcontainers::core::{ IntoContainerPort, Mount, WaitFor};
use testcontainers::core::logs::LogSource;
use testcontainers::core::wait::LogWaitStrategy;
use testcontainers::runners::SyncRunner;

pub const CONFIG_FOLDER_PATH: &str = "/tests/integration/config";
pub const INIT_SQL_PATH: &str = "/db/init.sql";
pub const CONTAINER_PATH: &str = "/docker-entrypoint-initdb.d/init.sql";


pub static POSTGRES_CONTAINER: LazyLock<Container<GenericImage>> = LazyLock::new(|| {
    let current_dir = env::current_dir().expect("Get Current Dir");
    let current_dir_str = current_dir.to_str().expect("Get Current Dir as Str");

    let container = GenericImage::new("postgres", "latest")
        .with_wait_for(WaitFor::Log(LogWaitStrategy::new(LogSource::StdOut, "PostgreSQL init process complete; ready for start up.")))
        .with_wait_for(WaitFor::Duration { length: Duration::from_secs(1) })
        .with_exposed_port(5432.tcp())
        .with_env_var("POSTGRES_USER", "postgres")
        .with_env_var("POSTGRES_PASSWORD", "postgres")
        .with_env_var("POSTGRES_DB", "postgres")
        .with_mount(Mount::bind_mount(format!("{}{CONFIG_FOLDER_PATH}{INIT_SQL_PATH}", current_dir_str), CONTAINER_PATH))
        .start().expect("Postgres started");

    unsafe {
        POSTGRES_CONTAINER_HOST = container.get_host().expect("Get Postgres Container Port Host").to_string();
        POSTGRES_CONTAINER_PORT = container.get_host_port_ipv4(5432).expect("Get Postgres Container Port retrieved");
    }

    container
});

static mut POSTGRES_CONTAINER_HOST: String = String::new();
static mut POSTGRES_CONTAINER_PORT: u16 = 5432;


#[ctor]
fn init() {
    let _ = &*POSTGRES_CONTAINER;
}


pub async fn get_db_pool() -> Pool<Postgres> {
    let (host, port) = unsafe {
        (POSTGRES_CONTAINER_HOST.to_string(), POSTGRES_CONTAINER_PORT)
    };

    let conn_info = format!(
        "postgres://{}:{}@{}:{}/{}",
        "postgres",
        "postgres",
        host,
        port,
        "postgres"
    );
    PgPoolOptions::new()
        .max_connections(1)
        .min_connections(1)
        .connect(conn_info.as_str())
        .await.expect("Get Database pool")
}


#[dtor]
fn destroy() {
    //(&*POSTGRES_CONTAINER).stop();
}








