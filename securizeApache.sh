#! /bin/bash

echo ""
echo " __                      _             _      ___  _      ___         __  "
echo "/ _\ ___  ___ _   _ _ __(_)_______    /_\    / _ \/_\    / __\ /\  /\/__\ "
echo "\ \ / _ \/ __| | | | '__| |_  / _ \  //_ \  / /_)//_ \  / /   / /_/ /_\   "
echo "_\ \  __/ (__| |_| | |  | |/ /  __/ /  _  \/ ___/  _  \/ /___/ __  //__   "
echo "\__/\___|\___|\__,_|_|  |_/___\___| \_/ \_/\/   \_/ \_/\____/\/ /_/\__/   "
echo ""

#Variables
ficheroVarEnt="/etc/apache2/envvars"
rutaFicheroConfigApache="/etc/apache2/apache2.conf"
ficheroVarEnt="sandbox/envvars"
rutaFicheroConfigApache="sandbox/apache2.conf"

#1. Usuarios y grupos de ejecución.

echo "Vamos a comprobar si el usuario y el grupo del fichero de configuración de apache están igualados a 'www-data': "
lineaUser=$(grep ^User.* $rutaFicheroConfigApache)
lineaUser=${lineaUser#*\{}
lineaUser=${lineaUser%\}*}

lineaGrupo=$(grep ^Group.* $rutaFicheroConfigApache)
lineaGrupo=${lineaGrupo#*\{}
lineaGrupo=${lineaGrupo%\}*}

grep ^$lineaUser=www-data $ficheroVarEnt >> /dev/null
if [[ $? -eq 0 ]]
then 
	echo "El valor de la variable de entorno $lineaUser está establecida a www-data."
else
	#sed -i 's/^User.*/User www-data/' $ficheroVarEnt
	echo "El valor de la variable de entorno $lineaUser debe ser establecido a www-data."
fi

grep ^$lineaGrupo=www-data $ficheroVarEnt >> /dev/null
if [[ $? -eq 0 ]]
then 
	echo "El valor de la variable de entorno $lineaGrupo está establecida a www-data."
else
	#sed -i 's/^Group.*/Group www-data/' $ficheroVarEnt
	echo "El valor de la variable de entorno $lineaGrupo debe ser establecido a www-data."
fi


























