/**
PRACTICA 1
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
NO. CONTROL: 19400595
FECHA: 09/09/2021
DESCRIPCION: CREANDO MI PRIMERA BD
**/
CREATE DATABASE TBD2021GA
ON PRIMARY
(
NAME = 'TBD2021_GRUPOA.MDF',
FILENAME = 'C:\TBD2021\U1\TBD2021GA.MDF'
)
LOG ON
(
NAME = 'TBD2021_GRUPOA.LDF',
FILENAME ='C:\TBD2021\U1\TBD2021GA.LDF'
);

-- PONER EN USO
USE TBD2021GA;