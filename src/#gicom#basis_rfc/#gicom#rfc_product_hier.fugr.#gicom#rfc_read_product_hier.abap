FUNCTION /GICOM/RFC_READ_PRODUCT_HIER.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_PRODUCT_HIER) TYPE  /GICOM/CPRODUCT_HIER_A_STT
*"     VALUE(ET_PRODUCT_HIER_TXT) TYPE  /GICOM/CPRODUCT_HIER_TXT_A_STT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

DATA: lo_exception TYPE REF TO /gicom/cx_root_da.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_prod_hier ).

    NEW /gicom/cl_dso_product_hier( )->select_product_hier(
            IMPORTING
              et_product_hier     = et_product_hier
              et_product_hier_txt = et_product_hier_txt ).


    CATCH /gicom/cx_root_da INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.




ENDFUNCTION.
