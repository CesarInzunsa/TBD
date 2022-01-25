--PONER EN USO LA BD
USE PROYECTO_MUNICIPIO;

--1. Genera el diagrama de la base de datos.

--2. Realiza una transacción en la cual insertes 5 registros en la tabla de estados(Incluye tu estado).
BEGIN TRAN
	INSERT INTO Estado VALUES(5,'NAYARIT'),(6,'NUEVO LEON'),(7,'MICHOACAN'),(8,'GUERRERO'),(9,'DURANGO');
COMMIT TRAN

--3. Realiza una transacción en la cual insertes 1 registro en la tabla de municipio por cada estado
--    que insertaste (Incluye tu municipio).
BEGIN TRAN
	INSERT INTO Municipio VALUES(5,'TEPIC',5),(6,'MONTERREY',6),
	(7,'MORELIA',7),(8,'ACAPULCO',8),(9,'VICTORIA DE DURANGO',9);
COMMIT TRAN

--4. Realiza una transacción en la cual insertes en la  tabla Proyecto, un proyecto que sea de tu
--   conocimiento en tu municipio.
BEGIN TRAN
	INSERT INTO Proyecto VALUES('LIMPIEZA DEL RIO MOLOLOA',1000000000,'LIMPIEZA PROFUNDA DE TODO EL RIO MOLOLOA');
COMMIT TRAN

--5. Relaciona el proyecto que insertaste con tu municipio por medio de la tabla de
--   Proyecto-Municipio usando commit y rollback, dentro del bloque del try insertar el mensaje
--   “Proyecto en proceso”.
BEGIN TRY
	BEGIN TRAN
		INSERT INTO Proyecto_Municipio VALUES(6,5)
	COMMIT TRAN
	PRINT 'Proyecto en proceso'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
END CATCH

--6. Haz una consulta donde muestres los nombres de los proyectos y su monto (SOLO COMMIT).
BEGIN TRAN
	SELECT Nombre, Monto FROM Proyecto;
COMMIT TRAN

--7. Elabora una transacción en la cual cambies las letras a MAYÚSCULAS mientras el nombre de los
--   estados que insertaste empiece por una consonante.
BEGIN TRY
BEGIN TRAN
	UPDATE Estado SET Nombre = UPPER(Nombre) WHERE Nombre NOT LIKE '[AEIOU]%';
COMMIT TRAN
PRINT 'EXITO'
END TRY
BEGIN CATCH
ROLLBACK TRAN
PRINT 'ERROR'
END CATCH

--8. Actualiza el monto del proyecto #1 por un monto de tu  elección haciendo uso de commit y roll back.
BEGIN TRY
	BEGIN TRAN
		UPDATE Proyecto SET Monto = 5000000 WHERE ID_Proyecto = 1;
	COMMIT TRAN
	PRINT 'EXITO'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'ERROR'
END CATCH

--9. Inserta en la tabla de proyecto, un proyecto sin monto, haciendo uso de commit y rollback,
--   dentro del bloque del catch mandar el mensaje “Inserción no permitida”.
BEGIN TRY
	BEGIN TRAN
		INSERT INTO Proyecto VALUES ('CONSTRUCCION',NULL,'CONSTRUCCION DE UN MERCADO');
	COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'Inserción no permitida'
END CATCH

--10. Realiza una transacción anidada en la cual insertes a el estado(que no esté registrado)
--    en el primer nivel, en el segundo inserta a un municipio del estado que acabas de insertar y 
--    en el último nivel deberás de insertar un proyecto para este municipio guarda cada transacción
--    cuando se realice.(no usar try catch).
BEGIN TRAN T1
	INSERT INTO Estado VALUES (10,'PUEBLA')
	SAVE TRAN T1
	BEGIN TRAN T2 
		INSERT INTO Municipio VALUES (10,'PUEBLA DE ZARAGOZA',10)
		SAVE TRAN T2
        BEGIN TRAN T3
			INSERT INTO Proyecto VALUES ('SISTEMA DE PARQUIMETROS',977777777,'IMPLEMENTAR UNA POLITICA DE PARQUIMETROS')
		    SAVE TRAN T3
		COMMIT TRAN T3 
	COMMIT TRAN T2 
COMMIT TRAN T1 

--11. Realiza una transacción errónea en la cual deberás de insertar un proyecto sin descripción
--    para que uses el rollback y después con un select verifica que no se insertará el registro.
BEGIN TRY
	BEGIN TRAN
		INSERT INTO Proyecto VALUES ('MUSEO',10000000,null)
    COMMIT TRAN
	PRINT 'EXITO'
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'ERROR'
END CATCH

--12. Realiza una transacción en la cual por medio de un bulk insert insertes todos los municipios
--    de nayarit (Solo utiliza el commit).
BEGIN TRAN
	BULK INSERT MUNICIPIO FROM 'C:\TBD2021\U3 y U4\QUERY\MUNICIPIOS_NAYARIT.CSV' WITH (FIELDTERMINATOR = ',');
COMMIT TRAN

--13. Por medio de una transacción anidada de dos niveles  asignale dos proyectos al municipios
--    de santa maria del oro (un proyecto por nivel) deberás ponerle un print que diga
--    “Proyecto agregado correctamente”(usa commit y rollback como también un bloque de try cath).
BEGIN TRY
	BEGIN TRAN T1
	INSERT INTO Proyecto_Municipio VALUES (5,24)
		BEGIN TRAN T2 
			INSERT INTO Proyecto_Municipio VALUES (4,24)
		COMMIT TRAN T2 
		PRINT 'Proyecto agregado correctamente'
	COMMIT TRAN T1 
	PRINT 'Proyecto agregado correctamente'
END TRY
BEGIN CATCH
	ROLLBACK
	PRINT 'ERROR'
END CATCH

--14. Actualiza los montos de los proyectos del punto anterior por el monto de 350000.
BEGIN TRAN
	UPDATE Proyecto SET Monto=35000000 WHERE ID_Proyecto IN (4,5);
COMMIT TRAN

--15. Elimina el proyecto que tú creaste por medio de un commit
BEGIN TRAN
	DELETE FROM Proyecto_Municipio WHERE ID_Proyecto IN (6,8);
	DELETE FROM Proyecto WHERE ID_Proyecto IN (6,8);
COMMIT TRAN