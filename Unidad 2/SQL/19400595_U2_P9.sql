/**
PRACTICA 9
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
NO. CONTROL: 19400595
FECHA: 25/10/2021
DESCRIPCION: REFORZAR EL USO DE LA FUNCIÓN MAX(), INSERT INTO, FUNCIÓN AVG(), UPDATE, INNER JOIN, Y SUBCONSULTAS
**/

--PONER EN USO LA BD
USE Northwind;

/*
1.- Muestra el no. De orden, la fecha de orden, y el precio del producto del producto más 
    caro que se vendió en esa orden .
*/
SELECT O.OrderID AS [NO. DE ORDEN], O.OrderDate AS [FECHA DE ORDEN], (SELECT MAX(OD.UnitPrice)
FROM [Order Details] OD WHERE OD.OrderID = O.OrderID) AS [PRECIO DEL PRODUCTO MAS CARO]
FROM Orders O;

--2.- Consulta todos los nombres de los empleados que no hayan vendido ninguna orden.
SELECT P.FirstName AS NOMBRE
FROM Employees P
WHERE P.EmployeeID NOT IN (SELECT EmployeeID FROM Orders);

/*
3.- Crea un vista con los siguientes datos (con subcosultas)
    Id. Empleado, Nombre del Empleado, Total de Ordenes Vendidas por el empleado
*/
CREATE VIEW V_Ordenes_Empleados AS(
SELECT P.EmployeeID, P.FirstName,
(SELECT COUNT (*) FROM Orders O WHERE P.EmployeeID = O.EmployeeID) AS [NO. ORDENES VENDIDAS]
FROM Employees P);

--4.- Crea un vista en donde contenga el no. De orden y el total que se cobró por esa orden.
CREATE VIEW V_ORDENES_PRECIO_TOTAL AS (
SELECT O.OrderID, SUM(OD.UnitPrice) AS [PRECIO TOTAL]
FROM Orders O
INNER JOIN [Order Details] OD ON (O.OrderID = OD.OrderID)
GROUP BY O.OrderID);

--5.- Muestra los 3 empleados más jóvenes que tenemos
SELECT TOP(3) E.FirstName, E.BirthDate
FROM Employees E
ORDER BY E.BirthDate DESC

--6.- Muestra los 5 empleados más viejos que tenemos
SELECT TOP(5) E.FirstName, E.BirthDate
FROM Employees E
ORDER BY E.BirthDate ASC

/*
7.- Crea una vista con la siguiente información:
    No. De Orden, Fecha orden, Cantidad de productos, vendidos en esa orden,Total 
    Cobrado por la orden, Total de descuento por la orden
*/
CREATE VIEW V_ORDENES_PRODUCTOS AS (
SELECT O.OrderID, O.OrderDate, SUM(OD.Quantity) AS [NO. PRODUCTOS], SUM (OD.UnitPrice) AS [PRECIO TOTAL],
SUM(OD.Discount) AS [DESCUENTO TOTAL]
FROM Orders O
INNER JOIN [Order Details] OD ON (O.OrderID = OD.OrderID)
GROUP BY O.OrderID, O.OrderDate);

/*
8.- Hemos decidido liquidar a todo los vendedores que no han vendido nada. Por lo tanto
    borra a todos los empleados que no hayan vendido ninguna orden
*/
DELETE FROM Employees
WHERE EmployeeID IN (SELECT V.EmployeeID FROM V_Ordenes_Empleados V WHERE V.[NO. ORDENES VENDIDAS] = 0)

/*
9.- Muestra las órdenes que hayan vendido el producto más caro que tenemos en nuestro
    inventario actualmente.
*/
SELECT OD.OrderID
FROM [Order Details] OD
WHERE OD.ProductID IN (SELECT TOP(1) ProductID FROM Products WHERE UnitsInStock>0 ORDER BY UnitPrice DESC)
ORDER BY OD.OrderID ASC

/*
10.- Inserta 5 empleados que sean tú y 4 compañeros solo agregarle los datos más 
     importantes no llenes el registro completo
*/
INSERT INTO Employees (LastName, FirstName, Title, BirthDate, HireDate) VALUES
('Inzunsa','Cesar','Sales Representative', '2000-11-03','2003-01-01'),
('Licea','Brian','Sales Representative', '2000-05-04','2003-01-01'),
('Hernandez','Isaac','Sales Representative', '2000-06-05','2003-01-01'),
('Robles','Ivan','Sales Representative', '2000-07-06','2003-01-01'),
('Guerra','Osmar','Sales Representative', '2000-08-07','2003-01-01');


