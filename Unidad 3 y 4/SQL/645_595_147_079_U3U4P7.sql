--PONER EN USO LA BD
USE Banco;

--1. Generar el diagrama de la base datos

/*
2.  Insertate a ti mismo en tabla de cliente haciendo uso de commit, rollback y un bloque de
	try catch en el cual deberás de poner un mensaje en un print que digan los siguiente
	(“Cliente agregado ”) en la parte del try.
*/
BEGIN TRY
	BEGIN TRAN
		INSERT INTO Cliente VALUES ('CESAR', 'INZUNSA', 'DIAZ', '3112589658', 5);
	COMMIT TRAN
		PRINT 'Cliente agregado'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'NO SE ACEPTAN NULOS'
END CATCH


/*
3.  Realizar 5 inserciones en la tabla de Clientes haciendo uso del commit y el rollBack (No anidadas)
	y asignale una cuenta bancaria a cada cliente creado
*/
BEGIN TRY
	BEGIN TRAN
		INSERT INTO Cliente VALUES ('DENILSON','CASTELLANOS','LOPEZ','3117589368',4);
		INSERT INTO [Cuenta Bancaria] VALUES ('1','PESOS MEXICANOS',2);
	COMMIT TRAN
	PRINT 'Cliente agregado'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'NO SE ACEPTAN NULOS'
END CATCH

BEGIN TRY
	BEGIN TRAN
		INSERT INTO Cliente VALUES ('MARIO','GOMEZ','ENCISO','3111236935',1);
		INSERT INTO [Cuenta Bancaria] VALUES ('2','PESOS MEXICANOS',3);
	COMMIT TRAN
	PRINT 'Cliente agregado'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'NO SE ACEPTAN NULOS'
END CATCH

BEGIN TRY
	BEGIN TRAN
		INSERT INTO Cliente VALUES ('LUIS','PACHECO','OCHOA','3114718596',3);
		INSERT INTO [Cuenta Bancaria] VALUES ('3','PESOS MEXICANOS',4);
	COMMIT TRAN
	PRINT 'Cliente agregado'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'NO SE ACEPTAN NULOS'
END CATCH

BEGIN TRY
	BEGIN TRAN
		INSERT INTO Cliente VALUES ('BRIAN','LICEA','LANGARICA','3115284565',5);
		INSERT INTO [Cuenta Bancaria] VALUES  ('4','PESOS MEXICANOS',5);
	COMMIT TRAN
	PRINT 'Cliente agregado'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'NO SE ACEPTAN NULOS'
END CATCH

BEGIN TRY
	BEGIN TRAN
		INSERT INTO Cliente VALUES ('OSMAR','CHALITA','LUNA','3114711441',1);
		INSERT INTO [Cuenta Bancaria] VALUES ('5','PESOS MEXICANOS',6);
	COMMIT TRAN
	PRINT 'Cliente agregado'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'NO SE ACEPTAN NULOS'
END CATCH

SELECT * FROM Cliente;
SELECT * FROM [Cuenta Bancaria];


/*
4. Inserta un cliente sin ponerle apellido materno usa el commit y rollback para que veas la diferencia
*/
BEGIN TRY
	BEGIN TRAN
		INSERT INTO Cliente VALUES ('GERARDO', 'ENCISO', '3114716985', 5);
	COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN
END CATCH

--5. Realizar 1 inserción (mínimo) por cliente en la tabla de Transacciones haciendo uso del
--   commit y el rollBack
BEGIN TRY
	BEGIN TRAN
		INSERT INTO Transaccion VALUES (1,'1','PAGO DEL TEC',1500)
	COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'ERROR'
END CATCH

--6. Actualiza 1 inserción de clientes con commit y envía el mensaje “datos actualizados”.
BEGIN TRAN
	UPDATE Cliente SET [Nomre(s)] = 'CARLOS' WHERE IDSocio = 1;
COMMIT TRAN;
PRINT 'DATOS ACTUALIZADOS'

--7. Verifica que el punto 6 se hizo correctamente y muestra los campos de la tabla que actualizaste.
SELECT * FROM Cliente WHERE IDSocio = 1;

