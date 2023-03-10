CREATE USER CLUB_NAUTICO IDENTIFIED BY CLUB_NAUTICO DEFAULT TABLESPACE USERS;

GRANT CREATE SESSION, ALTER SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE TABLESPACE, UNLIMITED TABLESPACE TO CLUB_NAUTICO;

CREATE TABLESPACE CLUB_NAUTICO_DATOS DATAFILE
'C:\oraclexe\app\oracle\oradata\XE\club_nautico_datos01.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;

CONNECT CLUB_NAUTICO/ CLUB_NAUTICO;

CREATE TABLE SOCIO (
DNI VARCHAR2(10) CONSTRAINT SOCIO_PK PRIMARY KEY,
NOMBRE VARCHAR2(50) NOT NULL,
DIRECCION VARCHAR2(50),
FECHAINGRESO DATE
) TABLESPACE CLUB_NAUTICO_DATOS;

CREATE TABLE ZONA (
ZONA_LETRA VARCHAR2(20),
ZONA_TIPO VARCHAR2(20),
NBARCOS NUMBER(10),
CONSTRAINT ZONA_PK PRIMARY KEY (ZONA_LETRA, ZONA_TIPO)
) TABLESPACE CLUB_NAUTICO_DATOS;

CREATE TABLE EMPLEADO (
CODIGO NUMBER (10) CONSTRAINT EMPLEADO_PK PRIMARY KEY,
NOMBRE VARCHAR2(50) NOT NULL,
TELEFONO NUMBER(9)
) TABLESPACE CLUB_NAUTICO_DATOS;

CREATE TABLE EMBARCACION (
MATRICULA VARCHAR2(7) CONSTRAINT EMBARCACION_PK PRIMARY KEY,
TIPO VARCHAR2(4) CONSTRAINT EMBARCACION_CK CHECK (TIPO IN ('VL', 'M', 'YV', 'YM')),
DNI VARCHAR2(10) CONSTRAINT SOCIO_EMBARCACION_FK REFERENCES SOCIO(DNI) NOT NULL
) TABLESPACE CLUB_NAUTICO_DATOS;

CREATE TABLE SE_ENCARGA (
CODIGO_EMPLEADO NUMBER(10) CONSTRAINT EMPLEADO_SE_ENCARGA_FK REFERENCES EMPLEADO(CODIGO),
ZONA_LETRA VARCHAR2(20),
ZONA_TIPO VARCHAR2(20),
NBARCOS NUMBER(10),
CONSTRAINT SE_ENCARGA_PK PRIMARY KEY (CODIGO_EMPLEADO, ZONA_LETRA, ZONA_TIPO),
CONSTRAINT ZONA_SE_ENCARGA_FK FOREIGN KEY (ZONA_LETRA, ZONA_TIPO) REFERENCES ZONA(ZONA_LETRA, ZONA_TIPO)
) TABLESPACE CLUB_NAUTICO_DATOS;

CREATE TABLE AMARRE (
ZONA_LETRA VARCHAR2(20),
ZONA_TIPO VARCHAR2(20),
NUMERO NUMBER(10),
SERVICIOS VARCHAR2(50),
MATRICULA VARCHAR2(7) CONSTRAINT AMARRE_UK UNIQUE,
CONSTRAINT AMARRE_PK PRIMARY KEY (ZONA_LETRA,ZONA_TIPO, NUMERO),
CONSTRAINT ZONA_AMARRE_FK FOREIGN KEY  (ZONA_LETRA, ZONA_TIPO) REFERENCES ZONA(ZONA_LETRA, ZONA_TIPO),
CONSTRAINT EMBARCACION_AMARRE_FK FOREIGN KEY (MATRICULA) REFERENCES EMBARCACION(MATRICULA)
) TABLESPACE CLUB_NAUTICO_DATOS;

CREATE TABLE ES_PROPIETARIO (
LETRA VARCHAR2(20),
TIPO VARCHAR2(20),
NUMERO NUMBER(10),
DNI_SOCIO VARCHAR2(10) CONSTRAINT SOCIO_ES_PROPIETARIO_FK REFERENCES SOCIO(DNI),
FCOMPRA DATE,
CONSTRAINT ES_PROPIETARIO_PK PRIMARY KEY (LETRA, TIPO, NUMERO),
CONSTRAINT AMARRE_ES_PROPIETARIO_FK FOREIGN KEY (LETRA, TIPO, NUMERO) REFERENCES AMARRE(ZONA_LETRA, ZONA_TIPO, NUMERO)
) TABLESPACE CLUB_NAUTICO_DATOS;

ALTER TABLE SOCIO ADD CONSTRAINT SOCIO_UK UNIQUE (NOMBRE);

ALTER TABLE AMARRE ADD CONSTRAINT AMARRE_CK CHECK (SERVICIOS IN('S', 'N'));

ALTER TABLE SE_ENCARGA ADD CONSTRAINT SE_ENCARGA_CK CHECK(NBARCOS < 0);

ALTER TABLE SOCIO 
ADD SEXO VARCHAR2(6) DEFAULT 'MUJER'
ADD CONSTRAINT SOCIO_CK CHECK (SEXO IN ('MUJER','HOMBRE'));


CREATE SEQUENCE SEC_CODIGO
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999
    MINVALUE 1
    NOCYCLE;
    
ALTER TABLE AMARRE DISABLE CONSTRAINT AMARRE_CK CASCADE;

ALTER TABLE AMARRE ENABLE CONSTRAINT AMARRE_CK;

ALTER TABLE AMARRE DROP CONSTRAINT AMARRE_CK;
/* EJERICIO 3*/
ALTER TABLE SE_ENCARGA
DROP CONSTRAINT EMPLEADO_SE_ENCARGA_FK;
ALTER TABLE SE_ENCARGA
ADD CONSTRAINT EMPLEADO_SE_ENCARGA_FK FOREIGN(CODIGO_EMPLEADO) REFERENCES EMPLEADO(CODIGO) ON DELETE CASCADE;