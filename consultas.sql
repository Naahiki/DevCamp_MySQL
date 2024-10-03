-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS devcamp_project_schema;
USE devcamp_project_schema;

-- Crear la tabla de profesores
CREATE TABLE IF NOT EXISTS professors (
    professor_id INT PRIMARY KEY,
    professor_name VARCHAR(100) NOT NULL
);

-- Crear la tabla de estudiantes
CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL
);

-- Crear la tabla de cursos
CREATE TABLE IF NOT EXISTS courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES professors(professor_id)
);

-- Crear la tabla de calificaciones
CREATE TABLE IF NOT EXISTS grades (
    grade_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade DECIMAL(5, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insertar datos de ejemplo
-- Profesores
INSERT INTO professors (professor_id, professor_name) VALUES
(1, 'Dra. García Pérez'),
(2, 'Dr. López Martínez'),
(3, 'Dra. Fernández Gómez'),
(4, 'Dr. Rodríguez Sánchez'),
(5, 'Dra. Martínez Ruiz'),
(6, 'Dr. Ramírez González'),
(7, 'Dra. Ortiz Márquez');

-- Estudiantes
INSERT INTO students (student_id, student_name) VALUES
(1, 'Alicia González'),
(2, 'Benjamín Torres'),
(3, 'Carla Ramírez'),
(4, 'Daniela Morales'),
(5, 'Eduardo Silva'),
(6, 'Fernanda Díaz'),
(7, 'Gabriel Castro'),
(8, 'Helena Romero'),
(9, 'Iván Navarro'),
(10, 'Julieta Herrera'),
(11, 'Laura Sánchez'),
(12, 'Marta Suárez'),
(13, 'Pedro Gutiérrez'),
(14, 'Raúl Pérez');

-- Cursos
INSERT INTO courses (course_id, course_name, professor_id) VALUES
(1, 'Matemáticas', 1),
(2, 'Física', 2),
(3, 'Química', 3),
(4, 'Biología', 4),
(5, 'Historia', 5),
(6, 'Programación ', 6),
(7, 'Ingeniería de Software', 7),
(8, 'Historia Contemporánea', 5),
(9, 'Álgebra Lineal', 1),
(10, 'Filosofía Moderna', 4);


-- Calificaciones
INSERT INTO grades (grade_id, student_id, course_id, grade) VALUES
(1, 1, 1, 88.50),
(2, 1, 2, 92.00),
(3, 2, 1, 74.25),
(4, 2, 3, 85.75),
(5, 3, 2, 90.00),
(6, 3, 3, 78.50),
(7, 4, 1, 82.00),
(8, 4, 4, 91.25),
(9, 5, 2, 69.50),
(10, 5, 5, 88.00),
(11, 6, 3, 95.00),
(12, 6, 4, 89.75),
(13, 7, 1, 76.00),
(14, 7, 5, 84.50),
(15, 8, 2, 93.00),
(16, 8, 4, 87.25),
(17, 9, 3, 80.50),
(18, 9, 5, 77.75),
(19, 10, 1, 85.00),
(20, 10, 2, 90.50),
(21, 1, 9, 82.50),
(22, 1, 6, 89.00),
(23, 2, 9, 78.25),
(24, 3, 8, 92.00),
(25, 3, 7, 85.50),
(26, 4, 6, 87.75),
(27, 4, 10, 90.50),
(28, 5, 9, 75.25),
(29, 6, 10, 84.00),
(30, 6, 8, 91.00),
(31, 7, 7, 88.50),
(32, 7, 9, 73.50),
(33, 8, 6, 95.75),
(34, 8, 7, 90.00),
(35, 9, 8, 77.25),
(36, 10, 10, 85.00),
(37, 11, 1, 83.50),
(38, 11, 2, 90.75),
(39, 12, 6, 88.00),
(40, 13, 5, 89.50),
(41, 14, 4, 92.50);

-- Consultas SQL requeridas
-- Promedio de calificaciones por profesor
SELECT p.professor_name, AVG(g.grade) AS average_grade
FROM grades g
JOIN courses c ON g.course_id = c.course_id
JOIN professors p ON c.professor_id = p.professor_id
GROUP BY p.professor_name;

-- Mejores calificaciones de cada estudiante
SELECT s.student_name, MAX(g.grade) AS top_grade
FROM grades g
JOIN students s ON g.student_id = s.student_id
GROUP BY s.student_name;

-- Ordenar estudiantes por los cursos en los que están inscritos
SELECT s.student_name, c.course_name
FROM students s
JOIN grades g ON s.student_id = g.student_id
JOIN courses c ON g.course_id = c.course_id
ORDER BY s.student_name, c.course_name;

-- Resumen de cursos y sus calificaciones medias, ordenado de más difícil a más fácil
SELECT c.course_name, AVG(g.grade) AS average_grade
FROM courses c
JOIN grades g ON c.course_id = g.course_id
GROUP BY c.course_name
ORDER BY average_grade ASC;

--  Encontrar qué estudiante y profesor tienen más cursos en común
SELECT s.student_name, p.professor_name, COUNT(c.course_id) AS common_courses
FROM students s
JOIN grades g ON s.student_id = g.student_id
JOIN courses c ON g.course_id = c.course_id
JOIN professors p ON c.professor_id = p.professor_id
GROUP BY s.student_name, p.professor_name
ORDER BY common_courses DESC
LIMIT 1;



