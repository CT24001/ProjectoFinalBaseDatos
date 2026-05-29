CREATE OR REPLACE PROCEDURE sp_top_elementos (
    p_top_n IN NUMBER
) AS
    -- REQUISITO: Cursor explícito para procesar fila por fila
    CURSOR c_top_empleados IS
        SELECT e.empleado_id, e.nombre || ' ' || e.apellido AS nombre_completo, SUM(a.horas_asignadas) AS total_horas
        FROM Empleado e
        JOIN Asignacion a ON e.empleado_id = a.empleado_id
        GROUP BY e.empleado_id, e.nombre, e.apellido
        ORDER BY total_horas DESC;

    v_reg c_top_empleados%ROWTYPE;
    v_contador NUMBER := 0;
BEGIN
    IF p_top_n <= 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Error: El parámetro N debe ser un número entero positivo.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('=== KPI P2: RANKING TOP ' || p_top_n || ' EMPLEADOS CON MÁS HORAS ===');

    OPEN c_top_empleados;
    LOOP
        FETCH c_top_empleados INTO v_reg;
        EXIT WHEN c_top_empleados%NOTFOUND OR v_contador >= p_top_n;
        
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE(v_contador || '. ID: ' || v_reg.empleado_id || ' | ' || v_reg.nombre_completo || ' | Horas: ' || v_reg.total_horas);
    END LOOP;
    CLOSE c_top_empleados;

    IF v_contador = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No existen asignaciones de horas registradas en el sistema.');
    WHEN OTHERS THEN
        IF c_top_empleados%ISOPEN THEN CLOSE c_top_empleados; END IF;
        ROLLBACK;
        sp_registrar_log(SQLCODE, 'Error en sp_top_elementos: ' || SQLERRM);
        RAISE_APPLICATION_ERROR(-20099, 'Error crítico inesperado. Revisar LOG_ERRORES.');
END;
/