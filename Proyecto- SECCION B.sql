-- SECCION B -  Consultas con LEFT JOIN Y RIGHT JOIN

-------------------          CONSULTA B1        ------------------------
--Consulta para saber los empleados que no están asignados a un proyecto.

SELECT E.EMPLEADO_ID, E.NOMBRE, E.APELLIDO, D.NOMBRE_DEPARTAMENTO, A.PROYECTO_ID
FROM EMPLEADO E
LEFT JOIN ASIGNACION A
    ON E.EMPLEADO_ID = A.EMPLEADO_ID
LEFT JOIN DEPARTAMENTO D
    ON E.DEPARTAMENTO_ID = D.DEPARTAMENTO_ID
WHERE A.PROYECTO_ID IS NULL;



-------------------          CONSULTA B2       ------------------------
--Consulta para saber los proyectos que no han sido asignados a un empleado.

SELECT P.PROYECTO_ID, P.NOMBRE_PROYECTO, P.ESTADO
FROM PROYECTO P
LEFT JOIN ASIGNACION A
     ON P.PROYECTO_ID = A.PROYECTO_ID
WHERE
A.EMPLEADO_ID IS NULL;



-------------------          CONSULTA B3       ------------------------
--Consulta para saber los departamentos en los que no existen empleados.

SELECT D.DEPARTAMENTO_ID, D.NOMBRE_DEPARTAMENTO
FROM DEPARTAMENTO D
LEFT JOIN EMPLEADO E
     ON D.DEPARTAMENTO_ID = E.DEPARTAMENTO_ID
WHERE
E.EMPLEADO_ID IS NULL;


-------------------          CONSULTA B4      ------------------------
--Consulta para mostrar registros que con relación y sin relación.
--El uso de CASE-WHEN sirve para mostrar qué proyecto está relacionado a qué empleado.
--Y también los proyectos que no están relacionados con ningún empleado.

SELECT E.EMPLEADO_ID, E.NOMBRE || '' || E.APELLIDO AS EMPLEADO, P.NOMBRE_PROYECTO,
     CASE
         WHEN A.PROYECTO_ID IS NULL THEN 'Proyecto no asignado'
         ELSE 'Proyecto asignado'
     END AS ESTADO_ASIGNACION
FROM EMPLEADO E
LEFT JOIN ASIGNACION A
     ON E.EMPLEADO_ID = A.EMPLEADO_ID
LEFT JOIN PROYECTO P
     ON A.PROYECTO_ID = P.PROYECTO_ID
ORDER BY E.EMPLEADO_ID;



-------------------          CONSULTA B5      ------------------------
--Consulta para mostrar todos los proyectos aunque no tengan asignado a un empleado

SELECT E.NOMBRE || '' || E.APELLIDO AS EMPLEADO, P.PROYECTO_ID, P.NOMBRE_PROYECTO
FROM ASIGNACION A
RIGHT JOIN PROYECTO P
      ON A.PROYECTO_ID = P.PROYECTO_ID
LEFT JOIN EMPLEADO E
     ON A.EMPLEADO_ID  = E.EMPLEADO_ID
ORDER BY P.PROYECTO_ID;



-------------------          CONSULTA B6      ------------------------
--Consulta para saber los departamentos cuyos empleados 
--no tienen algún proyecto asignado
SELECT D.NOMBRE_DEPARTAMENTO, E.NOMBRE || ''|| E.APELLIDO AS EMPLEADO
FROM DEPARTAMENTO D
LEFT JOIN EMPLEADO E
     ON D.DEPARTAMENTO_ID = E.DEPARTAMENTO_ID
LEFT JOIN ASIGNACION A
     ON E.EMPLEADO_ID = A.EMPLEADO_ID
WHERE A.PROYECTO_ID IS NULL
ORDER BY D.NOMBRE_DEPARTAMENTO;


