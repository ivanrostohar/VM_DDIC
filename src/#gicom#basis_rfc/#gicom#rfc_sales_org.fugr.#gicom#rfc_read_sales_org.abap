FUNCTION /gicom/rfc_read_sales_org.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_SALES_ORGS) TYPE  /GICOM/CSALES_ORG_A_STT
*"     VALUE(ET_SALES_ORGS_TXT) TYPE  /GICOM/CSALES_ORG_TXT_A_STT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  DATA: lo_exception TYPE REF TO /gicom/cx_root_da.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_sales_org ).

      NEW /gicom/cl_dso_sales_org( )->select_sales_orgs(
        IMPORTING
          et_sales_orgs     = et_sales_orgs
          et_sales_orgs_txt = et_sales_orgs_txt ).

    CATCH /gicom/cx_root_da INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
