FROM debian:bullseye

# Mettre à jour les dépôts et installer les paquets nécessaires
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    wget \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-intl \
    php7.4-curl \
    mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Télécharger, extraire, et configurer WordPress
RUN wget https://wordpress.org/wordpress-6.4.3.tar.gz -P /var/www && \
    tar -xzf /var/www/wordpress-6.4.3.tar.gz -C /var/www && \
    rm /var/www/wordpress-6.4.3.tar.gz && \
    mv /var/www/wordpress /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Créer le répertoire pour le socket PHP-FPM
RUN mkdir -p /run/php && chown www-data:www-data /run/php

# Copier les fichiers de configuration et le script
COPY tools/auto-config.sh /usr/local/bin/auto-config.sh
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Télécharger et configurer WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Rendre le script exécutable et définir la commande à exécuter
RUN chmod +x /usr/local/bin/auto-config.sh
ENTRYPOINT /usr/local/bin/auto-config.sh
