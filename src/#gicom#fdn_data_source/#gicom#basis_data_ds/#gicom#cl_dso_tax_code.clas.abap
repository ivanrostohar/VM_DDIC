CLASS /gicom/cl_dso_tax_code DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_tax_code .
    INTERFACES if_badi_interface .

    ALIASES read_tax_data
      FOR /gicom/if_dso_tax_code~read_tax_data .
    ALIASES select_tax_codes
      FOR /gicom/if_dso_tax_code~select_tax_codes .
    ALIASES insert_tax_codes
      FOR /gicom/if_dso_tax_code~insert_tax_codes .
    ALIASES delete_tax_codes
      FOR /gicom/if_dso_tax_code~delete_tax_codes .
    ALIASES read_tax_codes
      FOR /gicom/if_dso_tax_code~read_tax_codes .

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS /gicom/cl_dso_tax_code IMPLEMENTATION.


  METHOD read_tax_data.

    DATA: lb_dso_tax_code TYPE REF TO /gicom/badi_ds_tax_code.

    GET BADI lb_dso_tax_code.

    CALL BADI lb_dso_tax_code->read_tax_data
      EXPORTING
        iv_tax_code = iv_tax_code
        iv_country  = iv_country
      RECEIVING
        rs_tax      = rs_tax.

  ENDMETHOD.


  METHOD /gicom/if_dso_tax_code~select_tax_codes.
    DATA: lb_dso_tax_code TYPE REF TO /gicom/badi_ds_tax_code.
    GET BADI lb_dso_tax_code.

    CALL BADI lb_dso_tax_code->select_tax_codes
      RECEIVING
        rt_tax_codes = rt_tax_codes.
  ENDMETHOD.

  METHOD /gicom/if_dso_tax_code~delete_tax_codes.

    DELETE FROM /gicom/_tax_rate.
    DELETE FROM /gicom/_tax_ratt.

    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.


  ENDMETHOD.

  METHOD /gicom/if_dso_tax_code~insert_tax_codes.

    DATA : lt_tax_codes      TYPE TABLE OF /gicom/_tax_rate,
           lt_tax_codes_text TYPE TABLE OF /gicom/_tax_ratt.

    lt_tax_codes = CORRESPONDING #(  it_tax_codes ).

    INSERT /gicom/_tax_rate FROM TABLE lt_tax_codes ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_TAX_RATE' sy-subrc.

    ENDIF.

    lt_tax_codes_text = CORRESPONDING #(  it_tax_codes_text ).

    INSERT /gicom/_tax_ratt FROM TABLE lt_tax_codes_text ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_TAX_RATE' sy-subrc.

    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_tax_code~read_tax_codes.

    DATA(lv_language) = /gicom/cl_system=>get_language(  ).

    DATA lt_selopt_title TYPE ddshselops.
    DATA lt_selopt_not_title TYPE ddshselops.


    LOOP AT it_selopt ASSIGNING FIELD-SYMBOL(<ls_selopt>).
      IF <ls_selopt>-shlpfield = 'TITLE'.
        APPEND <ls_selopt> TO lt_selopt_title.
      ELSE.
        APPEND <ls_selopt> TO lt_selopt_not_title.
      ENDIF.
    ENDLOOP.

    IF lt_selopt_title IS NOT INITIAL.
      DATA(lv_where_title) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
        it_selopt    = lt_selopt_title
        iv_statement = '2'
      ).
    ENDIF.

    IF lt_selopt_not_title IS NOT INITIAL.
      DATA(lv_where_not_title) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
        it_selopt    = lt_selopt_not_title
        iv_statement = '2'
      ).
    ENDIF.


    SELECT
      *
    FROM
      /gicom/_tax_rate
    INTO
      CORRESPONDING FIELDS OF TABLE @et_tax_codes
    WHERE
      (lv_where_not_title).

    LOOP AT et_tax_codes ASSIGNING FIELD-SYMBOL(<ls_tax_code>).

      IF lt_selopt_not_title IS NOT INITIAL.

        SELECT
          *
        FROM
          /gicom/_tax_ratt
        WHERE
          langu = @lv_language AND
          tax_code = @<ls_tax_code>-tax_code AND
          country = @<ls_tax_code>-country
        INTO
          CORRESPONDING FIELDS OF TABLE @et_tax_codes_text.

      ELSE.

        SELECT
         *
        FROM
          /gicom/_tax_ratt
        WHERE
          (lv_where_title)
        INTO
          CORRESPONDING FIELDS OF TABLE @et_tax_codes_text.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
