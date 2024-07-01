interface /GICOM/IF_DSO_SOURCING_TYPE
  public .


  interfaces IF_BADI_INTERFACE .

  methods SELECT
    exporting
      !ET_SOURCING_TYPE type /GICOM/SOURCING_TYPE_A_TT
      !ET_SOURCING_TYPE_TXT type /GICOM/SRC_TYP_TXT_TT
    raising
      /gicom/cx_root_ds.
endinterface.
