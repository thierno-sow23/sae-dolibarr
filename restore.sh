#!/bin/bash

#Application de l'ancienne config directement dans la base de données
mysql -u root -p'foo' -h 127.0.0.1 dolibarr < sql/save_third_part.sql
