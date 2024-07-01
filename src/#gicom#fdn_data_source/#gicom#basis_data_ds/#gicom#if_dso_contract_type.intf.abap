interface /GICOM/IF_DSO_CONTRACT_TYPE
  public .


  interfaces IF_BADI_INTERFACE .

  methods SELECT
    importing
      !ITR_CONTR_TYPE type /GICOM/CONTRACT_TYPE_RTT optional
      !IV_VALID type /GICOM/VALID_TO default SY-DATUM
    exporting
      !ET_CONTRACT_TYPES type /GICOM/CONTRACT_TYPE_A_TT
      !ET_CONTRACT_TYPES_TXT type /GICOM/CONTRACT_TYPE_TXT_TT
      !ET_CONTRACT_TYPE_CONDT_REL type /GICOM/CNTR_TYP_CONDT_A_TT
      !ET_CONTRACT_TYPE_DOC_REL type /GICOM/CONTR_TYPE_DOC_TT
      !ET_CONTRACT_TYPE_ROV_REL type /GICOM/TCNT_TROV_A_TT
      !ET_CONTRACT_DOC_TEMPLATES type /GICOM/TCNTDTYP_DB_TT
      !ET_CONTRACT_DOC_TYP type /GICOM/CONTR_TYPE_DOC_TT
    raising
      /GICOM/CX_ROOT_DS .

  methods CHECK_EXISTENCE
    importing
      ITR_CONTR_TYPE type /GICOM/CONTRACT_TYPE_RTT optional
    returning
      VALUE(RT_CNTR_TYPE) type /GICOM/CONTRACT_TYPE_TT.

endinterface.
