CREATE SCHEMA IF NOT EXISTS minimarket_schema;

CREATE TABLE `minimarket_schema`.`proveedores`(
`proveedor_id` INT NOT NULL AUTO_INCREMENT,
`nombre`  VARCHAR(20) NOT NULL,
`telefono` INT NOT NULL,
PRIMARY KEY (`proveedor_id`));

CREATE TABLE `minimarket_schema`.`productos`(
`producto_id` INT NOT NULL AUTO_INCREMENT,
`nombre`  VARCHAR(30) NOT NULL,
`precio` INT NOT NULL,
PRIMARY KEY (`producto_id`));

CREATE TABLE `minimarket_schema`.`clientes`(
`cliente_id` INT NOT NULL AUTO_INCREMENT,
`nombre`  VARCHAR(30) NOT NULL,
PRIMARY KEY (`cliente_id`));

CREATE TABLE `minimarket_schema`.`tipoProductos`(
`tipoProducto_id` INT NOT NULL AUTO_INCREMENT,
`nombre`  VARCHAR(30) NOT NULL,
PRIMARY KEY (`tipoProducto_id`));

CREATE TABLE `minimarket_schema`.`ordenes`(
`orden_id` INT NOT NULL AUTO_INCREMENT,
`fecha`  date NOT NULL,
montoCompra INT NOT NULL,
PRIMARY KEY (`orden_id`));

CREATE TABLE `minimarket_schema`.`productos_ordenes`(
`producto_orden_id` INT NOT NULL AUTO_INCREMENT,
PRIMARY KEY (`producto_orden_id`));

CREATE TABLE `minimarket_schema`.`productos_proveedores`(
`producto_proveedor_id` INT NOT NULL AUTO_INCREMENT,
PRIMARY KEY (`producto_proveedor_id`));

-- 1
ALTER TABLE minimarket_schema.productos ADD tipoProducto_id INT NOT NULL;
ALTER TABLE minimarket_schema.productos ADD CONSTRAINT fktipoProducto FOREIGN KEY (tipoProducto_id) REFERENCES minimarket_schema.tipoproductos(tipoProducto_id);

-- 2
ALTER TABLE minimarket_schema.ordenes ADD cliente_id INT NOT NULL;
ALTER TABLE minimarket_schema.ordenes ADD CONSTRAINT fkordenCliente FOREIGN KEY (cliente_id) REFERENCES minimarket_schema.clientes(cliente_id);

-- 3
ALTER TABLE minimarket_schema.productos_ordenes ADD producto_id INT NOT NULL;
ALTER TABLE minimarket_schema.productos_ordenes ADD CONSTRAINT fkordenProducto FOREIGN KEY (producto_id) REFERENCES minimarket_schema.productos(producto_id);

-- 4
ALTER TABLE minimarket_schema.productos_ordenes ADD orden_id INT NOT NULL;
ALTER TABLE minimarket_schema.productos_ordenes ADD CONSTRAINT fkproductoOrden FOREIGN KEY (orden_id) REFERENCES minimarket_schema.ordenes(orden_id);

-- 5
ALTER TABLE minimarket_schema.productos_proveedores ADD producto_id INT NOT NULL;
ALTER TABLE minimarket_schema.productos_proveedores ADD CONSTRAINT fkproductoProveedor FOREIGN KEY (producto_id) REFERENCES minimarket_schema.productos(producto_id);

-- 6
ALTER TABLE minimarket_schema.productos_proveedores ADD proveedor_id INT NOT NULL;
ALTER TABLE minimarket_schema.productos_proveedores ADD CONSTRAINT fkproveedorProducto FOREIGN KEY (proveedor_id) REFERENCES minimarket_schema.proveedores(proveedor_id);

INSERT INTO minimarket_schema.clientes(nombre) VALUES ('Juan Martinez');
INSERT INTO minimarket_schema.clientes(nombre) VALUES ('Rosa Sanchez');
INSERT INTO minimarket_schema.clientes(nombre) VALUES ('Abigail Sepulveda');
INSERT INTO minimarket_schema.clientes(nombre) VALUES ('Hernando Ramirez');
INSERT INTO minimarket_schema.clientes(nombre) VALUES ('Belen Hurtado');

INSERT INTO minimarket_schema.proveedores(nombre, telefono) VALUES ('Cecinas manolito', 98765356);
INSERT INTO minimarket_schema.proveedores(nombre, telefono) VALUES ('hamburguesas pedrito', 98755356);
INSERT INTO minimarket_schema.proveedores(nombre, telefono) VALUES ('salchichas alegria', 98645356);
INSERT INTO minimarket_schema.proveedores(nombre, telefono) VALUES ('rebecca helados', 93755356);
INSERT INTO minimarket_schema.proveedores(nombre, telefono) VALUES ('miku verduras', 98750056);

INSERT INTO minimarket_schema.tipoproductos(nombre) VALUES ('verduras');
INSERT INTO minimarket_schema.tipoproductos(nombre) VALUES ('cecinas');
INSERT INTO minimarket_schema.tipoproductos(nombre) VALUES ('bebidas');
INSERT INTO minimarket_schema.tipoproductos(nombre) VALUES ('helados');
INSERT INTO minimarket_schema.tipoproductos(nombre) VALUES ('lacteos');

