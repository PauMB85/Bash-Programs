#!/bin/bash                                                                                                       

####################################################################################                              
#Autor: PauMB                                                                      #                              
#Programa:Replica del comando "SCP", para bajar 'un' archivo de una maquina remota #                              
#         No re se realiza con 'expect' por seguridad                              #                              
####################################################################################                              

#funcion que nos indica como utilizar el script                                                                   
function help {
    echo "Uso: downFileMR.sh Nombre_Maquina Archivo_Origen(MR)"
    exit 1
}

#numero de argumentos                                                                                             
argumentos=$#

#si se introducen mal el numero de argumentos                                                                     
if [ $argumentos -ne 2 ]; then
    help
fi

#asignamos argumentos                                                                                             
nombreMR=$1
file=$2
encontrado=0

#buscamos la direccion remota                                                                                     
while IFS=: read nombre dirSSH passwd #se deja el passwd, si en un futuro                                         
                                      #se emplea expect                                                           
do
    if [ $nombreMR = $nombre ]; then 
        #esto es para debug                                                          
        #echo "Se trata de: $nombre"                                                                              
        #echo "su direccion es: $dirSSH"                                                                          
        #echo "con el passwd: $passwd" 
        #
        encontrado=1
        break
    fi
done < ~/Documents/Pau/ProgsBash/maquinaRemota #aqi poner ruta del documentos donde                               
                                               #se guardan las direcciones de la Maquinas Remotas                 

if [ $encontrado -eq 0 ]; then
    echo "La maquina no se encuentra en la lista o esta mal escrito"
    help
fi

#descargamos el archivo mediante el comando scp                                                                   
#remoto --> local                                                                                                 
scp $dirSSH:$file . #el archivo se descarga en el directorio actual                                               

#aqui vendria "expect", para automatizarlo                                                                        

#fin                                                                                                              
exit 0
