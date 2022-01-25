
-- PONER EN USO LA BD
USE RESTAURANT

-- Paso 1: Ingresa tres mesas de capacidad: 3, 4 y 5 y de id al gusto.
INSERT INTO MESA
VALUES
(1,3),
(2,4),
(3,5);

-- Paso 2: A��dete a ti y a 2 amigos m�s a MESEROS.
INSERT INTO MESEROS
VALUES
(20,'JESUS ALBERTO PARTIDA MICHEL','ME GUSTA MUCHO LOS VIDEOJUEGOS',500),
(20,'DANIEL EFRAIN PARTIDA DUE�AS','ME GUSTA MUCHO LEER LIBROS',500),
(20,'MARCOS EFREN HERRERA PE�A','ME GUSTA MUCHO BAILAR',500);

-- Paso 3: Introduce tus 3 comidas favoritas
INSERT INTO PLATILLO
VALUES
(1,'HAMBURGUESA','HAMBURGUESA DE POLLO CON PAPAS',75),
(2,'PESCADO EMPANIZADO','UN FILETE DE PESCADO EMPANIZADO CON ARROZ',90),
(3,'ORDEN DE TACOS','4 TACOS DE ASADA CON SALSA',45);

-- Paso 4: Introduce 3 bebidas:
INSERT INTO BEBIDAS
VALUES
(1,'AGUA DE MARACUYA',15),
(2,'AGUA DE LIMON',15),
(3,'COCA-COLA',20);

-- Paso 5: Mediante una transacci�n a�ade: un platillo (que gustes) y un mesero
BEGIN TRAN
INSERT INTO PLATILLO 
VALUES
(4,'MILANESA','PECHUGAS DE POLLO EMPANIZADA CON ARROZ',60);
INSERT INTO MESEROS
VALUES
(20,'MARTHA JULISSA PALOMERA LORENZANA','ME GUSTA MUCHO LOS BAILES Y LAS FIESTAS',500);
SELECT * FROM PLATILLO;
SELECT * FROM MESEROS;

-- Paso 6: Deshacer la transacci�n del paso 4.
ROLLBACK;

SELECT * FROM PLATILLO;
SELECT * FROM MESEROS;

-- Paso 7: Mediante una transacci�n inserta un mesero y guarda un punto llamado: Punto 1.
BEGIN TRAN
INSERT INTO MESEROS
VALUES
(20,'RUBEN DE JESUS PARRA GORDIAN','SOY UNA PERSONA ATLETICA Y AVENTURERA',500);

SAVE TRAN [Punto 1];

SELECT * FROM MESEROS;

-- Paso 8: Mediante una transacci�n borra a la persona que acabas de agregar
BEGIN TRAN
DELETE FROM MESEROS
WHERE nombre='RUBEN DE JESUS PARRA GORDIAN';

SELECT * FROM MESEROS;

-- Paso 9: Regresar al Punto1, verificar los valores y hacerlo permanente.
ROLLBACK TRAN [Punto 1];

SELECT * FROM MESEROS;

COMMIT;

-- Paso 10:Utilizando transacciones y "try": aumentar tu salario hasta que de error, recuerda que es de tipo (INT)
BEGIN TRY
BEGIN TRAN
UPDATE MESEROS
SET sueldo = 100000000000 
WHERE idMesero = 1
COMMIT
END TRY
BEGIN CATCH
PRINT 'ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!' 
ROLLBACK
END CATCH

-- Paso 11: As�gante un sueldo v�lido utilizando transacciones y m�todo "try"
BEGIN TRY
BEGIN TRAN
UPDATE MESEROS
SET sueldo = 3000
WHERE idMesero = 1
COMMIT
END TRY
BEGIN CATCH
PRINT 'ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
ROLLBACK
END CATCH

-- Paso 12:Usando transacciones realiza lo siguiente:
--Un cliente lleg� al restaurante,Lo atendi� el mesero:3 y orden� lo siguiente:
--Un sushi (Guarda un punto de transacci�n en este paso).
--una Coca-cola.
BEGIN TRAN
INSERT INTO ORDEN 
VALUES (1,3,1,1,3)
SAVE TRAN Pedido1
INSERT INTO ORDEN (idOrden,idBebida)
VALUES(2,1);

SELECT * FROM ORDEN;

--Paso 13: El cliente cancel� la bebida y confrim� su orden, haz la indicaci�n que se adjunta.
ROLLBACK TRAN Pedido1;
COMMIT;

SELECT * FROM ORDEN;

-- Paso 14: despide al mesero 2 y aumenta tu salario a 5000 (haz commit).
BEGIN TRAN
DELETE FROM MESEROS
WHERE idMesero=2
UPDATE MESEROS
SET sueldo=5000
WHERE idMesero=1
COMMIT;

SELECT * FROM MESEROS;

-- Paso 15: A�ade un mesero nuevo y establece el salario del mesero 2 a 1000. Haz commit en la instrucci�n.
BEGIN TRAN 
INSERT INTO MESEROS
VALUES(20,'ANA ELISA MICHEL PE�A','PERSONA FELIZ QUE GUSTA AYUDAR A LOS DEM�S',10000)
UPDATE MESEROS
SET sueldo=1000
WHERE idMesero=2
COMMIT;