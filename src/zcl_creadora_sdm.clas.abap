CLASS zcl_creadora_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "Ejercicio 2.1: Creación del tipo para la tabla que va contener los datos del empleado.
    TYPES tty_emp TYPE STANDARD TABLE OF ztab_eje_obj_sdm WITH EMPTY KEY.

    "Ejercicio 2.3: Creación del constructor de la clase
    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter iv_nombre | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter iv_apellido | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter iv_telefono | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter iv_experiencia | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter iv_certificaciones | <p class="shorttext synchronized" lang="en"></p>
    METHODS constructor
      IMPORTING
        iv_nombre          TYPE zde_nombre_sdm
        iv_apellido        TYPE zde_nombre_sdm
        iv_telefono        TYPE zde_tele_sdm
        iv_experiencia     TYPE i
        iv_certificaciones TYPE i.

    "Ejercicio 2.4: Creación del método clacular_sueldo para calcular el sueldo del empleado y guardarlo en la estructura ls_prueba
    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    METHODS clacular_sueldo.

    "Ejercicio 2.5: Creación del método ex_id_empleado para generar el siguiente id_empleado disponible.
    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    METHODS ex_id_empleado.

    "Ejercicio 2.6: Creación del método alta_empleado para actualizar la base datos con el nuevo empleado o modificar los datos de uno ya existente
    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter rv_mensaje | <p class="shorttext synchronized" lang="en"></p>
    METHODS alta_empleado
      RETURNING
        VALUE(rv_mensaje) TYPE string.

    "Ejercicio 2.7: Creación del método modificacion para modificar los datos de un empleado que se encuentre en la base de datos
    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter iv_id_empleado | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter iv_nombre | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter iv_apellido | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter iv_telefono | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter iv_experiencia | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter iv_certificaciones | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter rv_mensaje | <p class="shorttext synchronized" lang="en"></p>
    METHODS modificacion
      IMPORTING
        iv_id_empleado     TYPE i
        iv_nombre          TYPE zde_nombre_sdm
        iv_apellido        TYPE zde_nombre_sdm
        iv_telefono        TYPE zde_tele_sdm
        iv_experiencia     TYPE i
        iv_certificaciones TYPE i
      RETURNING
        VALUE(rv_mensaje)  TYPE string.

    "Ejercicio 2.8: Creación del método traer_lt para leer los empleados de la base de datos
    "!
    "!
    "! @parameter iv_id_empleado | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter rv_tabla | <p class="shorttext synchronized" lang="en"></p>
    METHODS traer_lt
      IMPORTING
        iv_id_empleado  TYPE i
      RETURNING
        VALUE(rv_tabla) TYPE tty_emp.

    "Ejercicio 2.9: Creación del método traer_n_filas para leer n primeras filas de la base de datos de empleados
    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter iv_n_filas | Numero de filas a traer de la tabla de la base de datos
    "! @parameter rv_tabla | Tabla que contiene los registros obtenidos de la base de datos
    METHODS traer_n_filas
      IMPORTING
        iv_n_filas      TYPE i
      RETURNING
        VALUE(rv_tabla) TYPE tty_emp.


  PROTECTED SECTION.
  PRIVATE SECTION.
    "Ejercicio 2.2: Atributos privados de la clase
    DATA lt_registro     TYPE tty_emp. "Tabla interna de trabajo para las lecturas
    DATA ls_prueba       TYPE ztab_eje_obj_sdm. "Estructura de trabajo con los datos del empleado actual
    DATA experiencia     TYPE i. "Años de experiencia
    DATA id_empleado     TYPE i. "ID del empleado (para modificaciones)
    DATA certificaciones TYPE i. "Número de certificaciones

ENDCLASS.



CLASS zcl_creadora_sdm IMPLEMENTATION.

  METHOD constructor.

    me->ls_prueba-nombre = iv_nombre.
    me->ls_prueba-apellido = iv_apellido.
    me->ls_prueba-telefono = iv_telefono.
    me->experiencia = iv_experiencia.
    me->certificaciones = iv_certificaciones.
    me->ls_prueba-currency_code = 'EUR'.

  ENDMETHOD.


  METHOD clacular_sueldo.

    me->ls_prueba-sueldo = ( certificaciones * 50 + experiencia * 100 ) + 1000.

  ENDMETHOD.


  METHOD ex_id_empleado.

    SELECT MAX( id_empleado )
    FROM ztab_eje_obj_sdm
    INTO @DATA(lv_id_max).

    IF sy-subrc = 0.
      ls_prueba-id_empleado = lv_id_max + 1.
    ELSE.
      ls_prueba-id_empleado = 1.
    ENDIF.

  ENDMETHOD.


  METHOD alta_empleado.

    clacular_sueldo( ).

    IF ls_prueba-id_empleado IS NOT INITIAL.
      ls_prueba-id_empleado = id_empleado.
    ELSE.
      ex_id_empleado( ).
    ENDIF.

    MODIFY ztab_eje_obj_sdm FROM @ls_prueba.

    IF sy-subrc = 0.
      COMMIT WORK.
      rv_mensaje = 'Subida correcta.'.
    ELSE.
      rv_mensaje = 'Error en la Subida.'.
    ENDIF.

  ENDMETHOD.


  METHOD modificacion.

    me->id_empleado = iv_id_empleado.
    me->ls_prueba-nombre = iv_nombre.
    me->ls_prueba-apellido = iv_apellido.
    me->ls_prueba-telefono = iv_telefono.
    me->experiencia = iv_experiencia.
    me->certificaciones = iv_certificaciones.
    me->ls_prueba-currency_code = 'EUR'.

    SELECT SINGLE @abap_true
    FROM ztab_eje_obj_sdm
    WHERE id_empleado = @me->id_empleado
    INTO @DATA(lv_existe).

    IF sy-subrc = 0. "Se puede usar la variable lv_existe
      rv_mensaje = alta_empleado( ).
    ELSE.
      rv_mensaje = 'El ID no existe en la base de datos, no se a podido hacer la modificación.'.
    ENDIF.

  ENDMETHOD.


  METHOD traer_lt.

    IF iv_id_empleado = 0.
      SELECT *
      FROM ztab_eje_obj_sdm
      ORDER BY id_empleado
      INTO TABLE @lt_registro.

    ELSE.
      SELECT *
        FROM ztab_eje_obj_sdm
        WHERE id_empleado = @iv_id_empleado
        ORDER BY id_empleado
        INTO TABLE @lt_registro.
    ENDIF.

    rv_tabla = lt_registro.

  ENDMETHOD.

  METHOD traer_n_filas.

    SELECT *
    FROM ztab_eje_obj_sdm
    INTO TABLE @rv_tabla
    UP TO @iv_n_filas ROWS.

  ENDMETHOD.

ENDCLASS.