/*
11.- Actualiza el Titulo (Title) de los empleados que hayan vendido más ordenes que el
     promedio (utiliza la vista anteriormente creada y subcosultas) asciéndelos a Gerente de
     Ventas (“Sales Manager”)
*/
UPDATE Employees
SET Title = 'Sales Manager'
WHERE EmployeeID IN
(SELECT v.EmployeeID FROM v_Ordenes_Empleados V WHERE v.[NO. ORDENES VENDIDAS] >
(SELECT AVG(VE.[NO. ORDENES VENDIDAS]) AS [PROM. ORDENES VENDIDAS] FROM V_Ordenes_Empleados VE));

/*
12.- Inserta al menos dos órdenes completas que vendieron los empleados que acabas de
     agregar (cada orden debió vender al menos 3 productos)
*/
INSERT INTO Orders VALUES
('ALFKI',23,'2020-05-01','2020-06-01','2020-05-21',1,30.36,'ENVIO RAPIDO','328 Ward Meadow','Rockford','US','70355','USA'),
('ANATR',23,'2020-05-01','2020-06-02','2020-05-21',2,41.36,'HERMES','6585 Christiansen Island','Lincoln','JP','32579','Japan'),

('ANTON',24,'2020-05-02','2020-06-03','2020-05-22',3,63.05,'TRUENO','2290 Jones Glen','Lafayette','CO','93418','Colombia'),
('AROUT',24,'2020-05-03','2020-06-04','2020-05-23',1,55.26,'ECONOMICAS','536 Jessica Dale','Burlington','NE','78478','Niue'),

('BERGS',25,'2020-05-03','2020-06-04','2020-05-23',2,80.12,'VELOZ','4380 Sonya Tunnel','Minot','GL','77416','Guadeloupe'),
('BLAUS',25,'2020-05-04','2020-06-05','2020-05-24',3,35.69,'PA MAÑANA','1277 Goodwin Crossing','Covington','OD','25644','Argentina'),

('BLONP',26,'2020-05-04','2020-06-05','2020-05-24',1,22.59,'EXPRES','8664 Hettinger Spur','Washington','CP','65149','Cyprus'),
('BOLID',26,'2020-05-05','2020-06-06','2020-05-25',2,44.59,'FASTWAY','89966 Williamson Parkways','Sioux Falls','LB','99017','Luxembourg'),

('BONAP',27,'2020-05-06','2020-06-07','2020-05-26',3,43.59,'NAVISTAR','32239 Josefina Roads','Lakewood','GB','66728','Guinea-Bissau'),
('BOTTM',27,'2020-05-07','2020-06-08','2020-05-27',1,63.59,'MULTITRANS','86274 Letha Underpass','Bozeman','BM','17327','Bermuda');

INSERT INTO [Order Details] VALUES
(11080,1,14.40,10,0.2),
(11080,2,19.00,22,0),
(11080,3,10.00,22,0),
(11081,4,18.07,14,0.15),
(11081,5,21.35,8,0),
(11081,6,12.50,6,0.5),
(11082,7,30.00,14,0),
(11082,8,12.00,7,0.7),
(11082,9,72.75,13,0.25),
(11083,10,31.00,10,0),
(11083,11,10.05,5,0.5),
(11083,12,34.20,50,0.1),
(11084,13,6.00,1,0),
(11084,14,20.95,16,0.1),
(11084,15,10.85,1,0.3),
(11085,16,15.71,4,0.1),
(11085,17,19.50,20,0.5),
(11085,18,37.50,32,0.4),
(11086,19,9.20,1,0),
(11086,20,32.40,44,0.6),
(11086,21,10.00,01,0),
(11087,22,14.70,30,0.3),
(11087,23,9.00,1,0),
(11087,24,4.50,1,0),
(11088,25,11.20,21,0.2),
(11088,26,18.74,15,0.4),
(11088,27,21.95,33,0.5),
(11089,28,13.68,45,0.7),
(11089,29,12.38,300,0.9),
(11089,30,23.30,04,0.1);