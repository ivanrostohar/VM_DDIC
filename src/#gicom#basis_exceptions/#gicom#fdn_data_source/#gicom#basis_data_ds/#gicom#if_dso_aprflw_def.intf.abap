interface /GICOM/IF_DSO_APRFLW_DEF
  public .


  interfaces /GICOM/IF_DSO_DESCRIPTION .
  interfaces IF_BADI_INTERFACE .

  methods SELECT_WL
    exporting
      !ET_APRFLW_WL type /GICOM/APRFLW_WL_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods SELECT
    importing
      !IT_APRFLW type /GICOM/APRFLW_TT
    exporting
      !ET_AF_DOC type /GICOM/AF_DOC_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods DB_UPDATE
    importing
      !IV_TABNAME type TABNAME
      !IT_INSERT type TABLE
      !IT_UPDATE type TABLE
      !IT_DELETE type TABLE
    raising
      /GICOM/CX_ROOT_DS .
  methods VERSION_GET
    importing
      !IV_APRFLW type /GICOM/BAPRFLW
      !IV_READ_LATEST_VERSION type /GICOM/ABAP_BOOL
    exporting
      !EV_VRSIO type /GICOM/BAFVRSIO .
  methods SELECT_APPROVAL
    exporting
      value(ET_APPROVALS) type /GICOM/BAPPROVAL_TT
      value(ET_APPROVALS_TXT) type /GICOM/BAPPROVAL_TXT_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods SELECT_ACTIVITIES_BY_UROLE
    importing
      !IT_ROLE type /GICOM/AFUSROLE_TT
    returning
      value(RT_AFSACT) type /GICOM/TAFSACT_TT .
  methods GENERATE_ACTH_GUID
    returning
      value(RV_GUID) type /GICOM/AFACTH_GUID .
  methods GET_INACIVE_VERSION
    importing
      !IV_APRFLW type /GICOM/BAPRFLW
    exporting
      value(ES_APFLW) type /GICOM/APRFLW_S .
endinterface.
