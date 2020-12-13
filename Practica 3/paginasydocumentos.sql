--
--NO LEA ESTE DOCUMENTO
--
--
--LANCELO DIRECTAMENTE SOBRE SU ESQUEMA ORACLE
--
--
--
--
--
----
--
--
--
--
--
--
--
--
--
----
--
--
--
--
--
--
--
--
--
----
--
--
--
--
--
--
--
--
--
--

create table DOCUMENTO(
Nombre varchar2(100),
directorio varchar2(100), 
Fecha_Creacion date not null, 
Comentario varchar2(100), 
Tamano number(3), 
Constraint primaria_Documento primary key(Nombre,directorio));

 
INSERT INTO documento VALUES ('Prueba.txt','/user/practicas','3-jun-2002','fichero de prueba',30); 
INSERT INTO documento VALUES ('logo.gif','/user/practicas','13-jun-2002','ES UN GRAFICO',40); 
INSERT INTO documento VALUES ('Tesis.doc','/user/enciso','15-jun-2002','fichero de tesis',43); 
INSERT INTO documento VALUES ('Tesis2.doc','/user/enciso','15-may-2002','fichero de tesis 2',50); 
INSERT INTO documento VALUES ('Facturas junio','/user/enciso','3-may-2002','todas las facturas',50); 
INSERT INTO documento VALUES ('logo.gif', '/user/enciso','3-abr-2002','ESUN GRAFICO, No Txt',10); 




create table DOC_TEXTO( 
ASCII varchar2(1), 
Num_Lineas number(3), 
Num_Caracteres number(3)); 

create table APLICACIONES(
Nombre_APLIC varchar2(100) primary key, 
compania varchar2(100), 
Precio number(5,2), 
Web_APLICACION varchar2(100)); 


INSERT INTO aplicaciones VALUES ('PoorEdit', 'Sofw', 30.00,'http://www.soft.com/PE'); 
INSERT INTO aplicaciones VALUES ('SaveEdit', 'Borllan', 40.00,'http://www.Borllan.com'); 
INSERT INTO aplicaciones VALUES ('SimpleTexto', 'Micrisoft', 100.00,'http://www.micrisoft.com'); 
INSERT INTO aplicaciones VALUES ('TxtE', 'Sofw', 60.00,'http://www.soft.com/TxTE'); 


create table COMPATIBLE(
 Nombre_documento varchar2(100), 
directorio varchar2(100), 
Nombre_aplicacion varchar2(100),
 primary key(Nombre_documento,Nombre_aplicacion)); 

INSERT INTO compatible VALUES ('Prueba.txt','/user/practicas', 'PoorEdit'); 
INSERT INTO compatible VALUES ('Prueba.txt','/user/practicas', 'SaveEdit'); 
INSERT INTO compatible VALUES ('Tesis.doc','/user/enciso', 'SimpleTexto'); 
INSERT INTO compatible VALUES ('Facturas junio','/user/enciso', 'PoorEdit'); 
INSERT INTO compatible VALUES ('Facturas junio','/user/enciso', 'SaveEdit'); 
INSERT INTO compatible VALUES ('Facturas junio','/user/enciso', 'TxtE'); 
INSERT INTO compatible VALUES ('Tesis2.doc','/user/enciso', 'SimpleTexto'); 



create table PAGINA( Nombre varchar2(100), 
directorio varchar2(100), 
Numero_pagina Number(5),
 Primary key(Nombre,directorio,Numero_pagina)); 


INSERT INTO pagina VALUES ('Prueba.txt','/user/practicas',1); 
INSERT INTO pagina VALUES ('Prueba.txt','/user/practicas',2); 
INSERT INTO pagina VALUES ('Tesis.doc','/user/enciso',1); 



 --
--
--
--
--
----
--
--
--
--
--
--
--
--
--
----
--
--
--
--
--
--
--
--
--
----
--
--
--
--
--
--