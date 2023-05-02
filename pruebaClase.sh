#!/bin/bash

echo "Comprobamos los usuarios anónimos y se muestran por pantalla: "
 mysql -u root -p $contrasenaRoot <<EOF
 use mysql;
 SELECT COUNT(user) AS "Número de usuarios anónimos" FROM user WHERE user="" OR user="test";
 exit
EOF
