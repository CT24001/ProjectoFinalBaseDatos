-- SECCION A -  Consultas con INNER JOIN

-------------------          CONSULTA A1        ------------------------
--Consulta para conoces los proyectos que tiene la empresa y que empleados estan 
-- encargados de dichos proyectos y a que departamento esta y que rol cumple en dicho
--proyecto

SELECT e.nombre ||' '||e.apellido as NombreEmpleado, 
       d.nombre_departamento as Departamento,
       p.nombre_proyecto as ProyectoAsignado,
       a.rol_en_proyecto as Rol
FROM adminproyecto.EMPLEADO e 
INNER JOIN adminproyecto.Departamento d ON e.departamento_id = d.departamento_id
INNER JOIN adminproyecto.Asignacion a ON e.empleado_id = a.empleado_id
INNER JOIN adminproyecto.Proyecto p ON p.proyecto_id = a.proyecto_id;

-------------------          CONSULTA A2        ------------------------
-- Consulta que muestra la informacion de los proyectos , las asignaciones de trabajo
-- y que empleado es responsable de dicho proyecto en esta consulta solo se muestra 
-- los proyectos que estan activos
SELECT 
    p.nombre_proyecto AS "Proyecto Vigente",
    p.presupuesto AS "Presupuesto Asignado",
    e.nombre || ' ' || e.apellido AS "Empleado Asignado",
    a.rol_en_proyecto AS "Rol en el Equipo",
    a.horas_asignadas AS "Horas Semanales"
FROM adminProyecto.Proyecto p
INNER JOIN adminProyecto.Asignacion a ON p.proyecto_id = a.proyecto_id
INNER JOIN adminProyecto.Empleado e ON a.empleado_id = e.empleado_id
WHERE p.estado = 'Activo';

-------------------          CONSULTA A3        ------------------------
-- Consulta para saber los proyectos de cierto año en especifico y que empleados estan encargados
-- de dichos proyectos con sus respectivos departamentos
SELECT e.nombre ||' '||e.apellido as NombreEmpleado, 
       d.nombre_departamento as Departamento,
       p.nombre_proyecto as ProyectoAsignado,
       a.rol_en_proyecto as Rol
FROM adminProyecto.empleado e 
INNER JOIN adminProyecto.Departamento d ON e.departamento_id = d.departamento_id
INNER JOIN adminProyecto.Asignacion a ON e.empleado_id = a.empleado_id
INNER JOIN adminProyecto.Proyecto p ON p.proyecto_id = a.proyecto_id
WHERE fecha_inicio BETWEEN '01-01-2023' AND '31-12-2023';

-------------------          CONSULTA A4        ------------------------
-- Consulta que muestra los empleados que se han unido a la empresa en el año 2020
SELECT e.nombre ||' '||e.apellido as NombreEmpleado ,
       e.salario as Salario,
       d.nombre_departamento as Departamento,
       p.titulo_puesto as Puesto
FROM adminProyecto.empleado e
INNER JOIN adminProyecto.departamento d ON e.departamento_id = d.departamento_id
INNER JOIN adminProyecto.puesto p ON e.puesto_id = p.puesto_id
WHERE fecha_contratacion BETWEEN TO_DATE('01-01-2020', 'DD-MM-YYYY') AND TO_DATE('31-12-2020', 'DD-MM-YYYY');
       
-------------------          CONSULTA A5        ------------------------
-- Consulta con alias de columnas descriptivoos que presenta la informacion de los empleados
-- registrados
SELECT 
    e.nombre AS "Nombre del Trabajador",
    e.apellido AS "Apellido del Trabajador",
    e.email AS "Correo Electrónico",
    p.titulo_puesto AS "Cargo Ocupado",
    d.nombre_departamento AS "Unidad Organizativa"
FROM adminProyecto.Empleado e
INNER JOIN adminProyecto.Puesto p ON e.puesto_id = p.puesto_id
INNER JOIN adminProyecto.Departamento d ON e.departamento_id = d.departamento_id;


-------------------          CONSULTA A6        ------------------------
-- Consulta que responde en que region y pais se encuentra cada empleado
SELECT e.nombre ||' '||e.apellido as NombreEmpleado,
       d.nombre_departamento AS Departamento,
       p.nombre_pais AS Pais,
       r.nombre_region AS Region
FROM adminProyecto.empleado e
INNER JOIN adminProyecto.departamento d ON e.departamento_id = d.departamento_id
INNER JOIN adminProyecto.localizacion l ON d.localizacion_id = l.localizacion_id
INNER JOIN adminProyecto.pais p ON l.pais_id = p.pais_id
INNER JOIN adminProyecto.region r ON p.region_id = r.region_id








