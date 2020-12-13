select  p.nombre, p.apellido1, p.apellido2
from    profesores p, departamentos d
where   p.departamento = d.codigo and d.nombre like 'Lenguajes%';
select * from sol_2_1;

select distinct asi.codigo, asi.nombre, nvl(cast (asi.PRACTICOS as varchar2(10)), 'No tiene') "Creditos Practicos"
from    asignaturas asi, alumnos al, matricular m
where   al.nombre = 'Nicolas' and al.apellido1 = 'Bersabe' and al.apellido2 = 'Alba' and 
        al.dni = m.alumno and asi.codigo = m.asignatura;
select * from sol_2_2;

select  p.nombre, p.apellido1, p.apellido2, trunc((to_date(sysdate)-to_date(p.antiguedad))/7) "Antiguedad", next_day(sysdate-1, to_char(p.antiguedad, 'DAY')) "Siguiente semana"
from    profesores p, departamentos d
where   p.departamento = d.codigo and d.nombre = 'Ingenieria de Comunicaciones';
select * from sol_2_3;

select  al.*
from    alumnos al, matricular m, asignaturas asi
where   m.CALIFICACION != 'SP' and al.dni = m.alumno and m.asignatura = asi.codigo and asi.nombre = 'Bases de Datos';
select * from sol_2_4;

select  p.id, p.nombre, p.apellido1, p.apellido2, asi.codigo, asi.nombre
from    profesores p, impartir i, asignaturas asi
where   p.id=i.profesor and i.ASIGNATURA=asi.CODIGO;
select * from sol_2_5;

select  al1.nombre, trunc(months_between(sysdate, al1.fecha_nacimiento)/12) "Edad 1", al2.nombre,  trunc(months_between(sysdate, al2.fecha_nacimiento)/12) "Edad 2"
from    alumnos al1, alumnos al2
where   upper(al1.apellido1)=upper(al2.apellido1) and al1.dni<al2.dni;
select * from sol_2_6;

select  al1.apellido1, al2.apellido1
from    alumnos al1, alumnos al2
where   al1.fecha_nacimiento between to_date('01-01-1995') and to_date('01-01-1996') and
        al2.fecha_nacimiento between to_date('01-01-1994') and to_date('01-01-1997') and
        al2.dni != al1.dni;
select * from sol_2_7;

select  p1.nombre, p1.apellido1, p1.apellido2, trunc(months_between(sysdate, p1.antiguedad)/12) "Antiguedad 1", p2.nombre, p2.apellido1, p2.apellido2, trunc(months_between(sysdate, p1.antiguedad)/12) "Antiguedad 2"
from    profesores p1, profesores p2
where   abs(months_between(p1.antiguedad, p2.antiguedad)/12)<2 and
        p1.departamento = p2.departamento and
        p1.id < p2.id;
select * from sol_2_8;

select  al1.nombre, al1.apellido1, al1.apellido2, al2.nombre, al2.apellido1, al2.apellido2
from    alumnos al1, alumnos al2, matricular m1, matricular m2
where   al1.genero = 'FEM'  and al2.genero = 'MASC'     and
        m1.alumno = al1.dni and m1.asignatura = '112'   and
        m2.alumno = al2.dni and m2.asignatura = '112'   and
        decode(m1.calificacion, 'SP', 4, 'AP', 5, 'NT', 7, 'SB', 9, 'MH', 10, 0) > decode(m2.calificacion, 'SP', 4, 'AP', 5, 'NT', 7, 'SB', 9, 'MH', 10, 0) and
        to_char(al1.fecha_prim_matricula, 'ww') = to_char(al2.FECHA_PRIM_MATRICULA, 'ww');
select * from sol_2_9;

select  asi1.nombre, asi2.nombre, asi3.nombre, m3.codigo
from    asignaturas asi1, asignaturas asi2, asignaturas asi3, materias m1, materias m2, materias m3
where       asi1.COD_MATERIA = m1.codigo    and asi2.COD_MATERIA = m2.codigo    and asi3.COD_MATERIA = m3.codigo and
            m1.codigo = m2.codigo           and m2.codigo = m3.codigo           and
            asi1.codigo < asi2.codigo       and asi2.codigo < asi3.codigo;
select * from sol_2_10;

select  al.nombre, al.apellido1, al.apellido2, asi.nombre, decode(m.calificacion, 'SP', 'Suspenso', 'AP', 'Aprobado', 'NT', 'Notable', 'SB', 'Sobresaliente', 'MH', 'Matricula de Honor', 'No presentado') "Nota"
from    alumnos al, asignaturas asi, matricular m
where   (months_between(sysdate, al.fecha_nacimiento)/12)>22 and
        al.dni = m.alumno and
        m.asignatura = asi.CODIGO
order by al.apellido1, al.apellido2, al.nombre;
select * from sol_2_11;

select  al.nombre, al.apellido1, al.apellido2
from    alumnos al, impartir i, matricular m, profesores p
where   p.nombre = 'Enrique'    and p.apellido1 = 'Soler'   and
        p.id = i.profesor       and
        i.grupo = m.grupo       and i.curso = m.curso       and
        al.dni = m.alumno       and
        m.asignatura = i.asignatura
