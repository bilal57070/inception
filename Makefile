
all:
	sudo mkdir -p /home/bsafi/data/mariadb
	sudo mkdir -p /home/bsafi/data/wordpress
	sudo chmod -R 755 /home/bsafi/data/wordpress
	sudo chmod -R 755 /home/bsafi/data/mariadb
	cd srcs && docker compose up -d --build

clean:
	cd srcs && docker compose down
	sudo docker stop $$(sudo docker ps -qa) || true
	sudo docker rm $$(sudo docker ps -qa) || true
	sudo rm -rf /home/bsafi/data/mariadb
	sudo rm -rf /home/bsafi/data/wordpress
	sudo docker volume rm $$(sudo docker volume ls -q) || true
	sudo docker network rm $$(sudo docker network ls -q) 2>/dev/null || true

fclean:
	make clean
	docker system prune -a -f --volumes
	docker network prune -f
	docker network rm $$(docker network ls -q) 2>/dev/null || true
	docker volume rm $$(docker volume ls -qf dangling=true) 2>/dev/null || true
	sudo rm -rf /home/bsafi/data/mariadb
	sudo rm -rf /home/bsafi/data/wordpress

re:
	make fclean
	make all


