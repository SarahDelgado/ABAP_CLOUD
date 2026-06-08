CLASS zcl_global_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        i_nombre          TYPE ztab_usuario_sdm-nombre
        i_apellido        TYPE ztab_usuario_sdm-apellido
        i_telefono        TYPE ztab_usuario_sdm-telefono
        i_experiencia     TYPE i
        i_certificaciones TYPE i.

    METHODS calculo_sueldo.

    METHODS generar_id_empleado
      EXPORTING e_id_empleado TYPE ztab_usuario_sdm-id_empleado.

    METHODS alta_empleado.


  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: lv_id_empleado     TYPE ztab_usuario_sdm-id_empleado,
          lv_nombre          TYPE ztab_usuario_sdm-nombre,
          lv_apellido        TYPE ztab_usuario_sdm-apellido,
          lv_telefono        TYPE ztab_usuario_sdm-telefono,
          lv_sueldo          TYPE ztab_usuario_sdm-sueldo,
          lv_experiencia     TYPE i,
          lv_certificaciones TYPE i.
ENDCLASS.



CLASS zcl_global_sdm IMPLEMENTATION.

  METHOD constructor.

    me->lv_nombre = i_nombre.
    me->lv_apellido = i_apellido.
    me->lv_telefono = i_telefono.
    me->lv_experiencia = i_experiencia.
    me->lv_certificaciones = i_certificaciones.

  ENDMETHOD.

  METHOD calculo_sueldo.

    me->lv_sueldo = 1000 + ( lv_certificaciones * 50 ) + ( lv_experiencia * 100 ).

  ENDMETHOD.

  METHOD generar_id_empleado.

*    SELECT MAX( id_empleado )
*    FROM ztab_usuario_sdm
*    INTO TABLE @DATA( lt_max ).

*    if .
*
*    endif.




  ENDMETHOD.

  METHOD alta_empleado.

    calculo_sueldo(  ).

    generar_id_empleado(  ).

    "    "INSERT ( ) INTO TABLE ztab_usuario_sdm.

  ENDMETHOD.

ENDCLASS.
