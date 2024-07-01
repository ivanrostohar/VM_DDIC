interface /GICOM/IF_DSO_APRFLW_EXE
  public .


  interfaces IF_BADI_INTERFACE .

  methods SELECT
    importing
      !IV_REMINDER type CHAR1 optional
      !IT_STATUS type /GICOM/BAFSTATU_RTT
      !IT_BOAPFLW type /GICOM/BOAPFLW_TT
    exporting
      !ET_BOAPFLW_DOC type /GICOM/BOAFLW_DOC_TT
    raising
      /gicom/cx_root_ds.
  methods DB_UPDATE
    importing
      !IV_TABNAME type TABNAME
      !IT_INSERT type TABLE
      !IT_UPDATE type TABLE
      !IT_DELETE type TABLE
    raising
      /gicom/cx_root_ds.
  methods SELECT_WL
    importing
      !IV_USER type XUBNAME
      !IV_REMINDER type CHAR1
      !IT_SELOPT_USROLES type /GICOM/AFUSROLE_RTT
      !IT_SELOPT_BOTYP type /GICOM/BO_TYP_RTT
      !IT_SELOPT_REMINDER type /GICOM/ABAP_BOOL_RTT
    exporting
      !ET_WORKLIST type /GICOM/BOAPFLW_WL_TT
    raising
      /gicom/cx_root_ds.
  methods GET_COUNT
    importing
      !IV_USER type XUBNAME
      !IT_SELOPT_USROLES type /GICOM/AFUSROLE_RTT
      !IT_SELOPT_BOTYP type /GICOM/BO_TYP_RTT
      !IT_SELOPT_REMINDER type /GICOM/ABAP_BOOL_RTT
    exporting
      !ET_WORKLIST type /GICOM/BOAPFLW_WL_TT
    raising
      /gicom/cx_root_ds.
  methods SELECT_ACTIVITY_INFO
    importing
      !IV_ACTIVITY_ID type /GICOM/BGUID_16
    exporting
      !ES_APPROVAL_COMM type /GICOM/BBOAFLW_COMM_S
    raising
      /gicom/cx_root_ds.
  methods SELECT_APPROVAL_PROCESS
    importing
      !IV_OBJTY type /GICOM/BO_TYP
      !IV_OBJID type /GICOM/BO_ID
    exporting
      !EV_OBJPRS type /GICOM/BAPLPRS
    raising
      /gicom/cx_root_ds.
  methods SELECT_ACTIVITIES_BY_UROLE
    IMPORTING
      it_role   TYPE /GICOM/AFUSROLE_TT
    RETURNING VALUE(rt_BBOAFACT) TYPE /GICOM/BBOAFACT_TT.
  methods GENERATE_ACTH_GUID
    returning
      value(RV_GUID) type GUID_16 .
  methods SELECT_HISTORY
    importing
      !IS_TBOAFACT_H type /GICOM/TBOAFACT_H_S
    exporting
      !ET_TBOAFACT_H type /GICOM/TBOAFACT_H_TT .
  methods select_actactors
    IMPORTING
      it_acgud           TYPE /gicom/activity_guid_tt
    RETURNING
      VALUE(rt_actactor) TYPE /gicom/actactor_db_tt.
endinterface.
