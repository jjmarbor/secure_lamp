#! /bin/bash

# Modificamos el archivo mysqld.cnf para que no permita conexiones remotas.
sed 's/^bind-address.*/bind-address = 0.0.0.0/' mysqld.cnf

if [[ $? -eq 0 ]]
  then 
  	echo "El comando se ha realizado correctamente."
  else
  	echo "Se han encontrado errores al ejecutar el comando."
  	
#
if [[ grep 'mysqld' /etc/mysql/my.cnf ]]

