#!/bin/bash

# Démarrer MariaDB en arrière-plan (si nécessaire dans le contexte d'un conteneur)
mysqld_safe &

export MYSQL_ROOT_PASSWORD="$(cat $MYSQL_ROOT_PASSWORD_FILE)"
export MYSQL_PASSWORD="$(cat $MYSQL_PASSWORD_FILE)"

# Attendre que le service MariaDB soit prêt
sleep 30

# Créer la base de données si elle n'existe pas
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

# Créer l'utilisateur et lui accorder des privilèges sur la base de données
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;"

# Modifier le mot de passe du root
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "ALTER USER 'root'@'tgibert.42.fr' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

# Rafraîchir les privilèges
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

# Arrêter proprement MariaDB avant de démarrer le processus principal
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Lancer MariaDB en mode sécurisé
exec mysqld_safe
