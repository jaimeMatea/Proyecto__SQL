----------------CREACION TABLA E INSERCION EN TABLA ROL-----------------------
CREATE TEMP TABLE claustro (
    Nombre TEXT,
    Rol TEXT,
    Vertical TEXT,
    Promocion TEXT,
    Campus TEXT,
    Modalidad TEXT
);

COPY claustro (
    Nombre,
    Rol,
    Vertical,
    Promocion,
    Campus,
    Modalidad
)
FROM '/tmp/claustro.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ';'
);

select * from claustro;

CREATE SEQUENCE IF NOT EXISTS rol_id_seq START 1;
CREATE TABLE IF NOT EXISTS Rol (
    id_rol VARCHAR(10) PRIMARY KEY
        DEFAULT ('r' || nextval('rol_id_seq')),
    Rol VARCHAR(150) UNIQUE
);

INSERT INTO Rol (Rol)
SELECT DISTINCT Rol
FROM claustro
WHERE Rol IS NOT NULL
ON CONFLICT (Rol) DO NOTHING;

select * from Rol;


----------------CREACION TABLA E INSERCION EN TABLA PERSONA-----------------------
CREATE TEMP TABLE clase_1 (
    Nombre TEXT,
    Email TEXT,
    Promocion TEXT,
    Fecha_comienzo TEXT,
    Campus TEXT,
    Proyecto_HLF TEXT,
    Proyecto_EDA TEXT,
    Proyecto_BBDD TEXT,
    Proyecto_ML TEXT,
    Proyecto_Deployment TEXT
);

CREATE TEMP TABLE clase_2 (
    Nombre TEXT,
    Email TEXT,
    Promocion TEXT,
    Fecha_comienzo TEXT,
    Campus TEXT,
    Proyecto_HLF TEXT,
    Proyecto_EDA TEXT,
    Proyecto_BBDD TEXT,
    Proyecto_ML TEXT,
    Proyecto_Deployment TEXT
);

CREATE TEMP TABLE clase_3 (
    Nombre TEXT,
    Email TEXT,
    Promocion TEXT,
    Fecha_comienzo TEXT,
    Campus TEXT,
    Proyecto_HLF TEXT,
    Proyecto_EDA TEXT,
    Proyecto_BBDD TEXT,
    Proyecto_ML TEXT,
    Proyecto_Deployment TEXT
);

CREATE TEMP TABLE clase_4 (
    Nombre TEXT,
    Email TEXT,
    Promocion TEXT,
    Fecha_comienzo TEXT,
    Campus TEXT,
    Proyecto_HLF TEXT,
    Proyecto_EDA TEXT,
    Proyecto_BBDD TEXT,
    Proyecto_ML TEXT,
    Proyecto_Deployment TEXT
);

COPY clase_1 (
    Nombre,
    Email,
    Promocion,
    Fecha_comienzo,
    Campus,
    Proyecto_HLF,
    Proyecto_EDA,
    Proyecto_BBDD,
    Proyecto_ML,
    Proyecto_Deployment
)
FROM '/tmp/clase_1.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ';'
);

COPY clase_2 (
    Nombre,
    Email,
    Promocion,
    Fecha_comienzo,
    Campus,
    Proyecto_HLF,
    Proyecto_EDA,
    Proyecto_BBDD,
    Proyecto_ML,
    Proyecto_Deployment
)
FROM '/tmp/clase_2.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ';'
);

COPY clase_3 (
    Nombre,
    Email,
    Promocion,
    Fecha_comienzo,
    Campus,
    Proyecto_HLF,
    Proyecto_EDA,
    Proyecto_BBDD,
    Proyecto_ML,
    Proyecto_Deployment
)
FROM '/tmp/clase_3.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ';'
);

COPY clase_4 (
    Nombre,
    Email,
    Promocion,
    Fecha_comienzo,
    Campus,
    Proyecto_HLF,
    Proyecto_EDA,
    Proyecto_BBDD,
    Proyecto_ML,
    Proyecto_Deployment
)
FROM '/tmp/clase_4.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ';'
);

select * from clase_1;

