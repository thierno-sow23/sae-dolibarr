#!/bin/bash

DATE=$(date +%Y-%m-%d_%H-%M-%S) # Génère un horodatage sous la forme "2024-12-09_12-00-00"
mysqldump -u dolibarr -p'dolibarr' -h SQL_Server --port=3306 dolibarr > /var/www/documents/save_$DATE.sql

