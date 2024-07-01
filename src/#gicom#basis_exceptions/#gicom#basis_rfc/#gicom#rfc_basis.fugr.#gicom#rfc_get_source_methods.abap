FUNCTION /gicom/rfc_get_source_methods.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_CLASS_NAME) TYPE  SEOCLSNAME
*"  EXPORTING
*"     VALUE(ET_SOURCE) TYPE  /GICOM/CMETHOD_SOURCE_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------

  TRY.

      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_repos_engine ).

      et_source = NEW /gicom/cl_dso_repos_eng( )->get_source_methods( iv_class_name ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
