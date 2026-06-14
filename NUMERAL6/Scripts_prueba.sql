--P1 comando de prueba
SET SERVEROUTPUT ON;

BEGIN 
    adminProyecto.sp_resumen_periodo(TO_DATE('01/01/2023', 'DD/MM/YYYY'), TO_DATE('31/12/2023', 'DD/MM/YYYY')); 
END;
/
--P2 comando de prueba
SET SERVEROUTPUT ON;

BEGIN
    adminProyecto.sp_top_elementos(3);
END;
/
--P3 comando de prueba
SET SERVEROUTPUT ON;

BEGIN
    adminProyecto.sp_indicadores_categoria;
END;
/
--P4 comando de prueba
SET SERVEROUTPUT ON;

BEGIN
    adminProyecto.sp_alertas_negocio;
END;
/

--TRIGGERS--
-- ================================================================
-- SCRIPT DE PRUEBA REAL PARA EL TRIGGER T1 (AUDITORÍA)
-- =====================================================================

-- PASO 1: Modificar el salario de Juan Pérez (ID: 1) para activar el Trigger
UPDATE adminProyecto.Empleado 
SET salario = 3200.00
WHERE empleado_id = 1;

-- PASO 2: Confirmar la transacción para que impacte la base de datos
COMMIT;

-- PASO 3: Verificar que el Trigger T1 registró el movimiento en milisegundos
SELECT usuario, fecha_hora, accion, empleado_id, salario_anterior, salario_nuevo
FROM adminProyecto.AUDITORIA_EMPLEADOS
WHERE empleado_id = 1
ORDER BY fecha_hora DESC;

-- ======================================================================
-- SCRIPT DE PRUEBA REAL PARA EL TRIGGER T2 (INTEGRIDAD DE NEGOCIO)
-- =====================================================================
SET SERVEROUTPUT ON;

-- PASO 1: Intentar insertar una asignación que rompe la regla de inmediato (50 horas)
-- (Suponiendo que el proyecto_id 'PROY-01' o un ID numérico que tengás exista)
INSERT INTO adminProyecto.Asignacion (empleado_id, proyecto_id, horas_asignadas)
VALUES (1, 10, 50.00); 

