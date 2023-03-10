CREATE USER COCHE IDENTIFIED BY COCHE DEFAULT TABLESPACE USERS;

GRANT CREATE SESSION, ALTER SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE TABLESPACE, UNLIMITED TABLESPACE TO COCHE;

CREATE TABLESPACE COCHE_DATOS DATAFILE
'C:\oraclexe\app\oracle\oradata\XE\coche_datos01.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;

CONNECT COCHE/ COCHE;

CREATE TABLE CLIENTE (
CODCLIENTE NUMBER (9),
DNI VARCHAR2 (10),
NOMBRE VARCHAR2 (50),
DIRECCION VARCHAR2 (50),
TELEFONO NUMBER (9),
SEXO VARCHAR2(1)
) TABLESPACE COCHE_DATOS;

CREATE TABLE COCHE (
MATRICULA VARCHAR2(7),
MARCA VARCHAR2 (20), 
MODELO VARCHAR2 (20),
COLOR VARCHAR2 (10),
PRECIOHORA NUMBER (5)
) TABLESPACE COCHE_DATOS;

CREATE TABLE RESERVA (
NUMERO NUMBER(9),
FECHAINICIO DATE,
FECHAFIN DATE,
PRECIOTOTAL NUMBER(9),
CODCLIENTE NUMBER(9)
) TABLESPACE COCHE_DATOS;

CREATE TABLE AVALA (
AVALADO NUMBER(9),
AVALADOR NUMBER(9)
) TABLESPACE COCHE_DATOS;

CREATE TABLE INCLUYE (
NUMERO NUMBER (9),
MATRICULA VARCHAR2(7),
LITROSGAS NUMBER (5)
) TABLESPACE COCHE_DATOS;

ALTER TABLE CLIENTE 
ADD CONSTRAINT CLIENTE_PK PRIMARY KEY(CODCLIENTE)
ADD CONSTRAINT CLIENTE_UK UNIQUE(DNI)
MODIFY NOMBRE NOT NULL
ADD CONSTRAINT CLIENTE_SEXO_CK CHECK (SEXO IN ('V', 'H'));

ALTER TABLE COCHE 
ADD CONSTRAINT COCHE_PK PRIMARY KEY(MATRICULA)
MODIFY MARCA NOT NULL
MODIFY MODELO NOT NULL;

ALTER TABLE RESERVA 
ADD CONSTRAINT RESERVA_PK PRIMARY KEY(NUMERO)
ADD CONSTRAINT CLIENTE_RESERVA_FK FOREIGN KEY(CODCLIENTE) REFERENCES CLIENTE(CODCLIENTE);
CREATE SEQUENCE SECRES_RESERVA
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 99
    MINVALUE 1
    NOCYCLE;

ALTER TABLE AVALA 
ADD CONSTRAINT AVALA_PK PRIMARY KEY(AVALADO)
ADD CONSTRAINT CLIENTE_AVALA_FK1 FOREIGN KEY (AVALADO) REFERENCES CLIENTE(CODCLIENTE)
ADD CONSTRAINT CLIENTE_AVALA_FK2 FOREIGN KEY (AVALADOR) REFERENCES CLIENTE(CODCLIENTE);

ALTER TABLE INCLUYE
ADD CONSTRAINT INCLUYE_PK PRIMARY KEY (NUMERO, MATRICULA)
ADD CONSTRAINT RESERVA_INCLUYE_FK1 FOREIGN KEY (NUMERO) REFERENCES RESERVA(NUMERO)
ADD CONSTRAINT COCHE_INCLUYE_FK2 FOREIGN KEY(MATRICULA) REFERENCES COCHE(MATRICULA); 

