
--PONER EN USO LA BD
USE AGENCIA_DE_TALENTOS

--LOGIN SA
/*1.- Crear el diagrama de la base de datos, y analizar que tiene cada una de las
tablas.*/
-- YA ESTA HECHO

--2.- Crear un login llamado ceo y poner la contraseña 12345.
CREATE LOGIN ceo WITH PASSWORD = '12345'

/*3-. Asignarle un usuario al login que creamos en el paso anterior, llamado
ceo.*/
CREATE USER ceo FOR LOGIN ceo

/*4.- Crear un segundo login llamado artista y poner la contraseña 12345, con la
propiedad must change, para que se nos pida cambiar la contraseña por una nueva
al momento de iniciar crear sesión con el login. La nueva contraseña será
electronica.*/
CREATE LOGIN artista WITH PASSWORD = '12345' 
MUST_CHANGE, CHECK_EXPIRATION = ON

--5.- Crear un usuario para el login de ARTISTA que lleve el nombre de aimer y que 
-- ceo tenga acceso a todas las tablas
CREATE USER aimer FOR LOGIN artista

GRANT ALL ON Agente TO ceo
GRANT ALL ON Artistas TO ceo
GRANT ALL ON Clientes TO ceo
GRANT ALL ON Contratos TO ceo
GRANT ALL ON Generos_Musicales TO ceo
GRANT ALL ON Juridico TO ceo

/*6.- Otorgar todos los permisos al usuario aimer en la tabla Generos_Musicales 
(debe contar
con todos los permisos utilizando grant all)*/
GRANT ALL ON Generos_Musicales TO aimer

/*LOGIN aimer.
7.- Comprobar que se pueda SELECCIONAR, ACTUALIZAR, ELIMINAR E
--INSERTAR.*/
--a) Seleccionar todos los campos de la tabla área
SELECT * FROM Generos_Musicales

/*b) Actualizar el idGenero = 5 a 'Electronica' y comprobar el cambio
efectuado.*/
UPDATE Generos_Musicales
SET descripcion = 'Electronica'
WHERE idGenero = 5

SELECT * FROM Generos_Musicales WHERE idGenero = 5

--c) Insertar una nueva categoría llamada '('rock sinfonico' y como exponentes de la 
-- musica a'nightwish''
INSERT INTO Generos_Musicales VALUES ('rock sinfonico','nightwish')

SELECT * FROM Generos_Musicales

--d) Borrar la categoría agregada anteriormente.
DELETE FROM Generos_Musicales WHERE idGenero = 1002

SELECT * FROM Generos_Musicales

--LOGIN SA
/*8.- Revocar los permisos de los usuarios con tu nombre en el login de
ceo, a solo Select para que no tenga permiso de eliminar, editar o insertar
valores a la tabla Generos_Musicales.*/
REVOKE INSERT, UPDATE, DELETE ON Generos_Musicales TO aimer

/*9.- Efectuar las mismas operaciones hechas en los incisos del punto 7 para
corroborar que se haya efectuado la revocación.*/
SELECT * FROM Generos_Musicales

UPDATE Generos_Musicales
SET descripcion = 'Electronica'
WHERE idGenero = 5

INSERT INTO Generos_Musicales VALUES ('rock sinfonico','nightwish')

DELETE FROM Generos_Musicales WHERE idGenero = 1002

/*10.- Al usuario creado en el punto 3 llamado ceo, denegar los permisos de
INSERT, DELETE sobre la tabla generos musicales*/
REVOKE INSERT, DELETE ON Generos_Musicales TO ceo

/*LOGIN ceo
11.- comprobar las denegaciones de permisos para la tabla. Insertar un contrato en 
la tabla cvontrato en la que tenga
fecha inicio = 2021-03-11 , fecha fin = 2021-06-22 , pago contrato = 3 000 000, 
idcliente = 2, idagente =3
*/
INSERT INTO Contratos VALUES ('2021-03-11','2021-06-22',3000000,2,3)

/*12.- Comprobar la denegación de DELETE, intentado borrar el registro con el id= 1
de la tabla contratos*/
DELETE FROM Contratos WHERE idContrato = 1

/*LOGIN SA
--13.- Borrar el usuario ceo del Login ceo.*/
DROP USER ceo

--14.- Comprobar la eliminación de ese usuario.
-- YA ESTA COMPROBADO

--15.- Hacer lo mismo con el usuario creado con tu nombre del login Videojuegos.
DROP USER aimer

/*16.- Eliminar los logins, primeramente, cerrar la sesión en los logins. (en caso 
de mostrar algún error, dar clic derecho en login y dar clic activity monitor para 
matar
los procesos.)*/
DROP LOGIN ceo
DROP LOGIN artista