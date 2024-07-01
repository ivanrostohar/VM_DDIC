FUNCTION /gicom/rfc_put_domain.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_NAME) TYPE  DDOBJNAME
*"     VALUE(IV_TRKORR) TYPE  TRKORR OPTIONAL
*"     VALUE(IV_DEVCLASS) TYPE  DEVCLASS
*"     VALUE(IS_DD01V) TYPE  DD01V
*"     VALUE(IT_DD07V) TYPE  DD07V_TAB
*"  EXPORTING
*"     VALUE(EV_SUBRC) TYPE  SY-SUBRC
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      ev_subrc = NEW /gicom/cl_dso_ddic_eng( )->put_domain(
                   EXPORTING
                     iv_name     = iv_name
                     is_dd01v    = is_dd01v
                     iv_devclass = iv_devclass
                     iv_trkorr   = iv_trkorr
                     it_dd07v    = it_dd07v ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
