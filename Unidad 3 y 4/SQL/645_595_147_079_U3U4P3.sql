--PONER EN USO LA BD
USE NCT;

--1. Inserta de forma masiva los datos de los .csv que se te proporcionaron.
BULK INSERT INTEGRANTES FROM 'C:\TBD2021\U3 y U4\EQUIPO_MORADO\BD NCT\INTEGRANTES.CSV' WITH (FIELDTERMINATOR = ',');
BULK INSERT NACIONALIDAD FROM 'C:\TBD2021\U3 y U4\EQUIPO_MORADO\BD NCT\NACIONALIDAD.CSV' WITH (FIELDTERMINATOR = ',');
BULK INSERT POS_INT FROM 'C:\TBD2021\U3 y U4\EQUIPO_MORADO\BD NCT\POS_INT.CSV' WITH (FIELDTERMINATOR = ',');
BULK INSERT POSICION FROM 'C:\TBD2021\U3 y U4\EQUIPO_MORADO\BD NCT\POSICION.CSV' WITH (FIELDTERMINATOR = ',');
BULK INSERT SUB_INT FROM 'C:\TBD2021\U3 y U4\EQUIPO_MORADO\BD NCT\SUB_INT.CSV' WITH (FIELDTERMINATOR = ',');
BULK INSERT SUBUNIDADES FROM 'C:\TBD2021\U3 y U4\EQUIPO_MORADO\BD NCT\SUBUNIDADES.CSV' WITH (FIELDTERMINATOR = ',');

--2. Crear un LOGIN llamado “CEO” con contraseña de ‘12345’,
--   debe cambiar la contraseña cada que se quiera ingresar, idioma español.
CREATE LOGIN CEO WITH PASSWORD = '12345' MUST_CHANGE, CHECK_EXPIRATION = ON;

--3. Crea un USUARIO en la BD NCT con el nombre “Sooman” para el LOGIN que del punto 1.
CREATE USER Sooman FOR LOGIN CEO;

--4. Crear un LOGIN con nombre “Productor” con contraseña ‘12345’
CREATE LOGIN Productor WITH PASSWORD = '12345';

--5. Crear un nuevo USUARIO en la BD NCT con el nombre “Juan” para el LOGIN del punto 3.
CREATE USER Juan FOR LOGIN Productor;

--6. Otorgar los permisos de UPDATE, SELECT, INSERT y DELETE al USUARIO Sooman para todas las tablas.
GRANT UPDATE, SELECT, INSERT, DELETE TO Sooman;

--7. Con el LOGIN de CEO eliminar el idIntegrantes = 1.
DELETE FROM POS_INT WHERE idIntegrantes = 1;
DELETE FROM SUB_INT WHERE idIntegrantes = 1;
DELETE FROM INTEGRANTES WHERE idIntegrantes = 1;

--8. Muestra los nombres de los Integrantes, con el alias INTEGRANTES
SELECT NombreIntegrante AS INTEGRANTES FROM INTEGRANTES;

--9. Con el USUARIO de Juan, intente eliminar un integrante, para comprobar que no tiene permisos.
DELETE FROM INTEGRANTES WHERE idIntegrantes = 50;

--10. Otorgar permisos para toda la BD al usuario Juan.
GRANT ALL TO Juan;

--11. Deniega los permisos para todos los USUARIOSDENY ALL TO Juan;DENY ALL TO Sooman;--12. Elimina todos los USUARIOS.DROP USER Juan;DROP USER Sooman;--13. Elimina los LOGINDROP LOGIN CEO;DROP LOGIN Productor;