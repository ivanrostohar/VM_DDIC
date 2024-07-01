FUNCTION /GICOM/RFC_READ_CCS_CUST.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(ITR_MODEL_AGREEMENT) TYPE  /GICOM/MODEL_AGREEMENT_RTT
*"       OPTIONAL
*"     VALUE(ITR_OPERATOR_FOCUS) TYPE  /GICOM/OPERAT_FOCUS_RTT OPTIONAL
*"     VALUE(ITR_COND_TYPE) TYPE  /GICOM/COND_TYPE_RTT OPTIONAL
*"     VALUE(ITR_PROCESS_LEVEL) TYPE  /GICOM/LVL_PROCESS_RANGE_TTY
*"       OPTIONAL
*"     VALUE(IV_EFFECTIVE_DATE) TYPE  /GICOM/DATE_EFFECTIVE DEFAULT
*"       SY-DATUM
*"     VALUE(IV_MODEL_AGREEMENT) TYPE  /GICOM/MODEL_AGREEMENT
*"     VALUE(IV_OPERATOR_FOCUS) TYPE  /GICOM/OPERAT_FOCUS
*"     VALUE(IV_CNTR_TYPE) TYPE  /GICOM/CONTRACT_TYPE
*"     VALUE(ITR_TRANSFER_ID) TYPE  /GICOM/TRANSFER_ID_RTT
*"     VALUE(IV_CC_TYPE) TYPE  /GICOM/CCS_CONTR_TYPE OPTIONAL
*"  EXPORTING
*"     VALUE(ET_AGR2CCS) TYPE  /GICOM/CCS_AGRMNT_A_TT
*"     VALUE(ET_CCSAGRRL) TYPE  /GICOM/CCS_AGRMNT_REL_A_TT
*"     VALUE(ET_CCS_CAL) TYPE  /GICOM/CCS_CAL_CUST_TT
*"     VALUE(ET_CCS_SPLT) TYPE  /GICOM/CCS_SPLIT_A_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      INTERNAL_ERROR
*"----------------------------------------------------------------------
  DATA: lo_exception     TYPE REF TO /gicom/cx_root_appl,
        ls_gicom_bapiret TYPE /gicom/bapiret2,
        lt_condtype      TYPE /gicom/ccscndsp_tt,
        lb_dso_ccs_cust  TYPE REF TO /gicom/badi_dso_ccs_cust.

  TRY .
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).


      "Get DSO Badi Instance
      GET BADI lb_dso_ccs_cust.

      IF lb_dso_ccs_cust IS BOUND.
        TRY.
            CALL BADI lb_dso_ccs_cust->select_ccs_agr_rel
*              EXPORTING
*                iv_model_agreement = iv_model_agreement
*                iv_operator_focus  = iv_operator_focus
*                itr_cond_type      = itr_cond_type
*                iv_process_level   = iv_process_level
*                iv_effective_date  = iv_effective_date
              RECEIVING
                rt_ccs_agrmnt_rel = et_ccsagrrl.
          CATCH /gicom/cx_not_found.    "
        ENDTRY.

        CALL BADI lb_dso_ccs_cust->select_ccs_split_criteria
          EXPORTING
            iv_model_agreement = iv_model_agreement
            iv_operator_focus  = iv_operator_focus
            iv_cntr_type       = iv_cntr_type
            iv_effective_date  = iv_effective_date
          RECEIVING
            rt_ccs_split       = et_ccs_splt.


        TRY .
            CALL BADI lb_dso_ccs_cust->select_ccs_transfer_rules
              EXPORTING
                itr_transfer_id = itr_transfer_id
              RECEIVING
                rt_ccs_agrmnt   = et_agr2ccs.
          CATCH /gicom/cx_invalid_arguments.    "
          CATCH /gicom/cx_not_found.    "

        ENDTRY.

        CALL BADI lb_dso_ccs_cust->select_ccs_cnd_typ_map
          EXPORTING
            iv_model_agreement = iv_model_agreement
            iv_operator_focus  = iv_operator_focus
            iv_cntr_type       = iv_cntr_type
            iv_effective_date  = iv_effective_date
          RECEIVING
            rt_condtype        = lt_condtype.
        CALL BADI lb_dso_ccs_cust->select_ccs_calender_cust
          EXPORTING
            iv_cc_type        = iv_cc_type
            iv_effective_date = iv_effective_date
          RECEIVING
            rt_ccscal         = et_ccs_cal.

      ENDIF.

    CATCH /gicom/cx_no_auth_rfc.    "

    CATCH /gicom/cx_root_appl INTO lo_exception.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
