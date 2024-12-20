#[derive(Copy, Clone)]
pub struct DbCacheConfig {
    cache_id: &'static str,
    expires_in: u64,
}

impl DbCacheConfig {
    pub fn new(cache_id: &'static str, expires_in: u64) -> Self {
        Self { cache_id, expires_in }
    }
    pub fn expires_in(&self) -> u64 {
        self.expires_in
    }

    pub fn cache_id(&self) -> &'static str {
        self.cache_id
    }
}


