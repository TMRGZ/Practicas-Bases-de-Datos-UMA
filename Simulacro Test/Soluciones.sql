--CONSULTA 1). PW: SIMII18
select a.nombre, al.nombre, al.apellido1, al.apellido2 from asignaturas a, alumnos al where (al.fecha_nacimiento, a.codigo) in
(select max(al.fecha_nacimiento), a.codigo from alumnos al, asignaturas a, matricular m where m.asignatura = a.codigo and m.alumno = al.dni group by a.codigo);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--CONSULTA 2).
select  distinct a.nombre, NVL(a.creditos, 0) Creditos from asignaturas a, profesores p, impartir i where round((months_between(sysdate, p.fecha_nacimiento)/12)) > 50
and p.id = i.profesor and i.asignatura = a.codigo;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--CONSULTA 3).
select distinct p.apellido1, p.apellido2, p.nombre, a.creditos from profesores p, asignaturas a, impartir i where i.asignatura = a.codigo and p.id = i.profesor
and (p.despacho like '1%' or p.despacho like '3%');
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--CONSULTA 4).
select al.nombre, al.apellido1, al.apellido2, round(avg(decode(m.calificacion, 'AP',1,'NT',2,'SB',3,'MH',4)),2) Media from alumnos al, matricular m
where to_char(al.fecha_nacimiento, 'DAY') like 'LUNES%' or to_char(al.fecha_nacimiento, 'DAY') like 'MARTES%' or to_char(al.fecha_nacimiento, 'DAY') like 'MIÉRCOLES%'
or to_char(al.fecha_nacimiento, 'DAY') like 'JUEVES%' or to_char(al.fecha_nacimiento, 'DAY') like 'VIERNES%' and m.alumno = al.dni group by al.nombre, al.apellido1, al.apellido2;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--CONSULTA 5).
select distinct al1.nombre, al1.apellido1, al1.apellido2, al2.nombre, al2.apellido1, al2.apellido2 from alumnos al1, alumnos al2 where al1.cpro = al2.cpro and al1.cmun = al2.cmun
and al1.dni < al2.dni;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
