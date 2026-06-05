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


-- usr_lectura: Solo SELECT de negocio (Apuntando al esquema ADMINPROYECTO)

GRANT SELECT ON ADMINPROYECTO.Region TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Pais TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Localizacion TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Puesto TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Departamento TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Empleado TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Historial_Puesto TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Proyecto TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Asignacion TO usr_lectura;

-- Permiso para que usr_lectura pueda ver las VISTAS del proyecto
GRANT SELECT ON ADMINPROYECTO.vw_resumen_proyectos TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.vw_detalle_empleados TO usr_lectura;


-- usr_admin: EXECUTE de lógica y DML sobre auditoría/logs

GRANT EXECUTE ON ADMINPROYECTO.sp_resumen_periodo TO usr_admin;
GRANT EXECUTE ON ADMINPROYECTO.sp_top_elementos TO usr_admin;
GRANT EXECUTE ON ADMINPROYECTO.sp_indicadores_categoria TO usr_admin;
GRANT EXECUTE ON ADMINPROYECTO.sp_alertas_negocio TO usr_admin;

-- Permisos DML sobre las tablas 
GRANT SELECT, INSERT, UPDATE, DELETE ON ADMINPROYECTO.AUDITORIA_EMPLEADOS TO usr_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADMINPROYECTO.LOG_ERRORES TO usr_admin;