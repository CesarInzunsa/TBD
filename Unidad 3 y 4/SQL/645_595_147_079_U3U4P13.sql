
--1. PON EN USO LA BASE DE DATOS
--CREA EL DIAGRAMA DE LA BASE DE DATOS DE RENTA DE PELICULAS EL CUAL LLEVARA COMO NOMBRE "RentaPeliculas_Diagrama"
USE RentaPeliculas;
-- YA ESTA HECHO EL DIAGRAMA 

--2. CREAR UN ROL QUE SE LLAME "DEPENDIENTE".
CREATE ROLE DEPENDIENTE;


--3. CONCEDE TODOS LOS PERMISOS AL ROL "DEPENDIENTE" SOBRE LAS TABLAS DE "USUARIOS" Y "PRESTAMOS".
GRANT ALL ON USUARIOS TO DEPENDIENTE;
GRANT ALL ON PRESTAMOS TO DEPENDIENTE;

--4. CREAR UN LOGIN QUE TENGA COMO CONTRASEÑA "1234" Y UN USER PARA ESE LOGIN. AMBOS LLEVARAN COMO NOMBRE EL TUYO.
CREATE LOGIN JESUS WITH PASSWORD = '1234';
CREATE USER JESUS FOR LOGIN JESUS;


--5. OTORGALE AL USUARIO QUE ACABAS DE CREAR EL ROL DE "DEPENDIENTE".
ALTER ROLE DEPENDIENTE ADD MEMBER JESUS;


--6. CON EL LOGIN QUE CREASTE, INICIA SESION INSERTA A DOS DE TUS COMPAÑEROS EN LA TABLA DE USUARIOS (SOLO NOMBRE Y APELLIDO)
--    NOMBRE         APELLIDO   DOMICILIO
-- NOMBRE AMIGO 1 APELLIDO AMIGO 1 NULL
-- NOMBRE AMIGO 2 APELLIDO AMIGO 2 NULL
INSERT INTO USUARIOS VALUES
('ENRIQUE', 'lOPEZ', NULL),
('ALBERTO', 'PARTIDA', NULL);


--6.1 INTENTA BORRAR UN DATO DE LA TABLA PRESTAMOS Y VERIFICA QUE SI ES POSIBLE
DELETE FROM PRESTAMOS WHERE IdPrestamo = 10;


--7. DENIEGA EL PERMISO DE BORRAR AL ROL DE "DEPENDIENTE" y VERIFICA SI ES POSIBLE BORRAR UN DATO 
REVOKE DELETE TO DEPENDIENTE;


--8. CON EL LOGIN QUE CREASTE, INSERTA EN LA TABLA DE "PRESTAMOS" UNO PARA CADA UNO DE LOS USUARIOS QUE ACABAS DE INSERTAR
INSERT INTO PRESTAMOS VALUES
(1,18,'2021-11-18','2021-12-01',NULL),
(1,19,'2021-11-18','2021-12-01',NULL);

--8.1 CON EL LOGIN QUE CREASTE, INTENTA ELIMINAR UN PRESTAMO DE LOS COMPAÑEROS QUE ACABAS DE INSERTAR 
DELETE FROM PRESTAMOS WHERE idUsuario = 18;


--9. CON EL LOGIN QUE CREASTE, ACTUALIZAR LA FECHA DE DEVOLUCION PARA LOS ULTIMOS DOS PRESTAMOS, QUE LA DEVOLUCION SEA: "2021-11-22"
UPDATE PRESTAMOS
SET FechaDevolucion = '2021-11-22'
WHERE FechaDevolucion IS NULL;


--10. CREAR UN LOGIN QUE TENGA COMO CONTRASEÑA "1234" Y UN USER PARA ESE LOGIN. AMBOS SE LLAMARA "GERENTE"
CREATE LOGIN GERENTE WITH PASSWORD = '1234';
CREATE USER GERENTE FOR LOGIN GERENTE;


