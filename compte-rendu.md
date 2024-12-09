# **Table de matières**

### **1- Introduction**
### **2- Repartition de la charge de travail**
### **3- Possibilité d'installation de dolibarr**
### **4- Description de l'architecture conteneurisée mise en place**
### **5- Importation et exportation de la base de données en fichiers CSV**
### **6- Sauvegarde et restauration**
### **7- Problèmes rencontrés**
### **8- Notre avis et retour par rapport au Projet**
### **9- Conclusion**

## 1- Introduction

Dans le cadre de ce projet, nous avons exploré l'installation, la configuration et l'utilisation de Dolibarr, un logiciel de gestion d'entreprise open source. Dolibarr propose des solutions 
ERP (progiciel de gestion intégré) et CRM (gestion de la relation client) pour faciliter la gestion des processus administratifs et commerciaux au sein des entreprises. 
Ce projet nous a permis de découvrir ses différentes fonctionnalités, son processus d'installation via divers moyens (Docker, paquets Debian, fichiers source PHP), 
ainsi que ses capacités en matière de configuration, importation de données, et gestion de base de données avec des outils comme MySQL.

L'objectif principal était de comprendre Dolibarr dans son ensemble, d'expérimenter ses fonctionnalités, et d'explorer les différentes méthodes pour automatiser son déploiement, notamment via la conteneurisation avec Docker. 
En parallèle, nous avons abordé l'aspect sauvegarde avec des outils comme mysqldump et l'intégration de tâches planifiées avec cron.

## 2- Repartition de la charge de travail

Pour assurer une bonne organisation et une gestion efficace du projet, nous avons établi une répartition des tâches au sein de notre équipe composée des noms indiqués ci-dessu. 
Cette répartition visait à tirer parti des compétences de chacun tout en assurant une répartition équitable des responsabilités. 
LAWSON a été en charge de la recherche et de l'analyse des différentes méthodes d'installation de Dolibarr, en se concentrant sur l'étude comparative des méthodes avec Docker, paquets Debian, et les archives source PHP. 
SOW étant le chef de projet a pris en charge la configuration et l'automatisation et la tenue du fichier de suivit du projet en se concentrant sur 
l'utilisation de scripts Bash, la mise en place de tâches avec cron, et la conteneurisation avec Docker. Enfin, moi même (NGUIMBI) j'ai été chargé de la redaction du compte rendu et a été tenu responsable de 
la gestion des bases de données, de l'importation des données, ainsi que des tests relatifs aux sauvegardes avec mysqldump.

## 3- Possibilité d'installation de dolibarr

Pour l'installation de Dolibarr, plusieurs méthodes sont disponibles, chacune avec ses avantages et inconvénients.

### Les images Docker (Méthode choisi pour la réalisation du projet)

 La première méthode repose sur l'utilisation des images Docker, qui offrent un environnement conteneurisé préconfiguré. 
 Plusieurs images Docker sont disponibles, comme celles officielles ou créées par des utilisateurs tiers, notamment l'image upshift/dolibarr qui a le plus grand nombre de téléchargements. 
 Cette méthode est rapide, simplifiée, et permet une isolation parfaite entre l'application et l'hôte, mais nécessite une bonne maîtrise de Docker.

### Via les archives ou les fichiers sources PHP

Une autre méthode est l'installation via archive ou fichiers source PHP, où il faut configurer manuellement le serveur web et la base de données (MySQL ou MariaDB) sur une machine virtuelle ou un serveur physique. 
Cette méthode est plus flexible mais demande davantage de configuration manuelle.

### Paquet Debian(.deb)

L'installation peut également être réalisée avec le paquet Debian (.deb), 
qui permet d'automatiser une partie de l'installation avec les gestionnaires de paquets comme apt. 
Cette approche est la plus simple mais peut être limitée selon les versions et l'environnement utilisé.



## 4- Description de l'architecture conteneurisée mise en place :

