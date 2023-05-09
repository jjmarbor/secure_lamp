#! /bin/bash      
#Juan José Marruecos Borja

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

echo ""
echo "--------------------------------------------"
echo "##### Usuarios y grupos de ejecución. #####"
echo "--------------------------------------------"
echo ""

echo "Vamos a comprobar si el usuario y el grupo del fichero de configuración de apache están igualados a 'www-data': "
lineaUser=$(grep ^User.* $rutaFicheroConfigApache)
lineaUser=${lineaUser#*\{}
lineaUser=${lineaUser%\}*}

lineaGrupo=$(grep ^Group.* $rutaFicheroConfigApache)
lineaGrupo=${lineaGrupo#*\{}
lineaGrupo=${lineaGrupo%\}*}

if [[ $(grep ^$lineaUser=www-data $ficheroVarEnt) ]]
then 
	echo "El valor de la variable de entorno $lineaUser está establecida a www-data."
else
	#sed -i 's/^User.*/User www-data/' $ficheroVarEnt
	echo "El valor de la variable de entorno $lineaUser debe ser establecido a www-data."
fi

if [[ $(grep ^$lineaGrupo=www-data $ficheroVarEnt) ]]
then 
	echo "El valor de la variable de entorno $lineaGrupo está establecida a www-data."
else
	#sed -i 's/^Group.*/Group www-data/' $ficheroVarEnt
	echo "El valor de la variable de entorno $lineaGrupo debe ser establecido a www-data."
fi

#2. Deshabilitar módulos inecesarios

echo ""
echo "--------------------------------------------"
echo "##### Deshabilitar módulos inecesarios. #####"
echo "--------------------------------------------"
echo ""

sudo apachectl -M | grep "autoindex.*" 

if [[ $? -eq 0 ]] 
 then
 
    echo "Vamos a proceder a deshabilitar el módulo autoindex para impedir que muestre en la web el contenido de los directorios cuando no existe el index."

    # Sirve para no tener que escribir "Yes, do as I say!" una vez se ejecute el comando sudo a2dismod autoindex, para ello utilizamos el pipe ( '|' )
    echo "Yes, do as I say!" | sudo a2dismod autoindex
    
    read -p "Para efectuar el cambio debe reiniciar el servicio. ¿Desea reiniciarlo ahora?(S/N)" deseaReiniciar

    while [[ ! $deseaReiniciar =~ [SsNn] ]]
     do
	read -p "Para efectuar el cambio debe reiniciar el servicio. ¿Desea reiniciarlo ahora?(S/N)" deseaReiniciar
	echo $deseaReiniciar
     done

    if [[ $deseaReiniciar =~ [Ss] ]]
      then 
	systemctl restart apache2
	echo "El módulo autoindex se encuentra deshabilitado."
    else 
	echo "No se ha reiniciado el servicio."
    fi
	
else 
    echo "El módulo autoindex se encuentra deshabilitado."
fi




echo ""



