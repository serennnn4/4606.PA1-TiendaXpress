/* ============================================================
   PA1 - Actividad 2: Consultas de selección, filtros y agrupación 
   Curso: Programación Avanzada de Base de Datos (30627)
   Caso: TiendaXpress - consultas básicas
   Motor: SQL Server | Autenticación de Windows | instancia local
   ============================================================ */

USE PA1_TiendaXpress;
GO

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

