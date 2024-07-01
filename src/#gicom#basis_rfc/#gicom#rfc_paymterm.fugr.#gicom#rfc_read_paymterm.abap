FUNCTION /GICOM/RFC_READ_PAYMTERM.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  EXPORTING
*"     VALUE(ET_PAYMTERM) TYPE  /GICOM/PAYMTERM_TT
*"     VALUE(ET_PAYMTERM_TXT) TYPE  /GICOM/PAYMTERM_TXT_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------


 "Call DSO Method to get the data
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_paymterm  ).

      NEW /gicom/cl_dso_paymterm( )->select_data(
                                  IMPORTING
                                    et_paymterm        = et_paymterm
                                    et_paymterm_txt        = et_paymterm_txt ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.


ENDFUNCTION.
