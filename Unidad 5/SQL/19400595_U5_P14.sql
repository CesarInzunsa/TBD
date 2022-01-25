/*
PRACTICA 14
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
NO. CONTROL: 19400595
FECHA: 02/12/21
DESCRIPCION: CREAR UN TRIGGER QUE CADA QUE SE INSERTE UNA ORDEN CREA UNA COPIA DE
LA ORDEN EN UNA TABLA LLAMADA COPIAS_ORDER PERO DICHA INSERCION LA REALIZARA UN SP
*/

--PONER EN USO LA BD
USE Northwind;

--CREAR EL PROCEDIMIENTO ALMACENADO
CREATE PROC sp_copia_orden
(
@OrderID INT, @CustomerID NCHAR(5), @EmployeeID INT, @ShipVia INT,
@OrderDate DATETIME, @RequiredDate DATETIME, @ShippedDate DATETIME, @ShipAddress NVARCHAR(60)
)
AS
BEGIN
	
	INSERT INTO COPIA_ORDEN VALUES
	(
	@OrderID, @CustomerID, @EmployeeID, @ShipVia, @OrderDate, @RequiredDate, @ShippedDate, @ShipAddress
	)

END

--CREAR EL DISPARADOR SOBRE LA TABLA DE Orders
CREATE TRIGGER tr_orden_copias_order ON Orders FOR INSERT AS
BEGIN
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE TYPE = 'U' AND NAME = 'COPIA_ORDEN')
	CREATE TABLE COPIA_ORDEN(
	OrderID INT,
	CustomerID NCHAR(5),
	EmployeeID INT,
	ShipVia INT,
	OrderDate DATETIME,
	RequiredDate DATETIME,
	ShippedDate DATETIME,
	ShipAddress NVARCHAR(60)
	);
	ELSE

	DECLARE @OrderID INT, @CustomerID NCHAR(5), @EmployeeID INT, @ShipVia INT;
	DECLARE @OrderDate DATETIME, @RequiredDate DATETIME, @ShippedDate DATETIME, @ShipAddress NVARCHAR(60);

	SELECT
	@OrderID = OrderID,
	@CustomerID = CustomerID,
	@EmployeeID = EmployeeID,
	@ShipVia = ShipVia,
	@OrderDate = OrderDate,
	@RequiredDate = RequiredDate,
	@ShippedDate = ShippedDate,
	@ShipAddress = ShipAddress
	FROM inserted;

	EXEC sp_copia_orden
	@OrderID,
	@CustomerID,
	@EmployeeID,
	@ShipVia,
	@OrderDate,
	@RequiredDate,
	@ShippedDate,
	@ShipAddress;

END

--COMPROBAR QUE FUNCIONA
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia , ShipAddress) VALUES
('ANTON', 1, GETDATE(), GETDATE(), GETDATE(), 3, 'Av. Tecnologico');
SELECT * FROM Orders;
SELECT * FROM COPIA_ORDEN;