# 🎓 Sistema de Gestión Académica – Base de Datos PostgreSQL

## 📌 Descripción del proyecto

Este proyecto consiste en el diseño e implementación de una base de datos relacional para gestionar la información académica de un centro de formación.

El objetivo es centralizar y estructurar la información procedente de diferentes archivos CSV, integrando los datos de alumnos, profesores, promociones, campus, modalidades, proyectos y calificaciones en un único modelo relacional.

La solución se ha desarrollado utilizando **PostgreSQL y SQL**, aplicando conceptos de modelado de bases de datos, normalización, claves primarias y foráneas, relaciones entre entidades y transformación e integración de datos.

## 🛠️ Tecnologías utilizadas

- **PostgreSQL:** Sistema gestor de bases de datos relacionales.
- **SQL:** Creación, consulta y manipulación de datos.
- **pgAdmin:** Administración y gestión de la base de datos.
- **Docker:** Ejecución de PostgreSQL en un contenedor.
- **CSV:** Archivos utilizados como fuente de datos.

## 🗄️ Diseño de la base de datos

El diseño de la base de datos se divide en dos fases: el modelado conceptual mediante el Modelo Entidad-Relación (MER) y su posterior transformación en un modelo relacional.

### 1. Modelo Entidad-Relación (MER)

El Modelo Entidad-Relación representa el diseño conceptual de la base de datos. En él se identifican las entidades principales, sus atributos y las relaciones existentes entre ellas, junto con sus respectivas cardinalidades.

El modelo contempla las siguientes entidades:

- **ROL:** representa los diferentes roles de las personas.
- **PERSONA:** almacena los datos de alumnos y profesores.
- **CAMPUS:** identifica los campus del centro de formación.
- **PROMOCION:** representa las distintas promociones y su fecha de comienzo.
- **MODALIDAD:** identifica las modalidades formativas.
- **VERTICAL:** representa las áreas formativas.
- **EDICION:** representa una edición formativa y relaciona campus, promoción, modalidad y vertical.
- **PROYECTO:** identifica los proyectos formativos asociados a una vertical.

También se definen las siguientes relaciones:

| Relación | Cardinalidad | Descripción |
|---|---|---|
| TIENE_ROL | 1:N | Un rol puede estar asociado a varias personas. |
| SE_INSCRIBE_EN | N:M | Una persona puede inscribirse en varias ediciones y una edición puede tener varias personas inscritas. |
| SE_IMPARTE_EN | 1:N | Un campus puede tener varias ediciones. |
| CORRESPONDE_A | 1:N | Una promoción puede estar asociada a varias ediciones. |
| SE_CURSA_EN | 1:N | Una modalidad puede estar asociada a varias ediciones. |
| ES_DE_VERTICAL | 1:N | Una vertical puede estar asociada a varias ediciones. |
| TIENE_PROYECTO | 1:N | Una vertical puede tener varios proyectos. |
| ES_EVALUADO_EN | N:M | Una persona puede ser evaluada en diferentes proyectos y un proyecto puede evaluar a varias personas. |

La relación `ES_EVALUADO_EN` incorpora el atributo `calificacion`, que almacena el resultado obtenido por cada persona en cada proyecto.

**Diagrama del Modelo Entidad-Relación:**

![Modelo Entidad-Relación](docs/mer.png)

### 2. Modelo relacional

A partir del modelo conceptual se desarrolla el modelo relacional, transformando las entidades y relaciones en tablas, claves primarias y claves foráneas.

La base de datos está formada por 10 tablas:

| Tabla | Descripción |
|---|---|
| **Persona** | Almacena la información de alumnos y profesores, incluyendo nombre, email y rol. |
| **Rol** | Contiene los diferentes roles que pueden tener las personas. |
| **Campus** | Almacena los distintos campus del centro de formación. |
| **Promocion** | Registra las promociones y sus fechas de comienzo. |
| **Vertical** | Identifica las diferentes áreas formativas. |
| **Modalidad** | Recoge las modalidades de formación disponibles. |
| **Edicion** | Relaciona un campus, una promoción, una vertical y una modalidad para identificar una edición formativa. |
| **Inscripcion** | Relaciona a las personas con las ediciones en las que participan. |
| **Proyecto** | Almacena los proyectos formativos asociados a cada vertical. |
| **Calificacion** | Registra las calificaciones obtenidas por las personas en los diferentes proyectos. |

Las tablas `Inscripcion` y `Calificacion` permiten implementar las relaciones muchos a muchos (N:M) del modelo conceptual.

**Diagrama del modelo relacional:**

![Modelo relacional](docs/diagrama_entidad_relacion.png)

## ⚙️ Funcionamiento del proyecto

El proceso de construcción de la base de datos se divide en diferentes etapas:

### 1. Carga de datos (Staging)

Se crean tablas temporales para importar los archivos CSV originales mediante la instrucción `COPY`.

Los archivos utilizados son:

