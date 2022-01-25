

-- PONER EN USO LA BD 
USE Videojuego;

-- 1 CREA UN DIAGRAMA DE LA BASE DE DATOS Y ENTIENDE C�MO EST�
-- ESTRUCTURADO


-- 2 USA UNA TRANSACCI�N PARA INSERTAR EN LA BASE DE DATOS TUS DATOS DE
-- JUGADOR EN LA TABLA JUGADOR
SELECT * FROM JUGADOR

BEGIN TRY 
BEGIN TRAN
INSERT INTO JUGADOR VALUES ('Juan','Quiroz',2)
COMMIT TRAN
PRINT 'SE HA INSERTADO CORRECTAMENTE'
END TRY
BEGIN CATCH
ROLLBACK
PRINT 'NO SE INSERTO EL JUGADOR'
END CATCH

-- 3 MODIFICA EL PERSONAJE QUE SELECCIONASTE POR OTRO PERO HAS QUE SE
-- EJECUTE UN ROLLBACK Y VERIFICA EL CAMBIO
BEGIN TRY 
BEGIN TRAN 
UPDATE JUGADOR 
SET Personaje = 11
WHERE JugId = 11
COMMIT TRAN
PRINT 'JUGADOR MODIFICADO'
END TRY
BEGIN CATCH 
ROLLBACK TRAN
PRINT 'NO SE PUDO MODIFICAR EL JUGADOR' 
END CATCH 

-- 4 HAZ QUE LA CONSULTA ANTERIOR FUNCIONE Y VERIFICA EL CAMBIO
BEGIN TRY 
BEGIN TRAN 
UPDATE JUGADOR 
SET Personaje = 7
WHERE JugId = 11
COMMIT TRAN
PRINT 'JUGADOR MODIFICADO'
END TRY
BEGIN CATCH 
ROLLBACK TRAN
PRINT 'NO SE PUDO MODIFICAR EL JUGADOR' 
END CATCH 

SELECT * FROM JUGADOR;

-- 5 ELIMINA TU JUGADOR DE LA BASE DE DATOS USANDO UNA TRANSACCI�N Y
-- VERIFICA EL CAMBIO
BEGIN TRY 
BEGIN TRAN 
DELETE FROM JUGADOR WHERE JugId = 11
COMMIT TRAN
END TRY
BEGIN CATCH 
ROLLBACK TRAN
END CATCH

-- 6 HAZ UNA TRANSACCI�N DONDE INSERTES, ACTUALICES EL TIPO Y ELIMINES AL
-- PERSONAJE
-- Y MUESTRA DURANTE LA EJECUCI�N DE CADA PASO CON UN SELECT * EN CADA
-- PASO
SELECT * FROM TIPOP;

BEGIN TRAN T1
INSERT INTO PERSONAJE VALUES ('Vex', 1)
SELECT * FROM PERSONAJE
BEGIN TRAN T2
UPDATE PERSONAJE
SET Tipo = 9
WHERE PerNombre = 'Vex'
SELECT * FROM PERSONAJE
BEGIN TRAN T3
DELETE FROM PERSONAJE WHERE PerNombre = 'Vex'
SELECT * FROM PERSONAJE
COMMIT TRAN T3
COMMIT TRAN T2
COMMIT TRAN T1

-- 7 HAZ QUE LA TRANSACCI�N ANTERIOR ACTIVE EL ROLLBACK
BEGIN TRY
BEGIN TRAN T1
INSERT INTO PERSONAJE VALUES ('Vex', 1)
SELECT * FROM PERSONAJE
BEGIN TRAN T2
UPDATE PERSONAJE
SET Tipo = 11
WHERE PerNombre = 'Vex'
SELECT * FROM PERSONAJE
BEGIN TRAN T3
DELETE FROM PERSONAJE WHERE PerNombre = 'Vex'
SELECT * FROM PERSONAJE
COMMIT TRAN T3
COMMIT TRAN T2
COMMIT TRAN T1
END TRY 
BEGIN CATCH
ROLLBACK TRAN T1
PRINT 'ERROR'
END CATCH

