CLASS LHC_ZR_RECETAS_SDM DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrRecetasSdm
        RESULT result,
      validateTiempo FOR VALIDATE ON SAVE
            IMPORTING keys FOR ZrRecetasSdm~validateTiempo,
      setPublicada FOR DETERMINE ON MODIFY
            IMPORTING keys FOR ZrRecetasSdm~setPublicada,
      setInitialCategoria FOR DETERMINE ON SAVE
            IMPORTING keys FOR ZrRecetasSdm~setInitialCategoria.
ENDCLASS.

CLASS LHC_ZR_RECETAS_SDM IMPLEMENTATION.

  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.

  METHOD validateTiempo.
    READ ENTITIES OF ZR_RECETAS_SDM IN LOCAL MODE
      ENTITY ZrRecetasSdm
        FIELDS ( TiempoPrep ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_recetas).

      LOOP AT lt_recetas INTO DATA(ls_receta).
      "Validar si el tiempo está fuera del rango [1 - 600]
      IF ls_receta-TiempoPrep < 1 OR ls_receta-TiempoPrep > 600.
        "Marcar el registro como fallido para detener el guardado
        APPEND VALUE #( %tky = ls_receta-%tky ) TO failed-zrrecetassdm.
        "Añadir el mensaje de error a la estructura REPORTED
        APPEND VALUE #(
            %tky        = ls_receta-%tky
            %element-TiempoPrep = if_abap_behv=>mk-on " Ilumina el campo con error en la UI
            %msg        = new_message_with_text(
                            severity = if_abap_behv_message=>severity-error
                            text     = 'El tiempo de preparación debe estar entre 1 y 600 minutos.'
                          )
        ) TO reported-zrrecetassdm.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD setPublicada.
    MODIFY ENTITIES OF zr_recetas_sdm IN LOCAL MODE
      ENTITY ZrRecetasSdm
        UPDATE FIELDS ( Publicada ) WITH VALUE #( FOR key IN keys (
        %tky      = key-%tky
        Publicada = abap_true
    ) ).
  ENDMETHOD.

  METHOD setInitialCategoria.
    MODIFY ENTITIES OF zr_recetas_sdm IN LOCAL MODE
      ENTITY ZrRecetasSdm
        UPDATE FIELDS ( Categoria ) WITH VALUE #( FOR key IN keys (
        %tky      = key-%tky
        Categoria = 'N'
    ) ).
  ENDMETHOD.

ENDCLASS.
