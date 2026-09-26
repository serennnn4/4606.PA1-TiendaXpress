/* ============================================================
   PA1 - Actividad 1: Modelo físico y validación de restricciones
   Curso: Programación Avanzada de Base de Datos (30627)
   Caso: TiendaXpress - gestión de clientes, productos y pedidos
   Motor: SQL Server | Autenticación de Windows | instancia local
   ============================================================ */

-- 1. Crear la base de datos si no existe
IF DB_ID('PA1_TiendaXpress') IS NULL
BEGIN
    CREATE DATABASE PA1_TiendaXpress;
END
GO

USE PA1_TiendaXpress;
GO

-- 2. Limpiar tablas si ya existen (para poder re-ejecutar el script las veces que quieras)
IF OBJECT_ID('dbo.DetallePedido', 'U') IS NOT NULL DROP TABLE dbo.DetallePedido;
IF OBJECT_ID('dbo.Pedidos', 'U') IS NOT NULL DROP TABLE dbo.Pedidos;
IF OBJECT_ID('dbo.Productos', 'U') IS NOT NULL DROP TABLE dbo.Productos;
IF OBJECT_ID('dbo.Clientes', 'U') IS NOT NULL DROP TABLE dbo.Clientes;
GO

-- 3. Tabla Clientes
CREATE TABLE dbo.Clientes (
    ClienteID      INT IDENTITY(1,1) PRIMARY KEY,
    Nombres        VARCHAR(60)  NOT NULL,
    Apellidos      VARCHAR(60)  NOT NULL,
    Correo         VARCHAR(100) NOT NULL UNIQUE,
    Telefono       VARCHAR(20)  NULL,
    Ciudad         VARCHAR(50)  NULL,
    FechaRegistro  DATE         NOT NULL DEFAULT GETDATE()
);
GO

-- 4. Tabla Productos
CREATE TABLE dbo.Productos (
    ProductoID      INT IDENTITY(1,1) PRIMARY KEY,
    NombreProducto  VARCHAR(80)   NOT NULL,
    Categoria       VARCHAR(40)   NOT NULL,
    PrecioUnitario  DECIMAL(10,2) NOT NULL CHECK (PrecioUnitario > 0),
    Stock           INT           NOT NULL DEFAULT 0 CHECK (Stock >= 0),
    FechaAlta       DATE          NOT NULL DEFAULT GETDATE()
);
GO

-- 5. Tabla Pedidos (cabecera de la operación)
CREATE TABLE dbo.Pedidos (
    PedidoID     INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID    INT         NOT NULL,
    FechaPedido  DATETIME    NOT NULL DEFAULT GETDATE(),
    Estado       VARCHAR(20) NOT NULL DEFAULT 'Pendiente'
                 CHECK (Estado IN ('Pendiente','En proceso','Entregado','Cancelado')),
    CONSTRAINT FK_Pedidos_Clientes FOREIGN KEY (ClienteID)
        REFERENCES dbo.Clientes(ClienteID)
);
GO

-- 6. Tabla DetallePedido (detalle de la operación)
CREATE TABLE dbo.DetallePedido (
    DetalleID       INT IDENTITY(1,1) PRIMARY KEY,
    PedidoID        INT NOT NULL,
    ProductoID      INT NOT NULL,
    Cantidad        INT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario  DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Detalle_Pedidos FOREIGN KEY (PedidoID)
        REFERENCES dbo.Pedidos(PedidoID),
    CONSTRAINT FK_Detalle_Productos FOREIGN KEY (ProductoID)
        REFERENCES dbo.Productos(ProductoID)
);
GO

/* ============================================================
   INSERTS - datos válidos
   ============================================================ */

-- Clientes
INSERT INTO dbo.Clientes (Nombres, Apellidos, Correo, Telefono, Ciudad) VALUES
('Ana',      'Ramírez',  'ana.ramirez@mail.com',     '987111222', 'Lima'),
('Carlos',   'Flores',   'carlos.flores@mail.com',   '987222333', 'Arequipa'),
('Bertha',   'Quispe',   'bertha.quispe@mail.com',   '987333444', 'Trujillo'),
('Diego',    'Salazar',  'diego.salazar@mail.com',   '987444555', 'Lima'),
('Elena',    'Torres',   'elena.torres@mail.com',    '987555666', 'Cusco'),
('Fabricio', 'Mendoza',  'fabricio.mendoza@mail.com','987666777', 'Piura'),
('Gabriela', 'Ríos',     'gabriela.rios@mail.com',   '987777888', 'Lima'),
('Hugo',     'Castillo', 'hugo.castillo@mail.com',   '987888999', 'Arequipa');
GO

-- Productos
INSERT INTO dbo.Productos (NombreProducto, Categoria, PrecioUnitario, Stock) VALUES
('Laptop 14"',           'Tecnología', 2899.90, 15),
('Mouse inalámbrico',    'Tecnología',   45.50, 120),
('Teclado mecánico',     'Tecnología',  189.90, 60),
('Silla ergonómica',     'Hogar',       499.00, 25),
('Escritorio madera',    'Hogar',       650.00, 10),
('Polo algodón',         'Ropa',         39.90, 200),
('Zapatillas urbanas',   'Ropa',        249.90, 80),
('Mochila laptop',       'Accesorios',  120.00, 50),
('Audífonos bluetooth',  'Tecnología',  159.90, 70),
('Lámpara de escritorio','Hogar',        75.00, 40);
GO

-- Pedidos
INSERT INTO dbo.Pedidos (ClienteID, Estado) VALUES
(1, 'Entregado'),
(2, 'En proceso'),
(3, 'Pendiente'),
(1, 'Entregado'),
(4, 'Cancelado'),
(5, 'Entregado'),
(6, 'En proceso'),
(7, 'Pendiente'),
(8, 'Entregado'),
(2, 'Entregado'),
(3, 'En proceso'),
(5, 'Pendiente');
GO

-- DetallePedido (el PrecioUnitario se copia del producto al momento de la venta)
INSERT INTO dbo.DetallePedido (PedidoID, ProductoID, Cantidad, PrecioUnitario) VALUES
(1, 1, 1, 2899.90),
(1, 2, 2, 45.50),
(2, 3, 1, 189.90),
(2, 9, 1, 159.90),
(3, 4, 1, 499.00),
(4, 6, 3, 39.90),
(4, 7, 1, 249.90),
(5, 5, 1, 650.00),
(6, 8, 2, 120.00),
(6, 2, 1, 45.50),
(7, 10, 4, 75.00),
(7, 6, 2, 39.90),
(8, 1, 1, 2899.90),
(9, 9, 2, 159.90),
(9, 3, 1, 189.90),
(10, 4, 2, 499.00),
(10, 7, 1, 249.90),
(11, 2, 5, 45.50),
(12, 8, 1, 120.00),
(12, 10, 2, 75.00);
GO

-- Verificación rápida de que todo entró bien
SELECT * FROM dbo.Clientes;
SELECT * FROM dbo.Productos;
SELECT * FROM dbo.Pedidos;
SELECT * FROM dbo.DetallePedido;
