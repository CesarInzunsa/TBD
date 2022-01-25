/*
PRACTICA 12
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
NO. CONTROL: 19400595
FECHA: 22/09/2021
DESCRIPCION: EN EL KINDER MUNDO FELIZ SE LLEVARA A CABO LAS VOTACIONES PARA REY FEO Y LA
REYNA DE PRIMAVERA, TAMBIEN SE ELIGIRAN 3 PRINCESAS, PARA LOS CUAL TODOS LOS
ALUMNOS DE 1ERO., 2DO Y 3ERO DE PRESCOLAR PUEDEN INSCRIBIRSE COMO
CANDIDATOS, Y TAMBIEN DEBERAN VOTAR, LA FORMA DE VOTAR ES DAR UN PESO POR
VOTO, EL QUE JUNTE MAS VOTOS PARA CADA UNO DE LOS TIPOS DE CANDIDATOS SERA
EL GANADOR
*/

--CREAR BASE DE DATOS
CREATE DATABASE KINDER_MUNDO_FELIZ
ON PRIMARY
(
NAME = 'KINDER_MUNDO_FELIZ_DATA',
FILENAME = 'C:\TBD2021\U1\KINDER_MUNDO_FELIZ.MDF',
SIZE = 10MB,
MAXSIZE = UNLIMITED
)
LOG ON
(
NAME = 'KINDER_MUNDO_FELIZ_LOG',
FILENAME = 'C:\TBD2021\U1\KINDER_MUNDO_FELIZ.LDF',
SIZE = 10MB,
MAXSIZE = UNLIMITED
);

--PONER EN USO LA BASE DE DATOS
USE KINDER_MUNDO_FELIZ;

--CREAR TABLA DE TIPOS DE CANDIDATOS
CREATE TABLE TIPOSCANDIDATOS
(
TipoId SMALLINT IDENTITY(1,1) PRIMARY KEY,
TipoDescripcion VARCHAR(30), 
TipoSexo CHAR(1) CHECK(TipoSexo ='H' OR TipoSexo ='M')
);

--CREAR TABLA DE CANDIDATOS
CREATE TABLE CANDIDATOS
(
CandidatoId VARCHAR(3) PRIMARY KEY,
CandidatoNombre VARCHAR(40),
CandidatoApellidoPaterno VARCHAR(40),
CandidatoApellidoMaterno VARCHAR(40),
CandidatoGrupo CHAR(2),
CandidatoEdad TINYINT,
TipoId SMALLINT REFERENCES TIPOSCANDIDATOS(TipoId)
);

--CREAR TABLA DE VOTANTES
CREATE TABLE VOTANTES
(
VotanteId INT PRIMARY KEY,
VotanteNombre VARCHAR(40),
VotanteApellidoPaterno VARCHAR(40),
VotanteApellidoMaterno VARCHAR(40),
VotanteGrupo CHAR(2),
VotanteFecha DATE default(getdate())
);

--CREAR TABLA DE VOTOS
CREATE TABLE VOTOS
(
VotoId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
CandidatoId VARCHAR(3) REFERENCES CANDIDATOS(CandidatoId),
VotanteId INT REFERENCES VOTANTES(VotanteId),
Votos MONEY DEFAULT 10,
VotoFecha DATE DEFAULT(getdate()),
CONSTRAINT CK_VOTOS
CHECK (Votos>=10)
);

