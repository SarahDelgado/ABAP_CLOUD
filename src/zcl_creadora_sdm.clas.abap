CLASS zcl_creadora_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Ejercicio 2.1: Creación del tipo para la tabla que va contener los datos del empleado.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    TYPES tty_emp TYPE STANDARD TABLE OF ztab_eje_obj_sdm WITH EMPTY KEY.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Ejercicio 2.3: Creación del constructor de la clase
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "! Constructor de la clase.
    "!
    "! @parameter iv_nombre | Nombre del empleado.
    "! @parameter iv_apellido | Apellido del empleado.
    "! @parameter iv_telefono | Telefono del empleado.
    "! @parameter iv_experiencia | Experiencia del empleado.
    "! @parameter iv_certificaciones | Certificaciones del empleado.
    METHODS constructor
      IMPORTING
        iv_nombre          TYPE zde_nombre_sdm
        iv_apellido        TYPE zde_nombre_sdm
        iv_telefono        TYPE zde_tele_sdm
        iv_experiencia     TYPE i
        iv_certificaciones TYPE i.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Ejercicio 2.6: Creación del método alta_empleado para actualizar la base datos con el nuevo empleado o modificar los datos de uno ya existente
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "! Realiza el alta de un nuevo empleado o la actualización de uno existente tras calcular su sueldo.
    "! Si el empleado es nuevo, genera automáticamente un identificador único.
    "!
    "! @parameter rv_mensaje | Mensaje de texto con el resultado de la operación.
    METHODS alta_empleado
      RETURNING
        VALUE(rv_mensaje) TYPE string.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Ejercicio 2.7: Creación del método modificacion para modificar los datos de un empleado que se encuentre en la base de datos
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "! Modifica los datos de un empleado existente en la base de datos tras validar su existencia.
    "!
    "! @parameter iv_id_empleado | Identificador único del empleado a modificar.
    "! @parameter iv_nombre | Nuevo nombre del empleado.
    "! @parameter iv_apellido | Nuevo apellido del empleado.
    "! @parameter iv_telefono | Nuevo teléfono del empleado.
    "! @parameter iv_experiencia | Nuevos años de experiencia del empleado.
    "! @parameter iv_certificaciones | Nuevo número de certificaciones del empleado.
    "! @parameter rv_mensaje | Mensaje de texto con el resultado de la operación.
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

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Ejercicio 2.8: Creación del método traer_lt para leer los empleados de la base de datos
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "! Lee y devuelve los registros de empleados desde la base de datos filtrando por ID.
    "! Si el ID proporcionado es 0, recupera todos los empleados de la tabla.
    "!
    "! @parameter iv_id_empleado | Identificador del empleado a buscar (0 para traer todos).
    "! @parameter rv_tabla | Tabla interna que contiene los registros encontrados.
    METHODS traer_lt
      IMPORTING
        iv_id_empleado  TYPE i
      RETURNING
        VALUE(rv_tabla) TYPE tty_emp.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Ejercicio 2.9: Creación del método traer_n_filas para leer n primeras filas de la base de datos de empleados
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "! Lee y devuelve un número máximo de registros (N primeras filas) desde la base de datos de empleados.
    "! 
    "! @parameter iv_n_filas | Numero máximo de filas a traer de la tabla de la base de datos.
    "! @parameter rv_tabla | Tabla que contiene los registros obtenidos de la base de datos.
    METHODS traer_n_filas
      IMPORTING
        iv_n_filas      TYPE i
      RETURNING
        VALUE(rv_tabla) TYPE tty_emp.


  PROTECTED SECTION.
  PRIVATE SECTION.

    """""""""""""""""""""""""""""""""""""""""""""""""""
    "Ejercicio 2.2: Atributos privados de la clase
    """""""""""""""""""""""""""""""""""""""""""""""""""
    DATA lt_registro     TYPE tty_emp. "Tabla interna de trabajo para las lecturas
    DATA ls_prueba       TYPE ztab_eje_obj_sdm. "Estructura de trabajo con los datos del empleado actual
    DATA experiencia     TYPE i. "Años de experiencia del empleado
    DATA id_empleado     TYPE i. "ID del empleado (para modificaciones)
    DATA certificaciones TYPE i. "Número de certificaciones del empleado

   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Ejercicio 2.4: Creación del método calcular_sueldo para calcular el sueldo del empleado y guardarlo en la estructura ls_prueba
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "! Calcula de forma interna el sueldo del empleado basándose en sus certificaciones y experiencia.
    "! El resultado se almacena directamente en el componente correspondiente de la estructura interna 'ls_prueba'.
    METHODS calcular_sueldo.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Ejercicio 2.5: Creación del método ex_id_empleado para generar el siguiente id_empleado disponible.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "! Busca el valor máximo del ID de empleado en la base de datos para calcular y asignar el siguiente ID secuencial disponible.
    "! Si la tabla está vacía, inicializa el ID con el valor 1.
    METHODS ex_id_empleado.

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


  METHOD calcular_sueldo.

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

    calcular_sueldo( ).

    IF ls_prueba-id_empleado > 0.
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
