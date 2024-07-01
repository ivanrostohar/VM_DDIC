FUNCTION /gicom/rfc_get_class.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_CLASSNAME) TYPE  SEOCLSNAME
*"  EXPORTING
*"     VALUE(ES_CLASS) TYPE  VSEOCLASS
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------

  TRY.

      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_repos_engine ).

      es_class = NEW /gicom/cl_dso_repos_eng( )->get_class(
        EXPORTING
           iv_classname = iv_classname
      ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
