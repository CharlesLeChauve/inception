PROJECT_NAME = inception

DOCKER_COMPOSE = docker-compose -p $(PROJECT_NAME)

all: buildup

re:	clean-all buildup
# Arrêter et supprimer tous les conteneurs, images, volumes, et réseaux
clean-all:
	@docker stop $$(docker ps -qa) 2>/dev/null || true
	@docker rm $$(docker ps -qa) 2>/dev/null || true
	@docker rmi -f $$(docker images -qa) 2>/dev/null || true
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@docker network rm $$(docker network ls -q) 2>/dev/null || true
	@echo "All containers, images, volumes, and networks have been cleaned."

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