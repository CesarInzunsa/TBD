/**
PRACTICA 4
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
NO. CONTROL: 19400595
FECHA: 12/10/2021
DESCRIPCION: PRACTICAR EL USO DE INSERCION, ACTUALIZACION Y CONSULTAS CON OPERADORES.
**/

--PONER EN USO LA BASE DE DATOS
USE ELGOURMET;

--4. Insertate a ti como CHEF
INSERT INTO Chef VALUES ('Cesar Inzunsa',NULL);

--5. Inserta al menos 8 categorías de los platillos
INSERT INTO Categoria VALUES
('En frio'),
('Dips'),
('Desayunos'),
('Pastas'),
('Sopas y Cremas'),
('Entradas'),
('Lunch'),
('Platos fuertes');

/*
6. Investiga que CHEFs, participan o han participado en el canal e INSERTALOS en la BD,
pero solo inserta su nombre y los datos obligatorios en caso de que tengan, deben ser al
menos 15.
*/

INSERT INTO Chef VALUES
('Mauro Colagreco',NULL),
('Cristophe Bacquie', NULL),
('Arnaud Donckele',NULL),
('Emmanuel Renaut',NULL),
('Rene Redzepi',NULL),
('Laurent Petit',NULL),
('Dan Barber',NULL),
('Jonnie Boer',NULL),
('Bjorn Frantzen',NULL),
('Arnaud Lallement',NULL),
('Yannick Alleno',NULL),
('Alain Ducasse',NULL),
('Seiji Yamamoto',NULL),
('Pascal Barbot',NULL),
('Alain Passard',NULL);

/*
7. Inserta al menos 10 recetas completas, esto quiere decir que debes insertar en las distintas
tablas que intervienen en las recetas. (Al menos debe tener 4 ingredientes cada una) de
distintas categorías.
*/

INSERT INTO Receta VALUES
('Terrine de frutos rojos', 'Deliciosos postres con el toque de Media Crema NESTLE.',650.00, NULL,2,3),
('Dip de nueces', 'Salsa cremosita elaborada a base de nueces.',100.00, NULL,3,4),
('Atole de arroz con leche', 'ATOLE DE ARROZ CON LECHE preparado con LECHE EVAPORADA CARNATION CLAVEL.',250.00, NULL,4,5),
('Atole de galleta', 'Prepara un atole de galleta con CARNATION CLAVEL.',140.00, NULL,5,8),
('Pan de platano', 'Pan esponjoso elaborado a base de platano, se recomienda acompanar con bebida caliente',450.00, NULL,6,9),
('Espagueti tex-mex', 'Dale un toque diferente a tus pastas con este cremoso ESPAGUETI TEX-MEX preparado con Leche Evaporada CARNATION CLAVEL DESLACTOSADO.',550.00, NULL,7,10),
('Espagueti con jamon', 'SPAGUETI CON JAMON preparado con MEDIA CREMA NESTLE.',850.00, NULL,8,6),
('Crema de lechuga', 'Crema cremosita elaborada a base de lechuga',350.00, NULL,9,7),
('Sopa de champinones', 'Recetas con el toque tradicional Concentrado de Tomate con Pollo CONSOMATE.',200.00, NULL,10,7),
('Sopa de nuez al chipotle', 'Sopa de nuez con un toque de chipotle y Concentrado de Tomate con Pollo CONSOMATE.',550.00, NULL,11,7);

