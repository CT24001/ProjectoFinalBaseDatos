================================================================================
-- SECCIÓN D - SUBCONSULTAS (6 consultas)
-- Objetivo: Demostrar el uso de diferentes tipos de subconsultas en SQL
-- Tipos cubiertos: IN, NOT IN, correlacionada, escalar, tabla derivada, EXISTS
================================================================================

SET SERVEROUTPUT ON;
SET LINESIZE 150;
SET PAGESIZE 50;

PROMPT ================================================================================
PROMPT D1 - Subconsulta en WHERE con IN
PROMPT ================================================================================
-- D1: Empleados que trabajan en proyectos con presupuesto > 40,000
-- 
-- TIPO DE SUBCONSULTA: Subconsulta de conjunto con operador IN
-- La subconsulta interna se ejecuta UNA SOLA VEZ y devuelve una lista de IDs de proyectos
-- La consulta principal luego filtra los proyectos que estén en esa lista
--
-- FLUJO DE EJECUCIÓN:
-- 1. La subconsulta busca todos los proyecto_id cuyo presupuesto supera 40,000
-- 2. El resultado es una lista (ej: 1, 2, 5, 13)
-- 3. La consulta principal une Empleado -> Asignacion -> Proyecto
-- 4. Filtra solo las filas donde proyecto_id está en la lista obtenida
--
-- NOTA: Este enfoque es eficiente cuando la subconsulta devuelve pocos registros
--       y no depende de la consulta principal (no es correlacionada)

SELECT e.nombre || ' ' || e.apellido AS empleado,   -- Concatenamos nombre completo
       p.nombre_proyecto,                            -- Nombre del proyecto
       p.presupuesto                                 -- Presupuesto para ordenamiento
FROM empleado e
INNER JOIN asignacion a ON e.empleado_id = a.empleado_id      -- Unión por asignación
INNER JOIN proyecto p ON a.proyecto_id = p.proyecto_id        -- Unión por proyecto
WHERE p.proyecto_id IN (                                     -- FILTRO PRINCIPAL CON IN
    SELECT proyecto_id                                        -- Subconsulta: lista de IDs
    FROM proyecto
    WHERE presupuesto > 40000                                 -- Condición del presupuesto alto
)
ORDER BY p.presupuesto DESC;                                  -- Ordenamos de mayor a menor presupuesto


PROMPT ================================================================================
PROMPT D2 - Subconsulta en WHERE con NOT IN
PROMPT ================================================================================
-- D2: Proyectos sin empleados asignados (proyectos huérfanos o sin equipo)
--
-- TIPO DE SUBCONSULTA: Subconsulta de conjunto con operador NOT IN
-- Esta consulta encuentra proyectos que NO tienen ninguna relación en la tabla Asignacion
--
-- FLUJO DE EJECUCIÓN:
-- 1. La subconsulta obtiene todos los proyecto_id que EXISTEN en la tabla Asignacion
-- 2. El DISTINCT evita duplicados (un proyecto puede tener varios empleados)
-- 3. El filtro NOT IN excluye todos esos IDs, dejando solo proyectos sin asignaciones
-- 4. Se incluye "proyecto_id IS NOT NULL" para evitar problemas con valores nulos
--    (NOT IN con NULL se comporta de forma no intuitiva: devuelve vacío)
--
-- IMPORTANTE: Siempre manejar posibles NULLs en subconsultas con NOT IN

SELECT proyecto_id,                                        -- Identificador del proyecto
       nombre_proyecto                                     -- Nombre para identificar fácilmente
FROM proyecto
WHERE proyecto_id NOT IN (                                 -- EXCLUIMOS los proyectos que...
    SELECT DISTINCT proyecto_id                            -- ...aparecen en asignaciones
    FROM asignacion
    WHERE proyecto_id IS NOT NULL                          -- Importante: evitar NULLs en NOT IN
)
ORDER BY proyecto_id;                                      -- Ordenamos por ID para mejor lectura


PROMPT ================================================================================
PROMPT D3 - Subconsulta correlacionada en WHERE
PROMPT ================================================================================
-- D3: Empleados con salario mayor al promedio de su propio departamento
--
-- TIPO DE SUBCONSULTA: Subconsulta correlacionada (o subconsulta de fila)
-- CARACTERÍSTICA CLAVE: La subconsulta interna hace referencia a la tabla externa (e)
-- Se ejecuta UNA VEZ POR CADA FILA de la consulta principal
--
-- FLUJO DE EJECUCIÓN (para cada empleado):
-- 1. La consulta principal toma un empleado (e) con su departamento_id
-- 2. La subconsulta calcula el salario PROMEDIO solo de los empleados del MISMO departamento
-- 3. Se compara el salario del empleado actual con ese promedio
-- 4. Si es mayor, el empleado se incluye en el resultado
--
-- APLICACIÓN PRÁCTICA: Identificar "empleados estrella" que ganan más que sus pares
-- NOTA: Puede ser más lenta en tablas grandes porque recalcula el promedio por cada fila

SELECT e.nombre || ' ' || e.apellido AS empleado,        -- Empleado con salario alto
       e.salario,                                         -- Su salario actual
       d.nombre_departamento                              -- Departamento al que pertenece
FROM empleado e
INNER JOIN departamento d ON e.departamento_id = d.departamento_id   -- Traemos nombre del depto
WHERE e.salario > (                                       -- Comparación con promedio del depto
    SELECT AVG(salario)                                   -- Calculamos promedio
    FROM empleado e2                                      -- Alias diferente para evitar ambigüedad
    WHERE e2.departamento_id = e.departamento_id          -- CORRELACIÓN: mismo departamento
)
ORDER BY d.nombre_departamento, e.salario DESC;           -- Orden: por depto y salario descendente