CREATE SEQUENCE IF NOT EXISTS persona_id_seq START 1;
CREATE TABLE IF NOT EXISTS Persona (
    id_persona VARCHAR(10) PRIMARY KEY
        DEFAULT ('p' || nextval('persona_id_seq')),
    Email VARCHAR(150),
    Nombre VARCHAR(100),
    id_rol VARCHAR(10) REFERENCES Rol(id_rol)
);

INSERT INTO Persona (Email, Nombre, id_rol)
SELECT c.Email, c.Nombre, r.id_rol
FROM clase_1 c
LEFT JOIN claustro cl
    ON c.Nombre = cl.Nombre
LEFT JOIN Rol r
    ON cl.Rol = r.Rol;

INSERT INTO Persona (Email, Nombre, id_rol)
SELECT c.Email, c.Nombre, r.id_rol
FROM clase_2 c
LEFT JOIN claustro cl
    ON c.Nombre = cl.Nombre
LEFT JOIN Rol r
    ON cl.Rol = r.Rol;

INSERT INTO Persona (Email, Nombre, id_rol)
SELECT c.Email, c.Nombre, r.id_rol
FROM clase_3 c
LEFT JOIN claustro cl
    ON c.Nombre = cl.Nombre
LEFT JOIN Rol r
    ON cl.Rol = r.Rol;

INSERT INTO Persona (Email, Nombre, id_rol)
SELECT c.Email, c.Nombre, r.id_rol
FROM clase_4 c
LEFT JOIN claustro cl
    ON c.Nombre = cl.Nombre
LEFT JOIN Rol r
    ON cl.Rol = r.Rol;

INSERT INTO Persona (Nombre, id_rol)
SELECT DISTINCT cl.Nombre, r.id_rol
FROM claustro cl
LEFT JOIN Rol r
    ON cl.Rol = r.Rol;

select * from Persona;


----------------CREACION TABLA E INSERCION EN TABLA CAMPUS-----------------------
CREATE SEQUENCE IF NOT EXISTS campus_id_seq START 1
CREATE TABLE IF NOT EXISTS Campus (
    id_campus VARCHAR(10) PRIMARY KEY
        DEFAULT ('c' || nextval('campus_id_seq')),
    Campus VARCHAR(150) UNIQUE
);

INSERT INTO Campus (Campus)
SELECT DISTINCT Campus
FROM claustro
WHERE Campus IS NOT NULL
ON CONFLICT (Campus) DO NOTHING;

INSERT INTO Campus (Campus)
SELECT DISTINCT Campus
FROM clase_1
WHERE Campus IS NOT NULL
ON CONFLICT (Campus) DO NOTHING;

INSERT INTO Campus (Campus)
SELECT DISTINCT Campus
FROM clase_2
WHERE Campus IS NOT NULL
ON CONFLICT (Campus) DO NOTHING;

INSERT INTO Campus (Campus)
SELECT DISTINCT Campus
FROM clase_3
WHERE Campus IS NOT NULL
ON CONFLICT (Campus) DO NOTHING;

INSERT INTO Campus (Campus)
SELECT DISTINCT Campus
FROM clase_4
WHERE Campus IS NOT NULL
ON CONFLICT (Campus) DO NOTHING;

select * from Campus;


----------------CREACION TABLA E INSERCION EN TABLA VERTICAL-----------------------
CREATE SEQUENCE IF NOT EXISTS vertical_id_seq START 1;
CREATE TABLE IF NOT EXISTS Vertical (
    id_vertical VARCHAR(10) PRIMARY KEY
        DEFAULT ('v' || nextval('vertical_id_seq')),
    Vertical VARCHAR(150) UNIQUE
);

INSERT INTO Vertical (Vertical)
SELECT DISTINCT Vertical
FROM claustro
WHERE Vertical IS NOT NULL
ON CONFLICT (Vertical) DO NOTHING;

select * from Vertical;


----------------CREACION TABLA E INSERCION EN TABLA MODALIDAD-----------------------
CREATE SEQUENCE IF NOT EXISTS modalidad_id_seq START 1;
CREATE TABLE IF NOT EXISTS Modalidad (
    id_modalidad VARCHAR(10) PRIMARY KEY
        DEFAULT ('m' || nextval('modalidad_id_seq')),
    Modalidad VARCHAR(150) UNIQUE
);

