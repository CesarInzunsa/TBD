--PONER EN USO LA BASE DE DATOS DE ESCUELA_PRIMARIA
USE escuela_primaria;

--1. Crear un LOGIN de “Profesor”.
CREATE LOGIN Profesor WITH PASSWORD = '1234';

--2. Crear un USER para el LOGIN del punto 1.
CREATE USER Profesor FOR LOGIN Profesor;

--3. Ponle rol de WHITER al USER.
ALTER ROLE db_datawriter ADD MEMBER Profesor;

--4. Inserta a tu equipo como alumnos
INSERT INTO ALUMNOS VALUES
(2,'JESUS','PARTIDA',1,10,'JUAN MANUEL','3112589658','2011-01-01'),
(3,'ENRIQUE','LOPEZ',2,11,'JUAN MANUEL','3112589658','2010-01-01'),
(4,'JOSUE','AGUILAR',1,11,'JUAN MANUEL','3112589658','2010-01-01'),
(5,'CESAR','INZUNSA',2,10,'JUAN MANUEL','3112589658','2011-01-01');

--5. Inicia sesión con el USER “Profesor”.

--6. Crea un rol llamado “supervisor”.
CREATE ROLE supervisor;

--7. Ahora intenta borrar a uno de los “alumnos” que insertaste anteriormente para verificar.
DELETE FROM ALUMNOS WHERE idAlumno = 2;

--8. Vuelve al USER del sistema.

--9. Crea un LOGIN y USER con el nombre de “director”.
CREATE LOGIN director WITH PASSWORD = '1234';
CREATE USER director FOR LOGIN director;

--10. Asígnale el rol de OWNER (db_owner) al USER doctor e inicia sesión.
ALTER ROLE db_owner ADD MEMBER director;

--11. Asígnale los permisos de la tabla “alumnos” al rol que creaste en el punto 6(supervisor).
GRANT ALL ON ALUMNOS TO supervisor;

--12. Agrégate como USER.
CREATE LOGIN CESAR WITH PASSWORD = '1234';
CREATE USER CESAR FOR LOGIN CESAR;

--13. Ponte el rol de “supervisor”.
ALTER ROLE supervisor ADD MEMBER CESAR;

--14. Inicia sesión con tu USER (supervisor) y elimina al usuario de la tabla ADMINISTRATIVO.
DELETE FROM ADMINISTRACION WHERE idAdministracion = 1;

--15. Crea una copia de seguridad de la BD con el backup operator.
BACKUP DATABASE ESCUELA_PRIMARIA
TO DISK = 'C:\Users\cesar\Desktop\copia\ESCUELA_PRIMARIA.bak'
WITH FORMAT;
