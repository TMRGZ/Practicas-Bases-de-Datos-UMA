select  initcap(al.nombre), initcap(al.apellido1), initcap(al.apellido2), round((months_between(sysdate, al.fecha_nacimiento)/12), 0) "Edad"
from    alumnos al
where   al.email is not null and
        (months_between(sysdate, al.fecha_nacimiento)/12) <27;
        
select  p.nombre, p.apellido1, p.apellido2, p.antiguedad, next_day(to_date(to_char(p.antiguedad, 'dd/mm/') || to_char(sysdate, 'yy')), 'Viernes')
from    profesores p
where   (months_between(sysdate, p.fecha_nacimiento)/12) > 20;

select * from
(select  al.dni, round(avg(decode(m.calificacion, 'AP', '1', 'NT', '2', 'SB', '3', 'MH', '4')), 2)
from    alumnos al join matricular m on al.dni = m.alumno
where   m.calificacion in ('AP', 'NT', 'SB', 'MH')
group by al.dni
having count(distinct m.asignatura)>1
order by avg(decode(m.calificacion, 'AP', '1', 'NT', '2', 'SB', '3', 'MH', '4')) desc)
where rownum <=3;

select distinct p.nombre, p.apellido1, p.apellido2, al.nombre, al.apellido1, al.apellido2
from    profesores p join impartir i on p.id = i.profesor natural join matricular m join alumnos al on m.alumno = al.dni
where   substr(p.nombre, 1, 1) = substr(al.nombre,1 ,1) and substr(p.apellido1, 1, 1) = substr(al.apellido1,1 ,1);


select  asi1.codigo, asi1.nombre, asi2.codigo, asi2.nombre
from    asignaturas asi1, asignaturas asi2
where   asi1.codigo < asi2.codigo and
        (select count(distinct m1.alumno) from matricular m1 where m1.asignatura = asi1.codigo)
        =
        (select count(distinct m2.alumno) from matricular m2 where m2.asignatura = asi2.codigo)
        and
        (select count(distinct m1.alumno) from matricular m1 where m1.asignatura = asi1.codigo) != 0;

select  d.nombre, p.nombre, p.apellido1, p.apellido2
from    departamentos d, profesores p
where   (d.codigo, p.fecha_nacimiento) in(select  p.departamento, min(p.fecha_nacimiento)
                                            from    profesores p
                                            where   p.id not in (select  i.profesor
                                                                from    impartir i natural join matricular m join alumnos al on m.alumno = al.dni
                                                                where   al.fecha_nacimiento BETWEEN '01/01/1990' and '31/12/1999')
                                        group by p.departamento)