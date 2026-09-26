# Proceso de Aprendizaje 1 | TiendaXpress

## Nombre del proyecto
  
  * **PA1 - Actividad 1:** Modelo físico y validación de restricciones
  * **Curso:** Programación Avanzada de Base de Datos (30627)
  * **Caso:** TiendaXpress - gestión de clientes, productos y pedidos
  * **Motor:** SQL Server | Autenticación de Windows | instancia local
   
## Integrantes:

   * RODRIGO GOMEZ CARRASCO - Actividad 1 72207949@mail.isil.pE
   * MARIA FERNANDA LEON CATALAN - Actividad 1 75443768@mail.isil.pe
   * NADIA MABEL VINCES ASCA - Actividad 2 70474181@mail.isil.pe
   * LUIGI ALVA SANCHEZ - Actividad 3  48584750@mail.isil.pe
   * JEAN LUC MELLET DEL CASTILLO - Actividad 4 73994056@mail.isil.pe


## Descripción: 
Se diseñó el siguiente proyecto para la empresa "TiendaXpress", negocio del rubro retail que requiere administrar el cataláogo de productos, información de clientes y operaciones de ventas diarias. En la BBDD hemos resuelto la falta de integridad y centralización, además, estructuraremos la información dispersa aplicando reglas estrictas para evitar inconsisterncia en los datos (exe: datos duplicados. ) y permitir generar reportes logísticos y comerciales de forma automatizada.

## Objetivo:
Aplicar un modelo físico en SQL Server que mantenga la integridad de los datos y responda a los requerimientos de la organización a través de consultas simples, de agrupación, multitabla y con subconsultas.

## Desarrollo:
Dividimos el desarrollo en los siguientes puntos:

 * Definimos las entidades Clientes, Productos, Pedidos y DetallePedido, y sus relaciones.
<img width="619" height="103" alt="image" src="https://github.com/user-attachments/assets/483e869a-b66b-4352-bf55-d41704f1ce83" />

* Programamos el modelo físico con PRIMARY KEY y FOREIGN KEY para las relaciones, UNIQUE para que no se repita el correo de un cliente, y CHECK para que el precio, el stock y la cantidad nunca sean negativos, y para limitar el estado de un pedido a una lista cerrada de valores.
<img width="624" height="751" alt="image" src="https://github.com/user-attachments/assets/fdd7041a-8230-4994-b417-ba695abeb4c1" />

* Probamos las tablas con INSERT INTO usando datos de prueba, incluyendo un cliente sin ningún pedido asociado (Valeria Núñez), pensado a propósito para tener un caso real donde probar las consultas de clientes sin historial de compras.

* A partir de esos datos, Nadia resolvió consultas con WHERE (IN, BETWEEN), funciones de cadena y agrupación con GROUP BY y HAVING para identificar, por ejemplo, qué productos están por debajo de las 30 unidades de stock.
  
* Luigi trabajó las consultas multitabla: un INNER JOIN para relacionar pedidos con sus clientes y clasificar su prioridad de despacho con CASE, un LEFT JOIN para incluir también a los clientes sin pedidos y clasificarlos como frecuentes, casuales o sin compras, y un UNION ALL para consolidar productos y clientes en un solo listado de auditoría.
  
* Jean Luc cerró con dos subconsultas: una escalar para identificar productos por encima del precio promedio, y una con NOT EXISTS para encontrar clientes sin ningún pedido registrado, que es justamente el caso que cubre Valeria.

## Solución Propuesta:
* Con la base de datos funcional, entregamos un script con los objetos DDL (tablas y restricciones) y las inserciones DML de prueba.
* Resolvimos consultas para detectar productos con riesgo de desabastecimiento, es decir con stock menor a 30 unidades, y productos con más de 3 unidades vendidas en total.
  
* Unificamos datos de varias tablas para clasificar a los clientes según su historial de compras (frecuentes, casuales, inactivos) y priorizar pedidos según su estado.
  
* Comparamos alternativas para un mismo requerimiento, por ejemplo INNER JOIN frente a LEFT JOIN, y NOT EXISTS frente a NOT IN, explicando en el script por qué se eligió una sobre la otra.


## Indicaciones para ejecutar/revisar el proyecto:
1. Abrir SQL Server Management Studio y conectarse a la instancia local con Autenticación de Windows.
2. Ejecutar el script de la Actividad 1. Este crea la base de datos, las tablas con sus restricciones, inserta los datos de prueba y corre las 4 validaciones de restricciones al final (cada prueba se ejecuta por separado para ver su mensaje de error).
3. Ejecutar el script de la Actividad 2, con las consultas de filtros, funciones y agrupación.
4. Ejecutar el script de la Actividad 3, con las consultas de JOIN, CASE y UNION.
5. Ejecutar el script de la Actividad 4, con las subconsultas y la consulta con EXISTS.


## Evidencias:
* Diagrama de entidades: Clientes, Productos, Pedidos y DetallePedido.
  <img width="2189" height="1276" alt="image" src="https://github.com/user-attachments/assets/0aeaefa4-c658-420e-a427-4c2d1cafa1f2" />

* Modelo físico con PRIMARY KEY, FOREIGN KEY, UNIQUE y CHECK ya creado en SQL Server.
  
* Datos de prueba insertados con INSERT INTO.
  
* Consulta multitabla con JOIN y CASE mostrando la prioridad de cada pedido.


## Conclusiones:
El modelo físico con PRIMARY KEY, FOREIGN KEY, UNIQUE y CHECK evitó desde el inicio los problemas que TiendaXpress tenía con la información dispersa: no se pudo insertar un correo repetido, ni un precio negativo, ni un pedido sin cliente real detrás. Al combinar las consultas del equipo (filtros y agrupación, JOIN multitabla, subconsultas) pudimos responder preguntas de negocio completas, como identificar clientes inactivos o productos con riesgo de quiebre de stock, algo que con las tablas sueltas y sin relación no hubiera sido posible.

## Video de Exposición:
Video público de YouTube:
