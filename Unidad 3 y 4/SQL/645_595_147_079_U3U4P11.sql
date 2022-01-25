
-- PONER EN USO LA BD 
USE AGENCIA_DE_AUTOS

--LOGIN SA.
/*1.- Crear un diagrama de la base de datos para analizar las tablas, relaciones y
sus campos correspondientes*/
-- YA ESTA HECHO

/*2.- Crear un login que se llame Asesor con la contraseña 'qwerty' */
CREATE LOGIN Asesor WITH PASSWORD = 'qwerty'

/*3.- Crear un usuario correspondiente con el nombre de Andres Garcia*/
CREATE USER [Andres Garcia] FOR LOGIN Asesor

/*4.- Permitir al usuario Andres Garcia poder visualizar los registros de todas
las tablas con el comando GRANT y con SELECT*/
GRANT SELECT ON Agencia TO [Andres Garcia]
GRANT SELECT ON Ciudades TO [Andres Garcia]
GRANT SELECT ON Cliente TO [Andres Garcia]
GRANT SELECT ON Coche TO [Andres Garcia]
GRANT SELECT ON Compra TO [Andres Garcia]
GRANT SELECT ON Empresa TO [Andres Garcia]

--LOGIN Asesor.
/*5.-Ver el contenido de cada una de las tablas.*/
SELECT * FROM Agencia
SELECT * FROM Ciudades
SELECT * FROM Cliente
SELECT * FROM Coche
SELECT * FROM Compra
SELECT * FROM Empresa

/*6. Intentar insertar un coche en la tabla de coches.
con los siguientes valores: 'UVP-00-06',1999,'Mazda', 'Plata', 1 */
INSERT INTO Coche VALUES ('UVP-00-06',1999,'Mazda','Plata',1)

/*7.- *Intentar eliminar la ciudad con el id número 1, marcara error ya que no
contamos
con ese permiso.*/
DELETE FROM Ciudades WHERE idCiudad = 1

--LOGIN SA.
/*8.- Conceder el permiso de eliminar al usuario Andres Garcia para que pueda
efectuar la
instrucción del punto anterior.*/
GRANT DELETE ON Ciudades TO [Andres Garcia]

--LOGIN Asesor.
/*9.- Verificar si el permiso fue otorgado de forma exitosa.
tratando de ejecutar el punto 7 nuevamente*/
DELETE FROM Ciudades WHERE idCiudad = 1

--LOGIN SA - LOGIN Asesor.
/*10.- Revocar los permisos otorgados al usuario Andres Garcia y comprobar
que ya no cuente con ellos, con las instrucciones escritas en el punto 6 y en el
punto 7*/
REVOKE DELETE ON Ciudades TO [Andres Garcia]
REVOKE INSERT ON Coche TO [Andres Garcia]

INSERT INTO Coche VALUES ('UVP-00-06',1999,'Mazda','Plata',1)

DELETE FROM Ciudades WHERE idCiudad = 1

/*11.- Eliminar usuario Andrés Garcia y verificar su correcta eliminación.*/
DROP USER [Andres Garcia]

/*12.- Crear un nuevo Login llamado Administrador con la contraseña 'admon'.*/
CREATE LOGIN Administrador WITH PASSWORD = 'admon'

/*13.- Crear un usuario llamado Adalberto para el login del paso anterior.*/
CREATE USER Adalberto FOR LOGIN Administrador

/*14.- Otorgar todos los permisos a todas las tablas al usuario Adalberto. */
GRANT ALL ON Agencia TO Adalberto
GRANT ALL ON Ciudades TO Adalberto
GRANT ALL ON Cliente TO Adalberto
GRANT ALL ON Coche TO Adalberto
GRANT ALL ON Compra TO Adalberto
GRANT ALL ON Empresa TO Adalberto

--LOGIN Administrador.
/*15.- Comprobar que se pueda hacer SELECT en todas las tablas.*/
SELECT * FROM Agencia
SELECT * FROM Ciudades
SELECT * FROM Cliente
SELECT * FROM Coche
SELECT * FROM Compra
SELECT * FROM Empresa

--LOGIN SA.
/*16.- Denegar los permisos de INSERT y DELETE en la tabla Cliente */
DENY INSERT ON Cliente TO Adalberto
DENY DELETE ON Cliente TO Adalberto

--LOGIN Administrador.
/*17.- Comprobar que aplicaron los cambios de revocación de insert y delete.
Insertando el cliente 'FANJ900920HNTNLMO2', 'JUAN', 'FALSO', 'NOMBRE',
'CHORRITO 10 COL CHORROTE', '63000', 1, '3221224141'
Y tratando de borraR al cliente del renglon 5*/
INSERT INTO Cliente VALUES ('FANJ900920HNTNLMO2','JUAN','FALSO','NOMBRE','CHORRITO 10 COL CHORROTE','63000',1,'3221224141')

DELETE FROM Cliente WHERE CURP = 'TOCA770826MCXRSL96'

--LOGIN SA.
/*18. Eliminar el usuario Adalberto y comprobar que se haya eliminado
correctamente.*/
DROP USER Adalberto

/*19.- Eliminar los logins y verificar la acción.*/
DROP LOGIN Asesor
DROP LOGIN Administrador