/**
PRACTICA 6
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
NO. CONTROL: 19400595
FECHA: 20/09/2021
DESCRIPCION: Participara en la clase en el diseño e implementacion de la BD de SUPERHEROES
**/

--CREAR BASE DE DATOS
CREATE DATABASE SUPERHEROES
ON PRIMARY
(
NAME = 'SUPERHEROES.MDF',
FILENAME = 'C:\TBD2021\U1/SUPERHEROES.MDF'
)
LOG ON
(
NAME = 'SUPERHEROES.LDF',
FILENAME = 'C:\TBD2021\U1/SUPERHEROES.LDF'
);

--PONER EN USO LA BASE DE DATOS
USE SUPERHEROES;

--CREAR TABLA DE HEROES
CREATE TABLE HEROES
(
her_id INT IDENTITY(1,1) PRIMARY KEY,
her_name VARCHAR(100),
her_alias VARCHAR(30),
lug_id SMALLINT,
her_edad SMALLINT,
her_descripcion VARCHAR(MAX)
);

--CREAR TABLADE VILLANOS
CREATE TABLE VILLANOS
(
vil_id INT IDENTITY(1,1) PRIMARY KEY,
vil_name VARCHAR(100),
vil_alias VARCHAR(30),
vil_ubicacion VARCHAR(30) DEFAULT 'desconocida',
tra_id TINYINT
);

--CREAR TABLA DE TRAJES
CREATE TABLE TRAJES
(
tra_id TINYINT IDENTITY(1,1) PRIMARY KEY,
tra_material VARCHAR(15),
tra_color VARCHAR(15),
tra_nivel TINYINT CHECK (tra_nivel BETWEEN 1 AND 5),
tra_foto VARCHAR(200)
);

--CREAR TABLA DE LUGARES
CREATE TABLE LUGARES
(
lug_id SMALLINT IDENTITY(10,10) CONSTRAINT PK_LUGAR PRIMARY KEY,
lug_nombre VARCHAR(100)
);

--CREAR TABLA DE PODER
CREATE TABLE PODER
(
pod_id SMALLINT PRIMARY KEY,
pod_poder VARCHAR(20),
pod_descripcion VARCHAR(100)
);

--CREAR TABLA DE DETALLE DE PODER DE HEROE
CREATE TABLE DETALLE_PODER_HEROE
(
her_id INT NOT NULL,
pod_id SMALLINT NOT NULL,
	PRIMARY KEY (her_id, pod_id)
);

--CREAR TABLA DE DETALLE DE PODER PERO AHORA DE VILLANO
CREATE TABLE DETALLE_PODER_VILLANO
(
vil_id INT NOT NULL,
pod_id SMALLINT NOT NULL,
	PRIMARY KEY (vil_id, pod_id)
);

/*
*CREAR UNA DE DETALLE PODER PERO PARA VILLANOS [listo]
*tambien crear las llaves foraneas
	- heroes a lugares [LISTO]
	- detalle poder heroe a heroes [LISTO]
	- detalle poder heroe a poder [LISTO]
	- detalle poder villano a villano [LISTO]
	- detalle poder villano a poder [LISTO]
	- heroes a traje [LISTO]
	- villano a traje [LISTO]
*CREAR CHECK PARA EL CAMPO UNIVERSO DE HEROE

*CREAR DIAGRAMA PERSONALIZADO CON EL IDENTITY1
*/

--ALTERAR TABLA HEROES Y AÑADIR ID DE TRAJE
ALTER TABLE HEROES
ADD tra_id TINYINT;

--ALTERAR TABLA VILLAOS Y AÑADIR EDAD DEL VILLANO
ALTER TABLE VILLANOS
ADD vil_edad SMALLINT;

--ALTERAR TABLA HEROES Y AÑADIR SU UNIVERSO
ALTER TABLE HEROES
ADD her_universo VARCHAR(6);

-- CREAR LLAVES FORANEAS

--CREAR LLAVE FORANEA DE HEROES CON LUGAR
ALTER TABLE HEROES
ADD CONSTRAINT FK_HEROE_LUGAR
FOREIGN KEY (lug_id)
REFERENCES LUGARES (lug_id);

--CREAR LLAVE FORANEA DE DETALLE PODER CON HEROE
ALTER TABLE DETALLE_PODER_HEROE
ADD CONSTRAINT FK_DETALLE_HEROE_HEROES
FOREIGN KEY (her_id)
REFERENCES HEROES (her_id);

--CREAR LLAVE FORANEA DE DETALLE PODER CON PODER
ALTER TABLE DETALLE_PODER_HEROE
ADD CONSTRAINT FK_DETALLE_HEROE_PODER
FOREIGN KEY (pod_id)
REFERENCES PODER (pod_id);

--CREAR LLAVE FORANEA DE DETALLE PODER CON VILLANOS
ALTER TABLE DETALLE_PODER_VILLANO
ADD CONSTRAINT FK_DETALLE_VILLANO_VILLANOS
FOREIGN KEY (vil_id)
REFERENCES VILLANOS (vil_id);

--CREAR LLAVE FORANEA DE DETALLE PODER CON PODER
ALTER TABLE DETALLE_PODER_VILLANO
ADD CONSTRAINT FK_DETALLE_VILLANO_PODER
FOREIGN KEY (pod_id)
REFERENCES PODER (pod_id);

--CREAR LLAVE FORANEA DE HEROES CON TRAJE
ALTER TABLE HEROES
ADD CONSTRAINT FK_HEROES_TRAJE
FOREIGN KEY (tra_id)
REFERENCES TRAJES (tra_id);

--CREAR LLAVE FORANEA DE VILLANOS CON TRAJE
ALTER TABLE VILLANOS
ADD CONSTRAINT FK_VILLANOS_TRAJE
FOREIGN KEY (tra_id)
REFERENCES TRAJES (tra_id);

--CREAR LLAVE FORANEA DE HEROES CON EDAD
ALTER TABLE HEROES
ADD CONSTRAINT CK_HEROES_EDAD
CHECK (her_edad > 18);

--CREAR TABLA DE HEROES VS VILLANOS
CREATE TABLE HEROES_VS_VILLANOS
(
her_id INT NOT NULL,
vil_id INT NOT NULL,
PRIMARY KEY (her_id, vil_id),
CONSTRAINT FK_HEROES_VS_VILLANOS_HERID FOREIGN KEY(her_id) REFERENCES HEROES (her_id),
CONSTRAINT FK_HEROES_VS_VILLANOS_VILID FOREIGN KEY(vil_id) REFERENCES VILLANOS (vil_id)
);

ALTER TABLE HEROES
ADD CONSTRAINT CK_HEROES_UNIVERSO
CHECK (her_universo = 'MARVEL' OR her_universo = 'DC');