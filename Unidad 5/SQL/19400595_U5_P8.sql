/*
PRACTICA 8
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
NO. CONTROL: 19400595
FECHA: 07/12/21
DESCRIPCION: REALIZA UN SP QUE INSERTE UNA ORDEN Y TRES DETALLES DE LA ORDEN, USE TRANSACCIONES, 
			 PARA LA ORDEN RECIBIRÁ LOS DATOS BÁSICOS Y FK,  PARA EL DETALLE DE ORDEN SOLO ID PRODUCTO,
			 CANTIDAD DE PRODUCTOS Y DESCUENTO, EL PRECIO LO TENDRÁ QUE SACAR DEL CATÁLOGO DEL PRODUCTOS.
			 NOTA: ESTE SP SÓLO SIRVE PARA INSERTAR ÓRDENES CON 3 DETALLES.
*/

--PONER EN USO LA BD
USE Northwind;

--CREAR EL PROCEDIMIENTO ALMACENADO
ALTER PROC sp_insertar_ordenes_detalleOrden
(@customerId NCHAR(5), @employeeId INT, @orderDate DATETIME, @requiredDate DATETIME, @shippedDate DATETIME, @shipVia INT,
 @idProducto INT, @quantity SMALLINT, @discount REAL) AS
BEGIN
	DECLARE @unitPrice MONEY, @orderId INT;;
	SELECT @unitPrice = UnitPrice FROM Products WHERE ProductID = @idProducto;
	SET @unitPrice = (@unitPrice - (@unitPrice * @discount));

	BEGIN TRY
		BEGIN TRAN
			INSERT INTO Orders
			(CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia)VALUES
			(@customerId, @employeeId, @orderDate, @requiredDate, @shippedDate, @shipVia);

			SET @orderId = (SELECT TOP(1) OrderID FROM Orders ORDER BY OrderID DESC);

			INSERT INTO [Order Details] VALUES (@orderId, @idProducto, @unitPrice, @quantity, @discount)
			
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		PRINT 'ERROR'
	END CATCH

END

--COMPROBAR QUE FUNCIONA
EXEC sp_insertar_ordenes_detalleOrden 'BOTTM', 1, '2021-12-10', '2022-01-11', '2021-12-21', 1, 4, 3, 0.5;
SELECT * FROM Orders ORDER BY OrderID DESC;
SELECT * FROM [Order Details] ORDER BY OrderID DESC;