--11. CONCEDE LOS ROLES FIJOS DE db_datawriter Y db_datareader AL GERENTE
 ALTER ROLE db_datawriter ADD MEMBER GERENTE;
 ALTER ROLE db_datareader ADD MEMBER GERENTE;


--12. CON EL LOGIN DE GERENTE, INICIA SESION E INSERTA LOS SIGUIENTES REGISTROS EN LA TABLA DE PELÍCULAS Y,
--DE FORMA GRÁFICA EDITA LOS ACENTOS
--    NOMBRE    DURACIÓN (MINUTOS)       FECHA ESTRENO         DESCRIPCIÓN
--   Inception        118                 2010-06-23       Película ambientada en
--                                                         un mundo donde existe
--                                                         la tecnología para
--                                                         entrar en las mentes de
--                                                         las personas
-- V for Vendetta      102                2006-03-17       La vida de Evey da un
--                                                         giro inesperado tras
--                                                         conocer a un
--                                                         misterioso hombre
--                                                         enmascarado conocido
--                                                         como V
--    In time          109                2011-11-04       Ambientada en un
--                                                         futuro donde el tiempo
--                                                         es la moneda de
--                                                         cambio y la
--                                                         inmortalidad solo es
--                                                         conseguida por los
--                                                         millonarios
INSERT INTO PELICULAS VALUES 
('Inception',118,'2010-06-23','Película ambientada en un mundo donde existe la tecnología para entrar en las mentes de las personas'),
('V for Vendetta',102,'2006-03-17','La vida de Evey da un giro inesperado tras conocer a un misterioso hombre enmascarado conocido como V'),
('In time',109,'2011-11-04','Ambientada en un futuro donde el tiempo es la moneda de cambio y la inmortalidad solo es conseguida por los millonarios');


--13. CON EL LOGIN DE GERENTE, CONSULTA LOS TITULOS DE LAS PELICULAS Y LA CANTIDAD DE PRESTAMOS QUE TIENEN
SELECT P.Titulo, COUNT(PT.idPelicula) AS PRESTAMOS
FROM PELICULAS P
INNER JOIN PRESTAMOS PT ON (P.IdPelicula = PT.idPelicula)
GROUP BY P.Titulo;


--14. CREA UN LOGIN Y UN USUARIO PARA ESE LOGIN QUE SE LLAME "ADMINISTRADOR_SQL" y que tenga como contraseña: "SuperAdmin"
--    Y QUE TENGA COMO ROL: EL ROL FIJO DE NIVEL SERVIDOR DE processadmin
CREATE LOGIN ADMINISTRADOR_SQL WITH PASSWORD = 'SuperAdmin';
CREATE USER ADMINISTRADOR_SQL FOR LOGIN ADMINISTRADOR_SQL;
ALTER SERVER ROLE processadmin ADD MEMBER ADMINISTRADOR_SQL;


--15. CAMBIA EL NOMBRE DEL ROL DE GERENTE A GERENTE_PLUS
ALTER ROLE DEPENDIENTE WITH NAME = DEPENDIENTE_PLUS;


--16. REVOCA AL ROL DE DEPENDIENTE_PLUS ACTUALIZAR SOBRE LA TABLA DE USUARIOS Y COMPRUEBA QUE YA NO TENGAS DICHO PERMISO.
REVOKE UPDATE ON USUARIOS TO DEPENDIENTE_PLUS;

UPDATE USUARIOS
SET Apellido = 'PARTIDA MICHEL'
WHERE Nombre = 'ALBERTO';


--17. BORRA TODOS LOS USUARIOS, LOGIN Y ROLES
DROP USER JESUS;
DROP LOGIN JESUS;

DROP USER ADMINISTRADOR_SQL;
DROP LOGIN ADMINISTRADOR_SQL;

DROP USER GERENTE;
DROP LOGIN GERENTE;

DROP ROLE DEPENDIENTE_PLUS;

