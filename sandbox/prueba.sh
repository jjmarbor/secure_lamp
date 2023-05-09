# /bin/bash


read -p "Para efectuar el cambio debe reiniciar el servicio. ¿Desea reiniciarlo ahora?(S/N)" deseaReiniciar

while [[ ! $deseaReiniciar =~ [SsNn] ]]
     do
	read -p "Para efectuar el cambio debe reiniciar el servicio. ¿Desea reiniciarlo ahora?(S/N)" deseaReiniciar
	echo $deseaReiniciar
done
     
echo "Salgo del bucle"


# || $deseaReiniciar != "S" || $deseaReiniciar != "n" || $deseaReiniciar != "N"
