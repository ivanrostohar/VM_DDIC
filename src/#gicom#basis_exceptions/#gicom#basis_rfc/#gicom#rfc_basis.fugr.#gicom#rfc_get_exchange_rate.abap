FUNCTION /gicom/rfc_get_exchange_rate.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_FROM_CURRENCY) TYPE  /GICOM/CURRENCY
*"     VALUE(IV_TO_CURRENCY) TYPE  /GICOM/CURRENCY
*"     VALUE(IV_DATE) TYPE  /GICOM/DATE
*"  EXPORTING
*"     VALUE(EV_EXCHANGE_RATE) TYPE  /GICOM/CURRENCY_FACTOR
*"     VALUE(EV_FROM_FACTOR) TYPE  /GICOM/CURRENCY_FACTOR
*"     VALUE(EV_TO_FACTOR) TYPE  /GICOM/CURRENCY_FACTOR
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA: lb_currency  TYPE REF TO /gicom/badi_ds_currency,
        lo_exception TYPE REF TO /gicom/cx_root_ds.

  GET BADI lb_currency.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_currency ).

      CALL BADI lb_currency->get_exchange_rate
        EXPORTING
          iv_from_currency = iv_from_currency
          iv_to_currency   = iv_to_currency
          iv_date          = iv_date
        IMPORTING
          ev_exchange_rate = ev_exchange_rate
          ev_from_factor   = ev_from_factor
          ev_to_factor     = ev_to_factor.

    CATCH /gicom/cx_root_ds INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).
  ENDTRY.


ENDFUNCTION.
