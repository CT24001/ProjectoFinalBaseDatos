-- OBLIGATORIO: Asegurar que se ejecute dentro de la PDB del proyecto
ALTER SESSION SET CONTAINER = FREEPDB1;

-- LIMPIEZA PREVIA (Opcional, pero evita que falle si ya existen los usuarios)
DROP USER usr_lectura CASCADE;
DROP USER usr_admin CASCADE;

--LÍNEAS ORIGINALES DE CREACIÓN Y CONEXIÓN
CREATE USER usr_lectura IDENTIFIED BY "UesLectura2026";
CREATE USER usr_admin IDENTIFIED BY "UesAdmin2026";

ALTER USER usr_lectura DEFAULT TABLESPACE USERS; -- Agregado para asegurar orden
ALTER USER usr_lectura QUOTA UNLIMITED ON USERS;
ALTER USER usr_admin DEFAULT TABLESPACE USERS;   -- Agregado para asegurar orden
ALTER USER usr_admin QUOTA UNLIMITED ON USERS;

GRANT CREATE SESSION TO usr_lectura;
GRANT CREATE SESSION TO usr_admin;

--usr_lectura: Solo SELECT de negocio (CON EL PREFIJO CORRECTO)

GRANT SELECT ON ADMINPROYECTO.Region TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Pais TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Localizacion TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Puesto TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Departamento TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Empleado TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Historial_Puesto TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Proyecto TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.Asignacion TO usr_lectura;

--AGREGADO: Permisos para las vistas 
GRANT SELECT ON ADMINPROYECTO.vw_resumen_proyectos TO usr_lectura;
GRANT SELECT ON ADMINPROYECTO.vw_detalle_empleados TO usr_lectura;

--usr_admin: EXECUTE de lógica y DML sobre auditoría/logs (CON PREFIJO)

GRANT EXECUTE ON ADMINPROYECTO.sp_resumen_periodo TO usr_admin;
GRANT EXECUTE ON ADMINPROYECTO.sp_top_elementos TO usr_admin;
GRANT EXECUTE ON ADMINPROYECTO.sp_indicadores_categoria TO usr_admin;
GRANT EXECUTE ON ADMINPROYECTO.sp_alertas_negocio TO usr_admin;

GRANT SELECT, INSERT, UPDATE, DELETE ON ADMINPROYECTO.AUDITORIA_EMPLEADOS TO usr_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADMINPROYECTO.LOG_ERRORES TO usr_admin;