-- ================================================================================
-- SECCIÓN E - VISTAS (VIEWS)
-- ================================================================================

-- --------------------------------------------------------------------------------
-- E1 - Vista operativa de empleados (información completa para consultas diarias)
-- --------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vista_empleados_operativa AS
SELECT 
    e.empleado_id,
    e.nombre || ' ' || e.apellido AS nombre_completo,      -- Nombre completo concatenado
    e.email,
    e.telefono,
    TO_CHAR(e.fecha_contratacion, 'DD/MM/YYYY') AS fecha_contratacion,  -- Fecha formateada
    TO_CHAR(e.salario, 'FM$999,999.99') AS salario_formateado,          -- Salario con formato moneda
    e.comision_pct,
    p.titulo_puesto,                                      -- Título del puesto desde tabla Puesto
    d.nombre_departamento,                                -- Departamento del empleado
    jefe.nombre || ' ' || jefe.apellido AS nombre_jefe,   -- Nombre del jefe (LEFT JOIN permite nulos)
    l.ciudad,                                             -- Ubicación geográfica
    l.provincia,
    pa.nombre_pais,
    r.nombre_region,
    ROUND((SYSDATE - e.fecha_contratacion) / 365, 1) AS anios_antiguedad  -- Años trabajados
FROM empleado e
INNER JOIN puesto p ON e.puesto_id = p.puesto_id
INNER JOIN departamento d ON e.departamento_id = d.departamento_id
LEFT JOIN empleado jefe ON e.manager_id = jefe.empleado_id    -- LEFT JOIN porque CEO no tiene jefe
LEFT JOIN localizacion l ON d.localizacion_id = l.localizacion_id
LEFT JOIN pais pa ON l.pais_id = pa.pais_id
LEFT JOIN region r ON pa.region_id = r.region_id;

-- --------------------------------------------------------------------------------
-- Consulta de prueba: Visualizar primeros 10 registros de la vista
-- --------------------------------------------------------------------------------
SELECT * FROM vista_empleados_operativa WHERE ROWNUM <= 10;

-- --------------------------------------------------------------------------------
-- E2 - Vista de reporting para análisis gerencial por departamento
-- --------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vista_reporting_departamentos AS
SELECT 
    d.nombre_departamento,
    COUNT(e.empleado_id) AS total_empleados,                               -- Cantidad de empleados
    ROUND(AVG(e.salario), 2) AS salario_promedio,                         -- Promedio salarial
    TO_CHAR(SUM(e.salario), 'FM$999,999,999.00') AS salario_total_formateado,  -- Masa salarial
    TO_CHAR(MIN(e.salario), 'FM$999,999.00') AS salario_minimo,            -- Salario más bajo
    TO_CHAR(MAX(e.salario), 'FM$999,999.00') AS salario_maximo,            -- Salario más alto
    TO_CHAR(MAX(e.fecha_contratacion), 'DD/MM/YYYY') AS ultima_contratacion,  -- Empleado más nuevo
    TO_CHAR(MIN(e.fecha_contratacion), 'DD/MM/YYYY') AS primera_contratacion,  -- Empleado más antiguo
    ROUND((SYSDATE - MIN(e.fecha_contratacion)) / 365, 1) AS anios_desde_primer_empleado  -- Madurez del equipo
FROM departamento d
LEFT JOIN empleado e ON d.departamento_id = e.departamento_id    -- LEFT JOIN muestra departamentos sin empleados
GROUP BY d.nombre_departamento;

-- --------------------------------------------------------------------------------
-- Consulta de prueba: Departamentos ordenados por salario promedio descendente
-- --------------------------------------------------------------------------------
SELECT * 
FROM vista_reporting_departamentos
ORDER BY salario_promedio DESC;

-- ================================================================================
-- Todas las consultas y vistas han sido ejecutadas correctamente.
-- ================================================================================