FUNCTION /GICOM/RFC_PUT_DATAELEMENT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NAME) TYPE  DDOBJNAME
*"     VALUE(IV_TRKORR) TYPE  TRKORR OPTIONAL
*"     VALUE(IV_DEVCLASS) TYPE  DEVCLASS
*"     VALUE(IS_DD04V) TYPE  DD04V
*"  EXPORTING
*"     VALUE(EV_SUBRC) TYPE  SY-SUBRC
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      ev_subrc = NEW /gicom/cl_dso_ddic_eng( )->put_dataelement(
                   EXPORTING
                     iv_name     = iv_name
                     iv_devclass = iv_devclass
                     iv_trkorr   = iv_trkorr
                     is_dd04v    = is_dd04v
                 ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