- `claustro.csv`
- `clase_1.csv`
- `clase_2.csv`
- `clase_3.csv`
- `clase_4.csv`

Estas tablas temporales permiten trabajar con los datos originales antes de incorporarlos al modelo relacional definitivo.

### 2. Creación de tablas y generación de identificadores

Se crean las tablas definitivas utilizando `CREATE TABLE IF NOT EXISTS`.

Para generar identificadores únicos se utilizan secuencias (`CREATE SEQUENCE`), combinadas con prefijos alfanuméricos:

| Entidad | Prefijo | Ejemplo |
|---|---|---|
| Persona | p | p1 |
| Rol | r | r1 |
| Campus | c | c1 |
| Promoción | pr | pr1 |
| Vertical | v | v1 |
| Modalidad | m | m1 |
| Edición | e | e1 |
| Inscripción | i | i1 |
| Proyecto | pro | pro1 |
| Calificación | cal | cal1 |

### 3. Transformación e integración de datos

Una vez cargados los datos originales, se realizan diferentes operaciones SQL para integrar la información:

- `SELECT DISTINCT`: obtiene valores únicos para poblar las tablas maestras.
- `UNION`: combina la información de las diferentes clases.
- `LEFT JOIN` y `JOIN`: permiten relacionar los datos entre las tablas temporales y las definitivas.
- `ON CONFLICT DO NOTHING`: evita insertar registros que ya existen en tablas con restricciones de unicidad.
- `TO_DATE`: transforma las fechas originales al tipo `DATE`.

### 4. Construcción de las relaciones

Se establecen las relaciones entre las entidades mediante claves foráneas (`FOREIGN KEY`).

Se construyen especialmente las relaciones entre personas, ediciones, inscripciones, proyectos y calificaciones, permitiendo consultar conjuntamente toda la información académica.

### 5. Gestión de calificaciones

Los datos originales contienen las calificaciones de diferentes proyectos en columnas independientes:

- Proyecto_HLF
- Proyecto_EDA
- Proyecto_BBDD
- Proyecto_ML
- Proyecto_Deployment

Mediante consultas SQL y la utilización de `UNION`, se transforman estas columnas en registros individuales dentro de la tabla `Calificacion`.

De esta forma, cada calificación queda asociada a una persona y a su correspondiente proyecto mediante sus claves foráneas.

## 📂 Estructura del proyecto

La organización del repositorio es la siguiente:

```text
Sistema-Gestion-Academica/
│
├── README.md
│
├── database/
│   └── creacion_y_carga.sql
│
├── data/
│   ├── claustro.csv
│   ├── clase_1.csv
│   ├── clase_2.csv
│   ├── clase_3.csv
│   └── clase_4.csv
│
└── docs/
    ├── mer.png
    └── diagrama_entidad_relacion.png
```

## 🚀 Instalación y ejecución

### Requisitos previos

- Docker.
- PostgreSQL.
- pgAdmin (opcional, para la administración visual).
- Los archivos CSV originales.

### Pasos de ejecución

**1. Levantar PostgreSQL mediante Docker**

```bash
docker run --name postgres-demo \
  -e POSTGRES_PASSWORD=tu_password \
  -p 5432:5432 \
  -d postgres
```

**2. Conectar con la base de datos**

Desde pgAdmin, crear una conexión al servidor PostgreSQL utilizando los siguientes parámetros:

- Host: `localhost`
- Port: `5432`
- Usuario: `postgres`
- Contraseña: la definida al crear el contenedor.

**3. Crear la base de datos**

Crear una nueva base de datos para el proyecto desde pgAdmin.

**4. Preparar los archivos CSV**

Los archivos deben estar disponibles para PostgreSQL en las rutas utilizadas por las instrucciones `COPY` del script.

Si se utiliza Docker, será necesario copiar los archivos al contenedor o configurar un volumen para que PostgreSQL pueda acceder a ellos.

**5. Ejecutar el script SQL**

Ejecutar el script de creación y carga de datos en una misma sesión, ya que utiliza tablas temporales (`CREATE TEMP TABLE`).

El script se encarga de crear las tablas definitivas, importar los datos y establecer las relaciones entre las entidades.

## 🎯 Objetivos de aprendizaje

Este proyecto permite poner en práctica diferentes conceptos relacionados con el diseño y la gestión de bases de datos:

- Diseño de modelos entidad-relación.
- Transformación del modelo conceptual al modelo relacional.
- Normalización de bases de datos relacionales.
- Definición de claves primarias y foráneas.
- Gestión de restricciones de unicidad.
- Creación y utilización de secuencias.
- Importación de datos desde archivos CSV.
- Transformación e integración de datos mediante SQL.
- Consultas con diferentes tipos de `JOIN`.
- Gestión de relaciones entre múltiples entidades.
- Uso de PostgreSQL en entornos Docker.

## 👨‍💻 Autor

Proyecto desarrollado como ejercicio práctico de diseño e implementación de bases de datos relacionales, utilizando PostgreSQL y SQL.
