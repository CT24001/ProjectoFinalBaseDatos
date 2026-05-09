-- Agregando registros de Regiones
INSERT INTO Region (nombre_region) VALUES ('América del Norte');
INSERT INTO Region (nombre_region) VALUES ('América Central');
INSERT INTO Region (nombre_region) VALUES ('América del Sur');
INSERT INTO Region (nombre_region) VALUES ('Europa Occidental');
INSERT INTO Region (nombre_region) VALUES ('Europa del Este');
INSERT INTO Region (nombre_region) VALUES ('Asia Oriental');
INSERT INTO Region (nombre_region) VALUES ('Medio Oriente');
INSERT INTO Region (nombre_region) VALUES ('África');
INSERT INTO Region (nombre_region) VALUES ('Oceanía');
INSERT INTO Region (nombre_region) VALUES ('Sudeste Asiático');


-- Agregando Paises
INSERT INTO Pais (pais_id, nombre_pais, region_id) VALUES ('SV', 'El Salvador', 2);
INSERT INTO Pais (pais_id, nombre_pais, region_id) VALUES ('US', 'Estados Unidos', 1);
INSERT INTO Pais (pais_id, nombre_pais, region_id) VALUES ('MX', 'México', 1);
INSERT INTO Pais (pais_id, nombre_pais, region_id) VALUES ('ES', 'España', 4);
INSERT INTO Pais (pais_id, nombre_pais, region_id) VALUES ('JP', 'Japón', 6);
INSERT INTO Pais (pais_id, nombre_pais, region_id) VALUES ('BR', 'Brasil', 3);
INSERT INTO Pais (pais_id, nombre_pais, region_id) VALUES ('DE', 'Alemania', 4);
INSERT INTO Pais (pais_id, nombre_pais, region_id) VALUES ('CA', 'Canadá', 1);
INSERT INTO Pais (pais_id, nombre_pais, region_id) VALUES ('FR', 'Francia', 4);
INSERT INTO Pais (pais_id, nombre_pais, region_id) VALUES ('CN', 'China', 6);

-- Agregando Localizaciones 
INSERT INTO Localizacion (calle, codigo_postal, ciudad, provincia, pais_id) VALUES ('Calle La Reforma 123', '01101', 'San Salvador', 'San Salvador', 'SV');
INSERT INTO Localizacion (calle, codigo_postal, ciudad, provincia, pais_id) VALUES ('1600 Amphitheatre Pkwy', '94043', 'Mountain View', 'California', 'US');
INSERT INTO Localizacion (calle, codigo_postal, ciudad, provincia, pais_id) VALUES ('Paseo de la Reforma 50', '06600', 'Ciudad de México', 'CDMX', 'MX');
INSERT INTO Localizacion (calle, codigo_postal, ciudad, provincia, pais_id) VALUES ('Calle Mayor 1', '28001', 'Madrid', 'Madrid', 'ES');
INSERT INTO Localizacion (calle, codigo_postal, ciudad, provincia, pais_id) VALUES ('Shinjuku-ku 1-1', '160-0022', 'Tokio', 'Tokio', 'JP');
INSERT INTO Localizacion (calle, codigo_postal, ciudad, provincia, pais_id) VALUES ('Av. Paulista 1000', '01310-100', 'Sao Paulo', 'SP', 'BR');
INSERT INTO Localizacion (calle, codigo_postal, ciudad, provincia, pais_id) VALUES ('Alexanderplatz 1', '10178', 'Berlín', 'Berlín', 'DE');
INSERT INTO Localizacion (calle, codigo_postal, ciudad, provincia, pais_id) VALUES ('Bay St 200', 'M5J 2J2', 'Toronto', 'Ontario', 'CA');
INSERT INTO Localizacion (calle, codigo_postal, ciudad, provincia, pais_id) VALUES ('Champs-Élysées 10', '75008', 'París', 'Isla de Francia', 'FR');
INSERT INTO Localizacion (calle, codigo_postal, ciudad, provincia, pais_id) VALUES ('Nanjing Rd 500', '200001', 'Shanghái', 'Shanghái', 'CN');


-- Agregando los diferentes puestos
INSERT INTO Puesto VALUES ('IT_PROG', 'Programador Junior', 1200, 2500);
INSERT INTO Puesto VALUES ('IT_SR_PR', 'Programador Senior', 3000, 5500);
INSERT INTO Puesto VALUES ('AD_ASST', 'Asistente Administrativo', 800, 1500);
INSERT INTO Puesto VALUES ('SA_REP', 'Representante de Ventas', 1500, 4000);
INSERT INTO Puesto VALUES ('FI_ACC', 'Contador', 2000, 3500);
INSERT INTO Puesto VALUES ('HR_REP', 'Representante RRHH', 1500, 2800);
INSERT INTO Puesto VALUES ('MK_MAN', 'Gerente de Marketing', 3500, 7000);
INSERT INTO Puesto VALUES ('IT_DIR', 'Director de IT', 6000, 12000);
INSERT INTO Puesto VALUES ('CEO', 'Director Ejecutivo', 15000, 30000);
INSERT INTO Puesto VALUES ('ST_CLRK', 'Auxiliar de Almacén', 600, 1000);

