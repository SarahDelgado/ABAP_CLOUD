CLASS zcl_obj_bloqueo_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_obj_bloqueo_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( 'El usuario ha empezado el programa.' ).

    TRY.
        DATA(lo_lock_object) = cl_abap_lock_object_factory=>get_instance( EXPORTING iv_name = 'EZINV_SDM' ).
      CATCH cx_abap_lock_failure.
        out->write( 'El objeto de instacia no se ha creado.' ).
        RETURN.
    ENDTRY.

    DATA lt_parameter TYPE if_abap_lock_object=>tt_parameter.

    lt_parameter = VALUE #( ( name = 'ID' value = REF #( '00000001' ) ) ).

    TRY.
        lo_lock_object->enqueue(
        it_parameter = lt_parameter

         ).

      CATCH cx_abap_foreign_lock cx_abap_lock_failure.
        out->write( 'El objeto ya esta siendo tratado por otro usuario.' ).
        RETURN.
    ENDTRY.

    out->write( 'El objeto ya está disponible.' ).


    IF sy-subrc = 0.
      out->write( 'La base de datos ha sido actualizada.' ).
    ENDIF.

    TRY.
        lo_lock_object->dequeue(  it_parameter = lt_parameter ).
      CATCH cx_abap_lock_failure.
        out->write( 'El objeto no ha sido liberado' ).
    ENDTRY.

    out->write( 'El objeto ha sido liberado' ).


  ENDMETHOD.
ENDCLASS.
