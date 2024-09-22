# Development setup scripts and instructions.

## Ubuntu

### System setup
The following script installs php8.1, composer, mariadb-server + user and creates a ssh key pair.
* ``./scripts/install.sh <system_name> <username/email> <db_username> <db_name> [php_version = 8.1]``
#### Packages
* git
* curl
* wget
* mariadb-server
* openssl
* PHP, extensions: curl, yaml, dom, xdebug, mysql, mbstring, xml
* Composer

### VSCode
* Set xdebug stub in Preferences: User Settings (JSON).

## Windows
* Download php >=8.3 thread safe x64 build
* Move to folder: C:\php-{8.3}\

### php.ini enable following
* extension=yaml
* extension=pdo_mysql
* extension=curl
* extension=mbstring
* extension=dom

### xdebug
* Download the xdebug .dll-file and rename it to "php_xdebug.dll"
  * Put php_xdebug.dll inside your php directory /ext/ folder.
* Edit php.ini:
  * Add: zend_extension=xdebug
  * Add: xdebug.mode=coverage
* Set xdebug stub in VSCode Preferences: User Settings (JSON).
* Set php include folder: C:\php-{8.3}\


## Scripts

### MariaDB
#### Install MariaDB and add local user + database
* ``./scripts/mariadb_install.sh <username> <database>``
#### Add database with user
* ``./scripts/mariadb_create_database_with_user.sh <username> <database> [remote_ip = localhost] [password = random]``
#### Remote user
* Change Configuration: ``/etc/mysql/mariadb.conf.d/50-server.cnf`` and the value ``bind-address=0.0.0.0``
* ``systemctl restart mariadb.service``

### SSH key pair
Creates ssh key pair and starts the ssh-agent
* ``./scripts/ssh_key_pair.sh <ssh_key_name/system_name> [ssh_key_comment = ""]``

### PHP and Composer
* ``./scripts/php.sh <php_version>``

### Apache2
Install apache2 + vhost and system web directories.
* ``./scripts/apache2.sh <domain_name> <system_dir>`` and ``./scripts/system_directories.sh <system_dir>``
#### Packages
* apache2
* net-tools

## PHPUnit 
### Installing
* ``composer require phpunit/phpunit``

### Setup
* Generate phpunit.xml configuration file: ``./vendor/bin/phpunit --generate-configuration``
* Change configuration file: requireCoverageMetadata="true" to requireCoverageMetadata="false"
* Add test suites and names.
* Check the include directory.

### Usage
* Coverage report: ``./vendor/bin/phpunit --coverage-text="coverage/coverage.txt" --coverage-html="coverage/html"``
* Run all tests: ``./vendor/bin/phpunit``
* Run specific test suite: ``./vendor/bin/phpunit --testsuite="<test_suite>"``
* Run specific test: ``./vendor/bin/phpunit --filter "<method_name>" "<unit_test_file>"``