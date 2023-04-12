#! /bin/bash
#Juan José Marruecos Borja

#Cabecera del programa

echo "  __                              __    _              ___   "
echo " / _\ ___  ___ _   _ _ __ ___    / /   /_\    /\/\    / _ \  "
echo " \ \ / _ \/ __| | | | '__/ _ \  / /   //_\\  /    \  / /_)/  "
echo " _\ \  __/ (__| |_| | | |  __/ / /___/  _  \/ /\/\ \/ ___/   "
echo " \__/\___|\___|\__,_|_|  \___| \____/\_/ \_/\/    \/\/       "
echo ""
                                                          

# 1.- Modificamos el archivo mysqld.cnf para que no permita conexiones remotas.

ficheroReal="/etc/mysql/mysql.conf.d/mysql.cnf"

sed 's/^bind-address.*/bind-address = 0.0.0.0/' mysqld.cnf

if [[ $? -eq 0 ]]
  then 
  	echo "El comando se ha realizado correctamente."
  	grep bind-address $ficheroReal
  else
  	echo "Se han encontrado errores al ejecutar el comando."
  	
  	
# 2.- Evitar acceso al sistema desde MySQL

ficheroReal2="/etc/mysql/my.cnf"

ruta="/etc/mysql/my.cnf"

if [[ grep "[mysqld]" $ruta ]]
 then 
 	grep local-infile $ficheroReal2
 	 if [[ $? -eq 0 ]] 
 	  then 
 	  	echo "Comprobación realizada con éxito. Es recomendable comprobar si en dicha sección están incluidos los parámetros indicados."
 	  else 
 	  	$ficheroReal2 >> ""
 	  	$ficheroReal2 >> "local-infile = 0"
 	  	$ficheroReal2 >> "secure-file-priv = /dev/null"
 	  	echo "Los parámetros que no se encontraban actualizados, han sido actualizados"
 	  fi
 fi
 	
 	
# 3.- Renombramos al usuario root

echo "Renombramos al usuario root."
read -p "¿Se está ejecutando el script desde el usuario root? (s/n)" $respuestaRoot

  while [[ $respuestaRoot != "s" && $respuestaRoot != "n" ]] 
  do
  	read -p "Debe introducir una de la respuesta correcta. (s/n)"
  done 

if [[ $respuestaRoot == "s" || $respuestaRoot == "S" ]]
  then 
  	read -p "Introduzca la contraseña del usuario root: " $contrasenaRoot
  	read -p "Introduzca el nuevo nombre del usuario root: " $nuevoRoot
  	echo "Cambiando el nombre del usuario root ..."
  	 
  	 mysql -u root -p $contrasenaRoot <<EOF
  	 	use mysql;
  	 	update mysql.user set user="$nuevoRoot" where user="root";
	 	flush privileges;
  	 	exit;
	EOF
	 
	echo "Cambio realizado con éxito."
	
   else 
   	echo "Continuamos con las comprobaciones..."

fi


# Evitar usuarios anónimos

echo "Comprobamos los usuarios anónimos y se muestran por pantalla: "
 mysql -u root -p $contrasenaRoot <<EOF
 use mysql;
 SELECT COUNT(user) AS "Número de usuarios anónimos" FROM user WHERE user="" OR user="test";
 exit
EOF

if [[ $? -eq 0 ]]
then
	echo "Se han eliminado todos los usuarios anónimos." 
else
	echo "No se ha encontrado ningún usuario anónimo."
fi


# Control de privilegios de los usuarios.

echo "Ahora vamos a comprobar los privilegios que tienen los usuarios:"

mysql -u root -p $contrasenaRoot <<EOF
use mysql;
SHOW GRANTS FOR 'root'@'localhost';
EOF








































































































