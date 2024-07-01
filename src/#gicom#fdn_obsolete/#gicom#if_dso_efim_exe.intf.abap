interface /GICOM/IF_DSO_EFIM_EXE
  public .


  interfaces IF_BADI_INTERFACE .

  methods EXECUTE_TM
    importing
      !IV_EVENT type /GICOM/TRANS_EVENT
      !IT_GROUPS type /GICOM/TRANSFER_GROUP_TT
      !IT_SOURCE_COPY_DATA type /GICOM/WLF_TM_COPY_DATA_TT
    exporting
      !ET_TARGET_COPY_DATA type /GICOM/WLF_TM_COPY_DATA_TT .
endinterface.
