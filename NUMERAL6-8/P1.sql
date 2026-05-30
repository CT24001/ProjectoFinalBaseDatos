CREATE OR REPLACE PROCEDURE sp_resumen_periodo (
    p_fecha_inicio IN DATE,
    p_fecha_fin IN DATE
) AS
    v_volumen       NUMBER := 0;
    v_monto_total   NUMBER(12,2) := 0;
    v_promedio      NUMBER(12,2) := 0;
BEGIN
    -- Error personalizado
    IF p_fecha_inicio > p_fecha_fin THEN
        RAISE_APPLICATION_ERROR(-20005, 'Error: La fecha de inicio no puede ser posterior a la fecha fin.');
    END IF;

    SELECT COUNT(*), NVL(SUM(presupuesto), 0), NVL(AVG(presupuesto), 0)
    INTO v_volumen, v_monto_total, v_promedio
    FROM Proyecto
    WHERE fecha_inicio BETWEEN p_fecha_inicio AND p_fecha_fin;

    -- Forzar excepción predefinida si no hay registros
    IF v_volumen = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;

    DBMS_OUTPUT.PUT_LINE('=== KPI P1: RESUMEN DE PROYECTOS EN EL PERIODO ===');
    DBMS_OUTPUT.PUT_LINE('Volumen de operaciones : ' || v_volumen || ' proyecto(s)');
    DBMS_OUTPUT.PUT_LINE('Monto total invertido  : $' || TO_CHAR(v_monto_total, '999,999,990.00'));
    DBMS_OUTPUT.PUT_LINE('Promedio por operación : $' || TO_CHAR(v_promedio, '999,999,990.00'));

    COMMIT; -- Control explícito de transacciones
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se encontraron proyectos en el período especificado.');
    WHEN TOO_MANY_ROWS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'Error crítico: La consulta devolvió demasiadas filas.');
    WHEN OTHERS THEN
        ROLLBACK;
        sp_registrar_log(SQLCODE, 'Error en sp_resumen_periodo: ' || SQLERRM);
        RAISE_APPLICATION_ERROR(-20099, 'Error crítico inesperado. Revisar LOG_ERRORES.');
END;
/