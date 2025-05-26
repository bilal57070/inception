FROM debian:buster
RUN apt update -y && apt upgrade -y
RUN apt-get install mariadb-server -y


COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/sc.sh /etc/mysql/sc.sh
RUN chmod +x /etc/mysql/sc.sh
RUN /etc/mysql/sc.sh