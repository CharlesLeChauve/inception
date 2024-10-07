#!/bin/sh

# Attendre pour que les services se lancent correctement
sleep 10

# Définir le répertoire de travail
cd /var/www/html

# Afficher le contenu du répertoire pour le débogage
#ls -la /var/www/html

echo "MYSQL_DATABASE=${MYSQL_DATABASE}"
echo "MYSQL_USER=${MYSQL_USER}"
echo "MYSQL_PASSWORD=${MYSQL_PASSWORD}"
echo "WORDPRESS_ADMIN_USER=${WP_ADMIN_USER}"
echo "WORDPRESS_ADMIN_PASSWORD=${WP_ADMIN_PASSWORD}"

# Vérifier si le fichier wp-config.php existe déjà
if [ ! -f wp-config.php ]; then
  echo "Creating WordPress configuration..."
  wp config create --allow-root \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost=mariadb:3306 \
    --path='/var/www/html'
fi

if wp core is-installed --allow-root --path='/var/www/html'; then
  echo "Resetting WordPress installation..."
  wp db reset --yes --allow-root --path='/var/www/html'
fi

# Installer WordPress si ce n'est pas déjà fait
if ! wp core is-installed --allow-root --path='/var/www/html'; then
  echo "Installing WordPress..."
  wp core install --allow-root \
    --url=$WP_URL \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL \
    --path='/var/www/html'
fi

echo "Username: $WP_USER"
echo "Email: $WP_EMAIL"
echo "Password: $WP_PASSWORD"

#create new user with editor perm
wp user create $WP_USER $WP_EMAIL --role=editor --user_pass=$WP_PASSWORD --allow-root --path='/var/www/html'

# Lancer PHP-FPM
/usr/sbin/php-fpm7.4 -F