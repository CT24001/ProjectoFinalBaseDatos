FASE I: CONFIGURACIÓN DE INFRAESTRUCTURA GLOBAL
•	Conexión Requerida: SYSTEM
•	Archivos a Ejecutar (en orden):
	1.	tablespace.sql
	2.	Usuario_administrador.sql
•	Acciones Principales: Inicializa el almacenamiento físico y crea el esquema propietario del desarrollo (adminProyecto), otorgándole los privilegios iniciales de sesión y cuota ilimitada de almacenamiento.

FASE II: DESPLIEGUE DEL MODELO DE RELACIÓN DE NEGOCIO (DDL)
•	Conexión Requerida: adminProyecto
•	Archivos a Ejecutar:
	1.	Proyecto.sql
•	Acciones Principales: Registra y estructura las 8 tablas base de la empresa en el diccionario de datos. Se inyecta la restricción del jefe de departamento al cierre del script mediante un comando ALTER TABLE para prevenir dependencias cíclicas.

FASE III: COMPILACIÓN DE COMPONENTES LÓGICOS, LOGS Y CAPA ANALÍTICA
•	Conexión Requerida: adminProyecto (Mantener sesión activa)
•	Archivos a Ejecutar (en orden):
	1.	soporte_infraestructura_logs.sql (Instancia las tablas LOG_ERRORES y AUDITORIA_EMPLEADOS)
	2.	(Ejecutar la Sección E de Vistas en la hoja de trabajo) (Crea vista_empleados_operativa y vista_reporting_departamentos)
	3.	P1.sql (Compila SP_RESUMEN_PERIODO)
	4.	P2.sql (Compila SP_TOP_ELEMENTOS)
	5.	P3.sql (Compila SP_INDICADORES_CATEGORIA)
	6.	P4.sql (Compila SP_ALERTAS_NEGOCIO)
	7.	T1.sql (Compila Trigger de auditoría)
	8.	T2.sql (Compila Trigger secundario)
•	Acciones Principales: Procesa las consultas encapsuladas de la capa analítica de negocio y compila la lógica de subprogramas y disparadores de manera directa dentro del esquema propietario.

FASE IV: POBLACIÓN DE DATOS (DML)
•	Conexión Requerida: adminProyecto (Mantener sesión activa)
•	Archivos a Ejecutar:
	1.	Proyecto- AgrendadoDatos.sql
•	Acciones Principales: Ejecuta la inserción masiva de los registros de prueba en las tablas base para poblar el sistema y validar el correcto funcionamiento de los disparadores (Triggers) de auditoría recién compilados.

FASE V: APLICACIÓN DEL MODELO DE SEGURIDAD (GRANTING)
•	Conexión Requerida: SYSTEM
•	Archivos a Ejecutar:
	1.	Script_seguridad_usuario_roles.sql
•	Acciones Principales: Remate final de la arquitectura. Elimina de manera preventiva y crea en limpio las cuentas operacionales de usuario final (usr_lectura y usr_admin), otorgando los accesos específicos y permisos cruzados (GRANT) sobre los objetos existentes del esquema de negocio.

FASE VI: VALIDACIÓN Y PRUEBAS DE CAJA NEGRA
•	Conexión Requerida: Cuentas operativas específicas (usr_lectura o usr_admin)
•	Archivos a Ejecutar:
	1.	Scripts_prueba.sql
•	Acciones Principales: Ejecuta los queries de validación y llamadas de subprogramas en los entornos de producción final para comprobar el cumplimiento de los privilegios asignados según la rúbrica de control de accesos.