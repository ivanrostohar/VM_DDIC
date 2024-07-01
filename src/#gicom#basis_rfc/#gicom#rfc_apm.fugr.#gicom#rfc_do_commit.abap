FUNCTION /GICOM/RFC_DO_COMMIT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_BAPI) TYPE  /GICOM/ABAP_BOOL
*"     VALUE(IV_LOCAL) TYPE  /GICOM/ABAP_BOOL
*"  EXPORTING
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA: lx_error_exception       TYPE REF TO /gicom/cx_root_ds,
        lx_commit_fail_exception TYPE REF TO /gicom/cx_commit_failed,
        lx_no_auth_rfc           TYPE REF TO /gicom/cx_no_auth_rfc.

  TRY.

      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).

      NEW /gicom/cl_dso_sap_settl_mngt( )->do_commit(
        EXPORTING
          iv_bapi  = iv_bapi
          iv_local = iv_local
      ).

    CATCH /gicom/cx_no_auth_rfc INTO lx_no_auth_rfc.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_no_auth_rfc ).
    CATCH /gicom/cx_root_ds INTO lx_error_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_error_exception ).
    CATCH /gicom/cx_commit_failed INTO lx_commit_fail_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_commit_fail_exception ).

  ENDTRY.

ENDFUNCTION.
