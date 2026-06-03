CREATE OR REPLACE TRIGGER T2_integridad_horas
BEFORE INSERT OR UPDATE ON Asignacion
FOR EACH ROW
DECLARE
    v_horas_totales NUMBER(5,2) := 0;
BEGIN
    SELECT NVL(SUM(horas_asignadas), 0) INTO v_horas_totales
    FROM Asignacion
    WHERE empleado_id = :NEW.empleado_id AND proyecto_id <> NVL(:OLD.proyecto_id, -1);

    IF (v_horas_totales + :NEW.horas_asignadas) > 40.00 THEN
        RAISE_APPLICATION_ERROR(-20010, 'Regla de negocio: El empleado excede las 40 horas máximas permitidas por semana.');
    END IF;
END;
/