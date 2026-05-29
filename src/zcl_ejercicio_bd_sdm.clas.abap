CLASS zcl_ejercicio_bd_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejercicio_bd_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


*  Tenéis que hacer una base de datos con dos  columnas
*1- campo id , es el campo clave ( key  ) se crea automáticamente con cada registro que se introduzca,
* comprueba el numero de registros de la base de datos y le asigna  al nuevo registro ese tamaño + 1.
*2- columna con nombre de todos los alumno de clase.

    DELETE FROM zdb_alumnos_sdm.

    DATA: lt_nombres TYPE TABLE OF string.

    lt_nombres = VALUE #(
      ( `Alba Gómez, Sergio` )
      ( `Anangono Tutasig, Karen Denisse` )
      ( `Ayala Doñas, Alejandro` )
      ( `Barnes Calancha, Lidia` )
      ( `Bureo Osuna, Jesús` )
      ( `Criado Romero, Samuel` )
      ( `Delgado Martín, Sarah` )
      ( `González de la Torre, José Antonio` )
      ( `Maldonado Hernández, Luis` )
      ( `Moreno Cabrera, María Dolores` )
      ( `Palacios Canales, Rebeca` )
      ( `Portillo Moral, Gonzalo` )
      ( `Prados Donaire, Miguel` )
      ( `Rojas Moreno, Antonio` )
      ( `Ruíz Rodríguez, Antonia` )
      ( `Sillero Fernández, David` )
      ( `Torres Albillo, Adrián` )
      ( `Vela Martínez, Rafael` )
    ).


    DATA:
      lv_id     TYPE i,
      ls_alumno TYPE zdb_alumnos_sdm.

*--------------------------------------------------------------------
* Obtener último ID
*--------------------------------------------------------------------
    SELECT FROM zdb_alumnos_sdm
    FIELDS MAX( id )
      INTO @lv_id.

    IF sy-subrc <> 0 OR lv_id IS INITIAL.
      lv_id = 0.
    ENDIF.

*--------------------------------------------------------------------
* Insertar alumnos
*--------------------------------------------------------------------
    LOOP AT lt_nombres INTO DATA(lv_nombre).

      lv_id += 1.

      INSERT zdb_alumnos_sdm FROM @( VALUE #( id = lv_id nombre = lv_nombre ) ).

      IF sy-subrc <> 0.
        out->write( |Error insertando:' { lv_nombre }| ).
      ENDIF.

    ENDLOOP.


**segunda parte: usando la función random, extraer un registro de esa base de datos.
*
**--------------------------------------------------------------------
** Obtener último ID
**--------------------------------------------------------------------
*    DATA lv_last_id type i.
*    SELECT FROM zdb_alumnos_sdm
*    FIELDS MAX( id )
*      INTO @lv_last_id.
*
**--------------------------------------------------------------------
** Crear generador aleatorio
**--------------------------------------------------------------------
*    DATA(lv_random) = cl_abap_random_int=>create(
*                  seed = cl_abap_random=>seed( )
*                  min  = 1
*                  max  = lv_last_id ).
*
**--------------------------------------------------------------------
** Obtener número aleatorio
**--------------------------------------------------------------------
*    DATA(lv_indice_random) = lv_random->get_next( ).
*
**--------------------------------------------------------------------
** Leer alumno aleatorio
**--------------------------------------------------------------------
*    SELECT SINGLE
*      FROM zdb_alumnos_sdm
*      FIELDS *
*      WHERE id = @lv_indice_random
*      INTO @DATA(ls_alumno_random).
*
*
*    IF sy-subrc = 0.
*      out->write( 'Alumno aleatorio:' ).
*      out->write( |Id: { ls_alumno_random-id }| ).
*      out->write( |Nombre: { ls_alumno_random-nombre }| ).
*    ELSE.
*      out->write( |No se encontró registro con ID { lv_indice_random }| ).
*    ENDIF.


* 3. Implementar un manera de insertar nuevos alumnos en la base de datos con su numero incremental,
*    asegurandose de que no están ya en la base de datos.

**--------------------------------------------------------------------
** Nombre del nuevo alumno
**--------------------------------------------------------------------
*    DATA(lv_new_nombre) = 'Delgado Martín, Sarah'.
*
**--------------------------------------------------------------------
** Comprueba si el alumno ya está en la base de datos
**--------------------------------------------------------------------
*    SELECT
*          FROM zdb_alumnos_sdm
*        FIELDS nombre
*         WHERE nombre = @lv_new_nombre
*          INTO @DATA(lv_existe).
*
*      IF sy-subrc <> 0.
**--------------------------------------------------------------------
** Obtener último ID
**--------------------------------------------------------------------
*        SELECT SINGLE FROM zdb_alumnos_sdm
*        FIELDS MAX( id )
*          INTO @DATA(lv_id_ult).
*
**--------------------------------------------------------------------
** ID del nuevo alumno
**--------------------------------------------------------------------
*        DATA(lv_new_id) = lv_id_ult + 1.
*
**--------------------------------------------------------------------
** Inserta el nuevo alumno en la tabla
**--------------------------------------------------------------------
*        INSERT zdb_alumnos_sdm FROM @( VALUE #( id = lv_new_id nombre = lv_new_nombre ) ).
*
*      ELSE.
*        out->write( 'El alumno ya se encuentra en la base de datos.' ).
*      ENDIF.






      ENDMETHOD.
ENDCLASS.
