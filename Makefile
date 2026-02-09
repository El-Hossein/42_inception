COMPOSE_FILE = srcs/docker-compose.yml
COMPOSE = docker compose -f $(COMPOSE_FILE)
PATHVOLUMES = /home/$(USER)

all: up

setup:
	@sudo mkdir -p $(PATHVOLUMES)/data/mariadb
	@sudo mkdir -p $(PATHVOLUMES)/data/wordpress
	@sudo mkdir -p $(PATHVOLUMES)/data/adminer
	@sudo mkdir -p $(PATHVOLUMES)/data/grafana
	@sudo chown -R 777:777 /home/$(USER)/data/grafana
	@sudo chmod -R 755 $(PATHVOLUMES)/data 2>/dev/null || true

up: setup
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

clean:
	$(COMPOSE) down --rmi all

fclean:
	$(COMPOSE) down -v --rmi all
	@sudo rm -rf $(PATHVOLUMES)/data

re: fclean up

.PHONY: all up down stop clean fclean re setup
