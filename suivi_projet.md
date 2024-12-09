# Suivi_projet  (SAE 51 projet 3)

## Créneaux

### lundi 05 Novembre 2024 : 08h30 – 11h30 

Prise en main, familiarisation et installations des outils : Dolibarr, MySQL
-	Consultation des références données dans le sujet
-	Installation en version graphique de dolibarr pour se familiariser
-	Installation de MySQL
-	Création d’une base de données 

(Tâches Carmella)

lundi 05 Novembre 2024 ( 14h30 – 17h30)
Installation de dolibarr : 
Prérequis : dolibarr nécessite un serveur web (Apache), PHP et une base de données MySQL ou Maria DB pour fonctionner ; (le choix porte sur MariaDB)

Étapes :

1.	Mise à jour
2.	Installer apache et maria dB
3.	Télécharger dolibarr depuis le site officiel et l’installer (installation réussie)
4.	Configurer maria dB pour dolibarr
5.	Création d’une BD : dolibarr
6.	Création d’un user : user / mot de passe : user1234 (qui ne pourra se connecter que sur le localhost de la machine auquelle maria DB est installée
7.	Configurer apache pour dolibarr : installer le serveur 
8.	Lancer l’installation de dolibarr dans le navigateur avec : http://localhost/dolibarr/htdocs/install/index.php


### Mercrédi 06/11/24 : 08h30 – 11h30

-	Problème rencontré lors de l’installation de dolibarr : il manque la prise en charge de l’extension php IMAP, cette extension est utilisée pour gérer les emails entrants dans dolibarr
-	Résolution : installer l’extension IMAP sur PHP 7.4 avec les commandes : sudo apt install php7.4-imap, 
-	Redémarrer Apache et réactiver la page d’installation
-	Résultat : problème résolu
-	Accéder à Dolibarr (Interface d’administration) dans le navigateur via le lien : http://localhost/dolibarr/htdocs/index.php
-	Problème rencontré : Changer la langue de configuration de l’anglais au français




### Vendredi 07/11/24 : 08h30 – 11h30

Objectifs d’ici la fin du créneau : Importer une base de données (fichier csv client) à dolibarr et configurer les informations sur l’entreprise (fictive) 

-	Chemin d’accès pour lancer Dolibarr : /var/www/html/dolibarr/htdocs
-	Ensuite lancer avec la commande : sudo systemctl start apache2
-	Si un autre service utilise le port (il faut l’arrêter avec sudo systemctl stop ‘nom du service’
-	Sudo lsof -i :80 = pour voir quel service utilise le port 80

Importation du fichier

1.	Connexionà Dolibarr et allez dans le module Outils multi-modules pour activer l’import et l’export des données !
2.	Cherchez une option d’importation de données dans les paramètres du module ou dans le menu d'administration.
3.	Sélectionnez le fichier CSV que vous avez téléchargé.
4.	Mappez les colonnes du fichier CSV aux champs correspondants dans Dolibarr (par exemple, Prénom, Nom, Adresse, etc.).
5.	Démarrez l'importation et vérifiez les données dans la liste des clients.
6.	Import de fichiers réussi 
7.	Export de fichier : 

### Vendredi 12/11/24 : 14h30 – 17h30
Phase de l’automatisation