-- 8 USA UN SELECT PARA COMPROBAR LO ANTERIOR
SELECT * FROM PERSONAJE;

-- 9 CON LA TRANSACCI�N ANTERIOR IMPLEMENTA UN PUNTO DE CONTROL ANTES
-- DE INICIAR LA TRANSACCI�N N�MERO 2
-- Y HAZ QUE ESTE SE EJECUTE USANDO EL ROLLBACK
-- NOTA QUE EL PERSONAJE INSERTADO NO SE BORR� NI ACTUALIZO USANDO UN
-- SELECT
BEGIN TRY
BEGIN TRAN T1
INSERT INTO PERSONAJE VALUES ('Vex', 1)
SELECT * FROM PERSONAJE
SAVE TRAN T1
BEGIN TRAN T2
UPDATE PERSONAJE
SET Tipo = 11
WHERE PerNombre = 'Vex'
SELECT * FROM PERSONAJE
BEGIN TRAN T3
DELETE FROM PERSONAJE WHERE PerNombre = 'Vex'
SELECT * FROM PERSONAJE
COMMIT TRAN T3
COMMIT TRAN T2
COMMIT TRAN T1
END TRY 
BEGIN CATCH
ROLLBACK TRAN T1
PRINT 'ERROR'
END CATCH

SELECT * FROM PERSONAJE;

-- 10 HAZ UN COMMIT PARA EL PUNTO DE CONTROL DONDE INSERTASTE EL
-- PERSONAJE
COMMIT TRAN T1

-- 11 INSERTA UN MUNDO NUEVO Y ELIMINA AL PERSONAJE DE LA TRANSACCI�N
-- ANTERIOR USANDO TRANSACCIONES ANIDADAS
-- Y COMPRUEBA CON UN SELECT LOS CAMBIOS HECHOS
BEGIN TRY 
BEGIN TRAN T1
INSERT INTO MUNDO VALUES ('Valorant', 4)
BEGIN TRAN T2
DELETE FROM PERSONAJE WHERE PerNombre = 'Vex'
COMMIT TRAN T2
COMMIT TRAN T1
END TRY
BEGIN CATCH 
ROLLBACK TRAN 
END CATCH

SELECT * FROM MUNDO;
SELECT * FROM PERSONAJE;

-- 12 INSERTA UN NUEVO JUGADOR PERO SIN AGREGAR EL PERSONAJE QUE
-- ELIGI� DEJALO COMO NULO,
-- Y EN LUGAR DE TERMINAR CON UN COMMIT LA TRANSACCI�N TERMINALO CON
-- UN PUNTO DE CONTROL
-- Y NOMBRARLO COMO CREAS CONVENIENTE
BEGIN TRAN 
INSERT INTO JUGADOR VALUES ('Alan','Covarrubias',NULL)
SAVE TRAN PUNTO1
SELECT * FROM JUGADOR

-- 13 SIN USAR TRANSACCIONES HAZ UNA ACTUALIZACI�N Y ASIGNA UN
-- PERSONAJE AL JUGADOR DE LA TRANSACCI�N ANTERIOR
-- COMPRUEBA CON UN SELECT QUE SE HAYA CAMBIADO
UPDATE JUGADOR
SET Personaje = 9
WHERE JugId = 12;
SELECT * FROM JUGADOR

-- 14 HAZ UN ROLLBACK AL PUNTO DE CONTROL DONDE INSERTASTE EL JUGADOR
-- Y COMPRUEBA QUE PASO CON UN SELECT
ROLLBACK TRAN PUNTO1
SELECT * FROM JUGADOR

-- 15 HAZ UN COMMIT PARA EL PUNTO DE CONTROL DONDE INSERTASTE EL
-- JUGADOR
COMMIT TRAN PUNTO1