--8. Realiza una transacción anidada en la cual el primer nivel insertarás una nuevo tipo de cliente,
--   en el segundo nivel insertarás un cliente que sea del tipo previamente creado, en el tercer
--   nivel un update en el cual cambies el tipo del cliente por “platino” y en un cuarto nivel elimina
--   el cliente (Muestra en cada paso el resultado)
BEGIN TRAN T1
	INSERT INTO TipoCliente VALUES ('PLATINO +')
	SELECT * FROM TipoCliente
	BEGIN TRAN T2
		INSERT INTO Cliente VALUES ('MARIO','CASTAÑEDA','RAMIREZ','3112588525',6)
		SELECT * FROM Cliente
		BEGIN TRAN T3
			UPDATE Cliente SET Tipo = 4 WHERE IDSocio = 7
			BEGIN TRAN T4
				DELETE FROM Cliente WHERE IDSocio = 7
				SELECT * FROM Cliente
			COMMIT TRAN T4
 		COMMIT TRAN T3
	COMMIT TRAN T2
COMMIT TRAN T1

--9. Realiza una transacción donde borres el tipo de cliente “Cobre”
BEGIN TRY
BEGIN TRAN
	DELETE FROM [Cuenta Bancaria] WHERE [N° de Cuenta] = 2 OR [N° de Cuenta] = 5;
	DELETE FROM Cliente WHERE TIPO = 1;
	DELETE FROM TipoCliente WHERE idTipo = 1;
COMMIT TRAN
END TRY
BEGIN CATCH
ROLLBACK TRAN
PRINT 'ERROR'
END CATCH

--10. Realiza una transacción anidada para la tabla de clientes donde insertes a dos clientes.
BEGIN TRAN T1
	INSERT INTO Cliente VALUES ('LUIS','C','C','3114714747',5)
	BEGIN TRAN T2
		INSERT INTO Cliente VALUES ('PEDRO','G','G','3111211441',5)
	COMMIT TRAN T2
COMMIT TRAN T1
SELECT * FROM Cliente;

--11. Realiza una transacción anidada en donde modifiques el tipo de cliente a platino
--    de los clientes insertados en el punto anterior.
BEGIN TRAN T1
	UPDATE CLIENTE SET TIPO = 6 WHERE IDSocio = 8
	BEGIN TRAN T2
		UPDATE CLIENTE SET TIPO = 6 WHERE IDSocio = 9
	COMMIT TRAN T2
COMMIT TRAN T1

SELECT * FROM CLIENTE WHERE IDSOCIO = 8 OR IDSOCIO = 9;

--12. Realiza una transacción donde consultes la tabla clientes y elimina a los cliente de tipo “Oro’
BEGIN TRAN
	SELECT * FROM Cliente WHERE TIPO = 2;
	DELETE FROM Cliente WHERE Tipo = 2
COMMIT TRAN
SELECT * FROM Cliente WHERE Tipo = 2;

--13. Crea 10 transacciones iguales con el go para la tabla de transacciones en el cual
--    tendrás que mandar un mensaje que diga “ Operación exitosa”  
BEGIN TRAN
	INSERT INTO TRANSACCION VALUES (1,'1','Deposito',5000);
COMMIT TRAN
	PRINT 'Operación exitosa'
GO 10
SELECT * FROM Transaccion;

--14. Realiza una transacción anidada que contenga tres niveles de anidamiento en el
--    primer nivel deberás de insertar a un cliente tu elige los datos en los siguientes 2
--    deberás generar registros en la tabla de transacciones  (No uses el bloque try catch).
BEGIN TRAN T1
	INSERT INTO Cliente VALUES ('BRIAN', 'GONZALEZ', 'GONZALEZ', '3115829636',4);
	BEGIN TRAN T2
		INSERT INTO TRANSACCION VALUES (1,'4','PAGO SIAPA',80000);
		BEGIN TRAN T3
			INSERT INTO TRANSACCION VALUES (1,'4','DEPOSITO',3000);
		COMMIT TRAN T3
	COMMIT TRAN T2
COMMIT TRAN T1
SELECT * FROM Cliente WHERE IDSocio = 5;
SELECT * FROM Transaccion WHERE Cuenta = 4;

--15 Modifica el inciso anterior para que guarde las transacciones una vez completada la
--   transacción se dejaría incompleto el tercer nivel para que veas los resultados y la diferencia.
BEGIN TRAN T1
	INSERT INTO Cliente VALUES ('BRIAN', 'GONZALEZ', 'GONZALEZ', '3115829636',1);
	SELECT * FROM Cliente WHERE IDSocio = 5;
	BEGIN TRAN T2
		INSERT INTO TRANSACCION VALUES (1,'4','PAGO SIAPA',80000);
		SELECT * FROM Transaccion WHERE Cuenta = 4;
		BEGIN TRAN T3
			INSERT INTO TRANSACCION VALUES (1,'4','DEPOSITO',NULL);
			SELECT * FROM Transaccion WHERE Cuenta = 4;
		COMMIT TRAN T3
		ROLLBACK TRAN T3
	COMMIT TRAN T2
COMMIT TRAN T1