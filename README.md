# SQLX Cache

## Tasks
- [ ] Improve delayed execution of cache events 
- [ ] Change println! calls to Logger trait
- [ ] Add integration tests for PUT operation
- [ ] Add performance tests
- [ ] Add unitary tests
- [ ] Add / Improve observability

## Overview

The SQLX Cache is a caching system designed for efficient storage and retrieval of entities in a database. It leverages the SQLX crate to perform database operations, providing support for both PUT and GET operations. This cache system allows you to set custom expiration times for cache entries, enabling automatic cleanup of expired data to prevent memory bloat and ensure that the cache remains fresh and accurate. The cache management system is flexible and can be integrated into your application to enhance performance by reducing database load and improving response times for frequently accessed data.

Event listeners, such as those for expiration, are implemented through the Cache Manager. This approach uses generic input parameters, when needed, with the Any trait (Cache Task) to handle cache events. The design avoids using an Arc-Inner shareable struct within the DbCache for delayed callbacks, aiming to minimize pointer indirections across all operations. Pointer indirections are introduced only once per cache event (if necessary), based on the assumption that core operations will be more frequent than entry expirations or any future cache events.

## Key Features
1. SQLX Integration: Seamlessly integrates with the SQLX crate for database interactions.
2. Automatic Cache Cleanup: Once an entry expires, it is automatically removed from the cache, maintaining memory efficiency.
3. Declarative Cache Design: Cache configuration is intuitive and allows developers to easily define expiration policies for different types of data.
4. Cache Efficiency: Reduces the need to repeatedly query the database by storing frequently accessed data, leading to faster response times.
    

## How to Use
1. Implement the DbCommands Trait

The first step is to implement the DbCommands trait. This trait should define the essential operations for your specific repository:

    PUT: This operation stores a new entity or updates an existing one in the cache and database.
    GET: This operation retrieves the entity from the cache, if it exists, otherwise it can fetch the data from the database.

The trait ensures that all operations are standardized and consistent across different repositories.

2. Construct a Cache Manager

Once the DbCommands trait is implemented, you need to construct a CacheManager stuct.
The CacheManager is responsible for managing multiple cache repositories and handling events such as entry expiration.

3. Build Your Cache Repositories

For each type of entity you want to cache, you need to create a corresponding repository that leverages the cache system. Each repository should handle the specific operations for the entity, ensuring that put and get operations interact with both the cache and the underlying database in a consistent manner.

Repositories can be easily built using the DbCommands trait, and you can define custom expiration policies based on the entity type (for example, a short-lived session cache or a longer-lived configuration data cache).

4. Start the Cache Manager

Once the cache repositories are built, you can start the CacheManager. It will initialize and begin managing cache operations for all the repositories that have been registered. The CacheManager will automatically handle cache expiration according to the rules you have set.


## Example of usage
In the Integration Tests folder, you can find examples demonstrating how to implement a cached repository using this crate, as well as how the caching mechanism works in practice. The tests showcase various scenarios, such as storing and retrieving data from the cache, handling cache expiration, and verifying cache misses when data is not found.
