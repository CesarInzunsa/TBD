/*
PRACTICA 4
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
NO. CONTROL: 19400595
FECHA: 24/11/21
DESCRIPCION: CREAR UN PROCEDIMIENTO ALMACENADO QUE MUESTRE LA LISTA DE LIBROS DE UN AUTOR ESPECIFICO
*/

--PONER EN USO LA BD
USE pubs;

--CREAR PROCEDIMIENTO ALMACENADO
CREATE PROC sp_info_autor ( @apellido varchar(40), @nombre varchar(20) ) AS
BEGIN
	-- LISTA DE  LIBROS DEL AUTOR
    SELECT au_lname, au_fname, title
	FROM  titleauthor ta
    INNER JOIN authors a ON (a.au_id = ta.au_id)
    INNER JOIN  titles t ON (t.title_id = ta.title_id)
	WHERE au_fname =  @nombre AND au_lname = @apellido
RETURN
END

--EJECUTAR EL PROCEDIMIENTO ALMACENADO POR POSICION
EXEC sp_info_autor 'Locksley', 'Charlene';
EXEC sp_info_autor 'White', 'Johnson';
EXEC sp_info_autor 'Cesar', 'Inzunsa';

--EJECUTAR EL PROCEDIMIENTO ALMACENADO POR NOMBRE, FORMA CORRECTA DE EJECUTAR UN PROCEDIMIENTO ALMACENADO;
EXEC sp_info_autor @apellido = 'White', @nombre = 'Johnson';

--MODIFICAR EL PROCEDIMIENTO ALMACENADO Y AGREGARLE UN DEFAULT
ALTER PROC sp_info_autor ( @apellido varchar(40) = 'Ringer', @nombre varchar(20) = 'Anne' )
AS
BEGIN
	-- LISTA DE  LIBROS DEL AUTOR
    SELECT au_lname, au_fname, title
	FROM  titleauthor ta
    INNER JOIN authors a ON (a.au_id = ta.au_id)
    INNER JOIN  titles t ON (t.title_id = ta.title_id)
	WHERE au_fname =  @nombre AND au_lname = @apellido
RETURN
END

--VERIFICAR SI SE HIZO LA MODIFICACION
EXEC sp_helptext sp_info_autor;

--PROCEDIMIENTO ALMACENADO CON PARAMETROS POR DEFECTO
EXEC sp_info_autor 'Ringer';
EXEC sp_info_autor 'Ringer', 'Anne';
EXEC sp_info_autor 'Locksley', 'Charlene';
EXEC sp_info_autor;