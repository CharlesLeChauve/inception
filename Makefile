PROJECT_NAME = inception

DOCKER_COMPOSE = docker-compose -p $(PROJECT_NAME)

up:
	$(DOCKER_COMPOSE) up -d

buildup:
	$(DOCKER_COMPOSE) up --build -d

build:
	$(DOCKER_COMPOSE) build

build-nocache:
	$(DOCKER_COMPOSE) build --no-cache

down:
	$(DOCKER_COMPOSE) down

down-all:
	$(DOCKER_COMPOSE) down --volumes --remove-orphans

logs:
	$(DOCKER_COMPOSE) logs -f

bash-nginx:
	$(DOCKER_COMPOSE) exec nginx bash

bash-wordpress:
	$(DOCKER_COMPOSE) exec wordpress bash

bash-mariadb:
	$(DOCKER_COMPOSE) exec mariadb bash

status:
	$(DOCKER_COMPOSE) ps


clean-volumes:
	$(DOCKER_COMPOSE) down -v

restart:
	$(DOCKER_COMPOSE) restart

images:
	docker images