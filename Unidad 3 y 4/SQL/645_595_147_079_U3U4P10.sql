
-- PONER EN USO LA BD
USE LIVERPOOL;

--LOGIN SA
/*1.- Crear el diagrama de la base de datos, y analizar que tiene cada una de las
tablas.*/
-- YA ESTA HECHO

--2.- Crear un login llamado Jugueter�a y poner la contrase�a Lego.
CREATE LOGIN Jugueteria WITH PASSWORD = 'Lego'

/*3-. Asignarle un usuario al usuario que creamos en el paso anterior, llamado
Juguetero.*/
CREATE USER Juguetero FOR LOGIN Jugueteria

/*4.- Crear un segundo login llamado Videojuegos y poner la contrase�a halo, con la
propiedad must change, para que se nos pida cambiar la contrase�a por una nueva
al momento de iniciar crear sesi�n con el login. La nueva contrase�a ser�
pikachu.*/
CREATE LOGIN Videojuegos WITH PASSWORD = 'Halo'
MUST_CHANGE, CHECK_EXPIRATION = ON

--5.- Crear un usuario para el login de Videojuegos que lleve tu nombre.
CREATE USER Jesus FOR LOGIN Videojuegos

/*6.- Otorgar todos los permisos al usuario videojuego en la tabla �rea (debe contar
con todos los permisos utilizando grant all)*/
GRANT ALL ON Area TO Jesus

/*LOGIN VIDEOJUEGOS.
7.- Comprobar que se pueda SELECCIONAR, ACTUALIZAR, ELIMINAR E
INSERTAR.*/
--a) Seleccionar todos los campos de la tabla �rea
SELECT * FROM Area

/*b) Actualizar el id = 10 a 'M�sica e instrumentos y comprobar el cambio
efectuado.*/
UPDATE Area
SET nombre = 'Musica e instrumentos'
WHERE idArea = 10

SELECT * FROM Area WHERE idArea = 10

--c) Insertar una nueva categor�a llamada 'Salas y comedores'
INSERT INTO Area VALUES ('Salas y comedores')

SELECT * FROM Area

--d) Borrar la categor�a agregada anteriormente.
DELETE FROM Area WHERE idArea = 11

SELECT * FROM Area

--LOGIN SA
/*8.- Revocar los permisos de los usuarios con tu nombre en el login de
videojuegos, a solo Select para que no tenga permiso de eliminar, editar o insertar
valores a la tabla �rea.*/
REVOKE INSERT, UPDATE, DELETE ON Area TO Jesus

/*9.- Efectuar las mismas operaciones hechas en los incisos del punto 7 para
corroborar que se haya efectuado la revocaci�n.*/
SELECT * FROM Area

UPDATE Area
SET nombre = 'Musica e instrumentos'
WHERE idArea = 10

INSERT INTO Area VALUES ('Salas y comedores')

DELETE FROM Area WHERE idArea = 11

/*10.- Al usuario creado en el punto 3 llamado Juguetero, denegar los permisos de
INSERT, DELETE sobre la tabla producto*/
DENY INSERT, DELETE ON Productos TO Juguetero

/*LOGIN JUGUETER�A
11.- comprobar las denegaciones de permisos para la tabla. Insertar un producto
llamado Samsumg A32, descripcion = 'Celular de gama media alta', y precio =
8000*/
INSERT INTO Productos VALUES ('Samsumg A32','Celular de gama media alta',8000)

/*12.- Comprobar la denegaci�n de DELETE, intentado borrar el registro con el id= 1
de la tabla Productos*/
DELETE FROM Productos WHERE idProducto = 1

--LOGIN SA
--13.- Borrar el usuario Juguetero del Login Jugueter�a.
DROP USER Juguetero

--14.- Comprobar la eliminaci�n de ese usuario.
-- LISTO ESTA COMPROBADO 

--15.- Hacer lo mismo con el usuario creado con tu nombre del login Videojuegos.
DROP USER Jesus

/*16.- Eliminar los logins, primeramente, cerrar la sesi�n en los logins. (en caso de
mostrar alg�n error, dar clic derecho en login y dar clic activity monitor para matar
los procesos.)*/
DROP LOGIN Jugueteria
DROP LOGIN Videojuegos