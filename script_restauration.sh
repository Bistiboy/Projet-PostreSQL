#!bin/sh


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

# Déclaration des variables
BACKUP_DIR = /pg_backup
DUMP = _pg_backup.sql

FILE = 'date + "%Y%m%d%H%M"'${DUMP}

INPUT_FILE = ${BACKUP_DIR}/${FILE}




echo "drop database $DATABASE;" | psql --username=$USER 
echo "create database $DATABASE with encoding 'utf8';" | psql -username=$USER 

psql --username=$USER $DATABASE < $INPUT_FILE
