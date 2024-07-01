FUNCTION /gicom/rfc_if_existence_check.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_CLASS_NAME) TYPE  SEOCLSNAME
*"  EXPORTING
*"     VALUE(EV_NOT_EXISTS) TYPE  XFELD
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------

  TRY.

      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_repos_engine  ).

      ev_not_exists = NEW /gicom/cl_dso_repos_eng( )->class_if_existence_check( iv_class_name ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      ev_not_exists = abap_true.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
