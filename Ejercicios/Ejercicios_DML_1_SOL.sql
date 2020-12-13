select nombre, apellido1, apellido2
from profesores
where departamento=1;
select * from sol_1_1;

select nombre, apellido1, apellido2
from profesores
where departamento!=3;
select * from sol_1_2;

select nombre, apellido1, apellido2, email
from profesores
where email like'%lcc.uma.es';
select * from sol_1_3;

select nombre, apellido1, apellido2
from alumnos
where email is null;
select * from sol_1_4;

select nombre, creditos, (teoricos/creditos)*100, (practicos/creditos)*100
from asignaturas
where curso = 3;
select * from sol_1_5;

select alumno, calificacion
from matricular
where asignatura=112
order by alumno;
select * from sol_1_6;

select nombre, hombres+mujeres
from municipio;
select * from sol_1_7;

select 'El alumno ' || nombre || ' ' || apellido1 || ' ' || apellido2 || ' no tiene correo' "Mensaje"
from alumnos
where email is null and genero = 'MASC'
union
select 'El alumna ' || nombre || ' ' || apellido1 || ' ' || apellido2 || ' no tiene correo' "Mensaje"
from alumnos
where email is null and genero = 'FEM';
select * from sol_1_8;

select nombre, apellido1, apellido2
from profesores
where antiguedad < to_date('01/01/1990', 'DD/MM/YYYY');
select * from sol_1_9;

select nombre, apellido1, apellido2
from profesores
where months_between(sysdate, FECHA_NACIMIENTO)/12 < 30;
select * from sol_1_10;

select upper (nombre), upper (apellido1), upper (apellido2), trunc(months_between(sysdate, antiguedad)/36) "Trienios"
from profesores
where months_between(sysdate, antiguedad)/36 > 3;
select * from sol_1_11;

select replace(nombre, 'Bases de Datos', 'Almacenes de Datos')
from asignaturas
where nombre like '%Bases de Datos%';
select * from sol_1_12;

select nombre, nvl(cast(creditos as varchar(10)), 'No asignado') "Creditos" 
from asignaturas
where caracter like 'O_';
select * from sol_1_13;

select *
from alumnos
where months_Between(sysdate, FECHA_PRIM_MATRICULA)<2;
select * from sol_1_14;

select *
from alumnos
where (months_Between(FECHA_PRIM_MATRICULA, fecha_nacimiento)/12)<18;
select * from sol_1_15;

select *
from alumnos
where to_char(fecha_prim_matricula, 'D')= 1;
select * from sol_1_16;







