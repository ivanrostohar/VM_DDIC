interface /GICOM/IF_DSO_TPARA
  public .


  interfaces IF_BADI_INTERFACE .

  methods SELECT_CUST_FOR_PARA
    importing
      !IV_PARA type /GICOM/KEY_PARA
    returning
      value(RS_TPARA) type /GICOM/TPARA_A_S .
  methods SELECT_CUST
    returning
      value(RT_TPARA) type /GICOM/TPARA_A_TT .
endinterface.
