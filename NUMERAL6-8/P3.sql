CREATE OR REPLACE PROCEDURE sp_indicadores_categoria AS
    v_activos NUMBER := 0; v_inactivos NUMBER := 0;
    v_monto_activos NUMBER(12,2) := 0; v_monto_inactivos NUMBER(12,2) := 0;
    v_variacion_pct NUMBER(5,2) := 0;
BEGIN
    SELECT COUNT(*), NVL(SUM(presupuesto), 0) INTO v_activos, v_monto_activos FROM Proyecto WHERE estado = 'Activo';
    SELECT COUNT(*), NVL(SUM(presupuesto), 0) INTO v_inactivos, v_monto_inactivos FROM Proyecto WHERE estado = 'Inactivo';

    IF v_monto_inactivos > 0 THEN
        v_variacion_pct := ((v_monto_activos - v_monto_inactivos) / v_monto_inactivos) * 100;
    ELSE
        v_variacion_pct := 100.00; -- Crecimiento neto absoluto si el histórico inactivo es cero
    END IF;

    DBMS_OUTPUT.PUT_LINE('=== KPI P3: COMPARATIVO Y CRECIMIENTO POR CATEGORÍA ===');
    DBMS_OUTPUT.PUT_LINE('Proyectos Activos   : ' || v_activos || ' | Presupuesto: $' || TO_CHAR(v_monto_activos, '999,999,990.00'));
    DBMS_OUTPUT.PUT_LINE('Proyectos Inactivos : ' || v_inactivos || ' | Presupuesto: $' || TO_CHAR(v_monto_inactivos, '999,999,990.00'));
    DBMS_OUTPUT.PUT_LINE('Variación Porcentual de Capital Activo vs Inactivo: ' || v_variacion_pct || '%');

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        sp_registrar_log(SQLCODE, 'Error en sp_indicadores_categoria: ' || SQLERRM);
        RAISE_APPLICATION_ERROR(-20099, 'Error crítico inesperado. Revisar LOG_ERRORES.');
END;
/