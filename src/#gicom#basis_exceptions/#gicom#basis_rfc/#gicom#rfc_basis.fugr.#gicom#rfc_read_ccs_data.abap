FUNCTION /GICOM/RFC_READ_CCS_DATA.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_CNTR_ID) TYPE  /GICOM/CONTRACT_ID OPTIONAL
*"     VALUE(IV_CC_LOOSE) TYPE  /GICOM/CCS_OVERLAP OPTIONAL
*"     VALUE(IV_SENDER) TYPE  /GICOM/OID_SENDER OPTIONAL
*"     VALUE(IV_GUID_CC) TYPE  /GICOM/GUID_CC
*"  EXPORTING
*"     VALUE(ET_CCS_VD) TYPE  /GICOM/CCS_VD_TT
*"     VALUE(ET_CCS_DIM) TYPE  /GICOM/CCS_DIM_A_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      INTERNAL_ERROR
*"----------------------------------------------------------------------

RAISE internal_error.

"2019-03-25 PB
" complete change, this RFC FM makes no sense

*  DATA: lo_exception     TYPE REF TO /gicom/cx_root_ds,
*        ls_gicom_bapiret TYPE /gicom/bapiret2,
*        lb_dso_ccs_data  TYPE REF TO /gicom/badi_ds_ccs_data,
*        ls_ccs_dim       TYPE /gicom/ccs_dim_a_s.
*
*  TRY .
*      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).
*
*
*      "Get DSO Badi Instance
*      GET BADI lb_dso_ccs_data.
*
*      IF lb_dso_ccs_data IS BOUND.
*        TRY.
*            CALL BADI lb_dso_ccs_data->select_exist_cc_for_contract
*              EXPORTING
**                iv_cntr_id       = iv_cntr_id
*                iv_cc_loose      = iv_cc_loose
*                iv_sender        = iv_sender
*              RECEIVING
*                rt_exist_cc_cntr = et_ccs_vd.
*          CATCH /gicom/cx_invalid_arguments.    "
*          CATCH /gicom/cx_not_found.    "
*
*        ENDTRY.
*        TRY .
*            CALL BADI lb_dso_ccs_data->select_ccs_dimension_for_id
*              EXPORTING
*                iv_guid_cc = iv_guid_cc
*              RECEIVING
*                rs_ccs_dim = ls_ccs_dim.
*            APPEND ls_ccs_dim TO et_ccs_dim.
*          CATCH /gicom/cx_not_found.    "
*
*        ENDTRY.
*      ENDIF.
*
*
*    CATCH /gicom/cx_no_auth_rfc.    "
*
*  ENDTRY.


ENDFUNCTION.
