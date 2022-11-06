include .env

build-app:
	@echo "Build environment"
	docker-compose up -d --build

start:
	docker-compose up -d

destroy:
	@echo "Cleaning up the build environment..."
	docker-compose down -v

ssh:
	docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" -it -u www-data $(container) /bin/bash
