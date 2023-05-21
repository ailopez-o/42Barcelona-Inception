################################################################################
# Colort
################################################################################

DEL_LINE =		\033[2K
ITALIC =		\033[3m
DEF_COLOR =		\033[0;39m
GRAY =			\033[0;90m
RED =			\033[0;91m
DARK_YELLOW =	\033[38;5;143m
BROWN =			\033[38;2;184;143;29m
DARK_GRAY =		\033[38;5;234m
DARK_GREEN =	\033[1m\033[38;2;75;179;82m


WP_PATH := $(shell grep WP_PATH srcs/.env | cut -d '=' -f2)
BBDD_PATH := $(shell grep BBDD_PATH srcs/.env | cut -d '=' -f2)



all:
	docker-compose -f srcs/docker-compose.yml up -d
stop:
	docker-compose -f srcs/docker-compose.yml down

cwp:
	-docker stop wordpress
	-docker rm wordpress
	-docker rmi srcs-wordpress
	-docker volume rm wp-data

cmdb:
	-docker stop mariadb
	-docker rm mariadb
	-docker rmi srcs-mariadb
	-docker volume rm sql-data

cnginx:
	-docker stop ngnix
	-docker rm nginx
	-docker rmi srcs-nginx

cadminer:
	-docker stop adminer
	-docker rm adminer
	-docker rmi srcs-adminer

clean:
	-docker-compose -f srcs/docker-compose.yml down
	@echo "$(DARK_GREEN)NGNIX Docker & Image Clean$(DEF_COLOR)"
	-docker rm nginx
	-docker rmi srcs-nginx
	@echo "$(DARK_GREEN)WORDPRESS Docker & Image Clean$(DEF_COLOR)"
	-docker rm wordpress
	-docker rmi srcs-wordpress
	@echo "$(DARK_GREEN)MARIADB Docker & Image Clean$(DEF_COLOR)"
	-docker rm mariadb	
	-docker rmi srcs-mariadb
	@echo "$(DARK_GREEN)ADMINER Docker & Image Clean$(DEF_COLOR)"
	-docker rm adminer	
	-docker rmi srcs-adminer
	@echo "$(DARK_GREEN)FTP Docker & Image Clean$(DEF_COLOR)"
	-docker rm ftp
	-docker rmi srcs-ftp
	@echo "$(DARK_GREEN)FTP Docker & Image Clean$(DEF_COLOR)"
	-docker rm backup
	-docker rmi srcs-backup
	@echo "$(DARK_GREEN)STATIC WEB Docker & Image Clean$(DEF_COLOR)"
	-docker rm staticweb
	-docker rmi srcs-staticweb
	@echo "$(DARK_GREEN)VOLUMES Clean$(DEF_COLOR)"
	-docker volume rm wp-data
	-docker volume rm sql-data
	rm -rf ${WP_PATH}
	mkdir -p ${WP_PATH}
	chmod 777 ${WP_PATH}
	rm -rf ${BBDD_PATH}
	mkdir -p ${BBDD_PATH}
	chmod 777 ${BBDD_PATH}
	@echo "$(DARK_GREEN)NETWORK Docker & Image Clean$(DEF_COLOR)"
	-docker network rm inception

prune:
	yes | docker system prune -a --volumes

re: clean all