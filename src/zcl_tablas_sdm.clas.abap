CLASS zcl_tablas_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tablas_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  TYPES: BEGIN OF ty_empleado,
         nombre TYPE STRING,
         edad TYPE I,
         telefono TYPE STRING,
         correo TYPE STRING,

  END OF TY_EMPLEADO.


  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "TABLAS
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  "DECLARAION DE TABLAS STANDARD
  "lt = LOCAL TABLE
  DATA lt_empleado TYPE STANDARD TABLE OF TY_EMPLEADO.
  DATA lt_empleado2 TYPE TABLE OF TY_EMPLEADO.

  "DECLARAION DE Tabla SORTED con clave unica especificada
  DATA lt_empleado3 TYPE SORTED TABLE OF ty_empleado WITH UNIQUE KEY correo.
  "DECLARACION DE Tabla SORTED con clave no unica especificada
  DATA lt_empleado4 TYPE SORTED TABLE OF ty_empleado WITH NON-UNIQUE KEY correo.

  "DECLARACION DE Tabla HASH solo puede tener clave unica, es la más rápida
  DATA lt_empleado5 TYPE HASHED TABLE OF ty_empleado WITH UNIQUE KEY correo.


  "RELLENAR LOS DATOS DE UNA TABLA
  "De forma manual
  "indicanco el indice
  DATA(ls_empleado) = VALUE ty_empleado( nombre = 'daniel' edad = 32 telefono = +3475657474 ).
  INSERT ls_empleado INTO lt_empleado INDEX 1.
  DATA ls_empleado2 TYPE ty_empleado.
  INSERT ls_empleado2 INTO lt_empleado INDEX 2.
  "Sin indicar el indice, nos coloca la fila en la siguiente linea vacia
  INSERT ls_empleado INTO TABLE lt_empleado.

  "Sacar datos de una tabla con un bucle
  LOOP AT lt_empleado INTO ls_empleado.
    out->write( ls_empleado ).
  ENDLOOP.


  "Ejercicio usando una tabla de base de datos
  "Rellenar una tabla interna con 4 filas de los datos que nos de la gana, filtracion de ciudades con la letra ñ
  DATA ls_aeropuerto TYPE /dmo/airport.
  DATA lt_aeropuerto TYPE TABLE OF /dmo/airport.






  ENDMETHOD.
ENDCLASS.
