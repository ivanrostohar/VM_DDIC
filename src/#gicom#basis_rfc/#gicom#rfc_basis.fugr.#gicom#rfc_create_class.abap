FUNCTION /gicom/rfc_create_class.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_DEVCLASS) TYPE  DEVCLASS OPTIONAL
*"     VALUE(IV_SUPERCLASS) TYPE  SEOCLSNAME OPTIONAL
*"     VALUE(IV_TRKORR) TYPE  TRKORR
*"     VALUE(IS_CLASS) TYPE  VSEOCLASS
*"     VALUE(IT_INTERFACE) TYPE  SEO_CLSKEYS OPTIONAL
*"  EXPORTING
*"     VALUE(EV_TRKORR) TYPE  TRKORR
*"     VALUE(EV_SUBRC) TYPE  SY-SUBRC
*"     VALUE(EV_CLASS) TYPE  SEOCLSNAME
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------

  "Call DSO Method to get the data
  TRY.

      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_repos_engine ).

      ev_trkorr = iv_trkorr.

      ev_subrc =  NEW /gicom/cl_dso_repos_eng( )->create_class(
        EXPORTING
           iv_devclass   = iv_devclass
           iv_superclass = iv_superclass
           is_class      = is_class
           it_interface  = it_interface
        IMPORTING
           ev_class      = ev_class
           ev_trkorr     = ev_trkorr
      ).
    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

  IF ev_class IS INITIAL.
    ev_subrc = 4.
  ENDIF.

ENDFUNCTION.
