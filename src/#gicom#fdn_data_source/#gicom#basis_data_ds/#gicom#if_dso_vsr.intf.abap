interface /GICOM/IF_DSO_VSR
  public .


  interfaces IF_BADI_INTERFACE .

  methods SELECT_DATA
    exporting
      !ET_VSR type /GICOM/VSR_A_TT
      !ET_VSR_TXT type /GICOM/VSR_TEXT_A_TT
      !ET_VSR_MATNR type /GICOM/VSR_MATNR_A_TT
    raising
      /GICOM/CX_ROOT_DS .
endinterface.
