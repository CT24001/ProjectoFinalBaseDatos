-- Tabla para registrar excepciones (Requisito Obligatorio EXCEPTION)
CREATE TABLE LOG_ERRORES (
    id_log NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    usuario VARCHAR2(50) DEFAULT USER,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    codigo_error NUMBER,
    mensaje_error VARCHAR2(4000)
);

-- Tabla para el Trigger T1 (Auditoría sobre la tabla Empleado)
CREATE TABLE AUDITORIA_EMPLEADOS (
    id_auditoria NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    usuario VARCHAR2(50) DEFAULT USER,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    accion VARCHAR2(20), -- INSERT o UPDATE
    empleado_id NUMBER,
    salario_anterior NUMBER(8,2),
    salario_nuevo NUMBER(8,2),
    puesto_anterior VARCHAR2(10),
    puesto_nuevo VARCHAR2(10)
);

-- Mini-procedimiento autónomo para registrar los logs (Garantiza que se guarden aunque el proceso principal haga ROLLBACK)
CREATE OR REPLACE PROCEDURE sp_registrar_log (
    p_codigo IN NUMBER,
    p_mensaje IN VARCHAR2
) AS
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO LOG_ERRORES (codigo_error, mensaje_error)
    VALUES (p_codigo, p_mensaje);
    COMMIT;
END;
/