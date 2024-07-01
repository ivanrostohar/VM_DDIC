FUNCTION /gicom/rfc_pmr_sync_vdr_fund.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_SENDER) TYPE  LOGSYS
*"     VALUE(IV_KEY_TST) TYPE  /GICOM/TIMESTMPS
*"     VALUE(IV_SRC_SYS) TYPE  LOGSYS
*"     VALUE(IT_PMR_VF_HEADER) TYPE  /GICOM/PMR_VF_HEADER_TT
*"     VALUE(IT_PMR_VF_MATERIAL) TYPE  /GICOM/PMR_VF_MATERIAL_TT
*"     VALUE(IT_PMR_VF_LOCATION) TYPE  /GICOM/PMR_VF_LOCATION_TT
*"     VALUE(IT_PMR_VF_DISTR_CHANNEL) TYPE
*"        /GICOM/PMR_VF_DISTR_CHANNEL_TT
*"     VALUE(IT_PMR_VF_AMOUNT) TYPE  /GICOM/PMR_VF_AMOUNT_TT
*"     VALUE(IT_PMR_VF_MATERIAL_AMOUNT) TYPE
*"        /GICOM/PMR_VF_MATERIAL_AMT_TT
*"  EXPORTING
*"     VALUE(ET_MESSAGE) TYPE  /GICOM/BAPIRET_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      INTERNAL_ERROR
*"----------------------------------------------------------------------
  DATA: lo_exception TYPE REF TO /gicom/cx_root_ds.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_pmr ).

      NEW /gicom/cl_dso_sap_pmr(  )->sync_vendor_fund(
        EXPORTING
          iv_sender                 = iv_sender
          iv_key_tst                = iv_key_tst
          iv_src_sys                = iv_src_sys
          it_pmr_vf_header          = it_pmr_vf_header
          it_pmr_vf_material        = it_pmr_vf_material
          it_pmr_vf_location        = it_pmr_vf_location
          it_pmr_vf_distr_channel   = it_pmr_vf_distr_channel
          it_pmr_vf_amount          = it_pmr_vf_amount
          it_pmr_vf_material_amount = it_pmr_vf_material_amount
        IMPORTING
          et_message                = et_message
      ).

    CATCH /gicom/cx_root_ds INTO lo_exception.
      /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).
  ENDTRY.

ENDFUNCTION.
