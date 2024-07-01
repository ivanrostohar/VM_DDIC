FUNCTION /gicom/rfc_get_interface.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_INTERFACE) TYPE  SEOCLSNAME
*"  EXPORTING
*"     VALUE(ES_INTERFACE) TYPE  VSEOINTERF
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------

  TRY.

      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_repos_engine ).

      es_interface = NEW /gicom/cl_dso_repos_eng( )->get_interface( iv_interface ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
