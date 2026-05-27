CLASS zcl_tablas_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TABLAS_SDM IMPLEMENTATION.


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


  "INSERTAR DATOS DE UNA TABLA
  "indicanco el indice
  DATA(ls_empleado) = VALUE ty_empleado( nombre = 'daniel' edad = 32 telefono = +3475657474 ).
  INSERT ls_empleado INTO lt_empleado INDEX 1.
  DATA ls_empleado2 TYPE ty_empleado.
  INSERT ls_empleado2 INTO lt_empleado INDEX 2.
  "Sin indicar el indice, nos coloca la fila en la siguiente linea vacia
  INSERT ls_empleado INTO TABLE lt_empleado.

  "ONTENER DATOS DE UNA TABLA CON UN BUCLE
  LOOP AT lt_empleado INTO ls_empleado.
    out->write( ls_empleado ).
  ENDLOOP.


  "Ejercicio
  "Rellenar una tabla interna con 4 filas de los datos que nos de la gana, filtracion de ciudades con la letra MC
  DATA lt_aeropuerto TYPE TABLE OF /dmo/airport.

  DATA(ls_aeropuerto1) = VALUE /dmo/airport( airport_id = '1' name = 'Madrid Barajas' city = 'Madrid' country = 'ES' ).
  INSERT ls_aeropuerto1 INTO TABLE lt_aeropuerto.

  DATA ls_aeropuerto TYPE /dmo/airport.
  DATA(lv_pattern) = `^M.*`.

  LOOP AT lt_aeropuerto INTO ls_aeropuerto.

    IF CONTAINS( val = ls_aeropuerto-city pcre = lv_pattern ).
        out->write( ls_empleado ).
    ENDIF.

  ENDLOOP.


  "EJERCICIO
  "Crear una tabla nueva que recoja los datos de la tabla anterior con una columna nueva con un id progresivo
  "Usar una filtracion



  "OTRA FORMA DE INSERTAR DATOS EN UNA TABLA
  DATA lt_empleado6 TYPE TABLE OF ty_empleado.
  INSERT VALUE #(
                    nombre = 'daniel'
                    edad = 32
                    telefono = '+3475657474'
                    correo = 'kk1@email.com' ) INTO TABLE lt_empleado6.

  "INSERTAR UNA LINEA EN BLANCO EN UNA TABLA
   INSERT INITIAL LINE INTO TABLE lt_empleado6.

  "HEREDAR ESCTRUCUTRA Y TIPOS DE UNA TABLA
  DATA lt_empleado7 LIKE lt_empleado6.

  "DUPLICAR CONTENIDO DE UNA TABLA A OTRA, COPIAR LOS DATOS DE UNA TABLA A OTRA
  INSERT LINES OF lt_empleado6 INTO TABLE lt_empleado7.

  "COPIA DESDE LA PRIMERA FILA HASTA LA FILA INDICADA EN EL TO DE UNA TABLA A OTRA
  INSERT LINES OF lt_empleado6 TO 1 INTO TABLE lt_empleado6.

  "COPIA LAS FILAS INDICADAS EN EL FROM TO DE UNA TABLA A OTRA
  INSERT LINES OF lt_empleado6 FROM 2 TO 4 INTO TABLE lt_empleado7.

  "APPEND añadir una fila por el final a una tabla
  APPEND ls_empleado TO lt_empleado.
  APPEND VALUE #(  ) TO lt_empleado.


  DATA(lt_empleado8) = VALUE ty_empleado(
                                            nombre = 'ana'
                                            edad = 8
                                            telefono = '325452'
                                            correo = 'kkdfsdfsd' ).



  ENDMETHOD.
ENDCLASS.
