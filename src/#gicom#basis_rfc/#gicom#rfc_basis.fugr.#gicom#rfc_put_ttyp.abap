FUNCTION /GICOM/RFC_PUT_TTYP.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_TABNAME) TYPE  DDOBJNAME
*"     VALUE(IV_TRKORR) TYPE  TRKORR OPTIONAL
*"     VALUE(IV_DEVCLASS) TYPE  DEVCLASS
*"     VALUE(IS_DD40V) TYPE  DD40V
*"  EXPORTING
*"     VALUE(EV_SUBRC) TYPE  SY-SUBRC
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      ev_subrc = NEW /gicom/cl_dso_ddic_eng( )->put_ttyp(
                   EXPORTING
                     iv_tabname = iv_tabname
                     iv_devclass = iv_devclass
                     iv_trkorr = iv_trkorr
                     is_dd40v   = is_dd40v
                 ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
