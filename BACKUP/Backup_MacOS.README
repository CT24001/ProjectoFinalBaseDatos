#EN EL CASO DE USAR DOCKKER SE REALIZA LO SIGUIENTE

###EXPORTACION###
#en macOS use este comando para exportar la base de datos completa a un archivo .dmp
docker exec -it oracle26ai expdp system@//localhost:1521/FREEPDB1 DIRECTORY=DATA_PUMP_DIR DUMPFILE=backup_completo_ues.dmp LOGFILE=backup_completo.log FULL=Y

# y con este comando copie el archivo .dmp al escritorio
docker cp oracle26ai:/opt/oracle/admin/FREE/dpdump/backup_completo_ues.dmp ~/Desktop/

###RESTAURACION###
#1.	Asegúrate de que el archivo backup_completo_ues.dmp esté ubicado en la misma ruta interna del Docker destino.
#2.	Ejecuta el comando de importación integral desde la terminal:

docker exec - it oracle26ai impdp system@//localhost:1521/FREEPDB1 DIRECTORY=DATA_PUMP_DIR DUMPFILE=backup_completo_ues.dmp LOGFILE=restauracion_completa.log FULL=Y

