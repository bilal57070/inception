
all:	up
	 
up:
		mkdir -p /home/bsafi/data/wordpress
		mkdir -p /home/bsafi/data/mariadb
		docker compose -f ./srcs/docker-compose.yml up -d --build

down:	docker compose -f ./srcs/docker-compose.yml down

clean:	down

fclean:	clean
		sudo rm -rf /home/bsafi/data/wordpress
		sudo rm -rf /home/bsafi/data/mariadb

re:	fclean all
	   


