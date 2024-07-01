FUNCTION /gicom/rfc_pmr_read_vdr_fund.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_SRC_SYS) TYPE  LOGSYS
*"     VALUE(IT_VDR_OFR_ID) TYPE  /GICOM/GUID_TT
*"  EXPORTING
*"     VALUE(ET_VDR_FUND) TYPE  /GICOM/PMR_BAPI_VF_BO_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      INTERNAL_EROR
*"----------------------------------------------------------------------
  DATA lo_exception TYPE REF TO /gicom/cx_root_ds.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_pmr ).

      NEW /gicom/cl_dso_sap_pmr(  )->select_vendor_fund(
        EXPORTING
        iv_src_sys    = iv_src_sys
        it_vdr_ofr_id = it_vdr_ofr_id
        IMPORTING
         et_vdr_fund  = et_vdr_fund
      ).

    CATCH /gicom/cx_root_ds INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).
  ENDTRY.



ENDFUNCTION.