INSERT INTO Modalidad (Modalidad)
SELECT DISTINCT Modalidad
FROM claustro
WHERE Modalidad IS NOT NULL
ON CONFLICT (Modalidad) DO NOTHING;

select * from Modalidad;


----------------CREACION TABLA E INSERCION EN TABLA PROMOCION-----------------------
CREATE SEQUENCE IF NOT EXISTS promocion_id_seq START 1;
CREATE TABLE IF NOT EXISTS Promocion (
    id_promocion VARCHAR(10) PRIMARY KEY
        DEFAULT ('pr' || nextval('promocion_id_seq')),
    Promocion VARCHAR(150) UNIQUE,
    Fecha_comienzo DATE
);

INSERT INTO Promocion (Promocion, Fecha_comienzo)
SELECT Promocion, MAX(TO_DATE(Fecha_comienzo, 'DD/MM/YYYY'))
FROM (
    SELECT Promocion, Fecha_comienzo FROM clase_1
    UNION
    SELECT Promocion, Fecha_comienzo FROM clase_2
    UNION
    SELECT Promocion, Fecha_comienzo FROM clase_3
    UNION
    SELECT Promocion, Fecha_comienzo FROM clase_4
    UNION
    SELECT Promocion, NULL AS Fecha_comienzo FROM claustro
) p_todas
WHERE Promocion IS NOT NULL
GROUP BY Promocion
ON CONFLICT (Promocion) DO NOTHING;

select * from Promocion;


----------------CREACION TABLA E INSERCION EN TABLA EDICION-----------------------
CREATE SEQUENCE IF NOT EXISTS edicion_id_seq START 1;
CREATE TABLE IF NOT EXISTS Edicion (
    id_edicion VARCHAR(10) PRIMARY KEY
        DEFAULT ('e' || nextval('edicion_id_seq')),
    id_campus VARCHAR(10) REFERENCES Campus(id_campus),
    id_promocion VARCHAR(10) REFERENCES Promocion(id_promocion),
    id_vertical VARCHAR(10) REFERENCES Vertical(id_vertical),
    id_modalidad VARCHAR(10) REFERENCES Modalidad(id_modalidad)
);

INSERT INTO Edicion (id_campus, id_promocion, id_vertical, id_modalidad)
SELECT DISTINCT ca.id_campus, p.id_promocion, v.id_vertical, m.id_modalidad
FROM (
    SELECT Campus, Promocion FROM clase_1
    UNION
    SELECT Campus, Promocion FROM clase_2
    UNION
    SELECT Campus, Promocion FROM clase_3
    UNION
    SELECT Campus, Promocion FROM clase_4
) clases
LEFT JOIN Campus ca 
    ON clases.Campus = ca.Campus
LEFT JOIN Promocion p 
    ON clases.Promocion = p.Promocion
LEFT JOIN claustro cl 
    ON clases.Campus = cl.Campus 
   AND clases.Promocion = cl.Promocion
LEFT JOIN Vertical v 
    ON cl.Vertical = v.Vertical
LEFT JOIN Modalidad m 
    ON cl.Modalidad = m.Modalidad;

select * from Edicion;


----------------CREACION TABLA E INSERCION EN TABLA INSCRIPCION-----------------------
CREATE SEQUENCE IF NOT EXISTS inscripcion_id_seq START 1;
CREATE TABLE IF NOT EXISTS Inscripcion (
    id_inscripcion VARCHAR(10) PRIMARY KEY
        DEFAULT ('i' || nextval('inscripcion_id_seq')),
    id_persona VARCHAR(10) REFERENCES Persona(id_persona),
    id_edicion VARCHAR(10) REFERENCES Edicion(id_edicion)
);

