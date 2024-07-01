FUNCTION /GICOM/RFC_ACTIVATE_TABLE.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_TABNAME) TYPE  DDOBJNAME
*"  EXPORTING
*"     VALUE(EV_SUBRC) TYPE  SY-SUBRC
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      ev_subrc = NEW /gicom/cl_dso_ddic_eng( )->activate_table( iv_tabname = iv_tabname ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.


ENDFUNCTION.
