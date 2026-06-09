-- 1. Forzar entrada a la PDB
ALTER SESSION SET CONTAINER = FREEPDB1;

-- 2. Asegurar que las cuentas de la rúbrica utilicen obligatoriamente el tablespace USERS
ALTER USER usr_lectura DEFAULT TABLESPACE USERS;
ALTER USER usr_lectura QUOTA UNLIMITED ON USERS;

ALTER USER usr_admin DEFAULT TABLESPACE USERS;
ALTER USER usr_admin QUOTA UNLIMITED ON USERS;

