FUNCTION /gicom/rfc_delete_class.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_CLASS) TYPE  SEOCLSNAME
*"     VALUE(IV_TRKORR) TYPE  TRKORR
*"  EXPORTING
*"     VALUE(EV_TRKORR) TYPE  TRKORR
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------

  TRY.

      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_repos_engine ).

      ev_trkorr = iv_trkorr.

      NEW /gicom/cl_dso_repos_eng( )->delete_class(
       EXPORTING
         iv_class  = iv_class
       IMPORTING
         ev_trkorr = ev_trkorr
      ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
