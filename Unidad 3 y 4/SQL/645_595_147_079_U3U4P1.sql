--PONER EN USO LA BASE DE DATOS
USE DISNEYPIXAR_FILMOGRAFIA;

--1. Crear un LOGIN llamado “Disney” con contraseña de ‘12345’.
CREATE LOGIN DISNEY WITH PASSWORD = '12345';

--2. Crea un USUARIO en la BD Disney con el nombre “Woody” para el LOGIN del punto 1
CREATE USER WOODY FOR LOGIN DISNEY;

--3. Crear un LOGIN con nombre “Pixar” con contraseña ‘12345’
CREATE LOGIN PIXAR WITH PASSWORD = '12345';

--4. Crear un nuevo USUARIO en la BD Disney con el nombre “Buzz” para el LOGIN del punto 3.
CREATE USER BUZZ FOR LOGIN PIXAR;

--5. Otorgar los permisos de UPDATE, SELECT, INSERT y DELETE al USUARIO Woody para todas las tablas.
GRANT UPDATE, SELECT, INSERT, DELETE TO WOODY;

--6. Con el LOGIN de Disney eliminar el personajeID = 10.
DELETE FROM PERSONAJES WHERE personajeID = 10;

--7. Muestra los nombres de los personajes, con el alias PERSONAJES.
SELECT nombre AS PERSONAJES FROM PERSONAJES;

--8. Con el USUARIO de Buzz, intente eliminar un personaje, para comprobar que no tiene permisos.
DELETE FROM PERSONAJES WHERE personajeID = 1;

--9. Otorgar permisos para toda la BD al usuario Buzz.
GRANT UPDATE, SELECT, INSERT, DELETE TO BUZZ;

--10. Insertar un nuevo personaje llamado “tu_nombre” con el LOGIN del punto 3
INSERT INTO PERSONAJES VALUES ('Cesar',' ',1,14);

--11. Insertar una película nueva que no esté en la tabla con el LOGIN del punto 1.
INSERT INTO PELICULAS VALUES ('Soul','2020-01-01','Animacion 3D',1);

--12. Mostrar las películas con el alias de LAS MEJORES PELICULAS DEL MUNDO
SELECT nombre AS [LAS MEJORES PELICULAS DEL MUNDO] FROM PELICULAS;

--13. Deniega los permisos para todos los USUARIOS.DENY ALL TO WOODY;DENY ALL TO BUZZ;--14. Elimina todos los USUARIOSDROP USER BUZZ;DROP USER WOODY;--15. Elimina los LOGINDROP LOGIN PIXAR;DROP LOGIN DISNEY;