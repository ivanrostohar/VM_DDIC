FUNCTION /gicom/rfc_read_group_currency.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_MANDT) TYPE  MANDT DEFAULT SY-MANDT
*"  EXPORTING
*"     VALUE(EV_CURRENCY) TYPE  /GICOM/CURRENCY
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA: lo_exception     TYPE REF TO /gicom/cx_root_ds,
        ls_gicom_bapiret TYPE /gicom/bapiret2.


  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_currency ).

      ev_currency = NEW /gicom/cl_dso_currency( )->select_for_mandt( iv_mandt = iv_mandt ).

    CATCH /gicom/cx_root_ds INTO lo_exception.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