-- Departamentos (10 registros - manager_id se deja NULL por ahora)
INSERT INTO Departamento (nombre_departamento, localizacion_id) VALUES ('Sistemas', 1);
INSERT INTO Departamento (nombre_departamento, localizacion_id) VALUES ('Ventas', 3);
INSERT INTO Departamento (nombre_departamento, localizacion_id) VALUES ('Recursos Humanos', 1);
INSERT INTO Departamento (nombre_departamento, localizacion_id) VALUES ('Contabilidad', 4);
INSERT INTO Departamento (nombre_departamento, localizacion_id) VALUES ('Marketing', 2);
INSERT INTO Departamento (nombre_departamento, localizacion_id) VALUES ('Dirección General', 2);
INSERT INTO Departamento (nombre_departamento, localizacion_id) VALUES ('Logística', 6);
INSERT INTO Departamento (nombre_departamento, localizacion_id) VALUES ('Atención al Cliente', 8);
INSERT INTO Departamento (nombre_departamento, localizacion_id) VALUES ('I+D', 5);
INSERT INTO Departamento (nombre_departamento, localizacion_id) VALUES ('Legal', 9);

// Agregando los proyectos de la empresa

INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Rediseño Web Corporativo', 12500, TO_DATE('2023-01-10','YYYY-MM-DD'), TO_DATE('2023-04-15','YYYY-MM-DD'));
INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Implementación ERP SAP', 85000, TO_DATE('2022-06-01','YYYY-MM-DD'), TO_DATE('2023-12-31','YYYY-MM-DD'));
INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Taller Ciberseguridad 2024', 4500, TO_DATE('2024-02-01','YYYY-MM-DD'), TO_DATE('2024-02-28','YYYY-MM-DD'));
INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Expansión Sucursal Norte', 150000, TO_DATE('2023-03-15','YYYY-MM-DD'), TO_DATE('2024-03-15','YYYY-MM-DD'));
INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Auditoría Calidad ISO9001', 9800, TO_DATE('2024-05-10','YYYY-MM-DD'), TO_DATE('2024-06-10','YYYY-MM-DD'));
INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Migración Microservicios', 45000, TO_DATE('2023-08-20','YYYY-MM-DD'), TO_DATE('2024-08-20','YYYY-MM-DD'));
INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Desarrollo App Móvil iOS', 32000, TO_DATE('2023-11-01','YYYY-MM-DD'), TO_DATE('2024-05-30','YYYY-MM-DD'));
INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Optimización DB Oracle', 15000, TO_DATE('2024-01-15','YYYY-MM-DD'), TO_DATE('2024-03-15','YYYY-MM-DD'));
INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Renovación Hardware DataCenter', 60000, TO_DATE('2023-02-01','YYYY-MM-DD'), TO_DATE('2023-05-01','YYYY-MM-DD'));
INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Portal Empleado v2', 25000, TO_DATE('2022-09-10','YYYY-MM-DD'), TO_DATE('2023-03-10','YYYY-MM-DD'));
INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Integración API Pagos', 18500, TO_DATE('2024-04-01','YYYY-MM-DD'), TO_DATE('2024-07-01','YYYY-MM-DD'));
INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Migración Windows 11', 12000, TO_DATE('2023-10-15','YYYY-MM-DD'), TO_DATE('2023-11-30','YYYY-MM-DD'));
INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Proyecto Data Analytics', 55000, TO_DATE('2024-03-01','YYYY-MM-DD'), TO_DATE('2025-03-01','YYYY-MM-DD'));
INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Campaña Marketing Q4', 20000, TO_DATE('2023-05-20','YYYY-MM-DD'), TO_DATE('2023-12-20','YYYY-MM-DD'));
INSERT INTO Proyecto (nombre_proyecto, presupuesto, fecha_inicio, fecha_fin) VALUES ('Plan Recuperación Desastres', 35000, TO_DATE('2024-06-01','YYYY-MM-DD'), TO_DATE('2024-12-01','YYYY-MM-DD'));



