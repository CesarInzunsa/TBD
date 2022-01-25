--PONER EN USO LA BD
USE Hospital;

--1. CREAR UN LOGIN DE ENFERMERO
CREATE LOGIN enfermero WITH PASSWORD = '1234';

--2. CREAR UN USUARIO PARA EL LOGIN
CREATE USER enfermero FOR LOGIN  enfermero;

--3. PONLE EL ROL DE READER AL USUARIO
ALTER ROLE db_datareader ADD MEMBER enfermero;

--4. INICIA SESION CON EL USUARIO ENFERMERO Y MUESTRA TODOS LOS MEDICAMENTOSSELECT * FROM medicamento;--5. INTENTA ELIMINAR EL MEDICAMENTO AMBROXOL PARA VERIFICAR TUS PERMISOSDELETE FROM medicamento WHERE Med_Nombre = 'ambroxol';

--6. REGRESA AL USUARIO DEL SISTEMA Y CREA EL LOGIN Y USUARIO DOCTOR
CREATE LOGIN doctor WITH PASSWORD = '1234';
CREATE USER doctor FOR LOGIN doctor;

--7. PONLE COMO ROL OWNER AL USUARIO DOCTOR E INICIA SESION CON EL
ALTER ROLE db_owner ADD MEMBER doctor;

--8. AGREGA ESTOS 3 MEDICAMENTOS: PARACETAMOL, OMEPRAZOL Y ASPIRINA
INSERT INTO Medicamento VALUES
(1,'PARACETAMOL','25Mmg'),
(2,'OMEPRAZOL','10Mmg'),
(3,'ASPIRINA','30Mmg');

--9. CON EL USUARIO DEL SISTEMA MODIFICA EL ROL DEL PRIMER USUARIO A DB_OWNERALTER ROLE db_owner ADD MEMBER enfermero;--10. CREA UN ROL LLAMADO GERENTECREATE ROLE gerente;--11. DALE TODOS LOS PERMISOS SOBRE LA TABLA MEDICAMENTO AL ROL QUE CREASTEGRANT ALL PRIVILEGES ON medicamento TO gerente;--12 AGREGATE COMO USUARIOCREATE LOGIN CESAR WITH PASSWORD = '1234';CREATE USER CESAR FOR LOGIN CESAR;--13. PONTE EL ROL DE GERENTEALTER ROLE gerente ADD MEMBER CESAR;--14. INICIA SESION CON TU USUARIO Y ELIMINA PARACETAMOL DE LOS MEDICAMENTOSDELETE FROM Medicamento WHERE Med_Nombre = 'PARACETAMOL';--15. CON EL USUARIO DEL SISTEMA ELIMINA A TU USUARIODROP LOGIN CESAR;DROP USER CESAR;--16. ELIMINA EL ROL GERENTEDROP ROLE gerente;