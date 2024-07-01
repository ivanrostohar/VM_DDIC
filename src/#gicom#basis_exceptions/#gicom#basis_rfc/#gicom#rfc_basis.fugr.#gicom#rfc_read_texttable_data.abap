FUNCTION /gicom/rfc_read_texttable_data.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_TABNAME) TYPE  TABNAME
*"     VALUE(IV_LANGU) TYPE  SPRAS OPTIONAL
*"     VALUE(IV_DESCR_FIELD) TYPE  FIELDNAME OPTIONAL
*"  EXPORTING
*"     VALUE(ET_VALUES) TYPE  TIHTTPNVP
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      NEW /gicom/cl_dso_ddic_eng( )->select_texttable_data(
      EXPORTING
        iv_tabname     = iv_tabname
        iv_langu       = iv_langu
        iv_descr_field = iv_descr_field
      RECEIVING
        rt_values      = et_values ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.


ENDFUNCTION.
