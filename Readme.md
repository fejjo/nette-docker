- enter folder with `docker-compose.yml`
- run `docker-compose up`
- that will start the PHP server on the localhost:8080
- the second *virtual host* is configured as nette.dev:8000
- add `127.0.0.1  nette.dev` to your `/etc/hosts` file
- the `nette.dev` web-application is served from `nette` folder of this project
- you can directly edit sources in `nette` folder (PHPStorm)
- for debuging to work, you must setup the alias for `lo0` network device
- on macOS run this `sudo ifconfig lo0 alias 10.100.100.1`
- it will make your localhost interface available as 10.100.100.1
- XDebug is using this as debuging host
- to stars debugging just turn-on the "telephone icon" in top right and...
- in the browser click the "start debugging" bookmarklet
- to create bookmarklet follow [link](https://confluence.jetbrains.com/display/PhpStorm/Zero-configuration+Web+Application+Debugging+with+Xdebug+and+PhpStorm)
- if debugging is not working, put breakpoint to the `nette/www/index.php`
- application shoud now stop, continue to the `bootstrap.php`
- now you will be prompted to properly setup directory mapping
- do it! just do it!
- to put down the development image run `docker-compose down`
- you can access the inner console env by running:

	`docker-compose run php php /var/www/nette/www/index.php`
	`docker-compose run php php /var/www/nette/www/index.php help orm:schema-tool:create`

- console php debuging TODO
