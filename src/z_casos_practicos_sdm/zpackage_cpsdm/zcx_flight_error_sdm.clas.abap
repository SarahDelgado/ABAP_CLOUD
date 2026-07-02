"! Excepción para la gestión de errores de vuelos
"! Clase de excepción estática utilizada para interrumpir el flujo del programa
"! ante fallos de validación en el motor de vuelos (precios incorrectos o duplicados).
CLASS zcx_flight_error_sdm DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    "! Mensaje descriptivo del error
    "! Almacena de forma dinámica el texto explicativo del fallo de negocio
    "! para que pueda ser leído desde la capa de presentación en el bloque CATCH.
    DATA mensaje TYPE string.

    "! Constructor de la clase de excepción
    "! Constructor extendido para permitir la captura del mensaje personalizado.
    "!
    "! @parameter textid   | Clave de texto estándar de la interfaz de mensajes
    "! @parameter previous | Referencia a una excepción previa para el encadenamiento
    "! @parameter mensaje  | Cadena de texto con la descripción detallada del error de validación
    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        mensaje   TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_flight_error_sdm IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
      previous = previous
    ).

    " Se añade la asignación local del parámetro de entrada al atributo de la clase
    me->mensaje = mensaje.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
