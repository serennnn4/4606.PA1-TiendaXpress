/*==========================================================================================================
PA1 - Actividad 4: Subconsultas y EXISTS
Curso: Programación Avanzada de Base de Datos (30627)
Caso: TiendaXpress
===========================================================================================================*/

USE PA1_TiendaXpress;
GO

-- 1. Subconsulta escalar: ¿Qué productos superan el precio promedio de toda la tienda?
SELECT 
    NombreProducto, 
    PrecioUnitario
FROM dbo.Productos
WHERE PrecioUnitario > (SELECT AVG(PrecioUnitario) FROM dbo.Productos)
ORDER BY PrecioUnitario DESC;
-- Propósito: identificar productos "premium" sin fijar un precio a mano; el promedio se recalcula
-- solo con que cambien los precios de la tabla, la consulta no necesita tocarse.
-- Alternativa: se podría calcular el promedio aparte (una consulta suelta) y comparar el número
-- manualmente, pero eso obliga a actualizarlo cada vez que cambian los precios. La subconsulta
-- resuelve las dos cosas en una sola instrucción.
GO

-- 2. Cláusula EXISTS: ¿qué clientes nunca hicieron un pedido?
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
-- Propósito: detectar clientes sin historial de compras, útil para una campaña de reactivación.
-- Alternativa: NOT IN (SELECT ClienteID FROM dbo.Pedidos) da el mismo resultado en la práctica,
-- pero si esa subconsulta llegara a traer un solo NULL, NOT IN deja de traer filas sin avisar.
-- NOT EXISTS no depende de comparar valores, solo verifica si existe o no una fila, así que no
-- tiene ese riesgo.
GO
