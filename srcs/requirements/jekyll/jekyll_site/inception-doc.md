---
layout: default
title: Accueil
---

# Docker Inception Project

## Description

Ce projet propose une infrastructure multi-conteneurs Docker, entièrement construite à partir de l'image Debian Bullseye. L'objectif est de fournir un environnement contenant un site WordPress, une base de données MariaDB, un serveur FTP, un serveur Redis pour la mise en cache, une interface d'administration de base de données via Adminer, et un site statique généré avec Jekyll, le tout encapsulé dans une architecture de conteneurs Docker sécurisée.

---

## Caractéristiques du Projet

- **WordPress** avec une base de données **MariaDB**
- **Adminer** pour administrer la base de données via une interface web
- **Redis** comme système de cache pour améliorer les performances de WordPress
- **Serveur FTP** pour gérer les fichiers du site WordPress
- **Site statique Jekyll** hébergé via un conteneur Docker dédié
- **Nginx** en proxy inverse pour gérer le trafic et les certificats SSL

## Configuration

### Secrets

Les secrets sont stockés dans des fichiers dans le dossier `../secrets` pour sécuriser les mots de passe et autres informations sensibles. Assurez-vous que ces fichiers sont bien présents avant de lancer le projet.

- `mysql_root_password.txt` : Mot de passe root de MariaDB
- `mysql_password.txt` : Mot de passe utilisateur de MariaDB
- `wp_admin_password.txt` : Mot de passe administrateur WordPress
- `wp_password.txt` : Mot de passe utilisateur WordPress
- `ftp_password.txt` : Mot de passe utilisateur FTP

### Variables d'Environnement

Définissez les chemins des volumes dans un fichier `.env` :

```plaintext
WP_VOL_PATH=chemin/vers/volume/wordpress
MDB_VOL_PATH=chemin/vers/volume/mariadb
```

## Services

### Nginx

- **Port** : 443 (SSL activé)
- **Rôle** : Proxy inverse gérant le trafic pour WordPress et Jekyll, avec SSL pour sécuriser les connexions.
- **Certificat SSL** : Assurez-vous d’avoir les fichiers `nginx.crt` et `nginx.key` dans `/etc/nginx/ssl`.

### MariaDB

- **Port** : 3306
- **Dépendances** : WordPress, Adminer
- **Sécurité** : Utilise des secrets pour sécuriser les mots de passe root et utilisateur.

### WordPress

- **Port** : 9000
- **Caractéristiques** : Utilisation de Redis pour améliorer les performances de cache, configuration automatique via des variables d’environnement.

### Adminer

- **Port** : 8080
- **Rôle** : Interface pour administrer la base de données MariaDB.

### FTP

- **Port** : 21, Plage passive : 21000-21010
- **Configuration** : Utilise des secrets pour le mot de passe FTP. Accessible via l’adresse et les identifiants définis.

### Redis

- **Port** : 6379
- **Rôle** : Système de cache pour WordPress.
- **Connexion** : Vérifiez la configuration dans `wp-config.php` pour s’assurer que Redis est activé.

### Jekyll

- **Port** : 4000
- **Fonction** : Site statique de présentation généré avec Jekyll et accessible via Nginx en HTTPS.

## Instructions de Configuration

### 1. Modifier le fichier `/etc/hosts`

Pour accéder aux différents services localement, ajoutez les entrées suivantes dans le fichier `/etc/hosts` :

127.0.0.1 tgibert.42.fr  
127.0.0.1 jekyll.local  

### 2. Générer un Certificat SSL Auto-signé (si besoin)

Utilisez la commande suivante pour créer un certificat auto-signé :
```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./certs/nginx.key -out ./certs/nginx.crt
```

Placez ensuite ces fichiers dans `./certs` et montez-les dans le conteneur Nginx.

### 3. Lancer le Projet

À la racine de votre projet, utilisez la commande suivante pour démarrer tous les conteneurs :

```bash
docker-compose -f ./srcs/docker-compose.yml -p inception up --build -d
```

### 4. Vérification des Services

- **WordPress** : Accédez à `https://tgibert.42.fr`
- **Adminer** : Accédez à `http://tgibert.42.fr:8080`
- **FTP** : Utilisez un client FTP pour tester la connexion avec les informations d'identification stockées.
```bash
ftp -p localhost 21
```
- **Redis** : Vérifiez l'intégration via `redis-cli` dans le conteneur Redis.
- **Jekyll** : Accédez à `http://tgibert.42.fr:4000`

---

## Commandes Utiles

### Arrêter les Conteneurs

```bash
docker-compose -f ./srcs/docker-compose.yml -p inception down
```

### Logs en Direct

```bash
docker-compose -f ./srcs/docker-compose.yml -p inception logs -f
```

---

## Conclusion

Ce projet offre une infrastructure Docker complète, basée sur Debian Bullseye, avec un ensemble de services entièrement conteneurisés, chacun ayant des responsabilités spécifiques pour gérer et servir un site WordPress sécurisé et performant. N'hésitez pas à ajuster les configurations selon vos besoins ou à expérimenter l'ajout de nouveaux services dans cette architecture.

--- 

**Bonne exploration et merci d'avoir suivi ce projet !**