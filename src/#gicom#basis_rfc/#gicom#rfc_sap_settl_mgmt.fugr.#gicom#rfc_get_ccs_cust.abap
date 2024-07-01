FUNCTION /gicom/rfc_get_ccs_cust.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_BVB_TYPE_DEEP) TYPE  /GICOM/CCS_BVB_TYPE_DEEP_TT
*"     VALUE(ET_COND_CONTRACT_TYPE) TYPE  /GICOM/CCS_CNTYP_TT
*"     VALUE(ET_BVB_TAB_DEEP) TYPE  /GICOM/CCS_BVB_TAB_DEEP_TT
*"     VALUE(ET_BVB_TAB_FIELDNAME) TYPE  /GICOM/_BVB_TAB_A_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA lo_exception TYPE REF TO /gicom/cx_root.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).

      NEW /gicom/cl_dso_sap_settl_mngt( )->get_ccs_cust(
      IMPORTING
        et_cond_contract_type = et_cond_contract_type
        et_bvb_type_deep      = et_bvb_type_deep
        et_bvb_tab_deep       = et_bvb_tab_deep
        et_bvb_tab_fieldname = et_bvb_tab_fieldname

      ).

    CATCH /gicom/cx_root INTO lo_exception.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.




ENDFUNCTION.
