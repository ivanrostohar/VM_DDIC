interface /GICOM/IF_CONSTANTS_CONTRACT
  public .


  constants GC_STATUS_INITIAL type /GICOM/STATUS_CONTRACT value '00' ##NO_TEXT.
  constants GC_STATUS_IN_PREP type /GICOM/STATUS_CONTRACT value '20' ##NO_TEXT.
  constants GC_STATUS_BINDING type /GICOM/STATUS_CONTRACT value '70' ##NO_TEXT.
  constants GC_STATUS_INTERRUPTED type /GICOM/STATUS_CONTRACT value '90' ##NO_TEXT.
  constants GC_STATUS_INVALID type /GICOM/STATUS_CONTRACT value '91' ##NO_TEXT.
  constants GC_CONTRACT_OPRTR type /GICOM/MODEL_AGREEMENT value 'B' ##NO_TEXT.
  constants GC_CONTRACT_DISTR type /GICOM/MODEL_AGREEMENT value 'A' ##NO_TEXT.
  constants GC_CONTRACT_SUPLR type /GICOM/MODEL_AGREEMENT value '' ##NO_TEXT.
  constants GC_CONTRACT_CUSTR type /GICOM/MODEL_AGREEMENT value 'K' ##NO_TEXT.
  constants GC_COLLECT type /GICOM/TYPE_REL value '10' ##NO_TEXT.
  constants GC_CONTEXT type /GICOM/TYPE_REL value '30' ##NO_TEXT.
  constants GC_SUCCESSOR type /GICOM/TYPE_REL value '20' ##NO_TEXT.
  constants GC_PREDECESSOR type /GICOM/TYPE_REL value 'PR' ##NO_TEXT.
  constants CV_ID_DUMMY type /GICOM/CONTRACT_ID value '9999999999' ##NO_TEXT.
  constants GC_CONTRACT_OPRTR_SENDER type /GICOM/OPERAT_FOCUS value 'S' ##NO_TEXT.
  constants GC_CONTRACT_OPRTR_RECEIVER type /GICOM/OPERAT_FOCUS value 'R' ##NO_TEXT.
  constants GC_SETTLE_VIA_APM type /gicom/code_settl value 'C' ##NO_TEXT.
  constants GC_SETTLE_VIA_CCS type /gicom/code_settl value 'S' ##NO_TEXT.
  constants GC_NO_SETTLEMENT type /gicom/code_settl value '' ##NO_TEXT.
endinterface.
