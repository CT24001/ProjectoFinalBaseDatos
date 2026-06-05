-- 1. Forzar entrada a la PDB del proyecto
ALTER SESSION SET CONTAINER = FREEPDB1;

-- 2. Limpieza por si ya habían hecho intentos erróneos
DROP USER adminProyecto CASCADE;

-- 3. Creación del administrador del negocio
CREATE USER adminProyecto
IDENTIFIED BY 2468
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS;

-- 4. Superpoderes para que pueda crear el script principal y la lógica
GRANT CREATE SESSION TO adminProyecto;
GRANT DBA TO adminProyecto;
