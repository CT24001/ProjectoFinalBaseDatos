CREATE OR REPLACE PROCEDURE sp_alertas_negocio AS
    v_alertas NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== KPI P4: ALERTAS OPERATIVAS Y ESTADOS CRÍTICOS ===');

    -- Alerta 1: Desajustes de umbrales salariales
    FOR r_emp IN (
        SELECT e.nombre || ' ' || e.apellido AS emp, e.salario, p.titulo_puesto, p.salario_max
        FROM adminProyecto.Empleado e JOIN adminProyecto.Puesto p ON e.puesto_id = p.puesto_id
        WHERE e.salario > p.salario_max
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('[CRÍTICO - SALARIO] ' || r_emp.emp || ' gana $' || r_emp.salario || ' superando el máximo de ' || r_emp.titulo_puesto || ' ($' || r_emp.salario_max || ')');
        v_alertas := v_alertas + 1;
    END LOOP;

    -- Alerta 2: Proyectos con vencimiento superado e incumplido
    FOR r_proy IN (
        SELECT nombre_proyecto, fecha_fin FROM Proyecto 
        WHERE estado = 'Activo' AND fecha_fin < SYSDATE
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('[CRÍTICO - VENCIMIENTO] Proyecto "' || r_proy.nombre_proyecto || '" sigue Activo a pesar de haber vencido el ' || TO_CHAR(r_proy.fecha_fin, 'DD/MM/YYYY'));
        v_alertas := v_alertas + 1;
    END LOOP;

    IF v_alertas = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Sistema operando bajo condiciones óptimas. Cero estados críticos.');
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        sp_registrar_log(SQLCODE, 'Error en sp_alertas_negocio: ' || SQLERRM);
        RAISE_APPLICATION_ERROR(-20099, 'Error crítico inesperado. Revisar LOG_ERRORES.');
END;
/