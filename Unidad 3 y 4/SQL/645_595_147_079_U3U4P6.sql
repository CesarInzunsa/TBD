--PONER EN USO LA BD
USE OXXOSTORE;

--1. Crear un login de EMPLEADO adem�s crear un usuario para el login con el nombre de
--   alguno de los trabajadores de la tabla de empleados.
CREATE LOGIN EMPLEADO WITH PASSWORD = '1324';
CREATE USER JORGE FOR LOGIN EMPLEADO;

--2. Ponle rol de writer al usuario qu� creasteALTER ROLE db_datawriter ADD MEMBER JORGE;--3. Inicia sesi�n con el usuario y muestra todos los productos qu� cuenta la tienda e intenta
--   eliminar la bebida fanta de la lista
SELECT * FROM PRODUCTOS;
DELETE FROM PRODUCTOS WHERE idPRODUCTOS = 17;

--4. Cual de las dos opciones fallo y por qu�, escribe la respuesta en la R

--R: Fallaron ambas debido a que el rol predefinido de db_datawriter solo otorga acceso
--   de INSERT, DELETE y UPDATE de todas las tablas, mas no de consultar registros o de utilizar WHERE

--5. Crear un usuario NATHALIA y Crea un rol llamado Administrador
CREATE LOGIN NATHALIA WITH PASSWORD = '1234';
CREATE USER NATHALIA FOR LOGIN NATHALIA;
CREATE ROLE Administrador;
ALTER ROLE Administrador ADD MEMBER NATHALIA;

--6. Asignar derechos al rol Administrador para que pueda modificar en la tabla productos
--   solo las columnas DESCRIPCI�N.
GRANT ALL(DESCRIPCION) ON PRODUCTOS TO Administrador;

--7. Comprueba qu� puedes modificar la columna descripci�n cambiando la descripci�n de
--   un producto y muestra el producto qu� modificaste.
UPDATE PRODUCTOS
SET DESCRIPCION = 'pan dulce de vainilla relleno de fresa'
WHERE idPRODUCTOS = 1;

SELECT DESCRIPCION FROM PRODUCTOS WHERE idPRODUCTOS = 1;

--8. Eliminar para el rol Administrador los derechos sobre la modificaci�n de la columna y
--   agregale todos los derechos sobre la tabla productos
REVOKE ALL(DESCRIPCION) ON PRODUCTOS TO Administrador;
GRANT ALL ON PRODUCTOS TO Administrador;

--9. Con el usuario NATHALIA agrega 3 productos (TAKIS, BIGMIX Y HOT-NUTS) de la
--   marca barcel BARCEL asignarles un precio y una descripci�n
INSERT INTO PRODUCTOS VALUES
(21, 'TAKIS', 'Barcel', 16, 'Maiz enrollada en forma de taco'),
(22, 'BIGMIX', 'Barcel', 16, 'Combinacion de diferentes botanas'),
(23, 'HOT-NUTS', 'Barcel', 16, 'Cacahuates con un toque de lim�n y chile piqu�n');

--10. Con el usuario qu� creaste en el punto 1 agrega un producto con el nombre de
--    manzanita de la marca Pepsico y si mundet de la coca cola company con un precio y descripci�n
INSERT INTO PRODUCTOS VALUES
(24, 'manzanita', 'Pepsico', 16, 'Refresco sabor a manzana'),
(25, 'mundet', 'coca cola', 16, 'Refresco sabor a manzana');

--11. Con el usuario NATHALIA agrega 2 nuevos empleados qu� ayuden uno tendr� qu�
--    estar en el turno de la ma�ana y otro en el vespertino
INSERT INTO PERSONAL VALUES
(9, 'CESAR', 'INZUNSA', 'DIAZ', '2021-01-01', 21, '3118526996', 'M'),
(10, 'JESUS', 'PARTIDA', 'MICHEL', '2021-02-01', 21, '3114744884', 'V');

--12. Con el usuario qu� creaste en el punto 1 agrega 3 nuevas ventas de productos qu�
--    usen los nuevos productos agregados en el punto 10 y muestra las ventas.INSERT INTO VENTAS VALUES(22, 24, 1, 2),(23, 25, 6, 5),(24, 25, 3, 1);SELECT * FROM VENTAS;--13. La tienda necesita un un nuevo due�o crea un nuevo login de due�o y usuario con tu
--    nombre y agr�gale el rol de ownerCREATE LOGIN CESAR WITH PASSWORD = '1234';CREATE USER CESAR FOR LOGIN CESAR;ALTER ROLE db_owner ADD MEMBER CESAR;--14. Lo primero qu� haces como nuevo due�o de la empresa es despedir 3 personas y
--    inicia sesi�n en tu usuario y despide a los empleados con los n�meros 6, 1, 3DELETE FROM PERSONAL WHERE idPERSONAL IN (6, 1, 3);--15. Elimina al usuario del punto 1 y el rol de empleadoDROP USER JORGE;DROP LOGIN EMPLEADO;