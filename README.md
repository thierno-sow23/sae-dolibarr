# SAE-51/Projet 3 : Installation d'un ERP_CRM

**Fait par : Carmella NGUIMBI, SOW Thierno et Darly LAWSON**

**Groupe B BUT3 FA**


## 2 Mise en place et utilisation de Dolibarr:

Pour la mise en place de Dolibarr, il suffit de lancer le script install.sh qui execute dans l'ordre les Etapes suivantes (correspondantes aux étapes commentées dans le script):

### Etape 1 :

Creation des volumes nécessaires pour la persistance des données au travers des deux commandes :
docker volume create dolibarr_db
docker volume create dolibarr_docs
Puis, creation du réseau qui servira à tous les conteneurs la possibilité de pouvoir communiquer :
docker network create sae51

### Etape 2 :

Creation du conteneur mysql au travers de la commande:
docker run --name SQL_Server \
-p 3306:3306 \
-v dolibarr_db:/var/lib/mysql \
--env MYSQL_ROOT_PASSWORD=foo \
--env MYSQL_USER=dolibarr \
--env MYSQL_PASSWORD=dolibarr \
--env MYSQL_DATABASE=dolibarr \
--env character_set_client=utf8 \
--env character-set-server=utf8mb4 \
--env collation-server=utf8mb4_unicode_ci \
-network=sae51 \
-d mysql

Puis une attente de quelques secondes au travers de la commande :
sleep 10

Cette attente est nécessaire pour permettre au SGBD d'être correctement accessible via un client mysql.

Il est important de noter qu'en aucun cas un conteneur utilisera l'utilisateur root de la base de données pouyr s'y connecter.

### Etape 3 :

Creation de la base de données dolibarr via la commande :
mysql -u dolibarr -p'dolibarr' -h 127.0.0.1 --port=3306 < sql/dolibarr.sql 2> /dev/null
Le fichier dolibarr.sql contient l'instruction nécessaire pour la création de la base de données :
CREATE DATABASE dolibarr;

### Etape 4 :

Creation du conteneur Dolibarr via la commande :
docker run -p 80:80 \ 

--name Dolibarr_CRM \ 

--env DOLI_DB_HOST=SQL_Server -d \ 

--env DOLI_DB_NAME=dolibarr \ 

--env DOLI_MODULES=modSociete\ 

--env DOLI_ADMIN_LOGIN=Haar\ 

--env DOLI_ADMIN_PASSWORD=Balete\ 

--network=sae51 \ 

upshift/dolibarr

### Etape 5 :

Execution du script build_and_run_cron.sh:

Construction de l'image pour le conteneur cron :
docker build -t cron_save -f cron/Dockerfile .

Puis lancement du conteneur :

docker run -d \ 

--name cron_backup \ 

-v dolibarr_docs:/var/www/documents \ 

--network=sae51 \ 

cron_save



