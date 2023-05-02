#! /bin/bash


echo "   _____                      _           _____  _    _ _____    "
echo "  / ____|                    (_)         |  __ \| |  | |  __ \   "
echo " | (___   ___  ___ _   _ _ __ _ _______  | |__) | |__| | |__) |  "
echo "  \___ \ / _ \/ __| | | | '__| |_  / _ \ |  ___/|  __  |  ___/   " 
echo "  ____) |  __/ (__| |_| | |  | |/ /  __/ | |    | |  | | |       "
echo " |_____/ \___|\___|\__,_|_|  |_/___\___| |_|    |_|  |_|_|       "
echo ""
                                                               

#rutaPhpIni= "/etc/php/7.4/apache2/php.ini"
rutaPHP="php.ini"

#3. Open_basedir

echo "Comprobando el estado actual del parámetro open_basedir..."
grep ";open_basedir.*=.* " $rutaPHP

if [[ $? -eq 0 ]]
  then 
      grep "open_basedir.*=.*" $rutaPHP 
       if [[ $? -eq 1 ]]
        then 
          echo "El parámetro open_basedir se encuentra activo en este momento."
        fi
else 
	echo "El parámetro open_basedir se encuentra inactivo."
	read -p "¿Desea activar el parámetro open_basedir?[S/N]" respuesta
	if [[ $respuesta == "S" || $respuesta == "s" ]]
	  then 
	    read -p "Introduzca el directorio que desea asignar al parámetro open_basedir: " ruta
	    until [ -d $ruta ]
	    do
	    	read -p "Introduzca el directorio que desea asignar al parámetro open_basedir: " ruta
	    done
	    sed -i "s/;open_basedir.*=.*/open_basedir=$ruta/g" $rutaPHP
	fi
fi


#5. Remote File Inclusion (RFI)


ficheroReal="/etc/php/7.4/apache2/php.ini"
ficheroReal="php.ini" 				#Borrar esta línea para ejecutar en producción.

grep '^allow_url_fopen.*=.*Off' $ficheroReal

if [[ $? = 0 ]]
 then 
 	echo "El parámetro allow_url_fopen está en Off"
 else 
 	echo "El parámetro allow_url_fopen se encontraba en ON y ahora está en Off."
  	sed -i 's/^allow_url_fopen.*/allow_url_fopen = Off/' $ficheroReal
 fi
 

grep '^allow_url_include.*=.*Off' $ficheroReal

if [[ $? = 0 ]]
 then 
 	echo "El parámetro allow_url_include está en Off"
 else 
 	echo "El parámetro allow_url_fopen se encontraba en ON y ahora está en Off."
  	sed -i 's/^allow_url_include.*/allow_url_include = Off/' $ficheroReal
 fi















