INSERT INTO Inscripcion (id_persona, id_edicion)
SELECT DISTINCT per.id_persona, ed.id_edicion
FROM (
    SELECT Nombre, Campus, Promocion FROM clase_1
    UNION
    SELECT Nombre, Campus, Promocion FROM clase_2
    UNION
    SELECT Nombre, Campus, Promocion FROM clase_3
    UNION
    SELECT Nombre, Campus, Promocion FROM clase_4
    UNION
    SELECT Nombre, Campus, Promocion FROM claustro 
    WHERE Nombre IS NOT NULL
) clases
JOIN Persona per 
    ON clases.Nombre = per.Nombre
JOIN Campus ca 
    ON clases.Campus = ca.Campus
JOIN Promocion p 
    ON clases.Promocion = p.Promocion
JOIN Edicion ed 
    ON ca.id_campus = ed.id_campus 
   AND p.id_promocion = ed.id_promocion;

select * from Inscripcion;


----------------CREACION TABLA E INSERCION EN TABLA PROYECTO-----------------------
CREATE SEQUENCE IF NOT EXISTS proyecto_id_seq START 1;
CREATE TABLE IF NOT EXISTS Proyecto (
    id_proyecto VARCHAR(10) PRIMARY KEY
        DEFAULT ('pro' || nextval('proyecto_id_seq')),
    nombre_proyecto VARCHAR(150) UNIQUE,
    id_vertical VARCHAR(10) REFERENCES Vertical(id_vertical)
);

INSERT INTO Proyecto (nombre_proyecto, id_vertical)
SELECT temp.nombre_proyecto, v.id_vertical
FROM (
    VALUES ('Proyecto_HLF'),('Proyecto_EDA'),('Proyecto_BBDD'),('Proyecto_ML'),('Proyecto_Deployment')
) AS temp(nombre_proyecto)
LEFT JOIN Vertical v 
    ON v.Vertical = 'DS'
ON CONFLICT (nombre_proyecto) DO NOTHING;

select * from Proyecto;


----------------CREACION TABLA E INSERCION EN TABLA CALIFICACION-----------------------
CREATE SEQUENCE IF NOT EXISTS calificacion_id_seq START 1;
CREATE TABLE IF NOT EXISTS Calificacion (
    id_calificacion VARCHAR(10) PRIMARY KEY
        DEFAULT ('cal' || nextval('calificacion_id_seq')),
    id_persona VARCHAR(10) REFERENCES Persona(id_persona),
    id_proyecto VARCHAR(10) REFERENCES Proyecto(id_proyecto),
    calificacion VARCHAR(50)
);

WITH clases AS (
    SELECT Nombre, Proyecto_HLF, Proyecto_EDA, Proyecto_BBDD, Proyecto_ML, Proyecto_Deployment FROM clase_1
    UNION
    SELECT Nombre, Proyecto_HLF, Proyecto_EDA, Proyecto_BBDD, Proyecto_ML, Proyecto_Deployment FROM clase_2
    UNION
    SELECT Nombre, Proyecto_HLF, Proyecto_EDA, Proyecto_BBDD, Proyecto_ML, Proyecto_Deployment FROM clase_3
    UNION
    SELECT Nombre, Proyecto_HLF, Proyecto_EDA, Proyecto_BBDD, Proyecto_ML, Proyecto_Deployment FROM clase_4
),
proyectos AS (
    SELECT Nombre, 'Proyecto_HLF' AS nombre_proyecto, Proyecto_HLF AS nota FROM clases
    UNION
    SELECT Nombre, 'Proyecto_EDA' AS nombre_proyecto, Proyecto_EDA AS nota FROM clases
    UNION
    SELECT Nombre, 'Proyecto_BBDD' AS nombre_proyecto, Proyecto_BBDD AS nota FROM clases
    UNION
    SELECT Nombre, 'Proyecto_ML' AS nombre_proyecto, Proyecto_ML AS nota FROM clases
    UNION
    SELECT Nombre, 'Proyecto_Deployment' AS nombre_proyecto, Proyecto_Deployment AS nota FROM clases
)
INSERT INTO Calificacion (id_persona, id_proyecto, calificacion)
SELECT p.id_persona, pro.id_proyecto, pp.nota
FROM proyectos pp
JOIN Persona p 
    ON pp.Nombre = p.Nombre
