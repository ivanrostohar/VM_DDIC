CLASS /gicom/cl_dso_paymterm DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES /gicom/if_dso_paymterm .

    ALIASES select_data
      FOR /gicom/if_dso_paymterm~select_data .
    ALIASES insert_payment_terms
      FOR /gicom/if_dso_paymterm~insert_payment_terms .
    ALIASES delete_payment_terms
      FOR /gicom/if_dso_paymterm~delete_payment_terms .
    ALIASES read_payment_terms
     FOR /gicom/if_dso_paymterm~read_payment_terms .



  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS get_badi
      RETURNING
        VALUE(rb_dso_paymterm) TYPE REF TO /gicom/badi_ds_paymterm .
ENDCLASS.



CLASS /gicom/cl_dso_paymterm IMPLEMENTATION.


  METHOD select_data.
***********************************************************************
*** Get DSO Badi Instance
***********************************************************************

    DATA(lb_dso_paymterm) = get_badi( ).

***********************************************************************
*** Invoke DSO Method to get payment terms
***********************************************************************

    TRY.
        CALL BADI lb_dso_paymterm->select_data
          IMPORTING
            et_paymterm     = et_paymterm
            et_paymterm_txt = et_paymterm_txt.

      CATCH /gicom/cx_root_ds.
        RAISE EXCEPTION TYPE /gicom/cx_internal_error.
    ENDTRY.
  ENDMETHOD.


  METHOD get_badi.
    GET BADI rb_dso_paymterm.
  ENDMETHOD.

  METHOD delete_payment_terms.

    DELETE FROM /gicom/_paytrm.
    DELETE FROM /gicom/_paytrm_t.

    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD insert_payment_terms.

    DATA : lt_payment_terms      TYPE TABLE OF /gicom/_paytrm,
           lt_payment_terms_text TYPE TABLE OF /gicom/_paytrm_t.

    lt_payment_terms = CORRESPONDING #( it_payment_terms ).

    LOOP AT lt_payment_terms ASSIGNING FIELD-SYMBOL(<ls_payment_term>).
      <ls_payment_term>-counter = sy-tabix.
    ENDLOOP.

    INSERT /gicom/_paytrm FROM TABLE lt_payment_terms ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_PAYTRM'  sy-subrc.

    ENDIF.

    lt_payment_terms_text = CORRESPONDING #( it_payment_terms_text ).

    LOOP AT lt_payment_terms_text ASSIGNING FIELD-SYMBOL(<ls_payment_term_text>).
      <ls_payment_term_text>-counter = sy-tabix.
    ENDLOOP.

    INSERT /gicom/_paytrm_t FROM TABLE lt_payment_terms_text ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_PAYTRM_T' sy-subrc.

    ENDIF.

  ENDMETHOD.

  METHOD read_payment_terms.

    DATA(lv_language) = /gicom/cl_system=>get_language(  ).
    "Generating WHERE clause
    IF it_selopt IS NOT INITIAL.
      DATA(lv_where) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
        it_selopt    = it_selopt
        iv_statement = '2'
      ).
    ENDIF.

    "Security check: check where clause
    IF lv_where NE space.
      DATA(lv_whilelist) = lv_where.
      TRY.
          lv_where = cl_abap_dyn_prg=>check_whitelist_str(
                       val       = lv_where
                       whitelist = lv_whilelist
                     ).

        CATCH cx_abap_not_in_whitelist INTO DATA(lx_exception).
          RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lx_exception ).
      ENDTRY.
    ENDIF.

    SELECT
      *
    FROM
      /gicom/_paytrm
    INTO
      CORRESPONDING FIELDS OF TABLE @et_payment_terms
    WHERE
      (lv_where).

   IF et_payment_terms IS NOT INITIAL.

      SELECT
        *
      FROM
        /gicom/_paytrm_t
      FOR ALL ENTRIES IN @et_payment_terms
      WHERE
        id     =  @et_payment_terms-id AND
        value  =  @et_payment_terms-value AND
        days   =  @et_payment_terms-days AND
        langu  =  @lv_language
      INTO
        CORRESPONDING FIELDS OF TABLE @et_payment_terms_text.

    ELSE.

      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).

    ENDIF.


ENDMETHOD.

ENDCLASS.
