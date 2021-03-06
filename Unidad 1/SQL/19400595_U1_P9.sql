/*
PRACTICA 9
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
NO. CONTROL: 19400595
FECHA: 30/09/2021
DESCRIPCION: CREAR UNA BD DE UNA PIZZERIA PARA LLEVAR EL CONTROL Y REGISTRO DE LAS VENTAS.
*/

CREATE DATABASE BD_DON_ITALIANIS
ON PRIMARY
(
NAME = 'BD_DON_ITALIANIS.MDF',
FILENAME = 'C:\TBD2021\U1\BD_DON_ITALIANIS.MDF'
)
LOG ON
(
NAME = 'BD_DON_ITALIANIS.LDF',
FILENAME = 'C:\TBD2021\U1\BD_DON_ITALIANIS.LDF'
);

--PONER EN USO LA BD
USE BD_DON_ITALIANIS;

--CREAR TABLA DE COLONIAS
CREATE TABLE COLONIAS(
idColonia INT NOT NULL,
nombreColonia VARCHAR(50),
CONSTRAINT PK_COLONIAS PRIMARY KEY(idColonia)
);

--CREAR TABLA DE PRODUCTOS
CREATE TABLE PRODUCTOS(
idProducto INT NOT NULL,
nombreProducto VARCHAR(50) CONSTRAINT DF_NOMBRE_PRODUCTO DEFAULT('Producto sin nombre'),
descripcionProducto VARCHAR(300),
precioProducto MONEY CONSTRAINT CK_PRECIO_PRODUCTO CHECK(precioProducto > 0),
CONSTRAINT PK_PRODUCTOS PRIMARY KEY(idProducto),
);

--CREAR TABLA DE PROMOCIONES
CREATE TABLE PROMOCIONES(
idPromocion INT NOT NULL,
descripcionPromocion VARCHAR(100),
descuentoPromocion MONEY CONSTRAINT DF_DESCUENTO_PROMOCION DEFAULT(0.1),
CONSTRAINT PK_PROMOCIONES PRIMARY KEY(idPromocion),
CONSTRAINT CK_DESCUENTO_PROMOCION CHECK(descuentoPromocion >= 0)
);

--CREAR TABLA DE DOMICILIO_ENVIO
CREATE TABLE DOMICILIO_ENVIO(
idDomicilioEnvio INT NOT NULL,
nombreCalle VARCHAR(200),
numeroCalle INT,
idColonia INT NOT NULL,
CONSTRAINT PK_DOMICILIO_ENVIO PRIMARY KEY(idDomicilioEnvio),
CONSTRAINT FK_DOMICILIO_ENVIO_COLONIAS FOREIGN KEY(idColonia) REFERENCES COLONIAS(idColonia)
);

--CREAR TABLA DE CLIENTES
CREATE TABLE CLIENTES(
noTelefonicoCliente VARCHAR(10) NOT NULL,
nombreCliente VARCHAR(50),
apellidoCliente VARCHAR(50),
edadCliente INT,
idDomicilioEnvio INT NOT NULL,
CONSTRAINT PK_CLIENTES PRIMARY KEY(noTelefonicoCliente),
CONSTRAINT FK_CLIENTES_DOMICILIO FOREIGN KEY(idDomicilioEnvio) REFERENCES DOMICILIO_ENVIO(idDomicilioEnvio),
CONSTRAINT CK_EDAD_CLIENTE CHECK(edadCliente >= 18)
);

--CREAR TABLA DE PEDIDO
CREATE TABLE PEDIDOS(
idPedido INT NOT NULL,
idCliente VARCHAR(10) NOT NULL,
idProducto INT NOT NULL,
idPromocion INT NOT NULL,
fechaPedido DATETIME CONSTRAINT FK_PEDIDOS_FECHA DEFAULT (GETDATE()),
idDomicilioEnvio INT,
CONSTRAINT PK_PEDIDOS PRIMARY KEY(idPedido),
CONSTRAINT FK_PEDIDOS_CLIENTES FOREIGN KEY(idCliente) REFERENCES CLIENTES(noTelefonicoCliente),
CONSTRAINT FK_PEDIDOS_PRODUCTOS FOREIGN KEY(idProducto) REFERENCES PRODUCTOS(idProducto),
CONSTRAINT FK_PEDIDOS_PROMOCIONES FOREIGN KEY(idPromocion) REFERENCES PROMOCIONES(idPromocion),
CONSTRAINT FK_PEDIDOS_DOMICILIO FOREIGN KEY(idDomicilioEnvio) REFERENCES DOMICILIO_ENVIO(idDomicilioEnvio),
);