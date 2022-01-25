--PONER EN USO LA BD
USE Zoologico;

--1.- Crea el diagrama de la base de datos

--2.- Realizar una transacción anidada donde insertes 5 registros en la tabla de tipos de animales
--    (una inserción por nivel).	
BEGIN TRAN T1
	INSERT INTO Animal_tipo VALUES(1, 'Vertebrados');
	BEGIN TRAN T2
		INSERT INTO Animal_tipo VALUES(2, 'Invertebrados');
		BEGIN TRAN T3
			INSERT INTO Animal_tipo VALUES(3, 'Anelidos');
			BEGIN TRAN T4
				INSERT INTO Animal_tipo VALUES(4, 'Moluscos');
				BEGIN TRAN T5
					INSERT INTO Animal_tipo VALUES(5, 'Poriferos');
				COMMIT TRAN T5
			COMMIT TRAN T4
		COMMIT TRAN T3
	COMMIT TRAN T2
COMMIT TRAN T1

--3.- Realizar una transacción anidada donde insertes 5 registros en la tabla de ubicación las ubicaciones
--    deberán ser las siguientes (Aviario,Sección Africana,Granja,Reptilario,Acuario),(una inserción por nivel).	
BEGIN TRAN T1
	INSERT INTO Ubicacion VALUES(1, 'Aviario');
	BEGIN TRAN T2
		INSERT INTO Ubicacion VALUES(2, 'Sección Africana');
		BEGIN TRAN T3
			INSERT INTO Ubicacion VALUES(3, 'Granja');
			BEGIN TRAN T4
				INSERT INTO Ubicacion VALUES(4, 'Reptilario');
				BEGIN TRAN T5
					INSERT INTO Ubicacion VALUES(5, 'Acuario');
				COMMIT TRAN T5
			COMMIT TRAN T4
		COMMIT TRAN T3
	COMMIT TRAN T2
COMMIT TRAN T1

--4.-Realiza una transacción en la cual agreges en la tabla de Tipo_espacio lo siguiente
--   (Para los bebés de la manada,Safari, Restaurante, Ob.servación animal) 
BEGIN TRAN
	INSERT INTO Tipo_Espacios
	VALUES(1,'Para los bebés de la manada'), (2,'Safari'), (3,'Restaurante'), (4,'Observación animal');
COMMIT TRAN

--5.-  Dentro de un bloque try catch realiza una transacción en la cual insertes lo siguiente en la
--     tabla de espacios (Paseo en cebras en la ubicación de  sección africana y esta será del tipo
--     para los bebés de la manada ) deberás de poner un print que diga “ Espacio Agregado satisfactoriamente”
BEGIN TRY
	BEGIN TRAN
	INSERT INTO Espacio VALUES (1,1,2,'Paseo en cebras');
	PRINT 'Espacio Agregado satisfactoriamente'
	COMMIT TRAN
END TRY
BEGIN CATCH 
	ROLLBACK TRAN
	PRINT 'ERROR'
END CATCH

--6.-Realizar una transacción donde insertes 5 registros en la tabla de animales en base a lo insertado
--   en los puntos anteriores.
BEGIN TRY
	BEGIN TRAN 
		INSERT INTO Animal
		VALUES (1,1,200,5,'HIPOPOTAMO',1), (2,2,1,1,'AVISPA',1), (3,3,1,1,'TERMITAS',1), (4,4,250,6,'TIBURON',1),
		       (5,5,150,10,'DELFIN',1);
	COMMIT TRAN
	PRINT 'EXITO'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'ERROR'
END CATCH

--7.-Haz una consulta donde muestres el nombre del animal y el nombre del tipo.
SELECT A.nombre AS NOMBRE , ATP.descripcion AS [NOMBRE DEL TIPO]
FROM Animal A
INNER JOIN Animal_tipo ATP ON (A.tipo = ATP.id_tipo);

