FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server

RUN chown -R mysql:mysql /var/lib/mysql
RUN chmod -R 750 /var/lib/mysql

COPY conf/my.cnf	/etc/mysql/mariadb.conf.d/my.cnf

COPY tools/init_db.sh /usr/local/bin/init_db.sh  
RUN chmod +x /usr/local/bin/init_db.sh

ENTRYPOINT /usr/local/bin/init_db.sh
