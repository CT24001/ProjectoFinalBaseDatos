CREATE USER usr_lectura IDENTIFIED BY "UesLectura2026";
CREATE USER usr_admin IDENTIFIED BY "UesAdmin2026";

ALTER USER usr_lectura QUOTA UNLIMITED ON USERS;
ALTER USER usr_admin QUOTA UNLIMITED ON USERS;

GRANT CREATE SESSION TO usr_lectura;
GRANT CREATE SESSION TO usr_admin;

-- usr_lectura: Solo SELECT de negocio
GRANT SELECT ON Region TO usr_lectura;
GRANT SELECT ON Pais TO usr_lectura;
GRANT SELECT ON Localizacion TO usr_lectura;
GRANT SELECT ON Puesto TO usr_lectura;
GRANT SELECT ON Departamento TO usr_lectura;
GRANT SELECT ON Empleado TO usr_lectura;
GRANT SELECT ON Historial_Puesto TO usr_lectura;
GRANT SELECT ON Proyecto TO usr_lectura;
GRANT SELECT ON Asignacion TO usr_lectura;

-- usr_admin: EXECUTE de lógica y DML sobre auditoría/logs
GRANT EXECUTE ON sp_resumen_periodo TO usr_admin;
GRANT EXECUTE ON sp_top_elementos TO usr_admin;
GRANT EXECUTE ON sp_indicadores_categoria TO usr_admin;
GRANT EXECUTE ON sp_alertas_negocio TO usr_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON AUDITORIA_EMPLEADOS TO usr_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON LOG_ERRORES TO usr_admin;