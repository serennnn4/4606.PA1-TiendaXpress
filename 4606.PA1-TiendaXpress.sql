/* ============================================================
   PA1 - Actividad 1: Modelo físico y validación de restricciones
   Curso: Programación Avanzada de Base de Datos (30627)
   Caso: TiendaXpress - gestión de clientes, productos y pedidos
   Motor: SQL Server | Autenticación de Windows | instancia local
   ============================================================ */

-- 1. Crear la base de datos
IF DB_ID('PA1_TiendaXpress') IS NULL
BEGIN
    CREATE DATABASE PA1_TiendaXpress;
END
GO

USE PA1_TiendaXpress;
GO

-- 2. Limpieza de tablas (para poder re-ejecutar el script cuando se desee)
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
GO

/* ============================================================
   VALIDACIÓN DE RESTRICCIONES
   ============================================================ */

-- ── Prueba 1: romper UNIQUE (correo duplicado) ───────────────
-- Ana Ramírez ya existe con este correo. Este INSERT debe fallar.
INSERT INTO dbo.Clientes (Nombres, Apellidos, Correo, Ciudad)
VALUES ('Ana', 'Duplicada', 'ana.ramirez@mail.com', 'Lima');

-- ── Prueba 2: romper CHECK (precio negativo) ─────────────────
INSERT INTO dbo.Productos (NombreProducto, Categoria, PrecioUnitario, Stock)
VALUES ('Producto inválido', 'Tecnología', -50.00, 10);

-- ── Prueba 3: romper FOREIGN KEY (cliente inexistente) ───────
INSERT INTO dbo.Pedidos (ClienteID, Estado)
VALUES (999, 'Pendiente');

-- ── Prueba 4: romper CHECK de dominio (estado no permitido) ──
INSERT INTO dbo.Pedidos (ClienteID, Estado)
VALUES (1, 'Enviado a la luna');
GO

/* ============================================================
   PA1 - Actividad 2: Consultas de selección, filtros y agrupación 
   ============================================================ */

-- 1. Consulta: "¿Qué clientes son de Lima o de Arequipa?" 
SELECT 
    Nombres, 
    Apellidos,
    Correo,
    Telefono,
    UPPER(Ciudad) AS CiudadMayus
FROM dbo.Clientes
WHERE Ciudad IN ('Lima', 'Arequipa');
GO

-- 2. Consulta: "¿Qué productos tienen riesgo de quiebre de stock?"
SELECT
     NombreProducto,
     Categoria,
     Stock
FROM dbo.Productos
WHERE Stock < 30
ORDER BY Stock ASC;
GO

-- 3. Consulta: "¿Qué productos acumulan 3 o más unidades compradas en total?"
SELECT
     ProductoID,
     SUM(Cantidad) AS TotalUnidades
FROM dbo.DetallePedido
GROUP BY ProductoID
HAVING SUM(Cantidad) >= 3
ORDER BY TotalUnidades DESC;
GO

-- 4. Consulta: "¿Qué productos tienen un precio entre 50 y 200 soles?"
SELECT
     NombreProducto,
     PrecioUnitario 
FROM dbo.Productos 
WHERE PrecioUnitario BETWEEN 50 AND 200;
GO

/*==========================================================================================================
Actividad 3: Consultas Multitabla
===========================================================================================================*/

---     Requerimiento 1: Reporte operativo de ventas
---     1. INNER JOIN + CASE
SELECT 
    c.ClienteID,
    CONCAT(c.Nombres,' ', c.Apellidos) AS NombreCliente,
    p.PedidoID,
    p.FechaPedido,
    p.Estado,
    CASE 
        WHEN p.Estado = 'Pendiente' THEN 'Prioridad Alta - Procesar envío'
        WHEN p.Estado = 'En proceso' THEN 'Prioridad Media - En empaque'
        WHEN p.Estado = 'Entregado' THEN 'Prioridad Baja - Entregado'
        WHEN p.Estado = 'Cancelado'  THEN 'Sin Prioridad - Anulado'
        ELSE 'Estado no identificado'
    END AS PrioridadLogistica
FROM dbo.Clientes AS c
INNER JOIN dbo.Pedidos AS p 
    ON c.ClienteID = p.ClienteID;
GO

---     Requerimiento 2: Análisis y segmentación de la cartera de clientes
---     2. LEFT OUTER JOIN + CASE + Creación de Tabla
IF OBJECT_ID('dbo.ResumenCarteraClientes', 'U') IS NOT NULL
    DROP TABLE dbo.ResumenCarteraClientes;

SELECT 
    c.ClienteID,
    CONCAT(c.Nombres,' ', c.Apellidos) AS NombreCliente,
    c.Correo,
    COUNT(p.PedidoID) AS TotalPedidos,
    CASE 
        WHEN COUNT(p.PedidoID) >= 3 THEN 'Cliente Frecuente'
        WHEN COUNT(p.PedidoID) BETWEEN 1 AND 2 THEN 'Cliente Casual'
        ELSE 'Cliente Inactivo / Sin Compras'
    END AS ClasificacionCliente
INTO dbo.ResumenCarteraClientes
FROM dbo.Clientes AS c
LEFT JOIN dbo.Pedidos AS p 
    ON c.ClienteID = p.ClienteID
GROUP BY 
    c.ClienteID, 
    c.Nombres, 
    c.Apellidos, 
    c.Correo;

SELECT * FROM dbo.ResumenCarteraClientes;
GO

---     Requerimiento 3: Consolidado general de entidades y estados.
---     3. UNION ALL
SELECT 
    'Producto' AS TipoEntidad,
    NombreProducto AS Descripcion,
    CASE 
        WHEN Stock = 0 THEN 'Agotado'
        WHEN Stock < 10 THEN 'Stock Crítico'
        ELSE 'Stock Disponible'
    END AS EstadoAnalisis
FROM dbo.Productos

UNION ALL

SELECT 
    'Cliente' AS TipoEntidad,
    CONCAT(Nombres,' ', Apellidos) AS Descripcion,
    CASE 
        WHEN ClienteID IN (SELECT DISTINCT ClienteID FROM dbo.Pedidos) THEN 'Con Historial'
        ELSE 'Sin Historial'
    END AS EstadoAnalisis
FROM dbo.Clientes;
GO

/*==========================================================================================================
Actividad 4: Subconsultas
===========================================================================================================*/


-- 1. Subconsulta Escalar: ¿Qué productos superan el precio promedio de toda la tienda?
SELECT 
    NombreProducto, 
    PrecioUnitario
FROM dbo.Productos
WHERE PrecioUnitario > (SELECT AVG(PrecioUnitario) FROM dbo.Productos)
ORDER BY PrecioUnitario DESC;
GO

-- 2. Cláusula EXISTS vs NOT EXISTS:

SELECT 
    cl.ClienteID, 
    cl.Nombres, 
    cl.Apellidos,
    cl.Correo
FROM dbo.Clientes cl
WHERE NOT EXISTS (
    SELECT 1 
    FROM dbo.Pedidos p 
    WHERE p.ClienteID = cl.ClienteID
);
GO