select  asi.nombre, al.nombre, al.apellido1, al.apellido2
from    asignaturas asi, alumnos al
where   (asi.codigo, al.fecha_nacimiento) in(select  m.asignatura, max(al.fecha_nacimiento)
                                            from    matricular m join alumnos al on m.alumno = al.dni
                                            group by m.asignatura);
                                                                         
select  asi.nombre, nvl(asi.creditos, 0)
from    asignaturas asi
where   asi.codigo not in (select  i.asignatura
                            from    profesores p join impartir i on p.id = i.profesor join asignaturas asi on asi.codigo = i.asignatura
                            where   round(months_between(sysdate, p.fecha_nacimiento)/12, 2) < 50);

select distinct p.nombre, p.apellido1, p.apellido2, asi.nombre, nvl(asi.creditos, '0')
from    profesores p left outer join impartir i on p.id = i.profesor left outer join asignaturas asi on i.asignatura = asi.codigo
where   substr(p.despacho, 1, 1) = '1' or substr(p.despacho, 1, 1) = '3';


select distinct  p.id, asi.nombre, asi.creditos
from profesores p natural join impartir i left outer join asignaturas asi on i.asignatura = asi.codigo
where substr(p.despacho, 1, 1) = '1' or substr(p.despacho, 1, 1) = '3';

select  al.nombre, al.apellido1, al.apellido2, round(avg(decode(m.calificacion,'AP', 1,'NT',2,'SB',3,'MH', 4)), 2)
from    alumnos al join matricular m on al.dni = m.alumno
where   m.calificacion in ('AP','NT','SB','MH') and
        al.dni not in (select  al.dni
                        from    alumnos al
                        where   to_char(al.FECHA_NACIMIENTO, 'Day') like '%S%' or to_char(al.FECHA_NACIMIENTO, 'Day') like '%D%')
group by al.dni, al.nombre, al.apellido1, al.apellido2;

select  distinct al1.nombre, al1.apellido1, al1.apellido2, al2.nombre, al2.apellido1, al2.apellido2
from    alumnos al1 join matricular m1 on al1.dni = m1.alumno, 
        alumnos al2 join matricular m2 on al2.dni = m2.alumno
where   al1.cmun = al2.cmun             and
        m1.alumno > m2.alumno           and
        m1.curso = m2.curso             and
        (select count(distinct m.asignatura)
        from matricular m 
        where m.alumno = m1.alumno and 
        m.asignatura in   (select distinct m.asignatura 
                            from matricular m 
                            where m.alumno = m2.alumno))>3;     
                                
                                
                                
                                
                                
                                
                                
