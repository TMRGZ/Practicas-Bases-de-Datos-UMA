select      d.nombre, count (p.id)
from        departamentos d, profesores p
where       d.codigo = p.departamento
group by    d.nombre;
select * from sol_3_1;

select      d.nombre, sum(asi.creditos)
from        departamentos d, asignaturas asi
where       d.codigo = asi.departamento
group by    d.nombre;
select * from sol_3_2;

select      asi.curso, count(distinct al.dni)
from        matricular m, alumnos al, asignaturas asi
where       m.alumno = al.dni and asi.codigo = m.asignatura and asi.curso is not null
group by    asi.curso;
select * from sol_3_3;

select      p.despacho, sum(i.CARGA_CREDITOS)
from        profesores p join impartir i on p.id = i.profesor
where       p.despacho is not null
group by    p.despacho;
select * from sol_3_4;

select      asi.codigo, (count(distinct al.dni)/(select count(*) from matricular m2 where m.asignatura = m2.asignatura))*100 "Porcentaje"
from        asignaturas asi, matricular m, alumnos al
where       asi.codigo = m.asignatura and m.alumno = al.dni and
            al.genero = 'FEM'
group by    asi.codigo
order by    asi.codigo;
select * from sol_3_5;

select      p.nombre, sum(m.HOMBRES)+sum(m.mujeres)
from        provincia p, municipio m
where       p.codigo = m.cpro
group by    p.nombre;
select * from sol_3_6;

select  d.nombre, p.nombre, p.apellido1, p.apellido2
from    departamentos d join profesores p on p.departamento = d.codigo
where   p.fecha_nacimiento in   (select min(p.fecha_nacimiento) 
                                from profesores p 
                                group by p.departamento);
select * from sol_3_7;

select distinct  al.nombre, al.apellido1, al.apellido2, asi.nombre
from    alumnos al join matricular m on al.dni = m.alumno join asignaturas asi on m.asignatura = asi.codigo
where   asi.creditos in (SELECT MAX(asiAux.creditos)
                        FROM (alumnos alAux JOIN matricular mAux ON mAux.alumno = alAux.dni) JOIN asignaturas asiAux ON mAux.asignatura=asiAux.codigo
                        WHERE al.dni=alAux.dni);
select * from sol_3_8; -- Revisar

select  d.nombre, p.nombre, p.apellido1, p.apellido2
from    departamentos d join profesores p on d.codigo = p.departamento
where   p.ANTIGUEDAD in (select min(p.antiguedad) 
                        from profesores p 
                        group by p.departamento);
select * from sol_3_9;

select  d.nombre, asi.nombre
from    departamentos d join asignaturas asi on d.codigo = asi.departamento
where   asi.creditos  in    (select min (asi.creditos) 
                            from asignaturas asi 
                            where d.codigo = asi.departamento 
                            group by asi.departamento);
select * from sol_3_10;

select distinct  asi.nombre, al.nombre, al.apellido1, al.apellido2
from    asignaturas asi join matricular m on asi.codigo = m.asignatura join alumnos al on al.dni = m.alumno
where   al.fecha_nacimiento in (select max(al.fecha_nacimiento) 
                                from alumnos al join matricular m on al.dni = m.alumno 
                                where m.curso = '14/15' and asi.codigo = m.asignatura 
                                group by m.asignatura);
select * from sol_3_11;

select      p.nombre, p.apellido1, p.apellido2, sum(i.carga_creditos)
from        profesores p join impartir i on p.id = i.profesor
group by    p.nombre, p.apellido1, p.apellido2
having      sum(i.carga_creditos) = (select max(sum(i.carga_creditos))
                                    from profesores p join impartir i on p.id = i.profesor
                                    group by p.id);
select * from sol_3_12;

select      d.nombre
from        departamentos d join asignaturas asi on d.codigo = asi.departamento
group by    d.nombre
having      count(asi.codigo) = (select max(count(asi.codigo))
                                from asignaturas asi join departamentos d on asi.departamento = d.codigo
                                group by d.codigo);
select * from sol_3_13;

select      p.id, sum(i.carga_creditos)
from        profesores p join impartir i on p.id = i.profesor
group by    p.id
having      sum(i.carga_creditos) < 10;
select * from sol_3_14;


select      p.nombre, p.apellido1, p.apellido2
from        profesores p
where       p.id in (select     p.id
                    from        profesores p join impartir i on p.id = i.profesor
                    group by    p.id
                    having      sum(i.carga_creditos) > (select avg(sum(i.carga_creditos))
                                                        from impartir i join profesores p on i.profesor = p.id
                                                        group by p.id));
select * from sol_3_15;

select      p.id
from        profesores p join impartir i on p.id = i.profesor
where       i.curso = '15/16' and i.carga_creditos < 6.5
group by    p.id
HAVING      count(i.asignatura)>1;
select * from sol_3_16;

select      asi.nombre
from        asignaturas asi
where       codigo not in (select asignatura
                            from matricular
                            where calificacion in ('AP', 'NT', 'SB', 'MH'));
select * from sol_3_17;

select      d.nombre
from        departamentos d
where       d.codigo not in (select departamento
                            from asignaturas
                            where creditos > 6);
select * from sol_3_18;

select  p.nombre, p.apellido1, p.apellido2
from    profesores p join impartir i on p.id = i.profesor join asignaturas asi on i.asignatura = asi.codigo
where   asi.caracter = 'OP' and
        p.id not in (select i.profesor 
                    from matricular m 
                    where i.grupo = m.grupo);
select * from sol_3_19;

select  p1.nombre, p1.apellido1, p1.apellido2, p2.nombre, p2.apellido1, p2.apellido2
from    profesores p1, profesores p2
where   p1.id > p2.id and not exists    (select m.alumno 
                                        from matricular m natural join impartir i
                                        where p1.id = i.profesor
                                        intersect
                                        select m.alumno 
                                        from matricular m natural join impartir i
                                        where p2.id = i.profesor);
select * from sol_3_20;

select  p1.nombre, p1.apellido1, p1.apellido2, p2.nombre, p2.apellido1, p2.apellido2
from    profesores p1, profesores p2
where   p1.id > p2.id and not exists    (select i.asignatura
                                        from impartir i
                                        where p1.id = i.profesor
                                        intersect
                                        select i.asignatura
                                        from impartir i
                                        where p2.id = i.profesor);
select * from sol_3_21;




select  asi.nombre
from    asignaturas asi
where   asi.codigo not in   (select m1.asignatura
                            from    matricular m1 natural join alumnos al1, 
                                    matricular m2 natural join alumnos al2 
                            where   m1.asignatura = m2.asignatura);


select  asi.nombre
from    asignaturas asi join matricular m on asi.codigo = m.asignatura join alumnos al on m.alumno = al.dni
group by asi.nombre
having count(distinct al.cmun)<2
union
select  asi.nombre
from    asignaturas asi
where   asi.codigo not in   (select m.asignatura
                            from    matricular m);
select * from sol_3_22;













