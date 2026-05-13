CLASS zcl_estructuras_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_estructuras_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "ESTRUCUTURAS SIMPLES
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


  "Tipo de dato personalizado
  "ty = type
  TYPES: BEGIN OF ty_empleado,
         nombre TYPE STRING,
         edad TYPE I,
         telefono TYPE STRING,
         correo TYPE STRING,

  END OF TY_EMPLEADO.

  "Declaracion de estructura usando un tipo personalizado.
  "local structure = ls
  DATA ls_empleado TYPE ty_empleado.

  "Rellenar los campos de la estructura
  ls_empleado-nombre = 'daniel'.
  ls_empleado-edad = 15.
  ls_empleado-telefono = '123456789'.
  ls_empleado-correo = 'daniel@sap.com'.

  out->write( ls_empleado ).

  "Ejercicio: Crear una estructura para almacenar los productos de un almacen, sofa, mesa, cama, lampara, es decir, un inventario, que nos indique cuanto hay de cada producto.
  TYPES: BEGIN OF ty_productos,
         sofa TYPE I,
         mesa TYPE I,
         cama TYPE I,
         lampara TYPE I,

  END OF TY_PRODUCTOS.

  DATA ls_inventario TYPE ty_productos.
  ls_inventario-sofa = 2.
  ls_inventario-mesa = 15.
  ls_inventario-cama = 30.
  ls_inventario-lampara = 127.

  out->write( ls_inventario ).


  "OTRA FORMA DE DECLARAR UNA ESTRUCTURA
  DATA(ls_empleado2) = VALUE ty_empleado( nombre = 'daniel' edad = 32 telefono = +3475657474 ).
  out->write( ls_empleado2 ).

  "OTRA FORMA DE DECLARAR UNA ESTRUCTURA
  DATA ls_empleado3 TYPE ty_empleado.
  ls_empleado3 = VALUE #( nombre = 'daniel' edad = 32 telefono = +3475657474 ).
  out->write( ls_empleado3 ).


  "Extraer datos de una tabla de base de datos
  DATA ls_empleado4 TYPE /dmo/airport.
  out->write( ls_empleado4 ).

  TYPES: BEGIN OF ty_empleado2,
         nombre TYPE STRING,
         edad TYPE I,
         telefono TYPE STRING,
         correo TYPE STRING,
         ciudad TYPE /dmo/city, "se puede usar un tipo de dato definido en una tabla externa

  END OF TY_EMPLEADO2.



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"ESTRUCUTRAS ANIDADAS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  DATA: BEGIN OF ls_empleado5,
        nombre TYPE STRING VALUE 'daniel',
        id TYPE I,
        email TYPE /dmo/email_address VALUE 'kk@email.com',

  END OF ls_empleado5.

  DATA: BEGIN OF ls_empleado_info,

        BEGIN OF info,
            id     TYPE I VALUE 01,
            nombre TYPE STRING VALUE 'daniel',
        END OF INFO,

        BEGIN OF direccion,
            ciudad TYPE STRING VALUE 'Granada',
            calle  TYPE STRING VALUE 'KK',
            pais   TYPE STRING VALUE 'España',
       END OF DIRECCION,

       BEGIN OF posicion,
            departamento TYPE STRING VALUE 'IT',
            sueldo       TYPE P DECIMALS 2 VALUE '18524.45',
       END OF POSICION,

   END OF ls_empleado_info.

   out->write( ls_empleado_info ).





  ENDMETHOD.
ENDCLASS.
