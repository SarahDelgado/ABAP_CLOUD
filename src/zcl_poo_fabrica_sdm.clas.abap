CLASS zcl_poo_fabrica_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS carga_alumnos
      IMPORTING i_lt_lista_alumnos TYPE string_table
      RETURNING VALUE(e_resultado) TYPE string.
    METHODS carga_alumno
      IMPORTING i_alumno           TYPE string
      RETURNING VALUE(e_resultado) TYPE string.
    METHODS alumno_random
      RETURNING VALUE(e_alumno) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_poo_fabrica_sdm IMPLEMENTATION.

  METHOD carga_alumnos.
    DATA:
      lv_id     TYPE i,
      ls_alumno TYPE zdb_alumnos_sdm.

*--------------------------------------------------------------------
* Obtener último ID
*--------------------------------------------------------------------
    SELECT MAX( id )
      FROM zdb_alumnos_sdm
      INTO @lv_id.

    IF sy-subrc <> 0 OR lv_id IS INITIAL.
      lv_id = 0.
    ENDIF.

*--------------------------------------------------------------------
* Insertar alumnos
*--------------------------------------------------------------------
    LOOP AT i_lt_lista_alumnos INTO DATA(lv_nombre).

      lv_id += 1.

      INSERT zdb_alumnos_sdm FROM @( VALUE #( id = lv_id nombre = lv_nombre ) ).

      IF sy-subrc <> 0.
        e_resultado = |Error insertando:' { lv_nombre }|.
        EXIT.
      ENDIF.
    ENDLOOP.
    e_resultado = 'Carga correcta.'.
  ENDMETHOD.



  METHOD carga_alumno.
*--------------------------------------------------------------------
* Comprueba si el alumno ya está en la base de datos
*--------------------------------------------------------------------
    SELECT SINGLE nombre
      FROM zdb_alumnos_sdm
     WHERE nombre = @i_alumno
      INTO @DATA(lv_existe).

    IF sy-subrc <> 0.
*--------------------------------------------------------------------
* Obtener último ID
*--------------------------------------------------------------------
      SELECT MAX( id )
        FROM zdb_alumnos_sdm
        INTO @DATA(lv_id_ult).

*--------------------------------------------------------------------
* ID del nuevo alumno
*--------------------------------------------------------------------
      DATA(lv_new_id) = lv_id_ult + 1.

*--------------------------------------------------------------------
* Inserta el nuevo alumno en la tabla
*--------------------------------------------------------------------
      INSERT zdb_alumnos_sdm FROM @( VALUE #( id = lv_new_id nombre = i_alumno ) ).

      e_resultado = 'Alumno añadido correctamente'.
    ELSE.
      e_resultado = 'El alumno ya se encuentra en la base de datos.'.
    ENDIF.
  ENDMETHOD.



  METHOD alumno_random.
*--------------------------------------------------------------------
* Obtener último ID
*--------------------------------------------------------------------
    DATA lv_last_id TYPE i.
    SELECT MAX( id )
      FROM zdb_alumnos_sdm
      INTO @lv_last_id.

    IF lv_last_id = 0.
      e_alumno = 'La tabla de alumnos está vacía.'.
      RETURN.
    ENDIF.

*--------------------------------------------------------------------
* Crear generador aleatorio
*--------------------------------------------------------------------
    DATA(lv_random) = cl_abap_random_int=>create(
                  seed = cl_abap_random=>seed( )
                  min  = 1
                  max  = lv_last_id ).

*--------------------------------------------------------------------
* Obtener número aleatorio
*--------------------------------------------------------------------
    DATA(lv_indice_random) = lv_random->get_next( ).

*--------------------------------------------------------------------
* Leer alumno aleatorio
*--------------------------------------------------------------------
    SELECT SINGLE nombre
      FROM zdb_alumnos_sdm
      WHERE id = @lv_indice_random
      INTO @e_alumno.

    IF sy-subrc <> 0.
      e_alumno = |No se encontró registro con ID { lv_indice_random }|.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
