# Prueba de Fundamentos de Bases de Datos Relacionales

Este proyecto corresponde a una prueba en la cual se validan los conocimientos de SQL y bases de datos relacionales. A continuación se detallan los requerimientos y pasos a seguir para completar la evaluación.
Descripción de la prueba

La prueba consiste en realizar las siguientes actividades:

  * Modelo de datos: Crear las tablas necesarias respetando las claves primarias, foráneas y los tipos de datos.
  * Inserción de datos:
  * Insertar 5 películas.
  * Insertar 5 etiquetas (tags), asignando etiquetas a las películas de acuerdo a las especificaciones.
  * Consultas SQL:
        Contar el número de etiquetas asociadas a cada película (mostrar 0 si no tiene ninguna).
  * Manejo de preguntas y respuestas:
        Insertar registros en las tablas de preguntas y respuestas, según las condiciones especificadas.
        Contar las respuestas correctas por usuario y por pregunta.
  * Borrado en cascada: Implementar la funcionalidad para borrar en cascada las respuestas al eliminar un usuario.
  * Restricciones:
        Agregar restricciones para evitar que se inserten usuarios menores de 18 años.
        Alterar la tabla de usuarios para incluir un campo de correo electrónico único.
        
## Estructura de la Base de Datos

El sistema está compuesto por varias tablas interrelacionadas que permiten gestionar la información de:

  * Películas: Almacena información sobre las películas disponibles.
  * Etiquetas (Tags): Palabras clave asociadas a las películas.
  * Usuarios: Información de los usuarios que interactúan con el sistema.
  * Preguntas y Respuestas: Almacena las preguntas del sistema y las respuestas de los usuarios, incluyendo respuestas correctas e incorrectas.

## Contenido del archivo pf.sql

El archivo incluye las siguientes secciones:

1. Creación de Tablas:
  ```peliculas```: Define las películas con sus atributos como título, año, etc.
  ```tags```: Contiene las etiquetas asociadas a las películas.
  ```peliculas_tags```: Tabla intermedia que relaciona películas con etiquetas (relación muchos a muchos).
  ```usuarios```: Información básica de los usuarios, incluyendo restricciones para evitar registros de menores de 18 años.
  ```preguntas```: Almacena las preguntas del sistema.
  ```respuestas```: Almacena las respuestas dadas por los usuarios, incluyendo si fueron correctas o incorrectas.

2. Inserción de Datos:
   Inserta 5 películas y 5 etiquetas, asociando etiquetas a películas de manera específica.
   Inserta registros en las tablas preguntas y respuestas según las reglas establecidas.

3. Consultas SQL:
   Contar etiquetas por película: Consulta que cuenta cuántas etiquetas están asociadas a cada película.
   Respuestas correctas por usuario: Consulta que cuenta cuántas respuestas correctas ha dado cada usuario, independientemente de la pregunta.
   Respuestas correctas por pregunta: Consulta que cuenta cuántos usuarios respondieron correctamente cada pregunta.

4. Manejo de Restricciones:
   Restricción para evitar el registro de usuarios menores de 18 años.
   Alteración de la tabla usuarios para agregar el campo email con la restricción de ser único.

5. Borrado en Cascada:
   Implementación del borrado en cascada en la tabla de respuestas al eliminar un usuario.

## Requisitos

PostgreSQL instalado.
El archivo ```pf.sql``` debe ser ejecutado en un entorno PostgreSQL para crear las tablas, insertar los datos y ejecutar las consultas.
