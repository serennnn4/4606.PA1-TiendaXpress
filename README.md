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
Se diseñó el siguiente proyecto para la empresa "TiendaXpress", negocio del rubro retail que requiere administrar el cataláogo de productos, información de clientes y operaciones de ventas diarias. En la BBDD hemos resuelto la falta de integridad y centralización, además, estructuraremos la información dispersa aplicando reglas estrictas para evitar inconsisterncia en los datos (exe: datos duplicados. ) y permitir generar
reportes logísticos y comerciales de forma automatizada.

## Objetivo:
Aplicar un modelo físico en SQL Server que mantenga la integridad de los datos y responda a los requerimientos a través de consultas simples, multitabla y de agrupación.

## Desarrollo:
Dividimos el desarrollo en los siguientes puntos:

  * Definimos las entidades DetallePedido, Pedidos, Productos y Clientes.
<img width="619" height="103" alt="image" src="https://github.com/user-attachments/assets/483e869a-b66b-4352-bf55-d41704f1ce83" />

  * Programamos el modelo físico a través de "PRIMARY KEY", "FOREIGN KEY" y las reglas "UNIQUE" (para los correos) y "CHECK" (pecios + inventario en positivo).
<img width="624" height="751" alt="image" src="https://github.com/user-attachments/assets/fdd7041a-8230-4994-b417-ba695abeb4c1" />

  * Probamos las entidades con INSERT INTO con datos de prueba (DML).
<img width="563" height="311" alt="image" src="https://github.com/user-attachments/assets/fd85cf14-be9d-44ee-b6fb-7cf25e828346" />

  *  Las sentencias SELECT usan filtros de fecha y texto. Con la condicional CASE etiquetamos el estado de pedidos y la unión JOIN para relacionar las ventas con el cliente.
<img width="588" height="601" alt="image" src="https://github.com/user-attachments/assets/bf9dff72-0e77-4e55-bc0a-4f548ffa2fa1" />

  *

## Solución Propuesta:
* Al contar con una base de datos funcional, realizamos un scrip con las tablas creadas (objetos DDL) y DML (Inserciones).
* Realizamos consultas para detectar productos con riesgo de desabastecimiento, osea que cuenten con stock menor a 30 unidades.
* Unificamos los datos extraídos de múltiples tablas para poder elaborar el análisis. La bbdd se programó para que se conecte con el registro general de usuarios con el historial de ventas. Esto permite la categorización de la actividad de cada cliente ( Frecuentes, Inactivos, Casuales). Estas etiquetas permiten priorizar los pedidos.


## Indicaciones para ejecutar/revisar el proyecto:
  * 1. Abrir el programa SQL Management Studio 22
  * 2. Archivo > Abrir > Archivo > Seleccionar "______.sql"
  * 3. Seleccionar
  * 4.


## Evidencias:

## Conclusiones:

## Video de Exposición:
