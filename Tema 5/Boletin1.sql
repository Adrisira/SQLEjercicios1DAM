--Ejercicio 1. Insertar datos en alumno
INSERT INTO ALUMNO (NUMMATRICULA, NOMBRE, FECHANACIMIENTO, TELEFONO)
VALUES (1, 'JUAN PADILLA','01/01/2001',954112233);

--Ejercicio2
INSERT INTO ALUMNO (NUMMATRICULA, NOMBRE, TELEFONO)
VALUES (2, 'MARTA SEGURA',954445566);
/*
Para introducirlo con una secuencia:
VALUES (SEQ_ALUMNO.NEXTVAL)
*/
--Ejercicio3
INSERT INTO PROFESOR (IDPROFESOR, NIF_P, NOMBRE, ESPECIALIDAD, TELEFONO)
VALUES (1, '28444567T','PEPE MARTOS', 'INFORMATICA',954112233);

--Ejercicio4
INSERT INTO PROFESOR (IDPROFESOR, NIF_P, NOMBRE, ESPECIALIDAD, TELEFONO)
VALUES (2, '27677777Y','DAVID PASCUAL', 'MATEMATICAS',954445566);

--Ejercicio5
INSERT ASIGNATURA (CODASIGNATURA, NOMBRE, IDPROFESOR)
VALUES(1, 'BASE DE DATOS', 1);
COMMIT;

--Ejercicio6
INSERT RECIBE (NUMMATRICULA, CODASIGNATURA, CURSOESCOLAR)
VALUES(1, 1, 2020/2021);
COMMIT;

--Ejercicio7
UPDATE PROFESOR
SET NOMBRE='DAVID PASCUAL SANCHEZ'
WHERE NOMBRE='DAVID PASCUAL';
COMMIT;

--Ejercicio8
ALTER TABLE ALUMNO
ADD NIF NUMBER(8);

--Ejercicio9
UPDATE ALUMNO
SET NIF='34567890'
WHERE NOMBRE='JUAN PADILLA';

--Ejercicio10
ALTER TABLE ALUMNO
ADD NIF_P VARCHAR2(10);

UPDATE ALUMNO
SET NIF_P = NIF;
COMMIT;

ALTER TABLE ALUMNO
DROP COLUNM NIF;

ALTER TABLE ALUMNO
RENAME COLUNM NIF_P TO NIF;


--Ejercicio11
UPDATE ALUMNO
SET NIF='14567890-H'
WHERE NOMBRE='JUAN PADILLA';
COMMIT;

--Ejercicio12. Pongo SANCHEZ para que sea el que est� creado
DELETE PROFESOR
WHERE NOMBRE='DAVID PASCUAL SANCHEZ';
COMMIT;
/*REVISAR QUE NO HAYA UN ON DELETE CASCADE SINO BORRA LA ASIGNATURA QUE IMPARTE ESE PROFESOR*/

--Ejercicio13
/* Primera solucion*/
UPDATE ASIGNATURA
SET IDPROFESOR = NULL
WHERE IDPROFESOR = 1;
COMMIT;

DELETE PROFESOR
WHERE NOMBRE='PEPE MARTOS';
COMMIT;

/*Segunda solcuion*/

DELETE RECIBE
WHERE CODASIGNATURA = 1;

DELETE ASIGNATURA
WHERE IDPROFESOR = 1;

DELETE PROFESOR
WHERE IDPROFESOR = 1;
COMMIT;

--Ejercicio14
INSERT INTO PROFESOR 
VALUES (1, '28444567T', 'PEPE MARTOS', 'INFORMATICA', 954987654);

INSERT INTO ASIGNATURA (CODASIGNATURA, NOMBRE, IDPROFESOR)
VALUES(1, 'BASE DE DATOS', 1);
COMMIT;
/*Nombre de las constraint diferentes*/
ALTER TABLE ASIGNATURA
    DROP CONSTRAINT ASIGNATURA_IDPROFESOR_FK;

ALTER TABLE ASIGNATURA
    ADD CONSTRAINT ASIGNATURA_IDPROFESOR_FK FOREIGN KEY (IDPROFESOR) REFERENCES PROFESOR (IDPROFESOR) ON DELETE CASCADE;

ALTER TABLE RECIBE
    DROP CONSTRAINT RECIBE_CODASIGNATURA_FK;

ALTER TABLE RECIBE
    ADD CONSTRAINT RECIBE_CODASIGNATURA_FK FOREIGN KEY (CODASIGNATURA) REFERENCES ASIGNATURA (CODASIGNATURA) ON DELETE CASCADE;

--Ejercicio15
CREATE SEQUENCE SEC_ALUMNO_NUMMATRICULA
    START WITH 3
    INCREMENT BY 1
    MAXVALUE 9999999999 /*Porque el limite de datos es 10*/
    MINVALUE 3
    NOCYCLE;

--Ejercicio16
INSERT INTO ALUMNO (SEC_ALUMNO_NUMMATRICULA,NOMBRE, FECHANACIMIENTO, TELEFONO)
VALUES (SEC_ALUMNO_NUMMATRICULA.NEXTVAL ,'MARGARITA PEREZ','01/01/2017', 954445566);

--Ejercicio17

CREATE INDEX PROFESOR_TELEFONO_IDX
ON TABLE (TELEFONO)
TABLESPACE INSTITUTO_DATOS;

/*BORRAR INDEX*/
DROP INDEX PROFESOR_TELEFONO_IDX;

--Ejercicio18
--CAPTURAS

--Ejercicio19
DROP TABLE INSTITUTO.RECIBE;
DROP TABLE INSTITUTO.ASIGNATURA;
DROP TABLE INSTITUTO.PROFESOR;
DROP TABLE INSTITUTO.ALUMNO;

