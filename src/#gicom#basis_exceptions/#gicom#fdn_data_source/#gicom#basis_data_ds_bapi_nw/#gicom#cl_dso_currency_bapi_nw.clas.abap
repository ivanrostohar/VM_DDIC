CLASS /gicom/cl_dso_currency_bapi_nw DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cl_dso_currency
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /gicom/if_dso_currency~get_exchange_rate
        REDEFINITION .
    METHODS /gicom/if_dso_currency~select
        REDEFINITION .
    METHODS /gicom/if_dso_currency~select_for_mandt
        REDEFINITION .
  PROTECTED SECTION.
ENDCLASS.



CLASS /GICOM/CL_DSO_CURRENCY_BAPI_NW IMPLEMENTATION.


  METHOD /gicom/if_dso_currency~get_exchange_rate.

    DATA:
      lv_exchange_rate TYPE ukurs_curr,
      lv_from_factor   TYPE /gicom/currency_factor,
      lv_to_factor     TYPE /gicom/currency_factor.

    CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
      EXPORTING
        date             = iv_date
        foreign_amount   = 1
        foreign_currency = iv_from_currency
        local_currency   = iv_to_currency
      IMPORTING
        exchange_rate    = lv_exchange_rate
        foreign_factor   = lv_from_factor
        local_factor     = lv_to_factor
      EXCEPTIONS
        no_rate_found    = 1
        overflow         = 2
        no_factors_found = 3
        no_spread_found  = 4
        derived_2_times  = 5.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_not_found.
    ENDIF.


    IF lv_exchange_rate < 0.
      ev_exchange_rate = 1 / ( - lv_exchange_rate ).
      ev_from_factor = lv_to_factor.
      ev_to_factor = lv_from_factor.
    ELSE.
      ev_exchange_rate = lv_exchange_rate.
      ev_from_factor = lv_from_factor.
      ev_to_factor = lv_to_factor.
    ENDIF.

  ENDMETHOD.


  METHOD /gicom/if_dso_currency~select.
    DATA:
      lt_temp     TYPE TABLE OF bapi1090_2,
      lt_detail   TYPE TABLE OF bapi1090_2,
      ls_decimals TYPE bapi1090_1,
      ls_result   TYPE bapireturn,
      ls_details  TYPE bapi1090_2,
      ls_currency TYPE /gicom/currency_st.

    CALL FUNCTION 'BAPI_CURRENCY_GETLIST'
      IMPORTING
        return        = ls_result
      TABLES
        currency_list = lt_temp.

    IF ls_result IS NOT INITIAL.
      RETURN.
    ENDIF.

    IF it_currencies IS INITIAL.
      lt_detail = lt_temp.
    ELSE.
      LOOP AT it_currencies INTO DATA(lv_currency).
        READ TABLE lt_temp WITH KEY currency = lv_currency INTO ls_details.

        IF ls_details IS NOT INITIAL.
          APPEND ls_details TO lt_detail.
          CLEAR ls_details.
        ENDIF.
      ENDLOOP.
    ENDIF.

    LOOP AT lt_detail INTO ls_details.
      CALL FUNCTION 'BAPI_CURRENCY_GETDECIMALS'
        EXPORTING
          currency          = ls_details-currency
        IMPORTING
          currency_decimals = ls_decimals
          return            = ls_result.

      IF ls_result IS INITIAL.
        ls_currency-currency     = ls_details-currency.
        ls_currency-currency_iso = ls_details-currency_iso.
        ls_currency-alt_curr     = ls_details-alt_curr.
        ls_currency-valid_to     = ls_details-valid_to.
        ls_currency-long_text    = ls_details-long_text.
        ls_currency-decimals     = ls_decimals-curdecimals.

        APPEND ls_currency TO rt_currencies.
        CLEAR ls_currency.
      ENDIF.

      CLEAR ls_details.
    ENDLOOP.

  ENDMETHOD.


  METHOD /gicom/if_dso_currency~select_for_mandt.

    DATA: lt_t000   TYPE TABLE OF t000,
          lv_system TYPE lissystem-sysnam.

    lv_system = sy-sysid.

    CALL FUNCTION 'LIS_MGR_GET_SAP_CLIENTS'
      EXPORTING
        iv_system = lv_system
      TABLES
        et_t000   = lt_t000.

    IF iv_mandt IS NOT INITIAL.
      IF line_exists( lt_t000[ mandt = iv_mandt ] ).
        rv_currency = lt_t000[ mandt = iv_mandt ]-mwaer.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
