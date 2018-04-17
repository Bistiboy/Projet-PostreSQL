#!bin/sh

# Déclaration des variables
BACKUP_DIR = /pg_backup
DAYS = 30
DUMP = _pg_backup.sql

#Demande du nom d'utilisateur :
if [ -z $1 ]; then
	echo "Entrez le nom d'utilisateur:"
	read USER
else
	USER = postgres
fi

#Demande du nom de la bdd
if [ -z $2 ]; then
	echo "Entrz le nom de la base de donnée:"
	read DATABASE
else
	DATABASE = appli_web
fi

FILE = 'date + "%Y%m%d%H%M"'${DUMP}

OUTPUT_FILE = ${BACKUP_DIR}/${FILE}

# Commande pour sauvegarder le serveur dans un fichier
pg_dump -U ${USER} ${DATABASE} -F t -f ${BACKUP_DIR}

# Afficher le resultat a l'utilisateur
echo "${OUTPUT_FILE} was created : "
ls -l ${OUTPUT_FILE}

# Pour gerer les backup de plus de 30jours
find $BACKUP_DIR -maxdepth 1 -mtime +$DAYS -name "*${DUMP} -exec rm -rf '{}' ';'
