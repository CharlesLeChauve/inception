FROM debian:bullseye

# Installer vsftpd
RUN apt-get update && \
    apt-get install -y vsftpd && \
    apt-get clean

# Créer un dossier pour le site WordPress (qui sera monté via un volume)
RUN mkdir -p /var/www/wordpress

RUN mkdir -p /var/run/vsftpd/empty

# Copier le fichier de configuration personnalisé
COPY conf/vsftpd.conf /etc/vsftpd.conf

# Ajouter l’utilisateur FTP sans définir de mot de passe (le mot de passe sera configuré à l'exécution)
RUN useradd -m -d /var/www/wordpress ftpuser

# Exposer le port 21 pour le FTP
EXPOSE 21

# Lire le mot de passe depuis le secret au démarrage et démarrer vsftpd
CMD echo "ftpuser:$(cat /run/secrets/ftp_password)" | chpasswd && vsftpd /etc/vsftpd.conf