// Agregando los empleados
INSERT INTO Empleado (nombre, apellido, email, fecha_contratacion, salario, puesto_id, departamento_id) VALUES ('Juan', 'Pérez', 'jperez@empresa.com', TO_DATE('2020-01-15','YYYY-MM-DD'), 2500, 'IT_PROG', 1);
INSERT INTO Empleado (nombre, apellido, email, fecha_contratacion, salario, puesto_id, departamento_id) VALUES ('Ana', 'García', 'agarcia@empresa.com', TO_DATE('2019-05-20','YYYY-MM-DD'), 4500, 'IT_SR_PR', 1);
INSERT INTO Empleado (nombre, apellido, email, fecha_contratacion, salario, puesto_id, departamento_id) VALUES ('Luis', 'Rodríguez', 'lrod@empresa.com', TO_DATE('2021-03-10','YYYY-MM-DD'), 1800, 'SA_REP', 2);
INSERT INTO Empleado (nombre, apellido, email, fecha_contratacion, salario, puesto_id, departamento_id) VALUES ('Marta', 'López', 'mlopez@empresa.com', TO_DATE('2018-11-01','YYYY-MM-DD'), 8000, 'IT_DIR', 1);
INSERT INTO Empleado (nombre, apellido, email, fecha_contratacion, salario, puesto_id, departamento_id) VALUES ('Carlos', 'Sánchez', 'csan@empresa.com', TO_DATE('2022-01-01','YYYY-MM-DD'), 20000, 'CEO', 6);
INSERT INTO Empleado (nombre, apellido, email, fecha_contratacion, salario, puesto_id, departamento_id) VALUES ('Elena', 'Martínez', 'emart@empresa.com', TO_DATE('2020-06-15','YYYY-MM-DD'), 2200, 'FI_ACC', 4);
INSERT INTO Empleado (nombre, apellido, email, fecha_contratacion, salario, puesto_id, departamento_id) VALUES ('Roberto', 'Gómez', 'rgom@empresa.com', TO_DATE('2021-08-20','YYYY-MM-DD'), 4000, 'MK_MAN', 5);
INSERT INTO Empleado (nombre, apellido, email, fecha_contratacion, salario, puesto_id, departamento_id) VALUES ('Sofía', 'Díaz', 'sdiaz@empresa.com', TO_DATE('2022-02-14','YYYY-MM-DD'), 1600, 'HR_REP', 3);
INSERT INTO Empleado (nombre, apellido, email, fecha_contratacion, salario, puesto_id, departamento_id) VALUES ('Diego', 'Torres', 'dtorres@empresa.com', TO_DATE('2019-12-01','YYYY-MM-DD'), 900, 'ST_CLRK', 7);
INSERT INTO Empleado (nombre, apellido, email, fecha_contratacion, salario, puesto_id, departamento_id) VALUES ('Lucía', 'Ruiz', 'lruiz@empresa.com', TO_DATE('2020-09-30','YYYY-MM-DD'), 1400, 'AD_ASST', 8);



-- Asignar Managers a Empleados (Marta supervisa a Juan y Ana)
UPDATE Empleado SET manager_id = 4 WHERE empleado_id IN (1, 2);
UPDATE Empleado SET manager_id = 5 WHERE empleado_id = 4; 
UPDATE Empleado SET manager_id = 5 WHERE empleado_id = 4;
UPDATE Empleado SET manager_id = 4 WHERE empleado_id = 6;
UPDATE Empleado SET manager_id = 7 WHERE empleado_id = 3;
UPDATE Empleado SET manager_id = 4 WHERE empleado_id = 10;
UPDATE Empleado SET manager_id = 5 WHERE empleado_id = 7;

// Agregando los jefes de departamentos
UPDATE Departamento SET manager_id = 4 WHERE departamento_id = 1; 
UPDATE Departamento SET manager_id = 5 WHERE departamento_id = 6; 
UPDATE Departamento SET manager_id = 7 WHERE departamento_id = 5;
UPDATE Departamento SET manager_id = 6 WHERE departamento_id = 4;
UPDATE Departamento SET manager_id = 8 WHERE departamento_id = 3;
UPDATE Departamento SET manager_id = 3 WHERE departamento_id = 2;