order by al.apellido1, al.apellido2, al.nombre;
select * from sol_2_12;

select  al.nombre, al.apellido1, al.apellido2
from    alumnos al, departamentos d, profesores p, impartir i, matricular m
where   d.nombre = 'Lenguajes y Ciencias de la Computacion' and
        d.codigo = p.departamento   and p.id = i.profesor   and
        i.curso = m.curso           and i.grupo = m.grupo   and i.asignatura = m.asignatura and
        m.alumno = al.dni
order by al.apellido1, al.apellido2, al.nombre;
select * from sol_2_13;

select  asi.nombre, m.nombre, p.nombre, p.apellido1, p.apellido2, asi.creditos
from    asignaturas asi, materias m, profesores p, impartir i
where   asi.COD_MATERIA = m.codigo  and
        p.id = i.PROFESOR           and i.asignatura = asi.codigo
order by m.codigo, asi.nombre desc;
select * from sol_2_14; -- Salen Repetidos

select  asi.nombre, d.nombre, asi.creditos, round((asi.practicos/asi.creditos)*100, 2) "%Practicos"
from    asignaturas asi, departamentos d
where   asi.creditos is not null and asi.practicos is not null and asi.teoricos is not null and
        asi.departamento = d.codigo
order by round((asi.practicos/asi.creditos)*100, 2) desc;
select * from sol_2_15;

select codigo from asignaturas
minus
select asignatura from impartir;
select * from sol_2_16;

select email from alumnos
where email is not null
union all
select email from profesores
where email is not null;
select * from sol_2_17;

(select apellido1 from profesores where apellido1 is not null
union
select apellido2 from profesores where apellido2 is not null)
intersect
(select apellido1 from alumnos where apellido1 is not null
union
select apellido2 from alumnos where apellido2 is not null);
select * from sol_2_18;

select apellido1 from profesores where upper(apellido1) like '%LL%'
union
select apellido2 from profesores where upper(apellido2) like '%LL%'
union
select apellido1 from alumnos where upper(apellido1) like '%LL%'
union
select apellido2 from alumnos where upper(apellido2) like '%LL%';
select * from sol_2_19;

select replace(apellido1, 'll', 'y') from profesores where upper(apellido1) like '%LL%'
union
select replace(apellido2, 'll', 'y') from profesores where upper(apellido2) like '%LL%'
union
select replace(apellido1, 'll', 'y') from alumnos where upper(apellido1) like '%LL%'
union
select replace(apellido2, 'll', 'y') from alumnos where upper(apellido2) like '%LL%';
select * from sol_2_20;

select  asi.nombre, i.profesor
from    asignaturas asi join impartir i on asi.codigo = i.asignatura
where   asi.creditos != nvl(asi.teoricos, 0) + nvl(asi.practicos, 0);
select * from sol_2_21;

select      p.nombre, p.apellido1, p.apellido2, dir.nombre, dir.apellido1, dir.apellido2
from        profesores p left outer join profesores dir on p.director_tesis = dir.id
order by    p.apellido1, p.apellido2, p.nombre;
select * from sol_2_22;

select  p.nombre, p.apellido1, p.apellido2, dir.nombre, dir.apellido1, dir.apellido2, nvl(i.tramos, 0)
from    profesores p join profesores dir on p.director_tesis = dir.id left outer join investigadores i on i.id_profesor = dir.id;
select * from sol_2_23;

select      al1.nombre, al1.apellido1, al1.apellido2, al2.nombre, al2.apellido1, al2.apellido2
from        alumnos al1 left outer join alumnos al2 on al1.fecha_prim_matricula = al2.fecha_prim_matricula and al1.dni != al2.dni
order by    al1.apellido1, al1.apellido2, al1.nombre, al2.apellido1, al2.apellido2, al2.nombre;
select * from sol_2_24;

select  asi.nombre, i.curso, i.grupo, p.nombre, p.apellido1
from    asignaturas asi left outer join impartir i on asi.codigo = i.asignatura left outer join profesores p on i.profesor = p.id;
select * from sol_2_25;

select  p.nombre, p.apellido1, p.apellido2, p.id
from    profesores p
where   p.id not in   (select   profesor
                        from    impartir);
select * from sol_2_26;

select  al.nombre, al.apellido1, al.apellido2
from    alumnos al
where   rownum <= 2         and
        al.genero = 'FEM'   and
        al.dni in (select alumno
                    from matricular
                    where asignatura = '115');
select * from sol_2_27;

select *
from profesores
where id not in (select id_profesor
                 from investigadores);
select * from sol_2_28;

select nombre, codigo
from asignaturas
where codigo in     (select asi1.codigo
                    from    asignaturas asi1, asignaturas asi2
                    where   nvl(asi1.curso,0) = nvl(asi2.curso, 0) and
                            nvl(asi1.creditos,0) < nvl(asi2.creditos,0));
select * from sol_2_29;

select nombre, codigo
from asignaturas
where codigo not in (select asi1.codigo
                    from    asignaturas asi1, asignaturas asi2
                    where   nvl(asi1.curso,0) = nvl(asi2.curso, 0) and
                            nvl(asi1.creditos,0) < nvl(asi2.creditos,0));
select * from sol_2_30;









