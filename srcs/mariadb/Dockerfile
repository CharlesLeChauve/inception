FROM debian:bullseye

#install package
RUN apt-get update && \
    apt-get install -y mariadb-server

#add permission
RUN chown -R mysql:mysql /var/lib/mysql
RUN chmod -R 750 /var/lib/mysql

#copy config file
COPY my.cnf	/etc/mysql/mariadb.conf.d/my.cnf

#run script shell
COPY init_db.sh /usr/local/bin/init_db.sh  
RUN chmod +x /usr/local/bin/init_db.sh

RUN echo "Vérification du script mariadb.sh :" && \
    ls -l /usr/local/bin/init_db.sh

CMD /usr/local/bin/init_db.sh
