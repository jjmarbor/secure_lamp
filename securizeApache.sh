#! /bin/bash

echo " __                      _             _      ___  _      ___         __  "
echo "/ _\ ___  ___ _   _ _ __(_)_______    /_\    / _ \/_\    / __\ /\  /\/__\ "
echo "\ \ / _ \/ __| | | | '__| |_  / _ \  //_ \  / /_)//_ \  / /   / /_/ /_\   "
echo "_\ \  __/ (__| |_| | |  | |/ /  __/ /  _  \/ ___/  _  \/ /___/ __  //__   "
echo "\__/\___|\___|\__,_|_|  |_/___\___| \_/ \_/\/   \_/ \_/\____/\/ /_/\__/   "
echo ""

# Usuarios y grupos de ejecución.

echo "Vamos a comprobar si el usuario y el grupo del fichero de configuración de apache están igualados a 'www-data'."
lineaUser=$(grep ^User.* /etc/apache2/apache2.conf)
lineaUser=${lineaUser#*\{}
lineaUser=${lineaUser%\}*}
echo $lineaUser

lineaGrupo=$(grep ^Group.* /etc/apache2/apache2.conf)
lineaGrupo=${lineaGrupo#*\{}
lineaGrupo=${lineaGrupo%\}*}
echo $lineaGrupo





























