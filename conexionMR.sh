#!/bin/bash                                                                                                     

#################################################################################                               
#Autor: PauMB                                                                   #                               
#Programa:Replica del comando "SSH", para conectarse  a una maquina remota      #                               
#         No re se realiza con 'expect' por seguridad                           #                               
#################################################################################                               


#funcion que nos indica como utilizar el script                                                                 
function help {
    echo "Uso: ./subirRemoto.sh dirRemoto\n"
    exit 1
}

argumentos=$#

#si se entroducen mal el numero dearguemntos                                                                            
if [ $argumentos -ne 1 ]; then
    help
fi
#asignamos argumentos                                                                                           
dirSSH=$1

#variable que nos india si se ha encontrado la maquina remota
encontrado=0

#buscamos la direccion remota                                                                                   
while IFS=: read nombre direccion passwd #se deja el pass, si en un futuro se desea                             
                                         #relaizar                                                              
do

    if [ $dirSSH = $nombre ]; then   #esto es para debug                                                        
        echo -e "Se trata de: $nombre                                                                           
                \nsu direccion es: $direccion                                                                   
                \ncon el passwd: $passwd"
        encontrado=1
        break
    fi
done < ~/Documents/Pau/ProgsBash/maquinaRemota #aqui poner ruta del documento donde                             
                                     #se guardan las dirrecciones de las maquinas remotas                       
if [ $encontrado -eq 0 ];then
    echo "La mquina no se encuentra en la lista o esta mal escrito"
    help
fi
#conexion ssh                                                                                                   
ssh $direccion

#aqui vendria expect para automatizar la conexion                                                               

#Fin                                                                                                            
exit 0
