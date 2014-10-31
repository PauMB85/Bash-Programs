#!/bin/bash                                                                                                     

###################################################################################                             
#Autor: PauMB                                                                     #                             
#Programa:Replica del comando "SCP", para subir 'un' archivo a una maquina remota #                             
#         No re se realiza con 'expect' por seguridad                             #                             
###################################################################################                             


#funcion que nos indica como utilizar el script                                                                 
function help {
    echo "Uso: ./upFileMR Nombre_Maquina Archivo"
    exit 1
}

#numero de argumentos
argumentos=$#

#si se introducen mal el numero de arguemntos                                                                   
if [ $argumentos -ne 2 ];then
    help
fi

#asignamos arguemntos                                                                                           
dirSSH=$1
file=$2

#variable que se utiliza para indicar si se ha encontrado la maquina remota
encontrado=0

#buscamos la direccion remota                                                                                   
while IFS=: read nombre direccion passwd #se deja el passwd, si en un futuro                                    
                                         #se emplea expect                                                      
do

    if [ $dirSSH = $nombre ];then 
        #esto es para debug                                                          
        echo "Se trata de: $nombre"
        echo "su direccion es: $direccion"
        echo "con el passwd: $passwd"
        #
        encontrado=1
        break
    fi
done < ~/Documents/Pau/ProgsBash/maquinaRemota #aqui poner ruta del documento donde                             
                                      #se guardan las direcciones de las Maquinas Remotas    

if [ $encontrado -eq 0 ];then
    echo "La maquina no se encuentra en la lista o esta mal escrito"
    help
fi

#subimos el archivo mediante el comando scp                                                                     
#local --> remoto                                                                                               
scp $file $direccion:

#vendria expect, para automatizarlo                                                                             


#fin                                                                                                            
exit 0
