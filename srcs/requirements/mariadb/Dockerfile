FROM debian:trixie

#RUN apt-get update -y && apt upgrade -y && apt-get install -y \
#    mariadb-server  tini-y\
#    mariadb-client \
#    && rm -rf /var/lib/apt/lists/*

RUN apt update -y && apt upgrade -y && apt install mariadb-server tini -y && \
rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld && rm -rf /var/lib/apt/lists/*

COPY ./tools/entrypoint.sh  /tmp/entrypoint.sh
COPY conf/init.sql /etc/mysql/init.sql
RUN chmod +x /tmp/entrypoint.sh

 #CMD ["mysqld", "--user=mysql"]

ENTRYPOINT [ "bash", "/tmp/entrypoint.sh" ]

