interface /GICOM/IF_DSO_CCS_CUST
  public .


  interfaces IF_BADI_INTERFACE .

  methods SELECT_CCS_AGR_REL
    importing
      !IV_MODEL_AGREEMENT type /GICOM/MODEL_AGREEMENT optional
      !IV_OPERATOR_FOCUS type /GICOM/OPERAT_FOCUS optional
      !ITR_COND_TYPE type /GICOM/COND_TYPE_RTT optional
      !IV_PROCESS_LEVEL type /GICOM/LVL_PROCESS optional
      !IV_EFFECTIVE_DATE type /GICOM/DATE_EFFECTIVE default SY-DATUM
    returning
      value(RT_CCS_AGRMNT_REL) type /GICOM/CCS_AGRMNT_REL_A_TT
    raising
      /gicom/cx_root_ds.
  methods SELECT_CCS_SPLIT_CRITERIA
    importing
      !IV_MODEL_AGREEMENT type /GICOM/MODEL_AGREEMENT
      !IV_OPERATOR_FOCUS type /GICOM/OPERAT_FOCUS
      !IV_CNTR_TYPE type /GICOM/CONTRACT_TYPE
      !IV_EFFECTIVE_DATE type /GICOM/DATE_EFFECTIVE default SY-DATUM
    returning
      value(RT_CCS_SPLIT) type /GICOM/CCS_SPLIT_A_TT .
  methods SELECT_CCS_TRANSFER_RULES
    importing
      !ITR_TRANSFER_ID type /GICOM/TRANSFER_ID_RTT
    returning
      value(RT_CCS_AGRMNT) type /GICOM/CCS_AGRMNT_A_TT
    raising
      /gicom/cx_root_ds.
  methods SELECT_CCS_CND_TYP_MAP
    importing
      !IV_MODEL_AGREEMENT type /GICOM/MODEL_AGREEMENT optional
      !IV_OPERATOR_FOCUS type /GICOM/OPERAT_FOCUS optional
      !IV_CNTR_TYPE type /GICOM/CCS_CONTR_TYPE optional
      !IV_EFFECTIVE_DATE type SY-DATUM default SY-DATUM
    returning
      value(RT_CONDTYPE) type /GICOM/CCSCNDSP_TT .
  METHODS select_ccs_calender_cust
    IMPORTING
      !iv_cc_type        TYPE /gicom/ccs_contr_type OPTIONAL
      !iv_condition_type TYPE /gicom/cond_type OPTIONAL
      !iv_effective_date TYPE sy-datum DEFAULT sy-datum
    RETURNING
      VALUE(rt_ccscal)   TYPE /gicom/ccs_cal_cust_tt .
  methods SELECT_CCS_EXCL_CND
    importing
      !IV_COND_TYPE type /GICOM/COND_TYPE optional
      !IV_VALID_FROM type /GICOM/VALID_FROM optional
      !IV_VALID_TO type /GICOM/VALID_FROM optional
    returning
      value(RT_CCS_EXCL_COND) type /GICOM/CCS_EXCL_COND_A_TT .
endinterface.
