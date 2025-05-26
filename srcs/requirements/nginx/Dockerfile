FROM debian:bullseye
RUN apt update -y && apt upgrade -y && apt install nginx -y
RUN apt install curl -y
RUN apt install openssl -y
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=FR/ST=REGION SUD/L=Nice/O=42/OU=42/CN=bsafi.42.fr/UID=bsafi"
RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
CMD [ "nginx", "-g", "daemon off;" ]

