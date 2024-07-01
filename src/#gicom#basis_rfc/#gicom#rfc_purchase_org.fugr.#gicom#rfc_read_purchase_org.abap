FUNCTION /gicom/rfc_read_purchase_org.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_PURCHASE_ORGS) TYPE  /GICOM/CPURCHASE_ORG_A_STT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  DATA: lo_exception TYPE REF TO /gicom/cx_root_da.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_purch_org ).

      NEW /gicom/cl_dso_purchase_org( )->select_purchase_orgs(
      IMPORTING
        et_purchase_orgs  = et_purchase_orgs ).

    CATCH /gicom/cx_root_da INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
