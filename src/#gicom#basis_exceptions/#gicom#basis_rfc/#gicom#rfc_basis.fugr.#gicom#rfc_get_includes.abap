FUNCTION /gicom/rfc_get_includes.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_CLASS_NAME) TYPE  SEOCLSNAME
*"  EXPORTING
*"     VALUE(ET_INCLUDE) TYPE  /GICOM/METHODS_W_INCLUDE_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------

  TRY.

      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_repos_engine  ).

      et_include = NEW /gicom/cl_dso_repos_eng( )->get_includes( iv_class_name ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
