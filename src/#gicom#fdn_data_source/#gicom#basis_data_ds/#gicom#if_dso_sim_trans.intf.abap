interface /GICOM/IF_DSO_SIM_TRANS
  public .


  interfaces IF_BADI_INTERFACE .

  methods INSERT_SIM_TRANS
    importing
      !IT_SIM_TRANS type /GICOM/SIM_TRANS_A_TT
      it_business_id_return  type /gicom/business_id_rtt
      !IV_COMMIT type XFLAG default 'X'
    returning
      value(RT_SIM_TRANS) type /GICOM/SIM_TRANS_A_TT
    raising
      /GICOM/CX_INTERNAL_ERROR .
  methods SELECT_LIST_FOR_SIM_RSN
    importing
      !IT_R_SIM_RSN type /GICOM/SIM_RSN_ID_RTT
      !IT_R_DIM_ID type /GICOM/DIM_ID_R_TT optional
      !IV_FROM type /GICOM/DATE
      !IV_UNTIL type /GICOM/DATE
      !IV_GRP_BY_LVL type /GICOM/GRP_BY_LVL
      !ITR_OID_OPERATOR type /GICOM/OID_OPERATOR_RANGE_TT optional
      !ITR_OID_SENDER_DOC type /GICOM/OID_SENDER_RTT optional
      !ITR_OID_RECEIVER_DOC type /GICOM/OID_RCV_RANGE_TT optional
      !ITR_OID_SENDER_TDIM type /GICOM/OID_SENDER_RTT optional
      !ITR_OID_RECEIVER_TDIM type /GICOM/OID_RCV_RANGE_TT optional
      !ITR_MATERIAL type /GICOM/MATNR_RTT optional
      !ITR_BUSINESS_ID_RETURN type /GICOM/BUSINESS_ID_RTT optional
      !ITR_BUSINESS_CLASS_RETURN type /GICOM/BUSINESS_CLASS_RTT optional
      !ITR_BUSINESS_ID type /GICOM/BUSINESS_ID_RTT optional
      !ITR_BUSINESS_CLASS type /GICOM/BUSINESS_CLASS_RTT optional
      !IV_TRIGGER_BO_TYP type /GICOM/BO_TYP optional
      !IV_TRIGGER_BO_ID type /GICOM/BO_ID optional
      !IV_FACTOR_PRICE type /GICOM/CHANGE_FACTOR optional
      !IV_FACTOR_QUANTITY type /GICOM/CHANGE_FACTOR optional
    exporting
      !EV_RETURN_FOUND type /GICOM/ABAP_BOOL
    returning
      value(RT_SIM_TRANS) type /GICOM/SIM_TRANS_SUM_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods SELECT_SIM_TRANS
    importing
      !IT_R_SIM_RSN type /GICOM/SIM_RSN_ID_RTT
      !IT_R_DIM_ID type /GICOM/DIM_ID_R_TT
      !IV_FROM type /GICOM/DATE
      !IV_UNTIL type /GICOM/DATE
      !IV_CURRENCY type /GICOM/CURRENCY
      !IV_UOM type /GICOM/UOM
      !IV_GRP_BY_LVL type /GICOM/GRP_BY_LVL
      !IV_TRIGGER_BO_TYP type /GICOM/BO_TYP optional
      !IV_TRIGGER_BO_ID type /GICOM/BO_ID optional
      !IV_FACTOR_PRICE type /GICOM/CHANGE_FACTOR optional
      !IV_FACTOR_QUANTITY type /GICOM/CHANGE_FACTOR optional
      !ITR_BUSINESS_ID_RETURN type /GICOM/BUSINESS_ID_RTT
      !ITR_BUSINESS_CLASS_RETURN type /GICOM/BUSINESS_CLASS_RTT
    returning
      value(RT_SIM_TRANS) type /GICOM/SIM_TRANS_SUM_TT
    raising
      /GICOM/CX_ROOT_DS .
endinterface.
