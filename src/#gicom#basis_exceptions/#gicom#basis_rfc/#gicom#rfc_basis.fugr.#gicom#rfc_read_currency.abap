FUNCTION /gicom/rfc_read_currency.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IT_CURRENCIES) TYPE  /GICOM/CURRENCY_TTY
*"  EXPORTING
*"     VALUE(ET_CURRENCIES) TYPE  /GICOM/CURRENCY_ST_TTY
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA: lo_exception     TYPE REF TO /gicom/cx_root_ds,
        ls_gicom_bapiret TYPE /gicom/bapiret2.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_currency ).

      et_currencies = NEW /gicom/cl_dso_currency( )->select( it_currencies = it_currencies ).

    CATCH /gicom/cx_root_ds INTO lo_exception.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.


ENDFUNCTION.
