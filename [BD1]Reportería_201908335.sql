--CONSULTA 1--
select p.titulo as PELICULA, count(*) from inventario inv
inner join Pelicula p on p.id_pelicula = inv.id_pelicula
where p.titulo = 'SUGAR WONKA'
group by p.titulo
order by p.titulo;

--CONSULTA 2--
select cli.nombre as NOMBRE, cli.apellido as APELLIDO, sum(r.monto) as PAGO_Total from CLIENTE cli, Renta r
where r.id_cliente = cli.id_cliente
group by NOMBRE, APELLIDO
having count(*) >40
order by NOMBRE, APELLIDO;

--CONSULTA 3--
select distinct cli.nombre as NOMBRE, cli.apellido as APELLIDO, p.titulo as TITULO from CLIENTE cli
inner join renta r on r.id_cliente = cli.id_cliente
inner join empleado e on e.id_empleado = r.id_empleado
inner join tienda t on t.id_tienda = e.id_tienda
inner join inventario i on i.id_inventario = i.id_tienda
inner join pelicula p on p.id_pelicula = i.id_pelicula
where (to_number(to_char(r.fecha_retorno,'yyyymmdd')) - to_number(to_char(r.fecha_renta,'yyyymmdd'))) > p.dias_renta
and to_number(to_char(r.fecha_retorno,'yyyymmdd')) != 0
order by cli.nombre;


--CONSULTA 4--
select concat(concat(a.nombre,' '), a.apellido) as Nombre_Completo from Actor a
where a.apellido like '%son%' or a.apellido like '%Son%'
order by a.nombre;

--CONSULTA 5--
select apellido as Apellido, count(*) as Cantidad from Actor
where nombre in (select nombre from actor group by nombre having count(*)>1)
group by apellido
order by apellido;

--CONSULTA 6--
select distinct a.nombre as Nombre, a.apellido as Apellido, p.anio_lanzamiento as ANIO_LANZAMIENTO from Actor a
inner join PELICULA_ACTOR pa on pa.id_actor = a.id_actor
inner join Pelicula p on p.id_pelicula = pa.id_pelicula
where p.descripcion like '%Crocodile%' and p.descripcion like '%Shark%'
order by apellido asc;


--CONSULTA 7--
select c.nombre as Categoria, count(*) Cant_Peliculas from Categoria c
inner join PELICULA_CATEGORIA pc on pc.id_categoria = c.id_categoria
inner join Pelicula p on p.id_pelicula = pc.id_pelicula
group by c.nombre
having  count(*) between 55 and 65
order by Cant_Peliculas desc;


--CONSULTA 8--
select c.nombre as Categoria from Categoria c
inner join PELICULA_CATEGORIA pc on pc.id_categoria = c.id_categoria
inner join Pelicula p on p.id_pelicula = pc.id_pelicula
group by c.nombre
having  avg(p."COSTO_DAÑO"-p.costo_renta) > 17;


--CONSULTA 9--
select p.titulo as Titulo, a.nombre as Nombre, a.apellido as Apellido from pelicula p
inner join PELICULA_ACTOR pa on pa.id_pelicula = p.id_pelicula
inner join ACTOR a on a.id_actor = pa.id_actor
where a.nombre in (
    select a.nombre as Nombre from pelicula p
    inner join PELICULA_ACTOR pa on pa.id_pelicula = p.id_pelicula
    inner join ACTOR a on a.id_actor = pa.id_actor
    group by a.nombre
    having count(*) > 1
)
order by a.nombre, a.apellido, p.titulo;


--CONSULTA 10--
SELECT NOMBRES || ' ' || APELLIDOS
FROM (
		SELECT NOMBRE AS NOMBRES, apellido AS APELLIDOS FROM ACTOR 
		UNION
		SELECT NOMBRE AS NOMBRES, APELLIDO AS APELLIDOS FROM CLIENTE 
)
INNER JOIN (
		SELECT NOMBRE AS NOMBRE_ACTOR, APELLIDO AS APELLIDO_ACTOR 
		FROM ACTOR 
		WHERE actor.id_actor = 8
	)
	ON NOMBRES=NOMBRE_ACTOR
	WHERE APELLIDOS <>  APELLIDO_ACTOR;


--CONSULTA 11-- 
select p.nombre as PAIS, c.nombre as Cliente, count(*)/(
select count(*) as Total from cliente c
inner join renta r on r.id_cliente = c.id_cliente
inner join pais p on p.id_pais = c.id_pais
group by p.nombre
having p.nombre = 'Argentina'
) as Total from cliente c
inner join renta r on r.id_cliente = c.id_cliente
inner join pais p on p.id_pais = c.id_pais
group by p.nombre, c.nombre 
order by count(*) desc, p.nombre;

--CONSULTA 13--
select p.nombre as PAIS, c.nombre as Cliente, count(*) as Total from pais p
inner join cliente c on p.id_pais = c.id_pais
inner join renta r on r.id_cliente = c.id_cliente
inner join empleado e on e.id_empleado = r.id_empleado
inner join tienda t on t.id_tienda = e.id_tienda
inner join inventario inv on inv.id_tienda = t.id_tienda
inner join pelicula pel on pel.id_pelicula = inv.id_pelicula
group by p.nombre, c.nombre
order by p.nombre;


--CONSULTA 14-- Hacerla


--CONSULTA 15-- Hacerla


--CONSULTA 16-- Hacerla


--CONSULTA 17-- Hacerla


--CONSULTA 18-- Hacerla


--CONSULTA 19-- Hacerla


--CONSULTA 20-- Hacerla
select c.nombre as Ciudad, i.nombre as Idioma, '100%' as Porcentaje from ciudad c
inner join tienda t on t.id_ciudad = t.id_ciudad
inner join inventario inv on t.id_tienda = inv.id_tienda
inner join pelicula p on p.id_pelicula = inv.id_pelicula
inner join pelicula_idioma pi on pi.id_pelicula = p.id_pelicula
inner join idioma i on i.id_idioma = pi.id_idioma
group by c.nombre, i.nombre
order by c.nombre;