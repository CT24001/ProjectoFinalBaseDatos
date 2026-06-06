-- 1. Forzar entrada a la PDB del proyecto en Docker
ALTER SESSION SET CONTAINER = FREEPDB1;

-- 2. Limpieza automática para evitar el choque ORA-01920 si ya existían
DROP USER usr_lectura CASCADE;
DROP USER usr_admin CASCADE;

-- 3. Creación de los usuarios del sistema
CREATE USER usr_lectura IDENTIFIED BY "UesLectura2026";
CREATE USER usr_admin IDENTIFIED BY "UesAdmin2026";

-- Asignación obligatoria del tablespace USERS
ALTER USER usr_lectura DEFAULT TABLESPACE USERS;
ALTER USER usr_lectura QUOTA UNLIMITED ON USERS;

ALTER USER usr_admin DEFAULT TABLESPACE USERS;
ALTER USER usr_admin QUOTA UNLIMITED ON USERS;

-- Permiso para que puedan iniciar sesión en Oracle
GRANT CREATE SESSION TO usr_lectura;
GRANT CREATE SESSION TO usr_admin;

-- ASIGNACIÓN DE PRIVILEGIOS A: usr_lectura

-- 1. Lectura sobre las 8 Tablas Base de Negocio
GRANT SELECT ON ADMINPROYECTO.Region TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Pais TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Localizacion TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Puesto TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Departamento TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Empleado TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Historial_Puesto TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Proyecto TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Asignacion TO usr_lectura;

-- 2. Lectura sobre las NUEVAS VISTAS REALES de la Sección E (CORREGIDO)
GRANT SELECT ON ADMINPROYECTO.vista_empleados_operativa TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.vista_reporting_departamentos TO usr_lectura;


-- ASIGNACIÓN DE PRIVILEGIOS A: usr_admin

-- 1. Ejecución sobre los 4 Procedimientos Almacenados (P1, P2, P3, P4)
GRANT EXECUTE ON ADMINPROYECTO.SP_RESUMEN_PERIODO TO usr_admin;
GRANT EXECUTE ON ADMINPROYECTO.SP_TOP_ELEMENTOS TO usr_admin;
GRANT EXECUTE ON ADMINPROYECTO.SP_INDICADORES_CATEGORIA TO usr_admin;
GRANT EXECUTE ON ADMINPROYECTO.SP_ALERTAS_NEGOCIO TO usr_admin;

-- 2. Permisos DML totales sobre las tablas de soporte (logs e infraestructura)
GRANT SELECT, INSERT, UPDATE, DELETE ON ADMINPROYECTO.AUDITORIA_EMPLEADOS TO usr_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADMINPROYECTO.LOG_ERRORES TO usr_admin;