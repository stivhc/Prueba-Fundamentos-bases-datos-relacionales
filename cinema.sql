-- Parte 1
-- Crear base de datos cinema
CREATE DATABASE cinema;

-- Concertarse a la base de datos cinema
\c cinema;

-- Crear la tabla de películas
CREATE TABLE peliculas (
    id SERIAL PRIMARY KEY,  -- id es la clave primaria autoincremental
    nombre VARCHAR(255),  -- nombre de la película, campo obligatorio
    anno INT
);

-- Crear la tabla de tags (etiquetas)
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,  -- id es la clave primaria autoincremental
    tag VARCHAR(32)  -- nombre del tag, campo obligatorio
);

-- Crear la tabla intermedia para la relación N:M entre películas y tags
CREATE TABLE pelicula_tags (
    pelicula_id INT,  -- Clave foránea que referencia a la tabla peliculas
    tag_id INT,  -- Clave foránea que referencia a la tabla tags
    FOREIGN KEY (pelicula_id) REFERENCES peliculas(id),  -- Definir clave foránea para pelicula_id
    FOREIGN KEY (tag_id) REFERENCES tags(id)  -- Definir clave foránea para tag_id
);

-- Insertar 5 películas en la tabla peliculas
INSERT INTO peliculas (nombre, anno) VALUES 
('The Shining', 1980), ('The Lighthouse', 2019), ('The Silence of the Lambs', 1991), ('One Flew Over the Cuckoos Nest', 1975), ('Manchester by the Sea', 2016);

-- Insertar 5 tags en la tabla tags
INSERT INTO tags (tag) VALUES 
('Terror'), ('Comedia'), ('Drama'), ('Ciencia Ficción'), ('Suspenso');

-- Asociar tags a las películas: la primera película tiene 3 tags y la segunda tiene 2
INSERT INTO pelicula_tags (pelicula_id, tag_id) VALUES 
(1, 1), (1, 3), (1, 5),  -- Película 1 tiene 3 tags
(2, 1), (2, 5);  -- Película 2 tiene 2 tags

-- Contar la cantidad de tags asociados a cada película
SELECT peliculas.nombre, COUNT(peliculas_tags.tag_id) AS cantidad_tags
FROM peliculas
LEFT JOIN pelicula_tags ON peliculas.id = peliculas_tags.pelicula_id  -- LEFT JOIN para incluir películas sin tags
GROUP BY peliculas.nombre;  -- Agrupar por id y nombre de película para obtener el conteo de tags por cada película

-- Parte 2
-- Crear la tabla de usuarios
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    edad INT
);

-- Crear la tabla de preguntas
CREATE TABLE preguntas (
    id SERIAL PRIMARY KEY,
    pregunta VARCHAR(255),
    respuesta_correcta VARCHAR
);

-- Crear la tabla de respuestas
CREATE TABLE respuestas (
    id SERIAL PRIMARY KEY,
    respuesta VARCHAR(255),
    usuario_id INT,
    pregunta_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (pregunta_id) REFERENCES preguntas(id)
);

-- Insertar 5 preguntas en la tabla preguntas
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES 
('¿Qué es la justicia distributiva?', 'Se refiere a cómo se distribuyen los recursos, beneficios y cargas en una sociedad de manera justa o equitativa'),
('¿Cuál es el concepto de contrato social?', 'Es la idea de que las personas aceptan formar una sociedad y seguir ciertas reglas, a cambio de protección y beneficios por parte del gobierno o la comunidad'),
('¿Qué significa el principio de igualdad en filosofía social?', 'Que todas las personas deben ser tratadas de manera equitativa y tener los mismos derechos y oportunidades en la sociedad'),
('¿Qué es la socialización?', 'Proceso mediante el cual las personas aprenden y adoptan las normas, valores y comportamientos apropiados de su cultura o sociedad'),
('¿Qué es la estratificación social?', 'Sistema por el cual una sociedad organiza a sus miembros en categorías jerárquicas, como clases sociales, basadas en factores como la riqueza, el poder y el estatus.');

-- Insertar 5 usuarios en la tabla usuarios
INSERT INTO usuarios (nombre, edad) VALUES
('Fideo Fidel', '28'), ('Carlitos Lechuga', '24'), ('Illya Kuryakin', '37'), ('Quinta Pata del Pescado', '32'), ('Elba Surita', '25');

-- Agrega 5 registros a la tabla preguntas. La primera debe ser contectada correctamente por dos usuarios distintos, la pregunta 2 debe ser contestada correctamente por un usuario, los otros registros deben ser respuestas incorrectas
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id) VALUES
('Se refiere a cómo se distribuyen los recursos, beneficios y cargas en una sociedad de manera justa o equitativa', 1, 1),
('Se refiere a cómo se distribuyen los recursos, beneficios y cargas en una sociedad de manera justa o equitativa', 2, 1),
('Es la idea de que las personas aceptan formar una sociedad y seguir ciertas reglas, a cambio de protección y beneficios por parte del gobierno o la comunidad', 3, 2),
('Es socializar con gente', 1, 3),
('Gran cantidad de personas en una ciudad', 2, 4);

-- Contar la cantidad de respuestas correctas totales por usuario
SELECT usuario_nombre, COUNT(respuestas.id) AS respuestas_correctas
FROM usuarios
JOIN prespuestas ON usuarios.id = respuestas.usuario_id
JOIN preguntas ON preguntas.id = respuestas.pregunta_id AND respuestas.respuesta = preguntas.respuesta_correcta GROUP BY usuarios.nombre;

-- Contar cuántos usuarios respondieron correctamente cada pregunta
SELECT preguntas.pregunta, COUNT(DISTINCT respuestas.usuario_id) AS usuarios_respuesta_correcta
FROM preguntas
JOIN respuestas ON preguntas.id = respuestas.pregunta_id AND respuesta.respuesta = preguntas.respuesta_correcta
GROUP BY preguntas.pregunta;

-- Implementa borrado en cascada de las respuestas al borrar un usuario y borrar el primer usuario para probar la implementación.
-- PRIMERO ELIMINAR LA RESTRICCION FORANEA DEBIDO A LAS COMPLEJIDADES QUE TRAE CONSIGO
ALTER TABLE respuestas DROP CONSTRAINT respuestas_usuario_id_fkey;

-- Luego añadir modificación en la tabla respuestas pero que referencia al usuario
ALTER TABLE respuestas ADD CONSTRAINT respuestas_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES USUARIOS(ID) ON DELETE CASCADE; 

-- Eliminar el usuario 1
DELETE FROM usuarios WHERE id = 1;

-- CREAR RESTRICCION PARA QUE LOS USUARIOS SEAN SOLO MAYORES DE EDAD
ALTER TABLE usuarios ADD CONSTRAINT edad_minima CHECK (edad >=18);

--Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos
ALTER TABLE usuarios
ADD COLUMN email VARCHAR (255),
ADD CONSTRAINT email_unico UNIQUE (email);
