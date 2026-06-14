-- SECCION C -  Consultas con Funciones de agregado(GROUP BY + HAVING

-------------------          CONSULTA C1        ------------------------
--Consulta para agrupar al total de empleados por departamento.

SELECT D.NOMBRE_DEPARTAMENTO,
COUNT(E.EMPLEADO_ID) AS TOTAL_EMPLEADOS
FROM adminProyecto.DEPARTAMENTO D
LEFT JOIN adminProyecto.EMPLEADO E
     ON D.DEPARTAMENTO_ID = E.DEPARTAMENTO_ID
GROUP BY D.NOMBRE_DEPARTAMENTO;



-------------------          CONSULTA C2      ------------------------
--Consulta para recopilar el salario promedio y máximo por departamento

SELECT D.NOMBRE_DEPARTAMENTO, 
       ROUND(AVG(E.SALARIO),2) AS SALARIO_PROMEDIO,
       MAX(E.SALARIO) AS SALARIO_MAXIMO
FROM adminProyecto.DEPARTAMENTO D
INNER JOIN adminProyecto.EMPLEADO E
      ON D.DEPARTAMENTO_ID = E.DEPARTAMENTO_ID
GROUP BY D.NOMBRE_DEPARTAMENTO
HAVING AVG(E.SALARIO) > 3000;


-------------------          CONSULTA C3      ------------------------
--Consulta para recopilar empleados contratados por año y mes.

SELECT
    EXTRACT(YEAR FROM FECHA_CONTRATACION) AS AÑO,
    EXTRACT(MONTH FROM FECHA_CONTRATACION) AS MES,
    COUNT(*) AS TOTAL_CONTRATADOS 
FROM adminProyecto.EMPLEADO 
GROUP BY
    EXTRACT(YEAR FROM FECHA_CONTRATACION),
    EXTRACT(MONTH FROM FECHA_CONTRATACION)
ORDER BY AÑO, MES;


-------------------          CONSULTA C4      ------------------------
--Consulta para listar el top de 5 empleados con más proyectos.

SELECT E.EMPLEADO_ID, E.NOMBRE, E.APELLIDO,
       COUNT(A.PROYECTO_ID) AS TOTAL_PROYECTOS    
FROM adminproyecto.EMPLEADO E
INNER JOIN adminProyecto.ASIGNACION A
      ON E.EMPLEADO_ID = A.EMPLEADO_ID
GROUP BY
      E.EMPLEADO_ID,
      E.NOMBRE,
      E.APELLIDO
ORDER BY TOTAL_PROYECTOS DESC
FETCH FIRST 5 ROWS ONLY;



-------------------          CONSULTA C5      ------------------------
--Consulta para listar departamentos  con salario superior al promedio general.

SELECT D.NOMBRE_DEPARTAMENTO,
       ROUND(AVG(E.SALARIO),2) AS SALARIO_PROMEDIO
FROM adminProyecto.DEPARTAMENTO D
INNER JOIN adminproyecto.EMPLEADO E
      ON D.DEPARTAMENTO_ID = E.DEPARTAMENTO_ID
GROUP BY D.NOMBRE_DEPARTAMENTO
HAVING AVG(E.SALARIO) >
( SELECT AVG(SALARIO)
  FROM adminProyecto.EMPLEADO);


-------------------          CONSULTA C6      ------------------------
--Consulta para Listar horas asignadas por proyecto y departamento.
SELECT D.NOMBRE_DEPARTAMENTO, P.NOMBRE_PROYECTO,
       SUM(A.HORAS_ASIGNADAS) AS TOTAL_HORAS
FROM adminProyecto.ASIGNACION A
INNER JOIN adminProyecto.EMPLEADO E
      ON A.EMPLEADO_ID = E.EMPLEADO_ID
INNER JOIN adminProyecto.DEPARTAMENTO D
      ON E.DEPARTAMENTO_ID = D.DEPARTAMENTO_ID
INNER JOIN adminProyecto.PROYECTO P
      ON A.PROYECTO_ID = P.PROYECTO_ID
GROUP BY
      D.NOMBRE_DEPARTAMENTO,
      P.NOMBRE_PROYECTO
ORDER BY TOTAL_HORAS DESC;





