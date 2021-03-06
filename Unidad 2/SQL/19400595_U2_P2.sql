/*
PRACTICA 2
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
FECHA: 06/09/21
NO. CONTROL: 19400595
DESCRIPCION: APRENDER A UTILIZAR EL BULK INSERT
*/

--PONER EN USO LA BASE DE DATOS DE SUPER HEROES
USE SUPERHERORES;

--BORRAR REGISTROS DE LA TABLA LUGARES_DEFENSA
DELETE FROM LUGARES_DEFENSA;

--REINICIAR IDENTITY DE LA TABLA LUGARES_DEFENSA
DBCC CHECKIDENT (LUGARES_DEFENSA, RESEED, 0);

--INSERTAR MASIVAMENTE DATOS DE UN ARCHIVO CSV  A LA TABLA LUGARES_DEFENSA
BULK INSERT LUGARES_DEFENSA FROM 'C:\TBD2021\U2\LUGARES_DEFENSA.CSV' WITH (FIELDTERMINATOR = ',');

--INSERTAR MASIVAMENTE DATOS DE UN ARCHIVO CSV  A LA TABLA TRAJES
BULK INSERT TRAJES FROM 'C:\TBD2021\U2\TRAJES.CSV' WITH (FIELDTERMINATOR = ',');

--INSERTAR MASIVAMENTE DATOS DE UN ARCHIVO CSV  A LA TABLA PODERES
BULK INSERT PODERES FROM 'C:\TBD2021\U2\PODERES.CSV' WITH (FIELDTERMINATOR = ',');

--INSERTAR MASIVAMENTE DATOS DE UN ARCHIVO CSV  A LA TABLA HEROES
BULK INSERT HEROES FROM 'C:\TBD2021\U2\HEROES.CSV' WITH (FIELDTERMINATOR = ',');

--INSERTAR MASIVAMENTE DATOS DE UN ARCHIVO CSV  A LA TABLA PODERES_HEROES
BULK INSERT PODERES_HEROES FROM 'C:\TBD2021\U2\PODERES_HEROES.CSV' WITH (FIELDTERMINATOR = ',');

--INSERTAR MASIVAMENTE DATOS DE UN ARCHIVO CSV  A LA TABLA VILLANOS
BULK INSERT VILLANOS FROM 'C:\TBD2021\U2\VILLANOS.CSV' WITH (FIELDTERMINATOR = ',');

--INSERTAR MASIVAMENTE DATOS DE UN ARCHIVO CSV  A LA TABLA PODERES_VILLANOS
BULK INSERT PODERES_VILLANOS FROM 'C:\TBD2021\U2\PODERES_VILLANOS.CSV' WITH (FIELDTERMINATOR = ',');

--INSERTAR MASIVAMENTE DATOS DE UN ARCHIVO CSV  A LA TABLA HEROESvsVILLANOS
BULK INSERT HEROESvsVILLANOS FROM 'C:\TBD2021\U2\HEROESvsVILLANOS.CSV' WITH (FIELDTERMINATOR = ',');

