-- Generado por Oracle SQL Developer Data Modeler 17.3.0.261.1529
--   en:        2017-12-18 19:45:21 CET
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



CREATE TABLE actividad (
    id      NUMBER NOT NULL,
    fecha   DATE NOT NULL
);

ALTER TABLE actividad ADD CONSTRAINT actividad_pk PRIMARY KEY ( id );

CREATE TABLE comentario (
    fecha          DATE NOT NULL,
    asiste         CHAR(1) NOT NULL,
    comentario     VARCHAR2(100),
    actividad_id   NUMBER NOT NULL,
    socio_id       NUMBER NOT NULL
);

ALTER TABLE comentario
    ADD CONSTRAINT comentario_pk PRIMARY KEY ( fecha,
    actividad_id,
    socio_id );

CREATE TABLE documentacion (
    id_documento   NUMBER NOT NULL,
    estado         VARCHAR2(20) NOT NULL,
    url            VARCHAR2(40) NOT NULL
);

ALTER TABLE documentacion ADD CONSTRAINT documentacion_pk PRIMARY KEY ( id_documento );

CREATE TABLE finanzas (
    cuota                NUMBER NOT NULL,
    mes                  DATE NOT NULL,
    iva                  NUMBER NOT NULL,
    financiacion         NUMBER,
    balance_de_cuentas   NUMBER,
    tesoreria            NUMBER,
    socio_id             NUMBER NOT NULL
);

ALTER TABLE finanzas ADD CONSTRAINT finanzas_pk PRIMARY KEY ( cuota,
mes );

CREATE TABLE pedido_online (
    n_pedido               NUMBER NOT NULL,
    precio                 NUMBER NOT NULL,
    validacion_de_pedido   CHAR(1),
    ingreso                NUMBER,
    gasto                  NUMBER,
    producto_id            NUMBER NOT NULL,
    socio_id               NUMBER NOT NULL
);

ALTER TABLE pedido_online
    ADD CONSTRAINT pedido_online_pk PRIMARY KEY ( n_pedido,
    producto_id,
    socio_id );

CREATE TABLE post (
    titulo      VARCHAR2(20) NOT NULL,
    contenido   VARCHAR2(200) NOT NULL
);

ALTER TABLE post ADD CONSTRAINT post_pk PRIMARY KEY ( titulo );

