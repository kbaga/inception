FROM debian:trixie

#RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y nginx \
	openssl -y \
	curl -y \
	vim -y \
	sudo -y \
	bash -y

#create a ssl folder
RUN mkdir -p /etc/nginx/ssl

#generate certificate and stores it
RUN openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 \
	-keyout /etc/nginx/ssl/inception.key \
	-out /etc/nginx/ssl/inception.crt \
	-subj "/C=CH/ST=GENEVA/L=GENEVA/O=42/OU=Student/CN=kbaga42.42.fr/UID=kbaga42"

RUN chmod 644 /etc/nginx/ssl/inception.key \
 && chmod 644 /etc/nginx/ssl/inception.crt

RUN mkdir -p /var/run/nginx

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

RUN rm -f /etc/nginx/conf.d/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
