CREATE USER INSTITUTO IDENTIFIED BY INSTITUTO DEFAULT TABLESPACE USERS;

GRANT CREATE SESSION, ALTER SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE TABLESPACE, UNLIMITED TABLESPACE TO INSTITUTO;

CONNECT INSTITUTO/ INSTITUTO;

CREATE TABLESPACE INSTITUTO_DATOS DATAFILE
'C:\oraclexe\app\oracle\oradata\XE\instituto_datos01.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;

CREATE TABLE ALUMNO(
NUMMATRICULA NUMBER(10) ,
NOMBRE VARCHAR2(50),
FECHANACIMIENTO DATE,
TELEFONO NUMBER(9),
CONSTRAINT ALUMNO_PK PRIMARY KEY(NUMMATRICULA)
) TABLESPACE INSTITUTO_DATOS;

ALTER TABLE ALUMNO MODIFY NOMBRE VARCHAR2(50);

CREATE TABLE PROFESOR(
IDPROFESOR NUMBER(10) CONSTRAINT PROFESOR_PK PRIMARY KEY,
NIF_P VARCHAR2(11) CONSTRAINT PROFESOR_NIF_P_UK UNIQUE,
NOMBRE VARCHAR2(50),
ESPECIALIDAD VARCHAR2(100),
TELEFONO VARCHAR2(20)
) TABLESPACE INSTITUTO_DATOS;

CREATE TABLE ASIGNATURA(
CODASIGNATURA NUMBER(9) CONSTRAINT ASIGNATURA_PK PRIMARY KEY,
NOMBRE VARCHAR2(50),
IDPROFESOR NUMBER(9) CONSTRAINT ASIGNATURA_PROFESOR_FK REFERENCES PROFESOR(IDPROFESOR)
) TABLESPACE INSTITUTO_DATOS;

CREATE TABLE RECIBE(
NUMMATRICULA NUMBER (10) CONSTRAINT ALUMNO_PK_RECIBE REFERENCES ALUMNO(NUMMATRICULA),
CODASIGNATURA NUMBER(9) CONSTRAINT ASIGNATURA_PK_RECIBE REFERENCES ASIGNATURA(CODASIGNATURA),
CURSOESCOLAR VARCHAR2(5),
CONSTRAINT RECIBE_PK PRIMARY KEY(NUMMATRICULA, CODASIGNATURA, CURSOESCOLAR)
)TABLESPACE INSTITUTO_DATOS;

DROP TABLE RECIBE;
DROP TABLE ASIGNATURA;
DROP TABLE PROFESOR;
DROP TABLE ALUMNO;
/* ADD CONSTRAINT CLIENTE_SEXO_CK CHECK (SEXO IN ('H', 'M'));*/
/* ""                                   (SEXO ='H' OR SEXO = 'M')*/
/* ""                                   (EDAD BETWEEN 5 AND 50)*/
/*""                                    (EDAD >= 5 AND EDAD <=50)*/