JOIN Proyecto pro 
    ON pp.nombre_proyecto = pro.nombre_proyecto
WHERE pp.nota IS NOT NULL AND pp.nota <> '';














































/*
INSERT INTO Edicion (Fecha_comienzo, id_campus, id_promocion, id_vertical, id_modalidad)
SELECT DISTINCT TO_DATE(c.Fecha_comienzo, 'DD/MM/YYYY'), ca.id_campus, p.id_promocion, v.id_vertical, m.id_modalidad
FROM clase_1 c
LEFT JOIN claustro cl
    ON c.Nombre = cl.Nombre
LEFT JOIN Campus ca
    ON c.Campus = ca.Campus
LEFT JOIN Promocion p
    ON c.Promocion = p.Promocion
LEFT JOIN Vertical v
    ON cl.Vertical = v.Vertical
LEFT JOIN Modalidad m
    ON cl.Modalidad = m.Modalidad;

INSERT INTO Edicion (Fecha_comienzo, id_campus, id_promocion, id_vertical, id_modalidad)
SELECT DISTINCT TO_DATE(c.Fecha_comienzo, 'DD/MM/YYYY'), ca.id_campus, p.id_promocion, v.id_vertical, m.id_modalidad
FROM clase_2 c
LEFT JOIN claustro cl
    ON c.Nombre = cl.Nombre
LEFT JOIN Campus ca
    ON c.Campus = ca.Campus
LEFT JOIN Promocion p
    ON c.Promocion = p.Promocion
LEFT JOIN Vertical v
    ON cl.Vertical = v.Vertical
LEFT JOIN Modalidad m
    ON cl.Modalidad = m.Modalidad;

INSERT INTO Edicion (Fecha_comienzo, id_campus, id_promocion, id_vertical, id_modalidad)
SELECT DISTINCT TO_DATE(c.Fecha_comienzo, 'DD/MM/YYYY'), ca.id_campus, p.id_promocion, v.id_vertical, m.id_modalidad
FROM clase_3 c
LEFT JOIN claustro cl
    ON c.Nombre = cl.Nombre
LEFT JOIN Campus ca
    ON c.Campus = ca.Campus
LEFT JOIN Promocion p
    ON c.Promocion = p.Promocion
LEFT JOIN Vertical v
    ON cl.Vertical = v.Vertical
LEFT JOIN Modalidad m
    ON cl.Modalidad = m.Modalidad;

INSERT INTO Edicion (Fecha_comienzo, id_campus, id_promocion, id_vertical, id_modalidad)
SELECT DISTINCT TO_DATE(c.Fecha_comienzo, 'DD/MM/YYYY'), ca.id_campus, p.id_promocion, v.id_vertical, m.id_modalidad
FROM clase_4 c
LEFT JOIN claustro cl
    ON c.Nombre = cl.Nombre
LEFT JOIN Campus ca
    ON c.Campus = ca.Campus
LEFT JOIN Promocion p
    ON c.Promocion = p.Promocion
LEFT JOIN Vertical v
    ON cl.Vertical = v.Vertical
LEFT JOIN Modalidad m
    ON cl.Modalidad = m.Modalidad;

INSERT INTO Edicion (Fecha_comienzo, id_campus, id_promocion, id_vertical, id_modalidad)
SELECT DISTINCT TO_DATE(c.Fecha_comienzo, 'DD/MM/YYYY'), ca.id_campus, p.id_promocion, v.id_vertical, m.id_modalidad
FROM claustro cl
LEFT JOIN clase_4 c
    ON c.Nombre = cl.Nombre
LEFT JOIN Campus ca
    ON cl.Campus = ca.Campus
LEFT JOIN Promocion p
    ON cl.Promocion = p.Promocion
LEFT JOIN Vertical v
    ON cl.Vertical = v.Vertical
LEFT JOIN Modalidad m
    ON cl.Modalidad = m.Modalidad;
*/



