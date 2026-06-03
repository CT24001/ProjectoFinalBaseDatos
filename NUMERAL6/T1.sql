CREATE OR REPLACE TRIGGER T1_auditoria_empleado
AFTER INSERT OR UPDATE ON Empleado
FOR EACH ROW
DECLARE
    v_accion VARCHAR2(20);
BEGIN
    IF INSERTING THEN v_accion := 'INSERT'; ELSE v_accion := 'UPDATE'; END IF;

    INSERT INTO AUDITORIA_EMPLEADOS (
        usuario, fecha_hora, accion, empleado_id, 
        salario_anterior, salario_nuevo, puesto_anterior, puesto_nuevo
    ) VALUES (
        USER, SYSDATE, v_accion, :NEW.empleado_id,
        :OLD.salario, :NEW.salario, :OLD.puesto_id, :NEW.puesto_id
    );
END;
/