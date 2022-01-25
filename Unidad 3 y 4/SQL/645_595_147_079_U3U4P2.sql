--PONER EN USO LA BASE DE DATOS
USE HOGWARTS;

--1. Crea un LOGIN llamado “Harry” con una contraseña de tu preferencia
CREATE LOGIN Harry WITH PASSWORD = '1234';

--2. Crea un USUARIO en la BD HOGWARTS con el nombre “Harry1” para el LOGIN que acabas de crear.
CREATE USER Harry1 FOR LOGIN Harry;

--3. Crea otro LOGIN con nombre “Ron” y contraseña “empleado”
CREATE LOGIN Ron WITH PASSWORD = 'empleado';

--4. Reasigna al USUARIO Harry1 al LOGIN que acabas de crear.
ALTER USER Harry1 WITH LOGIN = Ron;

--5. Crea un nuevo USUARIO en la BD HOGWARTS con nombre “Ron1” para el LOGIN “Harry”
CREATE USER Ron1 FOR LOGIN Harry;

/*
  6. Otorga privilegios de UPDATE, SELECT, INSERT y DELETE al USUARIO “Ron1”
     para las tablas ASIGNATURAS, CASAS, EQUIPO_QUIDDITCH, EST_QUIDDITCH,
     ESTUDIANTES, PROFESORES y TIPO_ASIGNATURAS.
*/
GRANT UPDATE, SELECT, INSERT, DELETE TO Ron1;

/*
  7. Comprueba los privilegios accediendo con el login al que corresponde el usuario
     Harry1. Luego crea un query, conectate a la BD, inserta una asignatura en la tabla
	 ASIGNATURA.
*/
INSERT INTO ASIGNATURAS VALUES
(1, 'Principios magicos 1', 1);

--8. Siguiendo con ese mismo login, elimina la Asignatura con el asignaturaID = 15
DELETE FROM ASIGNATURAS WHERE asignaturaID = 15;

--9. Muestra los nombres de los profesores y las asignaturas que imparten.SELECT P.nombre AS PROFESOR, A.nombre AS ASIGNATURA
FROM ASIGNATURAS A
INNER JOIN PROFESORES P ON (A.profesorID = P.profesorID);

--10. Otorga privilegios de UPDATE y SELECT al USUARIO “Ron1” sólo para la tabla PROFESORES.
GRANT UPDATE, SELECT ON PROFESORES TO Ron1;

/*
11. Comprueba que este usuario no tiene el privilegio de insertar en ESTUDIANTES.
    Para ello, intenta añadir un nuevo estudiante
*/
INSERT INTO ESTUDIANTES VALUES ('Juanito perez', 1, 1, '2000-01-01');

/*
12. Otorga los privilegios necesarios al USUARIO “Ron1” para que con una consulta
    muestres el nombre completo de los nombres de los estudiantes y el nombre de
    su casa.
*/
SELECT E.nombre AS ESTUDIANTE, C.nombre AS CASA
FROM ESTUDIANTES E
INNER JOIN CASAS C ON (E.casaID = C.casaID);

--13. Otorga todos los privilegios sobre la BD completa al USUARIO “Harry1“
GRANT ALL TO Harry1;

/*
14. Deniega todos los privilegios del USUARIO “Ron1” sobre la tabla
    TIPO_ASIGNATURAS. Comprueba que se realizó correctamente probando
    mostrar todos los datos de la tabla mencionada.
*/
DENY ALL ON TIPO_ASIGNATURAS TO Ron1;
SELECT * FROM TIPO_ASIGNATURAS;

--15. Revoca el privilegio UPDATE del usuario “Ron1” en las tablas ASIGNATURAS y ESTUDIANTES
REVOKE UPDATE ON ASIGNATURAS TO Ron1;
REVOKE UPDATE ON ESTUDIANTES TO Ron1;

--16. Elimina el usuario “Ron1”.
DROP USER Ron1;