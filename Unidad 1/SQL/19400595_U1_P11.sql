/**
PRACTICA 11
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
NO. CONTROL: 19400595
FECHA: 29/09/2021
DESCRIPCION: IMPLEMENTAR UNA BD PARA UN CAMPEONATO DE AJEDREZ
*/

CREATE DATABASE CAMPEONATO_AJEDREZ
ON PRIMARY
(
NAME = 'CAMPEONATO_AJEDREZ.MDF',
FILENAME = 'C:\TBD2021\U1CAMPEONATO_AJEDREZ.MDF',
FILEGROWTH = 10%
)
LOG ON
(
NAME = 'CAMPEONATO_AJEDREZ.LDF',
FILENAME = 'C:\TBD2021\U1\CAMPEONATO_AJEDREZ.LDF',
FILEGROWTH = 10%
);

--PONER EN USO LA BASE DE DATOS
USE CAMPEONATO_AJEDREZ;

--CREAR TABLA DE TIPO DE CONCURSO
CREATE TABLE TIPO_CONCURSO
(
TIP_ID INT IDENTITY(1,1) PRIMARY KEY,
TIP_NOMBRE VARCHAR(50),
TIP_NIVEL TINYINT
);

--CREAR LA TABLA DE CARRERAS
CREATE TABLE CARRERAS
(
CAR_ID CHAR(5) CONSTRAINT PK_CARRERAS PRIMARY KEY,
CAR_NOMBRE VARCHAR(60),
CAR_VIGENCIA1 DATE,
CAR_VIGENCIA2 DATE
);

--CREAR LA TABLA DE PARTICIPANTES
CREATE TABLE PARTICIPANTES
(
[No de Control] VARCHAR(8) CONSTRAINT PK_PARTICIPANTES PRIMARY KEY,
[Nombre Completo] VARCHAR(120),
Carrera CHAR(5) CONSTRAINT FK_PARTICIPANTES_CARRERAS REFERENCES CARRERAS(CAR_ID),
Semestre CHAR(2),
[Fecha de Nac] DATE,
Tipo_Concurso INT CONSTRAINT FK_PARTICIPANTES_TIPO_CONCURSO REFERENCES TIPO_CONCURSO (TIP_ID)
);

--CREAR LA TABLA DE RESULTADOS
CREATE TABLE RESULTADOS
(
RES_ID INT NOT NULL,
NOCtrl VARCHAR(8),
tip_id INT,
RES_LUGAR TINYINT,
RES_OBSERVACION VARCHAR(50),
RES_PUNTOS INT,
CONSTRAINT PK_RESULTADOS PRIMARY KEY (RES_ID),
CONSTRAINT FK_RESULTADOS_PARTICIPANTES FOREIGN KEY (NOCtrl) REFERENCES PARTICIPANTES ([No de Control]),
CONSTRAINT FK_RESULTADOS_CONCURSO FOREIGN KEY (tip_id) REFERENCES TIPO_CONCURSO (TIP_ID)
);

-- CREACION DE CONSTRAINT

--AGREGALE CONSTRAINT DE DEFAUL LUGAR DE LA TABLA RESULTADOS
ALTER TABLE RESULTADOS
ADD CONSTRAINT DF_RES_LUGAR
DEFAULT 1
FOR RES_LUGAR;

--AGREGA UN CHECK AL CAMPO NIVEL DE TIPO DE 1,2,3 Y 4
ALTER TABLE TIPO_CONCURSO
ADD CONSTRAINT CK_NIVEL
CHECK (TIP_NIVEL IN (1,2,3,4));

--AGREGA UN CHECK A PUNTOS DE LA RESULTADOS QUE NO PUEDA SER 0 NI MENOR QUE EL LUGAR DE LA TRABLA RESULTADOS
--QUE SOLO PUEDAR PRIMERO, SEGUNDO Y TERCERO
ALTER TABLE RESULTADOS
ADD CONSTRAINT CK_PUNTOS
CHECK (RES_PUNTOS IN ('PRIMERO','SEGUNDO','TERCERO'));

--AGREGA UN CAMPO LLAMADO OBSERVACIONES A LA TABLA TIPO DE CONCURSO
ALTER TABLE TIPO_CONCURSO
ADD OBSERVACIONES VARCHAR(100);

--AGREGA UN DEFAULT AL CAMPO OBSERVACIONES QUE ACABAS DE AGREGAR
ALTER TABLE TIPO_CONCURSO
ADD CONSTRAINT DF_TIPOCONCURSO_OBSERVACIONES
DEFAULT 'El formato de torneos está compuesto de los siguientes sistemas: "todos contra todos" o de liga, sistema suizo o por eliminación directa.'
FOR OBSERVACIONES;

-- QUITAR CAMPO VIGENCIA2 DE LA TABLA CARRERAS
ALTER TABLE CARRERAS
DROP COLUMN CAR_VIGENCIA2