--INSERTAR EN INGREDIENTES
INSERT INTO Ingrediente VALUES
('Frambuesas','Es un eterio formado por varias drupas.'),
('Zarzamora','La mora es una fruta comestible producida por muchas especies del genero Rubus en la familia Rosaceae.'),
('Fresa','Es un genero de plantas rastreras estoloniferas de la familia Rosaceae.'),
('Grenetina hidratada','Tambien conocida como gelatina es una sustancia incolora, transparente y sin sabor.'),
('Nuez','Fruto seco indehiscente, monospermo y con un pericarpio duro.'),
('Media Crema','Es una crema baja en grasa y es ideal para los platillos mexicanos, aderezos y toppings.'),
('Queso crema','Es un tipo de queso untable que se obtiene al cuajar mediante fermentos lacticos una mezcla de leche y nata.'),
('Chile chipotle','Es un chile jalapeno que se ha dejado madurar en seco, para despues ser ahumado y alinado.'),
('Arroz','Se trata de un cereal considerado alimento basico en muchas gastronomias del mundo.​'),
('Leche Evaporada','Es un concentrado de leche que soporta grandes periodos de almacenamiento.'),
('Leche Condensada','Es leche de vaca a la que se le ha extraido agua y agregado azucar.'),
('Canela','Es un condimento aromatico que proviene de la corteza de un arbol llamado canelo.'),
('Agua','Es una sustancia cuya molecula esta compuesta por dos atomos de hidrogeno y uno de oxigeno.'),
('Azucar','Es un endulzante de origen natural.'),
('Galletas Marias','Es un tipo de galleta dulce.'),
('Almendras','Es la semilla comestible del fruto del almendro dulce, de color blanco brillante envuelta con una cubierta marron rojiza.'),
('Huevo','Huevo que ponen las aves, especialmente la gallina, y que se toma como alimento.'),
('vainilla','Es un fruto tropical, procedente en su gran mayoria del Caribe.'),
('Platano maduro','Es una fruta amarilla, de forma alargada.'),
('Harina','Es el polvo fino que se obtiene del cereal molido y de otros alimentos ricos en almidon.​'),
('Mantequilla','Es un producto lacteo elaborado a partir de la leche de vaca.'),
('Ajo','Es una hortaliza que pertenece a la misma familia que las cebollas, las liliaceas.'),
('Apio','Es una especie perteneciente a la familia de las apiaceas, de distribucion cosmopolita.'),
('Elote','Se refiere a la mazorca del maiz, cuyo granos pueden ser consumidos en diferentes maneras.'),
('Mayonesa','Es una salsa emulsionada fria elaborada principalmente a base de huevo entero y aceite vegetal batidos.'),
('Consome de pollo','Es el resultado de la coccion larga de una proteina con agua.'),
('Jamon','Es el nombre generico del producto alimenticio obtenido de las patas traseras del cerdo.'),
('Espagueti','Es un tipo de pasta italiana elaborada con harina de grano duro y agua.'),
('Lechuga','Es una planta herbacea propia de las regiones semitempladas que se cultiva como alimento.'),
('Cebolla','Es una planta herbacea bienal perteneciente a la familia de las amarilidaceas. '),
('Fecula de maiz',' Es un polvo fino blanco, insoluble en agua.'),
('Queso parmesano','Es un famoso queso italiano de consistencia dura, madura y grasa.'),
('Aceite de maiz',' Es un aceite extraido del germen de maiz.'),
('Jitomate','Es una especie de planta herbacea del genero Solanum de la familia Solanaceae'),
('Epazote','Es una planta vivaz aromatica, que se usa como condimento y como planta medicinal en Mexico y muchos otros paises.'),
('Champinon','Es la especie de hongo comestible mas comunmente usada para la cocina.'),
('Concentrado de Tomate','Concentrado de tomate.'),
('Pure de tomate','Es un liquido espeso que se obtiene al cocinar y colar tomates.'),
('Ajo en polvo','Es una especia que se deriva del ajo deshidratado y se usa en la cocina para realzar el sabor.'),
('Sal','Es un tipo de sal denominada cloruro sodico, cuya formula quimica es NaCl.');

--INSERTAR EN DETALLES RECETA
INSERT INTO DETReceta VALUES
(14,7),
(15,7),
(16,7),
(17,7),
(18,8),
(19,8),
(20,8),
(21,8),
(22,9),
(23,9),
(24,9),
(25,9),
(26,10),
(27,10),
(28,10),
(29,10),
(30,11),
(31,11),
(32,11),
(33,11),
(34,12),
(35,12),
(36,12),
(37,12),
(38,13),
(39,13),
(40,13),
(41,13),
(42,14),
(43,14),
(44,14),
(45,14),
(46,15),
(47,15),
(48,15),
(49,15),
(50,16),
(51,16),
(52,16),
(53,16);

/*
8.Actualiza la especialidad de los CHEFS que tenga NULL en la especialidad de acuerdo a
los siguientes CRITERIOS
*/
--A) SI tiene NULL y su nombre empieza con una CONSONANTE le pondrás de
--especialidad PASTELERIA GENERAL
UPDATE Chef
SET ChefEspecialidad='PASTELERIA GENERAL'
WHERE  ChefEspecialidad = NULL AND NOT (ChefNombre LIKE '[AEIOU]%');

--B) Si tiene NULL y su nombre empieza con una VOCAL le pondrás de
--especialidad COCINA MEXICANA
UPDATE Chef
SET ChefEspecialidad='COCINA MEXICANA'
WHERE ChefNombre LIKE '[AEIOU]%' AND ChefEspecialidad=NULL;

/*
9. Muestra las el costo de las recetas por categoría y la cantidad de recetas que hay de cada
categoría en una sola consulta.
*/
SELECT Receta.IDCategoria, SUM(Receta.RecetaCosto) AS 'COSTO', COUNT(Receta.IDReceta) AS 'RECETAS' FROM Receta GROUP BY Receta.IDCategoria;

/*
10. Muestra los chef que su nombre empiecen con una vocal
*/
SELECT ChefNombre FROM Chef WHERE ChefNombre LIKE '[AEIOU]%';

/*
11. Actualiza las recetas cuyo costo sea menor que 250 y auméntales un 50% en el costo y
cambiales el chef y ponte tu como chef de esas recetas.
*/
UPDATE Receta
SET
RecetaCosto += (RecetaCosto/2),
IDChef = 2
WHERE RecetaCosto<250;