all:
	docker-compose -f srcs/docker-compose.yml up -d
stop:
	docker-compose -f srcs/docker-compose.yml down
clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\

prune:
	yes | docker system prune -a --volumes

re: clean all