INSERT INTO minimarket_schema.productos(nombre, precio, tipoProducto_id) VALUES ('lechuga',1000,1);
INSERT INTO minimarket_schema.productos(nombre, precio, tipoProducto_id) VALUES ('limones',1200,1);
INSERT INTO minimarket_schema.productos(nombre, precio, tipoProducto_id) VALUES ('jamon 500gr',2500,2);
INSERT INTO minimarket_schema.productos(nombre, precio, tipoProducto_id) VALUES ('coca cola 2L',2000,3);
INSERT INTO minimarket_schema.productos(nombre, precio, tipoProducto_id) VALUES ('helado chocolate 1L',1500,4);

INSERT INTO minimarket_schema.ordenes(fecha,cliente_id,montoCompra) VALUES ('2022-11-11',1,4800);   -- lechuga 1500 jamon 500 gr 3300
INSERT INTO minimarket_schema.ordenes(fecha,cliente_id,montoCompra) VALUES ('2022-11-10',2,4500);  -- coca cola 2500 helado choco 2000
INSERT INTO minimarket_schema.ordenes(fecha,cliente_id,montoCompra) VALUES ('2022-11-08',3,1500); -- lechuga
INSERT INTO minimarket_schema.ordenes(fecha,cliente_id,montoCompra) VALUES ('2022-11-11',4,2500);  -- coca
INSERT INTO minimarket_schema.ordenes(fecha,cliente_id,montoCompra) VALUES ('2022-11-11',5,3300); -- jamon

INSERT INTO minimarket_schema.productos_proveedores(producto_id,proveedor_id) VALUES(1,5);
INSERT INTO minimarket_schema.productos_proveedores(producto_id,proveedor_id) VALUES(2,5);
INSERT INTO minimarket_schema.productos_proveedores(producto_id,proveedor_id) VALUES(3,1);
INSERT INTO minimarket_schema.productos_proveedores(producto_id,proveedor_id) VALUES(4,4);
INSERT INTO minimarket_schema.productos_proveedores(producto_id,proveedor_id) VALUES(5,4);

INSERT INTO minimarket_schema.productos_ordenes(producto_id,orden_id) VALUES(1,1);
INSERT INTO minimarket_schema.productos_ordenes(producto_id,orden_id) VALUES(3,1);
INSERT INTO minimarket_schema.productos_ordenes(producto_id,orden_id) VALUES(4,2);
INSERT INTO minimarket_schema.productos_ordenes(producto_id,orden_id) VALUES(5,2);
INSERT INTO minimarket_schema.productos_ordenes(producto_id,orden_id) VALUES(1,3);
INSERT INTO minimarket_schema.productos_ordenes(producto_id,orden_id) VALUES(3,4);

-- consulta que une el numero de orden con el producto comprado, si aparece el mismo numero en la orden, 
-- por ejemplo el orden_id=1 esta dos veces, esto quiere decir que en la orden_id=1 se compro el producto_id=1 
-- que en este caso es una lechuga y el jamon con producto_id = 3 y orden_id =1.
SELECT minimarket_schema.ordenes.orden_id, minimarket_schema.productos_ordenes.producto_id
FROM minimarket_schema.ordenes
INNER JOIN minimarket_schema.productos_ordenes ON  minimarket_schema.ordenes.orden_id=minimarket_schema.productos_ordenes.orden_id;

-- para calcular las ventas anuales tendria que sumar los montos vendidos al cliente en la tabla orden todos los dias restandole el precio que compra al proveedor el producto que en este caso se aplicaria haciendo una suma en el monto de la tabla orden
SELECT SUM(minimarket_schema.ordenes.montoCompra) as 'ingresos totales agregados' 
FROM minimarket_schema.ordenes;

####################################666#############################################
-- DROP TABLE minimarket_schema.clientes;
-- DROP TABLE minimarket_schema.ordenes;
-- DROP TABLE minimarket_schema.productos;
-- DROP TABLE minimarket_schema.productos_ordenes;
-- DROP TABLE minimarket_schema.productos_proveedores;
-- DROP TABLE minimarket_schema.proveedores;
-- DROP TABLE minimarket_schema.tipoproductos;

-- ALTER TABLE minimarket_schema.ordenes DROP foreign key fkordenCliente;
-- ALTER TABLE minimarket_schema.productos DROP foreign key fktipoProducto;

-- ALTER TABLE minimarket_schema.productos_ordenes DROP foreign key fkordenProducto;
-- ALTER TABLE minimarket_schema.productos_ordenes DROP foreign key fkproductoOrden;
-- ALTER TABLE minimarket_schema.productos_proveedores DROP foreign key fkproductoProveedor;
-- ALTER TABLE minimarket_schema.productos_proveedores DROP foreign key fkproveedorProducto;

-- Atajo para borrar tablas en caso de error

################################777#################################################
