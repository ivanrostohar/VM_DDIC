FUNCTION /gicom/rfc_get_pgmid_for_obj.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_OBJTYPE) TYPE  TROBJTYPE
*"  EXPORTING
*"     VALUE(ES_TYPE) TYPE  KO100
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      es_type = NEW /gicom/cl_dso_ddic_eng( )->get_pgmid_for_object( iv_objtype ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
