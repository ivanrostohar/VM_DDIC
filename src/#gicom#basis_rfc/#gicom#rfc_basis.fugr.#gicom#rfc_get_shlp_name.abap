FUNCTION /gicom/rfc_get_shlp_name.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_TABNAME) TYPE  DFIES-TABNAME
*"     VALUE(IV_FIELDNAME) TYPE  DFIES-FIELDNAME
*"  EXPORTING
*"     VALUE(ES_SHLP) TYPE  SHLP_DESCR
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      NEW /gicom/cl_dso_ddic_eng( )->get_shlp_name(
        EXPORTING
          iv_tabname = iv_tabname
          iv_fieldname = iv_fieldname
        IMPORTING
          es_shlp = es_shlp
      ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
