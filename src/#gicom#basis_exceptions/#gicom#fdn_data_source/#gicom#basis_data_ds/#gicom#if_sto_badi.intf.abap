interface /GICOM/IF_STO_BADI
  public .


  interfaces IF_BADI_INTERFACE .

  methods CHANGE_MAPPING_DATA
    importing
      !IV_OBJECT_ID type /GICOM/STO_OBJECT_ID
      !IO_GETER type ref to OBJECT
    changing
      !CS_EDIDC type EDIDC
      !CT_EDIDD type EDIDD_TT .
endinterface.