/*
CREATE SEQUENCE IF NOT EXISTS promocion_id_seq START 1;
CREATE TABLE IF NOT EXISTS Promocion (
    id_promocion VARCHAR(10) PRIMARY KEY
        DEFAULT ('pr' || nextval('promocion_id_seq')),
    Promocion VARCHAR(150) UNIQUE
);

INSERT INTO Promocion (Promocion)
SELECT DISTINCT Promocion
FROM claustro
WHERE Promocion IS NOT NULL
ON CONFLICT (Promocion) DO NOTHING;

INSERT INTO Promocion (Promocion)
SELECT DISTINCT Promocion
FROM clase_1
WHERE Promocion IS NOT NULL
ON CONFLICT (Promocion) DO NOTHING;

INSERT INTO Promocion (Promocion)
SELECT DISTINCT Promocion
FROM clase_2
WHERE Promocion IS NOT NULL
ON CONFLICT (Promocion) DO NOTHING;

INSERT INTO Promocion (Promocion)
SELECT DISTINCT Promocion
FROM clase_3
WHERE Promocion IS NOT NULL
ON CONFLICT (Promocion) DO NOTHING;

INSERT INTO Promocion (Promocion)
SELECT DISTINCT Promocion
FROM clase_4
WHERE Promocion IS NOT NULL
ON CONFLICT (Promocion) DO NOTHING;
*/

/*
CREATE SEQUENCE IF NOT EXISTS edicion_id_seq START 1;
CREATE TABLE IF NOT EXISTS Edicion (
    id_edicion VARCHAR(10) PRIMARY KEY
        DEFAULT ('e' || nextval('edicion_id_seq')),
    Fecha_comienzo DATE,
    id_campus VARCHAR(10) REFERENCES Campus(id_campus),
    id_promocion VARCHAR(10) REFERENCES Promocion(id_promocion),
    id_vertical VARCHAR(10) REFERENCES Vertical(id_vertical),
    id_modalidad VARCHAR(10) REFERENCES Modalidad(id_modalidad)
);

--Las combinaciones de Fecha_comienzo,id_campus e id_promocion que no tenga asociadas id_vertical y id_modalidad
--   se les asociará unas con todas las combinaciones de id_vertical e id_modalidad
--Al usar UNION eliminamos las filas duplicadas entre ellas antes de continuar
--Insertamos todas las combinaciones posibles que se pueden dar entre estos atributos
INSERT INTO Edicion (Fecha_comienzo, id_campus, id_promocion, id_vertical, id_modalidad)
SELECT DISTINCT TO_DATE(c_todas.Fecha_comienzo, 'DD/MM/YYYY'), ca.id_campus, p.id_promocion, v.id_vertical, m.id_modalidad
FROM (
    SELECT Fecha_comienzo, Campus, Promocion FROM clase_1
    UNION
    SELECT Fecha_comienzo, Campus, Promocion FROM clase_2
    UNION
    SELECT Fecha_comienzo, Campus, Promocion FROM clase_3
    UNION
    SELECT Fecha_comienzo, Campus, Promocion FROM clase_4
) c_todas
LEFT JOIN Campus ca 
    ON c_todas.Campus = ca.Campus
LEFT JOIN Promocion p 
    ON c_todas.Promocion = p.Promocion
LEFT JOIN claustro cl 
    ON c_todas.Campus = cl.Campus 
   AND c_todas.Promocion = cl.Promocion
LEFT JOIN Vertical v 
    ON cl.Vertical = v.Vertical
LEFT JOIN Modalidad m 
    ON cl.Modalidad = m.Modalidad;
*/

/*
CREATE SEQUENCE IF NOT EXISTS proyecto_id_seq START 1;
CREATE TABLE IF NOT EXISTS Proyecto (
    id_proyecto VARCHAR(10) PRIMARY KEY
        DEFAULT ('pro' || nextval('proyecto_id_seq')),
    nombre_proyecto VARCHAR(150) UNIQUE
);

INSERT INTO Proyecto (nombre_proyecto)
VALUES ('Proyecto_HLF'),('Proyecto_EDA'),('Proyecto_BBDD'),('Proyecto_ML'),('Proyecto_Deployment')
ON CONFLICT (nombre_proyecto) DO NOTHING;
*/