CREATE TABLE producto (
    id       NUMBER NOT NULL,
    nombre   VARCHAR2(20) NOT NULL,
    precio   NUMBER NOT NULL,
    talla    NUMBER NOT NULL,
    stock    NUMBER
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( id );

CREATE TABLE relation_10 (
    socio_id    NUMBER NOT NULL,
    socio_id1   NUMBER NOT NULL
);

ALTER TABLE relation_10 ADD CONSTRAINT relation_10_pk PRIMARY KEY ( socio_id,
socio_id1 );

CREATE TABLE relation_14 (
    documentacion_id_documento   NUMBER NOT NULL,
    socio_id                     NUMBER NOT NULL
);

ALTER TABLE relation_14 ADD CONSTRAINT relation_14_pk PRIMARY KEY ( documentacion_id_documento,
socio_id );

CREATE TABLE relation_3 (
    socio_id          NUMBER NOT NULL,
    tutor_legal_dni   VARCHAR2(20) NOT NULL
);

ALTER TABLE relation_3 ADD CONSTRAINT relation_3_pk PRIMARY KEY ( socio_id,
tutor_legal_dni );

CREATE TABLE relation_7 (
    voluntario_id   NUMBER NOT NULL,
    actividad_id    NUMBER NOT NULL
);

ALTER TABLE relation_7 ADD CONSTRAINT relation_7_pk PRIMARY KEY ( voluntario_id,
actividad_id );

CREATE TABLE relation_8 (
    socio_id      NUMBER NOT NULL,
    post_titulo   VARCHAR2(20) NOT NULL
);

ALTER TABLE relation_8 ADD CONSTRAINT relation_8_pk PRIMARY KEY ( socio_id,
post_titulo );

CREATE TABLE relation_9 (
    voluntario_id   NUMBER NOT NULL,
    post_titulo     VARCHAR2(20) NOT NULL
);

ALTER TABLE relation_9 ADD CONSTRAINT relation_9_pk PRIMARY KEY ( voluntario_id,
post_titulo );

CREATE TABLE socio (
    id                 NUMBER NOT NULL,
    usuario            VARCHAR2(20) NOT NULL,
    contraseña         VARCHAR2(20) NOT NULL,
    grupo              VARCHAR2(20) NOT NULL,
    nombre             VARCHAR2(20) NOT NULL,
    apellidos          VARCHAR2(20) NOT NULL,
    direccion          VARCHAR2(20),
    fecha_nacimiento   DATE,
    telefono           NUMBER,
    fecha_ingreso      DATE,
    fecha_de_baja      DATE,
    so3                VARCHAR2(100),
    provincia          VARCHAR2(20),
    promesas           VARCHAR2(50),
    incidencias        VARCHAR2(50)
);

ALTER TABLE socio ADD CONSTRAINT socio_pk PRIMARY KEY ( id );

ALTER TABLE socio ADD CONSTRAINT socio_usuario_un UNIQUE ( usuario );

CREATE TABLE tutor_legal (
    dni         VARCHAR2(20) NOT NULL,
    nombre      VARCHAR2(20) NOT NULL,
    apellidos   VARCHAR2(20) NOT NULL
);

ALTER TABLE tutor_legal ADD CONSTRAINT tutor_legal_pk PRIMARY KEY ( dni );

ALTER TABLE tutor_legal ADD CONSTRAINT tutor_alumno_un UNIQUE ( nombre,
apellidos );

CREATE TABLE voluntario (
    id    NUMBER NOT NULL,
    dni   VARCHAR2(20) NOT NULL
);

ALTER TABLE voluntario ADD CONSTRAINT voluntario_pk PRIMARY KEY ( id );

ALTER TABLE comentario
    ADD CONSTRAINT comentario_actividad_fk FOREIGN KEY ( actividad_id )
        REFERENCES actividad ( id );

ALTER TABLE comentario
    ADD CONSTRAINT comentario_socio_fk FOREIGN KEY ( socio_id )
        REFERENCES socio ( id );

ALTER TABLE finanzas
    ADD CONSTRAINT finanzas_socio_fk FOREIGN KEY ( socio_id )
        REFERENCES socio ( id );

ALTER TABLE pedido_online
    ADD CONSTRAINT pedido_online_producto_fk FOREIGN KEY ( producto_id )
        REFERENCES producto ( id );

ALTER TABLE pedido_online
    ADD CONSTRAINT pedido_online_socio_fk FOREIGN KEY ( socio_id )
        REFERENCES socio ( id );

ALTER TABLE relation_10
    ADD CONSTRAINT relation_10_socio_fk FOREIGN KEY ( socio_id )
        REFERENCES socio ( id );

ALTER TABLE relation_10
    ADD CONSTRAINT relation_10_socio_fkv1 FOREIGN KEY ( socio_id1 )
        REFERENCES socio ( id );

ALTER TABLE relation_14
    ADD CONSTRAINT relation_14_documentacion_fk FOREIGN KEY ( documentacion_id_documento )
        REFERENCES documentacion ( id_documento );

ALTER TABLE relation_14
    ADD CONSTRAINT relation_14_socio_fk FOREIGN KEY ( socio_id )
        REFERENCES socio ( id );

ALTER TABLE relation_7
    ADD CONSTRAINT relation_7_actividad_fk FOREIGN KEY ( actividad_id )
        REFERENCES actividad ( id );

ALTER TABLE relation_7
    ADD CONSTRAINT relation_7_voluntario_fk FOREIGN KEY ( voluntario_id )
        REFERENCES voluntario ( id );

ALTER TABLE relation_8
    ADD CONSTRAINT relation_8_post_fk FOREIGN KEY ( post_titulo )
        REFERENCES post ( titulo );

ALTER TABLE relation_8
    ADD CONSTRAINT relation_8_socio_fk FOREIGN KEY ( socio_id )
        REFERENCES socio ( id );

ALTER TABLE relation_9
    ADD CONSTRAINT relation_9_post_fk FOREIGN KEY ( post_titulo )
        REFERENCES post ( titulo );

ALTER TABLE relation_9
    ADD CONSTRAINT relation_9_voluntario_fk FOREIGN KEY ( voluntario_id )
        REFERENCES voluntario ( id );

ALTER TABLE relation_3
    ADD CONSTRAINT socio_fk FOREIGN KEY ( socio_id )
        REFERENCES socio ( id );

ALTER TABLE relation_3
    ADD CONSTRAINT tutor_legal_fk FOREIGN KEY ( tutor_legal_dni )
        REFERENCES tutor_legal ( dni );

ALTER TABLE voluntario
    ADD CONSTRAINT voluntario_socio_fk FOREIGN KEY ( id )
        REFERENCES socio ( id );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            16
-- CREATE INDEX                             0
-- ALTER TABLE                             36
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
