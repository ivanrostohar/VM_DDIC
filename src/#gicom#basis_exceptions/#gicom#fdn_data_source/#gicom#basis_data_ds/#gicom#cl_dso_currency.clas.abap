CLASS /gicom/cl_dso_currency DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_currency .
    INTERFACES if_badi_interface
      ALL METHODS ABSTRACT .

    ALIASES get_exchange_rate
      FOR /gicom/if_dso_currency~get_exchange_rate .
    ALIASES select
      FOR /gicom/if_dso_currency~select .
    ALIASES select_for_mandt
      FOR /gicom/if_dso_currency~select_for_mandt .
    ALIASES insert_currencies
      FOR /gicom/if_dso_currency~insert_currencies .
    ALIASES delete_currencies
      FOR /gicom/if_dso_currency~delete_currencies .
    ALIASES read_currencies
      FOR /gicom/if_dso_currency~read_currencies .

  PRIVATE SECTION.

    METHODS
      get_badi
        RETURNING VALUE(rb_badi) TYPE REF TO /gicom/badi_ds_currency.

ENDCLASS.



CLASS /gicom/cl_dso_currency IMPLEMENTATION.


  METHOD /gicom/if_dso_currency~get_exchange_rate.
    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->get_exchange_rate
      EXPORTING
        iv_from_currency = iv_from_currency
        iv_to_currency   = iv_to_currency
        iv_date          = iv_date
      IMPORTING
        ev_exchange_rate = ev_exchange_rate
        ev_from_factor   = ev_from_factor
        ev_to_factor     = ev_to_factor.
  ENDMETHOD.


  METHOD /gicom/if_dso_currency~select.
    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->select
      EXPORTING
        it_currencies = it_currencies
      RECEIVING
        rt_currencies = rt_currencies.

  ENDMETHOD.


  METHOD /gicom/if_dso_currency~select_for_mandt.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->select_for_mandt
      EXPORTING
        iv_mandt    = iv_mandt
      RECEIVING
        rv_currency = rv_currency.

  ENDMETHOD.


  METHOD get_badi.
    GET BADI rb_badi.
  ENDMETHOD.

  METHOD delete_currencies.

    DELETE FROM /gicom/_curr.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD insert_currencies.

    DATA lt_currencies TYPE TABLE OF /gicom/_curr.

    lt_currencies = CORRESPONDING #( it_currencies ).

    INSERT /gicom/_curr FROM TABLE lt_currencies ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_CURR' SY-SUBRC.

     ENDIF.

  ENDMETHOD.

  METHOD read_currencies.

     "Generating WHERE clause
    IF it_selopt IS NOT INITIAL.
      DATA(lv_where) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
        it_selopt   = it_selopt
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
          RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lx_exception ) .
      ENDTRY.
    ENDIF.

    SELECT
      *
    FROM
      /gicom/_curr
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_currencies
    WHERE
      (lv_where).

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).
    ENDIF.


  ENDMETHOD.

ENDCLASS.
