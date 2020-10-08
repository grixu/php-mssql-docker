# PHP7.4-FPM 

It's prepared Docker image of `php-fpm` in latest stable version.

## Modules:
* opcache
* PDO (Mysql)
* Mbstring
* exif
* curl
* bcmath
* pcntl
* redis
* gd
* gmp
* imagick
* intl
* zip

## Extra software:
* composer

## Custom settings

### Via args:
* **user_uid** - nginx user UID (default: *1001*)
* **group_gid** - nginx group GID (default: *1001*)
* **port** - port for www pool (default: *8999*)

### Via env variables
* PHP_OPCACHE_VALIDATE_TIMESTAMPS
* PHP_OPCACHE_MAX_ACCELERATED_FILES
* PHP_OPCACHE_MEMORY_CONSUMPTION
* PHP_OPCACHE_MAX_WASTED_PERCENTAGE
* PHP_MAX_UPLOAD
* PHP_RESTART_TRESHOLD
* PHP_RESTART_INTERVAL
* PHP_CONTROL_TIMEOUT
* PHP_PM_MODE
* PHP_PM_MAX_CHILDREN
* PHP_PM_START_SERVERS
* PHP_PM_MIN_SPARE_SERVERS
* PHP_PM_MAX_SPARE_SERVERS
* PHP_PM_MAX_REQUESTS