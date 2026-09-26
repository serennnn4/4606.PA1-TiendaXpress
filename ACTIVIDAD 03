/*==========================================================================================================
PA1 - Actividad 3: Consultas Multitabla
Curso: Programación Avanzada de Base de Datos (30627)
Caso: TiendaXpress
===========================================================================================================*/

USE PA1_TiendaXpress;
GO

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

---     INNER JOIN: Se utilizó para cruzar las tablas "Clientes" y "Pedidos". Solo devuelve los registros
---     que tienen coincidencia en ambas tablas, es decir, únicamente los clientes que efectivamente han
---     realizado al menos un pedido.
---     CASE: Se emplea para evaluar la columna Estado y transformarla en una etiqueta clara
---     (PrioridadLogistica) que ayuda al equipo operativo a gestionar los despachos según su urgencia.

/*====================================================================*/

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

---     LEFT OUTER JOIN: A diferencia del INNER JOIN, esta combinación asegura que todos los registros de
---     la tabla izquierda (Clientes) aparezcan en el resultado, incluso si nunca han registrado una orden
---     en la tabla Pedidos (los cuales mostrarán valores NULL o un conteo de 0).
---     CASE: Evalúa la función de agregación COUNT(p.PedidoID) para categorizar comercialmente a cada
---     usuario.
---     Creación de tabla (INTO): Se utilizó la sintaxis SELECT ... INTO para persistir el resultado de
---     este análisis en una tabla física nueva (dbo.ResumenCarteraClientes), facilitando reportes
---     posteriores sin necesidad de recalcular el cruce constantemente.

/*====================================================================*/

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

---     UNION ALL: Permite combinar verticalmente los resultados de dos consultas estructuradas de forma
---     compatible (mismo número y tipo de datos en las columnas). Se prefirió UNION ALL sobre UNION para
---     evitar la sobrecarga de eliminación de duplicados, mejorando el rendimiento de la consulta.
