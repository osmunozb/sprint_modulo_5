-- Creación de la base de datos e ingreso a ella
CREATE DATABASE telovendo;
USE telovendo;
-- Creación de usuario con todos los privilegios
CREATE USER admintienda@localhost IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON telovendo TO admintienda@localhost;
-- creacion de la tabla telefono
 CREATE TABLE telefono (
 id_telefono INT primary KEY auto_increment,
 nombre_receptor varchar(20),
 telefono1 varchar(15),
 telefono2 varchar(15)
 );
 -- se insertar datos para la tabla telefono con sus respectivos valores
 INSERT INTO telefono (nombre_receptor, telefono1, telefono2) VALUES
('Juan Pérez', '+123456789', '+987654321'),
('María López', '+987654321', '+123456789'),
('Pedro Ramírez', '+555555555', '+111111111'),
('Ana Torres', '+999999999', '+888888888'),
('Luisa García', '+444444444', '+222222222');
 -- Se crea la tabla categoria con sus respectivas columnas
 create table categoria (
 id_categoria int primary key auto_increment,
 nombre varchar(30)
 );
 -- Se insertan valores para la categoria
INSERT INTO categoria (nombre) VALUES
('textil'),
('menaje'),
('tecnologia'),
('jugueteria'),
('materiales');
-- se crea la tabla proveedor con sus respectiuvas columnas
CREATE TABLE proveedor (
    id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre_representante VARCHAR(50),
    nombre_corporativo VARCHAR(50),
    correo_electronico VARCHAR(50),
    id_telefono int,
    id_categoria int,
    foreign key (id_telefono) references telefono(id_telefono),
    foreign key (id_categoria) references categoria(id_categoria)
);
-- Ingreso de 5 proveedores y visualización de la tabla
INSERT INTO proveedor(nombre_representante, nombre_corporativo, correo_electronico, id_telefono, id_categoria ) VALUES
('Juan Carlos', 'Juan Importaciones', 'juan@perezimportaciones.com',1,3),
('Ana Frank', 'electronic Ana','anaFrank@rodriguezmoda.com',2,3),
('Carlos Petacha', 'Petacha Elect', 'Petacha@sanchezelect.com',3,3),
('Juan Pérez', 'Pérez Importaciones', 'juan@perezimportaciones.com',1,1),
('Ana Rodríguez', 'Rodríguez Moda','ana@rodriguezmoda.com',2,2),
('Carlos Sánchez', 'Sánchez Elect', 'carlos@sanchezelect.com',3,3),
('Sofía García', 'García ltda', 'sofia@garcialdta.com',4,4),
('Javier Martínez', 'Martínez Hogar', 'javier@martinezhogar.com',5,5);
select * from proveedor;
-- Creación de tabla clientes, tiene su identificador como primary key y auto incremento para que no se repita.
-- Además se utilizó el VARCHAR en nombre, apellido y dirección para permitir letras, números y otros caracteres.
CREATE TABLE clientes(
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(20),
apellido VARCHAR(20),
direccion VARCHAR(50)
);
-- Ingreso de 5 clientes y visualización de la tabla
INSERT INTO clientes(nombre, apellido, direccion) VALUES
('Juan', 'Pérez', 'Calle 1 #123'),
('Ana', 'Gómez', 'Avenida 2 #456'),
('Luisa', 'Hernández', 'Calle 3 #789'),
('Carlos', 'García', 'Avenida 4 #1011'),
('María', 'Rodríguez', 'Calle 5 #1213')
;
SELECT*FROM clientes;
-- Creación de tabla productos, tiene su identificador como primary key y auto incremento para que no se repita.
-- Además se utilizó el VARCHAR en producto, categoría, proveedor y color para permitir letras, números y otros caracteres.
-- Se usa INT en stock y precio para ingresar números
CREATE TABLE productos(
id_producto INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(40),
stock INT,
precio INT,
color VARCHAR(20),
id_categoria int,
id_proveedor int,
foreign key (id_categoria) references categoria(id_categoria),
foreign key (id_proveedor) references proveedor(id_proveedor)
);
-- Ingreso de 10 productos y visualización de la tabla
INSERT INTO productos(nombre, stock, precio, color, id_categoria, id_proveedor ) VALUES
('Teléfono inteligente', 9, 500000, 'Negro', 3, 1),
('Cámara digital', 15, 250000, 'Plata', 3, 2),
('Ladrillo', 20, 15000, 'ladrillo',5,2 ),
('Auriculares bluetooth', 30, 50000, 'Negro',3,4),
('Reloj inteligente', 97, 150000, 'Blanco',3,5),
('Camiseta deportiva', 50, 19990, 'Azul', 1,3),
('Zapatos de cuero', 30, 40000, 'Marrón',1,5),
('platos', 23, 80000, 'Gris',2,2),
('Smart TV', 30, 300000, 'Negro', 3, 3),
('juguetesMaxSteel', 21, 400000, 'Gris',4,2)
;
SELECT*FROM productos;
-- Seleccionar la categoría que más se repite
SELECT categoria.nombre AS categoria, COUNT(*) AS repeticiones
FROM productos
JOIN categoria ON productos.id_categoria = categoria.id_categoria
GROUP BY categoria.nombre
ORDER BY repeticiones DESC
LIMIT 1;
-- Seleccionar los 3 primeros productos con mayor stock
SELECT nombre, stock FROM productos ORDER BY stock desc LIMIT 3;
-- Seleccionar el color mas común en la tienda
SELECT color, COUNT(color) AS color_productos FROM productos
GROUP BY color ORDER BY color_productos DESC LIMIT 1;
-- Seleccionar los proveedores con menor stock
select p.nombre_corporativo, Sum(pro.stock) as stock
from proveedor p
join productos pro ON p.id_proveedor = pro.id_proveedor
GROUP BY p.nombre_corporativo order by stock asc limit 3;
select *  from productos;
-- Cambiar la categoría de productos más popular por 'Electrónica y computación'
update categoria
set nombre = 'Electronica y computacion'
where id_categoria = (
	select count(*) as repeticion
    from productos
    group by id_categoria
    order by repeticion desc
    limit 1
    );
select * from categoria;