PROMPT ================================================================================
PROMPT D4 - Subconsulta en SELECT (columna escalar)
PROMPT ================================================================================
-- D4: Proyectos con total de empleados asignados
--
-- TIPO DE SUBCONSULTA: Subconsulta escalar (devuelve UNA sola fila y UNA sola columna)
-- UBICACIÓN: En la lista de columnas del SELECT
-- Se ejecuta UNA VEZ POR CADA FILA del resultado principal
--
-- FLUJO DE EJECUCIÓN:
-- 1. La consulta principal selecciona cada proyecto (uno por fila)
-- 2. Para cada proyecto, la subconsulta cuenta cuántas asignaciones tiene ese proyecto
-- 3. El resultado es el número de empleados trabajando en él
-- 4. Se muestra como una columna adicional
--
-- VENTAJA: Evita hacer un LEFT JOIN y GROUP BY, más legible en ciertos casos
-- DESVENTAJA: Puede ser menos eficiente que un JOIN + GROUP BY en tablas muy grandes

SELECT p.nombre_proyecto,                                 -- Nombre del proyecto
       p.presupuesto,                                     -- Presupuesto asignado
       p.estado,                                          -- Estado actual (Activo/Inactivo)
       (
           SELECT COUNT(*)                                -- Subconsulta escalar: cuenta registros
           FROM asignacion a
           WHERE a.proyecto_id = p.proyecto_id            -- CORRELACIÓN: misma proyecto_id
       ) AS total_empleados_asignados                     -- Alias para la columna calculada
FROM proyecto p
ORDER BY total_empleados_asignados DESC;                  -- Ordenamos por cantidad de empleados


PROMPT ================================================================================
PROMPT D5 - Subconsulta en FROM (tabla derivada / inline view)
PROMPT ================================================================================
-- D5: Departamentos con salario promedio mayor a 2000
--
-- TIPO DE SUBCONSULTA: Tabla derivada (subconsulta en la cláusula FROM)
-- La subconsulta actúa como una "tabla virtual" que luego se filtra en el WHERE externo
--
-- FLUJO DE EJECUCIÓN:
-- 1. PRIMERO: Se ejecuta la subconsulta interna (depto_promedio)
--    - Agrupa empleados por departamento y calcula el salario promedio de cada uno
--    - El resultado es una tabla con dos columnas: departamento y salario_promedio
-- 2. SEGUNDO: La consulta externa toma esta tabla virtual como si fuera una tabla real
-- 3. TERCERO: Se aplica el filtro WHERE sobre la columna salario_promedio (> 2000)
--
-- EQUIVALENCIA LÓGICA: Se podría hacer con HAVING, pero esta forma es más clara
-- cuando se necesitan múltiples niveles de agregación o cálculos intermedios

SELECT depto_promedio.departamento,                      -- Nombre del departamento
       depto_promedio.salario_promedio                    -- Salario promedio calculado
FROM (
    -- SUBCONSULTA: Tabla derivada que agrupa y calcula promedios por departamento
    SELECT d.nombre_departamento AS departamento,        -- Alias para la columna
           AVG(e.salario) AS salario_promedio            -- Promedio de salarios del depto
    FROM empleado e
    INNER JOIN departamento d ON e.departamento_id = d.departamento_id
    GROUP BY d.nombre_departamento                       -- Agrupamos por departamento
) depto_promedio                                          -- Alias de la tabla derivada (obligatorio)
WHERE depto_promedio.salario_promedio > 2000              -- Filtro sobre columna calculada
ORDER BY depto_promedio.salario_promedio DESC;            -- Ordenamos de mayor a menor promedio


PROMPT ================================================================================
PROMPT D6 - Subconsulta con EXISTS
PROMPT ================================================================================
-- D6: Empleados asignados a al menos un proyecto activo
--
-- TIPO DE SUBCONSULTA: EXISTS (subconsulta correlacionada de existencia)
-- CARACTERÍSTICA PRINCIPAL: Devuelve TRUE si la subconsulta encuentra al menos UNA fila
-- La subconsulta NO devuelve datos, solo verifica existencia
--
-- FLUJO DE EJECUCIÓN:
-- 1. Para cada empleado en la tabla principal, se ejecuta la subconsulta EXISTS
-- 2. La subconsulta busca si existe UNA ASIGNACIÓN de ese empleado a un proyecto ACTIVO
-- 3. Si encuentra AL MENOS UNA coincidencia, retorna TRUE y el empleado se incluye
-- 4. Si no encuentra NINGUNA, retorna FALSE y el empleado se excluye
--
-- VENTAJAS SOBRE IN:
-- - Más eficiente cuando solo importa la existencia (no los valores específicos)
-- - Se detiene en la primera coincidencia (short-circuit evaluation)
-- - Maneja correctamente NULLs (a diferencia de IN/NOT IN)
-- - Ideal para relaciones "al menos uno" o "existe al menos un"

SELECT e.nombre || ' ' || e.apellido AS empleado,        -- Nombre completo del empleado
       e.email                                            -- Email para contacto
FROM empleado e
WHERE EXISTS (                                           -- Condición de existencia
    SELECT 1                                             -- SELECT 1 es eficiente: solo verifica existencia
    FROM asignacion a
    INNER JOIN proyecto p ON a.proyecto_id = p.proyecto_id   -- Unimos con proyectos
    WHERE a.empleado_id = e.empleado_id                  -- CORRELACIÓN: mismo empleado
      AND p.estado = 'Activo'                            -- Filtro: proyecto activo
)
ORDER BY empleado;                                       -- Ordenamos alfabéticamente por nombre