| **Conteneurs**       | **Conteneur Dolibarr**              | **Conteneur MySQL**         | **Conteneur Cron**                           |
|-----------------------|-------------------------------------|-----------------------------|----------------------------------------------|
| **Image**            | upshift/dolibarr                   | mysql                       | cron_save (personnalisée à partir d'une image Ubuntu) |
| **Fonction**         | Logiciel Dolibarr accessible depuis une interface web | Base de données permettant à Dolibarr de fonctionner correctement | Serveur de sauvegarde hebdomadaire          |

## 5- Importation et exportation de la base de données en fichiers CSV

l'importation et l'exportation de la base de données ont été explorées sous forme de fichiers CSV dans un premier temps nous l'avons fait manuellement afin de faciliter la manipulation, la sauvegarde et la récupération des données dans Dolibarr. 
L'exportation de la base de données a été réalisée en utilisant l'outil mysqldump et en convertissant les données sous un format lisible par l'utilisateur, notamment au format CSV. 
Ce processus a permis de sauvegarder l'intégralité des tables utilisées par Dolibarr (276 en tout après vérification en se connectant à la BD) 
tout en offrant un moyen d'archivage et de réutilisation simple des données.
L'exportation avec mysqldump est un processus clé pour la sauvegarde régulière de la base de données. Nous avons configuré des tâches planifiées avec cron pour automatiser cette sauvegarde, garantissant ainsi une continuité en cas de défaillance ou incidents du serveur.
De même, l'importation a été réalisée via l'interface utilisateur de Dolibarr ainsi que via des commandes SQL directement avec l'outil en ligne de commande MySQL, ce qui a permis de valider les données sauvegardées et leur intégrité après restauration.


## 6- Sauvegarde et restauration

L'objectif était de mettre en place un mécanisme fiable pour sauvegarder régulièrement les données critiques de l'application, notamment la base de données et les configurations importantes, 
afin de prévenir toute perte accidentelle ou technique.

### Sauvegarde automatisée

Elle a été mise en place en utilisant l'outil mysqldump, qui extrait la base de données dans un format SQL. 
Pour automatiser ce processus, des tâches planifiées avec l'outil cron ont été configurées, permettant de sauvegarder la base de données à intervalles réguliers. Par exemple, un script save_hebdo.sh a été créé pour sauvegarder la base de données de Dolibarr chaque semaine. 
Les sauvegardes sont stockées dans un répertoire sécurisé, ce qui garantit un accès rapide en cas de besoin.

### La restauration

Quant à elle, a été réalisée en utilisant les sauvegardes générées par mysqldump. Grâce à cette procédure, il a été possible de restaurer l'intégralité de la base de données dans un environnement propre après un incident ou une défaillance. L'utilisation de commandes 
comme mysql -u user -p < dump.sql a facilité cette tâche, permettant un retour rapide à un état stable de l'application.

## 7- Problèmes rencontrés

### Problème 1:

(problème de connection entre le dolibarr et mysql --> solution, ajout de network entre les 2)

Le premier problème est intervenu à la suite du premier essai, grâce au logs de docker nous avons pu voir que la connection entre la base de donnée mysql et le conteneur dolibarr ne s'effectuait pas correctement, par conséquence dolibarr ne pouvais pas fonctionner. 
La solution à été de rajouter un réseau entre les 2 conteneurs afin de leur premettre la connection mutuelle
Nous avons donc utiliser dans le script install.sh la commande :
docker network create sae51
Et lors de la création de chaque conteneur, spécifier l'option :
--network=sae51

### Problème 2:

(problème de création de la Database avec la variable env MYSQL_DATABASE qui n'étais pas prise en compte --> solution, crée la database grâce à l'envoie d'une requête)

Nous avions eu une erreur lors de la récupération par dolibarr de la base de données appelé "dolibarr" (nom dolibarr inconnu) pour cause elle n'était pas correctement créée. Malgré l'utilisation de la variable d'environnement MYSQL_DATABASE qui 
est censé permettre la création de la base de donnée à l'initialisation du SGBD, la base de données n'était pas présente, 
la variable n'était pas prise en compte comparé aux autres variables d'environnement présentes permettant d'autre paramétrages. La solution à été d'utiliser une autre méthode pour effectuer l'implémentation de la base données, 
par l'envoie d'une requete pour effectuer la création de la base de données "dolibarr" :
CREATE DATABASE dolibarr


## 8- Notre avis et retour par rapport au Projet

Dans le cadre de ce projet, nous avons apprécié la richesse fonctionnelle de Dolibarr et la possibilité de découvrir qu'il existe d'autres outils dans le même contexte comme Odoo, SAP ERP,Salesforce et bien d'autres dont nous allons certainement exploiter pour notre connaissance personnelle ainsi que 
la gestion de bases de données avec des tâches automatisées via cron. L'expérience nous a permis de renforcer nos compétences en conteneurisation, configuration de bases de données, et automatisation avec des scripts Bash. Malgré cela, certaines étapes ont présenté des défis, notamment la configuration correcte des réseaux Docker et 
la gestion des permissions dans l'environnement conteneurisé. Cependant, ces obstacles ont été surmontés grâce à une analyse approfondie en équipe en consultant les fichiers des logs après chaque message d'erreur rencontré. 
Nous avons également tiré des leçons essentielles sur l'importance de la documentation et de la planification pour atteindre les objectifs d'un projet de cette portée. 
Pour l'avenir, nous suggérons d'intégrer davantage d'éléments de sécurité, une meilleure gestion des sauvegardes avec des outils de monitoring, et une simplification du processus d'installation pour une meilleure accessibilité.


## 9- Conclusion

En conclusion, ce projet a été une étape cruciale dans notre apprentissage et nous a ouvert 
des perspectives intéressantes sur l'utilisation de Dolibarr et des technologies connexes dans un contexte 
professionnel et académique.
