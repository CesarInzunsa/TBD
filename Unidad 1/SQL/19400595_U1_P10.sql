/*
PRACTICA 10
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
NO. CONTROL: 19400595
FECHA: 30/09/2021
DESCRIPCION: 
*/

CREATE DATABASE LaboratorioComputoITT
ON PRIMARY
(
NAME = 'LaboratorioComputoITT.MDF',
FILENAME = 'C:\TBD2021\U1\LaboratorioComputoITT.MDF',
SIZE = 10MB,
MAXSIZE = UNLIMITED,
FILEGROWTH = 10%
)
LOG ON
(
NAME = 'LaboratorioComputoITT.LDF',
FILENAME = 'C:\TBD2021\U1\LaboratorioComputoITT.LDF',
SIZE = 10MB,
MAXSIZE = UNLIMITED,
FILEGROWTH = 10%
);

--PONER EN USO LA BD
USE LaboratorioComputoITT;

--CREAR TABLA DE DISPOSITIVOS
CREATE TABLE DISPOSITIVOS(
idDispositivo INT CONSTRAINT PK_DISPOSITIVOS PRIMARY KEY,
nombreDispostivo VARCHAR(30),
descripcionDispositivo VARCHAR(300),
cantidadInventarioDispositivo INT CHECK(cantidadInventarioDispositivo > 0)
);


--CREAR TABLA DE PERSONA EN DONDE SE REGISTRA QUE TIPO DE INDIVIDUO ES SI MAESTRO O ALUMNO
CREATE TABLE PERSONAS(
idPersona VARCHAR(9) CONSTRAINT PK_PERSONA PRIMARY KEY,
tipoPersona VARCHAR(7) CHECK(tipoPersona = 'MAESTRO' OR tipoPersona = 'ALUMNO'),
nombre VARCHAR(30),
apellidoPaterno VARCHAR(30),
apellidoMaterno VARCHAR(30),
credencial CHAR(2) CHECK(credencial = 'SI')
);


--CREAR TABLA DE PRESTAMOS
CREATE TABLE PRESTAMOS(
idPrestamos INT CONSTRAINT PK_PRESTAMO PRIMARY KEY,
idPersona VARCHAR(9) NOT NULL CONSTRAINT FK_PRESTAMOS_PERSONAS REFERENCES PERSONAS(idPersona),
idDispositivo INT NOT NULL CONSTRAINT FK_PRESTAMOS_DISPOSITIVOS REFERENCES DISPOSITIVOS(idDispositivo),
tiempoPrestamo INT CHECK(tiempoPrestamo BETWEEN 1 AND 3)
);