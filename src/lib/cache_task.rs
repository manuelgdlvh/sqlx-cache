use std::any::Any;
use std::time::{SystemTime, UNIX_EPOCH};

pub enum CacheTask {
    INVALIDATION { exp_time: u128, cache_id: &'static str, key: Box<dyn Any + Send> }
}


impl CacheTask {
    pub fn invalidation(expires_in: u64, cache_id: &'static str, key: Box<dyn Any + Send>) -> CacheTask {
        let exp_time = SystemTime::now().duration_since(UNIX_EPOCH)
            .expect("Time went backwards").as_millis() + expires_in as u128;

        CacheTask::INVALIDATION {
            exp_time,
            cache_id,
            key,
        }
    }
    pub fn expires_in(&self) -> u64 {
        let exp_time = match self {
            CacheTask::INVALIDATION { exp_time, .. } => {
                *exp_time
            }
        };

        (exp_time - SystemTime::now().duration_since(UNIX_EPOCH)
            .expect("Time went backwards").as_millis()) as u64
    }
}




