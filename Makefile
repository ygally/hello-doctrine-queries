PHP8_VERION=8.1

help:
	@echo "You can 'make php8' to switch to php8 version on system if not ready yet. (need sudo access)"
	@echo "You can 'make install' to run composer install."
	@echo "You can 'make up' and 'make down' to start and stop the service."
	@echo "You can 'make init_db' to initialize the database."

php8:
	sudo add-apt-repository -y ppa:ondrej/php
	sudo apt -y update
	sudo apt -y install php$(PHP8_VERION) php$(PHP8_VERION)-cli php$(PHP8_VERION)-mysql php$(PHP8_VERION)-curl php$(PHP8_VERION)-gd php$(PHP8_VERION)-intl php$(PHP8_VERION)-mbstring php$(PHP8_VERION)-xml php$(PHP8_VERION)-zip
	#sudo a2enmod php$(PHP8_VERION)
	sudo update-alternatives --set php /usr/bin/php$(PHP8_VERION)
	sudo update-alternatives --set phar /usr/bin/phar$(PHP8_VERION)
	php -v
	echo "$(PHP8_VERION)" > .php-version

install:
	composer global update
	composer install

up:
	docker compose up -d

down:
	docker compose down

init_db:
	symfony console doctrine:database:create --if-not-exists
	symfony console doctrine:schema:update --force
	symfony console doctrine:fixtures:load

ca-install:
	symfony server:ca:install

start: up
	symfony serve -d

stop:
	symfony server:stop

logs:
	docker compose logs -f
