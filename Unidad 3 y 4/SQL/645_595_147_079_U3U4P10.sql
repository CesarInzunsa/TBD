
-- PONER EN USO LA BD
USE LIVERPOOL;

--LOGIN SA
/*1.- Crear el diagrama de la base de datos, y analizar que tiene cada una de las
tablas.*/
-- YA ESTA HECHO

--2.- Crear un login llamado Juguetería y poner la contraseña Lego.
CREATE LOGIN Jugueteria WITH PASSWORD = 'Lego'

/*3-. Asignarle un usuario al usuario que creamos en el paso anterior, llamado
Juguetero.*/
CREATE USER Juguetero FOR LOGIN Jugueteria

/*4.- Crear un segundo login llamado Videojuegos y poner la contraseña halo, con la
propiedad must change, para que se nos pida cambiar la contraseña por una nueva
al momento de iniciar crear sesión con el login. La nueva contraseña será
pikachu.*/
CREATE LOGIN Videojuegos WITH PASSWORD = 'Halo'
MUST_CHANGE, CHECK_EXPIRATION = ON

--5.- Crear un usuario para el login de Videojuegos que lleve tu nombre.
CREATE USER Jesus FOR LOGIN Videojuegos

/*6.- Otorgar todos los permisos al usuario videojuego en la tabla área (debe contar
con todos los permisos utilizando grant all)*/
GRANT ALL ON Area TO Jesus

/*LOGIN VIDEOJUEGOS.
7.- Comprobar que se pueda SELECCIONAR, ACTUALIZAR, ELIMINAR E
INSERTAR.*/
--a) Seleccionar todos los campos de la tabla área
SELECT * FROM Area

/*b) Actualizar el id = 10 a 'Música e instrumentos y comprobar el cambio
efectuado.*/
UPDATE Area
SET nombre = 'Musica e instrumentos'
WHERE idArea = 10

SELECT * FROM Area WHERE idArea = 10

--c) Insertar una nueva categoría llamada 'Salas y comedores'
INSERT INTO Area VALUES ('Salas y comedores')

SELECT * FROM Area

--d) Borrar la categoría agregada anteriormente.
DELETE FROM Area WHERE idArea = 11

SELECT * FROM Area

--LOGIN SA
/*8.- Revocar los permisos de los usuarios con tu nombre en el login de
videojuegos, a solo Select para que no tenga permiso de eliminar, editar o insertar
valores a la tabla área.*/
REVOKE INSERT, UPDATE, DELETE ON Area TO Jesus

/*9.- Efectuar las mismas operaciones hechas en los incisos del punto 7 para
corroborar que se haya efectuado la revocación.*/
SELECT * FROM Area

UPDATE Area
SET nombre = 'Musica e instrumentos'
WHERE idArea = 10

INSERT INTO Area VALUES ('Salas y comedores')

DELETE FROM Area WHERE idArea = 11

/*10.- Al usuario creado en el punto 3 llamado Juguetero, denegar los permisos de
INSERT, DELETE sobre la tabla producto*/
DENY INSERT, DELETE ON Productos TO Juguetero

/*LOGIN JUGUETERÍA
11.- comprobar las denegaciones de permisos para la tabla. Insertar un producto
llamado Samsumg A32, descripcion = 'Celular de gama media alta', y precio =
8000*/
INSERT INTO Productos VALUES ('Samsumg A32','Celular de gama media alta',8000)

/*12.- Comprobar la denegación de DELETE, intentado borrar el registro con el id= 1
de la tabla Productos*/
DELETE FROM Productos WHERE idProducto = 1

--LOGIN SA
--13.- Borrar el usuario Juguetero del Login Juguetería.
DROP USER Juguetero

--14.- Comprobar la eliminación de ese usuario.
-- LISTO ESTA COMPROBADO 

--15.- Hacer lo mismo con el usuario creado con tu nombre del login Videojuegos.
DROP USER Jesus

/*16.- Eliminar los logins, primeramente, cerrar la sesión en los logins. (en caso de
mostrar algún error, dar clic derecho en login y dar clic activity monitor para matar
los procesos.)*/
DROP LOGIN Jugueteria
DROP LOGIN Videojuegos