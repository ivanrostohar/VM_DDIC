FUNCTION /GICOM/RFC_GET_TEXTTABLE.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_STRUCTURE) TYPE  TABNAME
*"  EXPORTING
*"     VALUE(EV_TEXT_TABLE) TYPE  TABNAME
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      ev_text_table = NEW /gicom/cl_dso_ddic_eng( )->get_texttable( iv_structure ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
