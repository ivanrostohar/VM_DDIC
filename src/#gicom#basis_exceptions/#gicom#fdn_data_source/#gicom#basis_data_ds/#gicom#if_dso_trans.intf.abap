interface /GICOM/IF_DSO_TRANS
  public .


  interfaces IF_BADI_INTERFACE .

  methods INSERT_TRANS
    importing
      !IS_TRANS type /GICOM/TRANS_A_S
      !IV_COMMIT type XFLAG default 'X'
    returning
      value(RS_TRANS) type /GICOM/TRANS_A_S
    raising
      /GICOM/CX_INTERNAL_ERROR .
  methods REPLACE_POSITIONS
    importing
      !IS_TRANS type /GICOM/TRANS_A_S
      !IV_COMMIT type /GICOM/ABAP_BOOL default ABAP_TRUE
    returning
      value(RS_TRANS) type /GICOM/TRANS_A_S
    raising
      /GICOM/CX_INTERNAL_ERROR .
  methods SELECT_FOR_DIM_ID_POS
    importing
      !IT_DIM_ID_RANGE type /GICOM/DIM_ID_R_TT
      !IV_FROM type /GICOM/DATE
      !IV_TO type /GICOM/DATE
      !IV_GRP_BY_LVL type /GICOM/GRP_BY_LVL
    returning
      value(RT_SUM_TRANS) type /GICOM/TRANS_SUM_TT .
  methods SELECT_FOR_DIM_ID_RANGE
    importing
      !ITR_SENDER_TPOS type /GICOM/OID_SENDER_RTT optional
      !ITR_RECEIVER_TPOS type /GICOM/OID_RCV_RANGE_TT optional
      !IV_FROM type /GICOM/DATE
      !IV_UNTIL type /GICOM/DATE
      !IV_GRP_BY_LVL type /GICOM/GRP_BY_LVL
      !ITR_BUSINESS_ID_RETURN type /GICOM/BUSINESS_ID_RTT
      !ITR_BUSINESS_CLASS_RETURN type /GICOM/BUSINESS_CLASS_RTT
    returning
      value(RT_SUM_TRANS) type /GICOM/TRANS_SUM_TT
    raising
      /GICOM/CX_INTERNAL_ERROR .
  methods SELECT_TRANS
    importing
      !ITR_OID_OPERATOR type /GICOM/OID_OPERATOR_RANGE_TT optional
      !IV_DATE_FROM type /GICOM/DATE
      !IV_DATE_TO type /GICOM/DATE
      !ITR_OID_SENDER_DOC type /GICOM/OID_SENDER_RTT optional
      !ITR_OID_RECEIVER_DOC type /GICOM/OID_RCV_RANGE_TT optional
      !ITR_OID_SENDER_TDIM type /GICOM/OID_SENDER_RTT optional
      !ITR_OID_RECEIVER_TDIM type /GICOM/OID_RCV_RANGE_TT optional
      !ITR_DIM_ID type /GICOM/DIM_ID_R_TT optional
      !ITR_MATERIAL type /GICOM/MATNR_RTT optional
      !ITR_BUSINESS_ID_RETURN type /GICOM/BUSINESS_ID_RTT optional
      !ITR_BUSINESS_CLASS_RETURN type /GICOM/BUSINESS_CLASS_RTT optional
      !ITR_BUSINESS_ID type /GICOM/BUSINESS_ID_RTT optional
      !ITR_BUSINESS_CLASS type /GICOM/BUSINESS_CLASS_RTT optional
    exporting
      !EV_RETURN_FOUND type /GICOM/ABAP_BOOL
    returning
      value(RT_TRANS) type /GICOM/TRANS_A_TT
    raising
      /GICOM/CX_NOT_FOUND .
  methods SELECT_TRANS_FOR_DOC_NR
    importing
      !IV_DOC_NR type /GICOM/DOC_NR
      !IV_BUSINESS_CLASS type /GICOM/BUSINESS_CLASS optional
      !IV_BUSINESS_ID type /GICOM/BUSINESS_ID optional
    returning
      value(RS_TRANS) type /GICOM/TRANS_A_S
    raising
      /GICOM/CX_NOT_FOUND .
  methods SELECT_TRANS_FOR_DOC_NR_REF
    importing
      !IV_DOC_NR_REF type /GICOM/DOC_NR_REF
      !IV_BUSINESS_CLASS type /GICOM/BUSINESS_CLASS optional
      !IV_BUSINESS_ID type /GICOM/BUSINESS_ID optional
    returning
      value(RT_TRANS) type /GICOM/TRANS_A_TT
    raising
      /GICOM/CX_NOT_FOUND .
  "! Select data for a specific transaction number and position number if given
  "! @parameter iv_trans_id | Transaction number
  "! @parameter iv_trans_pos_no | (optional) Position number
  "! @parameter rs_trans | Transaction structure with data
  methods SELECT_TRANS_FOR_ID
    importing
      !IV_TRANS_ID type /GICOM/TRANS_ID
      !IV_TRANS_POS_NO type /GICOM/TRANS_POS_NO optional
    returning
      value(RS_TRANS) type /GICOM/TRANS_A_S
    raising
      /GICOM/CX_NOT_FOUND .
  methods UPDATE_TRANS
    importing
      !IS_TRANS type /GICOM/TRANS_A_S
      !IV_COMMIT type /GICOM/ABAP_BOOL default ABAP_TRUE
    returning
      value(RS_TRANS) type /GICOM/TRANS_A_S
    raising
      /GICOM/CX_INTERNAL_ERROR .
  methods UPDATE_TRANS_HEAD
    importing
      !IS_TRANS type /GICOM/TRANS_A_S
      !IV_COMMIT type /GICOM/ABAP_BOOL default ABAP_TRUE
    returning
      value(RS_TRANS) type /GICOM/TRANS_A_S
    raising
      /GICOM/CX_INTERNAL_ERROR .
  methods SELECT_TRANS_FOR_FIFO
    importing
      !IV_MATNR type /GICOM/MATNR40
      !IV_UOM type /GICOM/UOM
      !IV_PRICE type /GICOM/MOVE_PRICE optional
      !IV_OID_SENDER type /GICOM/OID_SENDER
      !IV_OID_SENDER_ORIG type /GICOM/OID_SENDER optional
      !ITR_BUSINESS_CLASS type /GICOM/BUSINESS_CLASS_RTT
      !ITR_BUSINESS_ID type /GICOM/BUSINESS_ID_RTT
      !ITR_TRANS_ID_IGNORE type /GICOM/TRANS_ID_RTT optional
    returning
      value(RT_TRANS) type /GICOM/TRANS_A_TT
    raising
      /GICOM/CX_INTERNAL_ERROR
      /GICOM/CX_NOT_FOUND .
  methods SELECT_SUM
    importing
      !ITR_SENDER type /GICOM/OID_SENDER_RTT optional
      !ITR_RECEIVER type /GICOM/OID_RCV_RANGE_TT optional
      !ITR_ART_GRP type /GICOM/OID_ART_GRP_RTT optional
      !ITR_MATNR type /GICOM/MATNR_RTT optional
      !ITR_SOURCING_TYPE type /GICOM/SOURCING_TYPE_RTT optional
      !ITR_GROUPING type /GICOM/GRP_R_TT optional
      !IV_FROM type /GICOM/DATE
      !IV_UNTIL type /GICOM/DATE
      !IV_CURRENCY type /GICOM/CURRENCY
      !IV_UOM type /GICOM/UOM
    returning
      value(RV_SUM_PRICE) type /GICOM/MOVE_PRICE
    raising
      /GICOM/CX_INTERNAL_ERROR .
  methods SELECT_SUM_TRANS_DISTRIBUTE
    importing
      !ITR_DISTRIBUTION_MODE type /GICOM/DISTRIBUTION_MODE_RTT optional
      !IT_DIM_GROUP_BY type /GICOM/DIM_GROUP_BY_TT optional
      !ITR_SENDER type /GICOM/OID_SENDER_RTT optional
      !ITR_RECEIVER type /GICOM/OID_RCV_RANGE_TT optional
      !ITR_ART_GRP type /GICOM/OID_ART_GRP_RTT optional
      !ITR_MATNR type /GICOM/MATNR_RTT optional
      !ITR_SOURCING_TYPE type /GICOM/SOURCING_TYPE_RTT optional
      !ITR_GROUPING type /GICOM/GRP_R_TT optional
      !ITR_AGRMT_ID type /GICOM/AGRMT_ID_RTT optional
      !ITR_SIM_FRGMT_ID type /GICOM/SIM_FRGMT_ID_RTT optional
      !ITR_SIM_RSN_ID type /GICOM/SIM_RSN_ID_RTT
      !IV_FROM type /GICOM/DATE
      !IV_UNTIL type /GICOM/DATE
      !IV_CURRENCY type /GICOM/CURRENCY
      !IV_UOM type /GICOM/UOM
      !IV_GRP_BY_LVL type /GICOM/GRP_BY_LVL optional
      !ITR_BUSINESS_ID type /GICOM/BUSINESS_ID_RTT optional
      !ITR_BUSINESS_CLASS type /GICOM/BUSINESS_CLASS_RTT optional
    exporting
      !ET_TRANS_SUM type /GICOM/DISTRIBUTE_TRANS_SUM_TT
      !EV_GRP_BY_LVL type /GICOM/GRP_BY_LVL
    raising
      /GICOM/CX_ROOT_DS .
endinterface.
