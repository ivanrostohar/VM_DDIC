interface /GICOM/IF_DSO_DYNDOC
  public .


  interfaces IF_BADI_INTERFACE .

  methods UPDATE
    importing
      !IV_TABNAME type TABNAME
      !IT_INSERT type TABLE
      !IT_UPDATE type TABLE
      !IT_DELETE type TABLE
    raising
      /gicom/cx_root_ds.
  methods READ
    importing
      !IT_DDOC type /GICOM/BDDHDR_KEY_TT
    exporting
      !ET_DYN_DOC type /GICOM/BDD_DOC_TT
    raising
      /gicom/cx_root_ds.
  methods SELECT_DYNDOC
    importing
      !IV_BO_TYP type /GICOM/BO_TYP
      !IV_OBJID type /GICOM/BO_ID
    exporting
      !ET_DYN_DOC type /GICOM/BDD_DOC_TT
    raising
      /gicom/cx_root_ds.
endinterface.
