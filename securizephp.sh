#! /bin/bash

rutaPhpINi= "/etc/apache2/php/php.ini"

#3. Open_basedir

echo "Comprobando el estado actual del parámetro open_basedir..."
grep ";open_basedir.*=.* " $rutaPhpIni

if [[ $? -eq 0 ]]
  then 
      grep "open_basedir.*=.*" $rutaPhpIni 
       if [[ $? -eq 1 ]]
        then 
          echo "El parámetro open_basedir se encuentra activo en este momento."
        fi
else 
	read -p "¿Desea activar el parámetro open_basedir?[S/N]" respuesta
	if [[ $respuesta == "S" || $respuesta == "s" ]]
	  then 
	    read -p "Introduzca el directorio que desea asignar al parámetro open_basedir: " ruta
	    while [ -d $ruta ]
	    do
	    	read -p "Introduzca el directorio que desea asignar al parámetro open_basedir: " ruta
	    done
	    sed -i "s/open_basedir.*=.*/open_basedir=$ruta" >> $rutaPhpINi
	fi
	
fi