--8.- Inserta un animal sin ubicación dentro de un bloque try-catch haciendo uso de commit y rollback,
--    dentro del rollback escribir “Error en la inserción”.
BEGIN TRY
	BEGIN TRAN
		INSERT INTO Animal VALUES(6,2,3,1,'CAMARON',NULL);
	COMMIT TRAN
END TRY
BEGIN CATCH 
	ROLLBACK TRAN
	PRINT 'Error en la inserción'
END CATCH

--9.- Dentro de un bloque Try Catch actualiza la edad de tu animal favorito haciendo uso del Commit y RollBack.
--    en la parte de uso RollBack escribir “Error en la actualización”.
BEGIN TRY
	BEGIN TRAN
		UPDATE Animal SET edad = 3 WHERE id_Animal = 3;
	COMMIT TRAN
END TRY
BEGIN CATCH 	
	ROLLBACK TRAN
	PRINT 'Error en la actualización'
END CATCH

--10.-Realizar una consulta que muestre la cantidad de animales que están en la ubicación 1.
SELECT COUNT(*) AS [CANTIDAD ANIMALES]
FROM Animal A
WHERE A.ubicacion = 1;

--11. Dentro de un bloque de try-catch y haciendo uso de commit y rollback actualizar el nombre de las
--    ubicaciones para que aparezcan en mayúsculas y en otro nivel mostrar el campo de nombre de las
--    ubicaciones para así verificar que hizo de manera correcta este proceso.
BEGIN TRY
	BEGIN TRAN T1
		UPDATE Ubicacion SET descripcion = UPPER(descripcion);
		BEGIN TRAN T2
			SELECT descripcion FROM Ubicacion;
		COMMIT TRAN T2
	COMMIT TRAN T1
END TRY
BEGIN CATCH 
	ROLLBACK TRAN
	PRINT 'ERROR'
END CATCH

--12.- Elabora una transacción en la cual cambies a letras mayúsculas a los animales que se encuentren en la ubicación 1.
BEGIN TRY
	BEGIN TRAN 
		UPDATE Animal SET nombre = UPPER(nombre) WHERE ubicacion = 1;
	COMMIT TRAN 
END TRY
BEGIN CATCH 
	ROLLBACK TRAN
	PRINT 'ERROR'
END CATCH

--13.- Realiza una transacción en un bloque de try catch para la tabla de espacios dentro utilizando el commit
--     y rollback pero sin ponerle el campo de ubicación además deberás de poner un print que diga
--     “No se pudo insertar el espacio”.
BEGIN TRY
	BEGIN TRAN 
		INSERT INTO Espacio VALUES (1, 1, NULL, 'ACUARIO');
	COMMIT TRAN 
END TRY
BEGIN CATCH 
	ROLLBACK TRAN
	PRINT 'No se pudo insertar el espacio'
END CATCH

/*
14.- Dentro de un bloque de try-catch haciendo uso de commit y rollback, hacer una transacción anidada de 4 niveles.
	 Primer nivel: 
	 Inserta a tu mascota en la tabla de animales.
	 segundo nivel
	 Consulta el nombre de tu mascota y cambiale el nombre a Toribio.
	 Tercer nivel
	 Elimina el animal que sea de tu menor agrado
	 Cuarto nivel
	 haz un select de la tabla animales
*/
BEGIN TRY
	BEGIN TRAN T1
		INSERT INTO Animal VALUES(6, 1, 60, 5, 'LOKI', 1);
		BEGIN TRAN T2
			UPDATE Animal SET nombre = 'Toribio' WHERE id_Animal = 6;
			BEGIN TRAN T3
				DELETE FROM Animal WHERE id_Animal = 3;
				BEGIN TRAN T4
					SELECT * FROM Animal;
				COMMIT TRAN T4
			COMMIT TRAN T3
		COMMIT TRAN T2
	COMMIT TRAN T1
END TRY
BEGIN CATCH 
	ROLLBACK TRAN
	PRINT 'ERROR'
END CATCH

--15.- Realiza una transacción donde elimines a todos los animales.
BEGIN TRY
	BEGIN TRAN
		DELETE FROM Animal;
	COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'ERROR'
END CATCH