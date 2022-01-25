
-- 1. PONER EN USO LA BASE DE DATOS Y CREAR EL DIAGRAMA PARA ANALIZARLO Y PONERLE DE NOMBRE "SPURS_Diagrama"
USE SPURS;

-- 2. CREAR UN LOGIN Y USUARIO LLAMADO PATROCINADOR CON CONTRASE�A DE "VidaSpurs"
CREATE LOGIN PATROCINADOR WITH PASSWORD = 'VidaSpurs'
CREATE USER PATROCINADOR FOR LOGIN PATROCINADOR

-- 3. CREAR UN ROL LLAMADO R_PATROCINADOR 
CREATE ROLE R_PATROCINADOR

-- 4. DARLE TODOS LOS PERMISOS A R_PATROCINADOR EN LAS TABLAS SULEDOS_EQUIPO_TECNICO Y SULEDOS_JUGADOR
GRANT ALL ON SULEDOS_EQUIPO_TECNICO TO R_PATROCINADOR
GRANT ALL ON SULEDOS_JUGADOR TO R_PATROCINADOR

-- 5. OTORGARLE AL USUARIO PATROCINADOR EL ROL DE R_PATROCINADOR
ALTER ROLE R_PATROCINADOR ADD MEMBER PATROCINADOR

-- 6. INICIAR SESION CON EL USUARIO PATROCINADOR, INSERTAR EN LA TABLA JUGADORES A UNO DE TUS COMPA�EROS
INSERT INTO JUGADORES VALUES 
(5,'Osmar','Luna','11','Delantero');

-- 7. ACTUALIZAR EL SUELDO DE ALGUNO DE LOS JUGADORES QUE YA ESTAN INSERTADOS CON EL USUARIO PATROCINADOR 
UPDATE SULEDOS_JUGADOR
SET Monto_Sueldo = 550000
WHERE Id_Jugador = 1;

-- 8. CREAR UN NUEVO ROL LLAMADO R_PATROCINADOR_PLUS Y OTORGARLE TODOS LOS PERMISOS DE LAS TABLAS QUE TIENE EL ROL R_PATROCINADOR Y A�ADIRLE LA TABLA JUGADORES
CREATE ROLE R_PATROCINADOR_PLUS
GRANT ALL ON SULEDOS_EQUIPO_TECNICO TO R_PATROCINADOR_PLUS
GRANT ALL ON SULEDOS_JUGADOR TO R_PATROCINADOR_PLUS
GRANT ALL ON JUGADORES TO R_PATROCINADOR_PLUS

-- 9. ELIMINAR EL ROL R_PATROCINADOR AL USUARIO PATROCINADOR Y A�ADIRLE EL ROL DE R_PATROCINADOR_PLUS
ALTER ROLE R_PATROCINADOR DROP MEMBER PATROCINADOR
ALTER ROLE R_PATROCINADOR_PLUS ADD MEMBER PATROCINADOR 

-- 10. INICIAR SESION NUEVAMENTE CON EL USUARIO PATROCINADOR, Y VOLVER A INTENTAR INSERTAR A UNO DE TUS COMPA�EROS COMO JUGADOR
INSERT INTO JUGADORES VALUES 
(5,'Osmar','Luna','11','Delantero');

-- 11. CREAR UN LOGIN Y USARIO LLAMADO REPRESENTANTE CON CONTRASE�A "MiPasion"

CREATE LOGIN REPRESENTANTE WITH PASSWORD = 'MiPasion'
CREATE USER REPRESENTANTE FOR LOGIN REPRESENTANTE

-- 12. OTORGARLE AL USUARIO REPRESENTANTE LOS ROLES FIJOS DE  db_datareader y processadmin
ALTER ROLE db_datareader ADD MEMBER REPRESENTANTE
ALTER SERVER ROLE processadmin ADD MEMBER REPRESENTANTE

-- 13. INICIAR SESION CON PATROCINADOR E INTENTAR VER LOS PROCESOS CON ACTIVITY MONITOR 
-- NO SE PUEDEN OBSERVAR LOS PROCESOS 

-- 14. AHORA INICIE SESION CON REPRESENTANTE E VOLVER A INTENTAR VER LOS PROCESOS CON ACTIVITY MONITOR 
-- AHORA SI SE PUEDEN OBSERVAR LOS PROCESOS

-- 15. CON REPRESENTANTE INTENTE AGREGARSE COMO UN EQUIPO TECNICO A USTED 
INSERT INTO EQUIPO_TECNICO
VALUES
('Asistente medico','Jesus','Partida');

-- 16. OTORGARLE AL USUARIO REPRESENTANTE EL ROL FIJO DE db_datawriter E INTERNTAR NUEVAMENTE REALIZAR EL PUNTO ANTERIOR 
ALTER ROLE db_datawriter ADD MEMBER REPRESENTANTE

INSERT INTO EQUIPO_TECNICO
VALUES
('Asistente medico','Jesus','Partida');

-- 17. CERRAR SESION CON TODOS LOS USUARIOS Y BORRAR TODOS LOS ROLES Y USUARIOS CREADOS
DROP USER REPRESENTANTE
DROP LOGIN REPRESENTANTE

DROP USER PATROCINADOR
DROP LOGIN PATROCINADOR

DROP ROLE R_PATROCINADOR
DROP ROLE R_PATROCINADOR_PLUS