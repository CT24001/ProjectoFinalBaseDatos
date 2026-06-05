
-- Vista 1: Resumen de Proyectos 
-- Cruza los proyectos con sus asignaciones de empleados

CREATE OR REPLACE VIEW vw_resumen_proyectos AS
SELECT 
    p.proyecto_id,
    p.nombre_proyecto,
    p.presupuesto,
    p.estado,
    COUNT(a.empleado_id) AS total_empleados_asignados
FROM Proyecto p
LEFT JOIN Asignacion a ON p.proyecto_id = a.proyecto_id
GROUP BY p.proyecto_id, p.nombre_proyecto, p.presupuesto, p.estado;


-- Vista 2: Detalle de Empleados 
-- Junta los datos del empleado con su puesto y su departamento

CREATE OR REPLACE VIEW vw_detalle_empleados AS
SELECT 
    e.empleado_id,
    e.nombre || ' ' || e.apellido AS nombre_completo,
    e.email,
    e.salario,
    pu.titulo_puesto,
    d.nombre_departamento
FROM Empleado e
LEFT JOIN Puesto pu ON e.puesto_id = pu.puesto_id
LEFT JOIN Departamento d ON e.departamento_id = d.departamento_id;