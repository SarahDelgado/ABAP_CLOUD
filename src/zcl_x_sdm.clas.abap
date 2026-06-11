CLASS zcl_x_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_x_sdm IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " 1. Declaramos las tablas internas usando exactamente los tipos de tus tablas destino
    DATA lt_carrier_dest TYPE STANDARD TABLE OF /lrn/carrier WITH DEFAULT KEY.
    DATA lt_conn_dest    TYPE STANDARD TABLE OF /lrn/connection WITH DEFAULT KEY.
    DATA lt_pass_dest    TYPE STANDARD TABLE OF /lrn/passflight WITH DEFAULT KEY.
    DATA lt_cargo_dest   TYPE STANDARD TABLE OF /lrn/cargoflight WITH DEFAULT KEY.
    DATA lt_airport_dest TYPE STANDARD TABLE OF /lrn/airport WITH DEFAULT KEY.

    " 2. Limpiamos tus tablas actuales para empezar desde cero
    DELETE FROM /lrn/carrier.
    DELETE FROM /lrn/connection.
    DELETE FROM /lrn/passflight.
    DELETE FROM /lrn/cargoflight.
    DELETE FROM /lrn/airport.

    " 3. Leemos de la tabla maestro de aerolíneas de SAP
    SELECT FROM /dmo/carrier
    FIELDS carrier_id,
           name,
           currency_code,
           local_created_by,
           local_created_at,
           local_last_changed_by,
           local_last_changed_at,
           last_changed_at
    INTO CORRESPONDING FIELDS OF TABLE @lt_carrier_dest.

    " 4. Leemos de la tabla maestro de conexiones de SAP
    SELECT FROM /dmo/connection
    FIELDS carrier_id,
           connection_id,
           airport_from_id,
           airport_to_id,
           departure_time,
           arrival_time,
           distance,
           distance_unit
    INTO CORRESPONDING FIELDS OF TABLE @lt_conn_dest.

    " 5. Leemos de las tablas maestro de SAP mapeando directamente a la estructura destino
    SELECT FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           flight_date,
           plane_type_id,
           seats_max,
           seats_occupied,
           price,
           currency_code
    INTO CORRESPONDING FIELDS OF TABLE @lt_pass_dest.

    " 6. Leemos y armamos los datos para la tabla de carga mapeando a su estructura destino
    SELECT FROM /dmo/flight AS f
      INNER JOIN /dmo/connection AS c
        ON f~carrier_id = c~carrier_id AND f~connection_id = c~connection_id
    FIELDS f~carrier_id,
           f~connection_id,
           f~flight_date,
           f~plane_type_id,
           CAST( 100000 AS DEC( 10, 2 ) ) AS maximum_load,
           CAST( 85000 AS DEC( 10, 2 ) )  AS actual_load,
           CAST( 'KG' AS CHAR( 2 ) )      AS load_unit,
           c~airport_from_id,
           c~airport_to_id,
           c~departure_time,
           c~arrival_time
    INTO CORRESPONDING FIELDS OF TABLE @lt_cargo_dest.

    " 6b. Leemos de la tabla maestro determinando la timezone con códigos 100% seguros de SAP (Máx 6 caracteres)
    SELECT FROM /dmo/airport
    FIELDS airport_id,
           name,
           city,
           country,
           CASE country
             WHEN 'DE' THEN 'CET'          " Alemania
             WHEN 'FR' THEN 'CET'          " Francia
             WHEN 'AT' THEN 'CET'          " Austria
             WHEN 'CH' THEN 'CET'          " Suiza
             WHEN 'NL' THEN 'CET'          " Países Bajos
             WHEN 'IT' THEN 'CET'          " Italia
             WHEN 'ES' THEN 'CET'          " España
             WHEN 'UK' THEN 'GMT'          " Reino Unido
             WHEN 'RU' THEN 'UTC+3'        " Rusia (Moscú) -> Reemplazado MCK por UTC+3 para asegurar compatibilidad
             WHEN 'US' THEN 'EST'          " Estados Unidos
             WHEN 'CA' THEN 'EST'          " Canadá
             WHEN 'MX' THEN 'CST'          " México
             WHEN 'BR' THEN 'UTC-3'        " Brasil (Brasilia) -> Reemplazado BRST por el genérico infalible UTC-3
             WHEN 'CU' THEN 'CST'          " Cuba
             WHEN 'AU' THEN 'UTC+10'       " Australia (Sídney/Melbourne) -> Reemplazado AUSACT por el estándar UTC+10
             WHEN 'ZW' THEN 'CAT'          " Zimbabue
             WHEN 'SA' THEN 'AST'          " Arabia Saudita
             WHEN 'JP' THEN 'JAPAN'        " Japón -> ¡CORREGIDO! (Evita el DUMP de JST, mide 5 caracteres)
             WHEN 'SG' THEN 'UTC+8'        " Singapur -> (Evita el DUMP original de SGT, 5 caracteres)
             WHEN 'MY' THEN 'UTC+8'        " Malasia -> (Misma zona que Singapur, 5 caracteres)
             WHEN 'CN' THEN 'CHINA'        " China (5 caracteres exactos, estándar nativo de SAP)
             WHEN 'TH' THEN 'UTC+7'        " Tailandia -> Reemplazado THA por el formato seguro UTC+7
             ELSE 'UTC'                    " Por si acaso
           END AS timzone
    INTO CORRESPONDING FIELDS OF TABLE @lt_airport_dest.

    " 7. Insertamos los datos limpios en tus tablas locales
    IF lt_carrier_dest IS NOT INITIAL.
        INSERT /lrn/carrier FROM TABLE @lt_carrier_dest.
    ENDIF.

    IF lt_conn_dest IS NOT INITIAL.
        INSERT /lrn/connection FROM TABLE @lt_conn_dest.
    ENDIF.

    IF lt_pass_dest IS NOT INITIAL.
        INSERT /lrn/passflight FROM TABLE @lt_pass_dest.
    ENDIF.

    IF lt_cargo_dest IS NOT INITIAL.
        INSERT /lrn/cargoflight FROM TABLE @lt_cargo_dest.
    ENDIF.

    IF lt_airport_dest IS NOT INITIAL.
        INSERT /lrn/airport FROM TABLE @lt_airport_dest.
    ENDIF.

    " 8. Mensaje de confirmación final
    out->write( '¡Listo! Tablas actualizadas con zonas horarias globales estándar (JAPAN, CHINA, UTC+X).' ).

  ENDMETHOD.
ENDCLASS.
