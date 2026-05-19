-- Elimnar datos
UPDATE Departamentos SET manager_id = NULL;
DELETE FROM Empleado;
DELETE FROM Departamento;
DELETE FROM Puesto;
DELETE FROM Localizacion;
DELETE FROM Pais;
DELETE FROM Region;

DROP TABLE Asignacion;
DROP TABLE Historial_Puesto;
DROP TABLE Empleado CASCADE CONSTRAINTS;
DROP TABLE Departamento CASCADE CONSTRAINTS;
DROP TABLE Puesto;
DROP TABLE Proyecto;
DROP TABLE Localizacion;
DROP TABLE Pais;
DROP TABLE Region;