-- Agrenado las asignaciones de los empleados a los proyectos
INSERT INTO Asignacion VALUES (1, 1, 20, 'Desarrollador');
INSERT INTO Asignacion VALUES (2, 1, 40, 'Líder Técnico');
INSERT INTO Asignacion VALUES (1, 2, 10, 'Desarrollador');
INSERT INTO Asignacion VALUES (6, 3, 30, 'Analista Financiero');
INSERT INTO Asignacion VALUES (7, 5, 25, 'Coordinador');
INSERT INTO Asignacion VALUES (8, 9, 15, 'Facilitador');
INSERT INTO Asignacion VALUES (3, 2, 35, 'Analista de Negocios');
INSERT INTO Asignacion VALUES (4, 1, 15, 'Arquitecto de Software');
INSERT INTO Asignacion VALUES (5, 4, 40, 'Gerente de Proyecto');
INSERT INTO Asignacion VALUES (6, 7, 25, 'Ingeniero de Calidad');
INSERT INTO Asignacion VALUES (2, 3, 10, 'Instructor');
INSERT INTO Asignacion VALUES (1, 13, 40, 'Científico de Datos');
INSERT INTO Asignacion VALUES (7, 14, 20, 'Coordinador de Medios');
INSERT INTO Asignacion VALUES (9, 9, 30, 'Técnico de Infraestructura');
INSERT INTO Asignacion VALUES (6, 5, 15, 'Auditor Interno');


// Agregando datos al historial de puesto
INSERT INTO Historial_Puesto VALUES (1, TO_DATE('2018-01-01','YYYY-MM-DD'), TO_DATE('2019-12-31','YYYY-MM-DD'), 'ST_CLRK', 7);
INSERT INTO Historial_Puesto VALUES (2, TO_DATE('2017-06-01','YYYY-MM-DD'), TO_DATE('2019-04-30','YYYY-MM-DD'), 'IT_PROG', 1);
INSERT INTO Historial_Puesto VALUES (1, TO_DATE('2015-01-01','YYYY-MM-DD'), TO_DATE('2017-12-31','YYYY-MM-DD'), 'ST_CLRK', 7);
INSERT INTO Historial_Puesto VALUES (3, TO_DATE('2019-02-15','YYYY-MM-DD'), TO_DATE('2021-02-14','YYYY-MM-DD'), 'AD_ASST', 8);
INSERT INTO Historial_Puesto VALUES (4, TO_DATE('2010-05-01','YYYY-MM-DD'), TO_DATE('2018-10-31','YYYY-MM-DD'), 'IT_SR_PR', 1);
INSERT INTO Historial_Puesto VALUES (6, TO_DATE('2018-03-20','YYYY-MM-DD'), TO_DATE('2020-06-14','YYYY-MM-DD'), 'AD_ASST', 3);
INSERT INTO Historial_Puesto VALUES (8, TO_DATE('2020-01-10','YYYY-MM-DD'), TO_DATE('2022-02-13','YYYY-MM-DD'), 'SA_REP', 2);
INSERT INTO Historial_Puesto VALUES (10, TO_DATE('2018-11-01','YYYY-MM-DD'), TO_DATE('2020-09-29','YYYY-MM-DD'), 'ST_CLRK', 7);
INSERT INTO Historial_Puesto VALUES (2, TO_DATE('2016-01-01','YYYY-MM-DD'), TO_DATE('2019-05-19','YYYY-MM-DD'), 'IT_PROG', 1);
INSERT INTO Historial_Puesto VALUES (7, TO_DATE('2017-08-15','YYYY-MM-DD'), TO_DATE('2021-08-19','YYYY-MM-DD'), 'SA_REP', 2);
INSERT INTO Historial_Puesto VALUES (5, TO_DATE('2012-01-01','YYYY-MM-DD'), TO_DATE('2021-12-31','YYYY-MM-DD'), 'MK_MAN', 5);
INSERT INTO Historial_Puesto VALUES (1, TO_DATE('2018-01-01','YYYY-MM-DD'), TO_DATE('2019-12-31','YYYY-MM-DD'), 'AD_ASST', 1);
INSERT INTO Historial_Puesto VALUES (9, TO_DATE('2017-04-01','YYYY-MM-DD'), TO_DATE('2019-11-30','YYYY-MM-DD'), 'AD_ASST', 3);
INSERT INTO Historial_Puesto VALUES (3, TO_DATE('2016-10-01','YYYY-MM-DD'), TO_DATE('2019-02-14','YYYY-MM-DD'), 'ST_CLRK', 7);
INSERT INTO Historial_Puesto VALUES (4, TO_DATE('2005-01-01','YYYY-MM-DD'), TO_DATE('2010-04-30','YYYY-MM-DD'), 'IT_PROG', 1);
INSERT INTO Historial_Puesto VALUES (6, TO_DATE('2015-06-01','YYYY-MM-DD'), TO_DATE('2018-03-19','YYYY-MM-DD'), 'ST_CLRK', 7);
INSERT INTO Historial_Puesto VALUES (8, TO_DATE('2017-01-01','YYYY-MM-DD'), TO_DATE('2020-01-09','YYYY-MM-DD'), 'AD_ASST', 8);







