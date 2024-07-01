interface /GICOM/IF_DS_CENTRL_CFG
  public .


  interfaces IF_BADI_INTERFACE .

  methods SELECT_BO
    importing
      !IV_DUMMY type CHAR1 optional
    exporting
      !ET_BO type /GICOM/BO_TT
      !ET_BOT type /GICOM/BOT_TT
      !ET_BODA type /GICOM/BODA_TT
      !ET_BODAT type /GICOM/BODAT_TT
      !ET_BOAPS type /GICOM/BOAPS_TT
      !ET_BOAPST type /GICOM/BOAPST_TT
      !ET_BODTYP type /GICOM/BODTYP_TT
      !ET_BODTYPT type /GICOM/BODTYPT_TT
      !ET_BODTRG type /GICOM/BODTRG_TT
      !ET_BODTRGT type /GICOM/BODTRGT_TT
      !ET_BODATRG type /GICOM/BODATRG_TT
      !ET_BODATRGT type /GICOM/BODATRGT_TT .
  methods SELECT_FOLDERS
    importing
      !IV_DUMMY type CHAR1 optional
    exporting
      !ET_FOLDERS type /GICOM/FOLDER_TT
      !ET_FOLDERST type /GICOM/FOLDERT_TT .
  methods SELECT_DOCUMENTS
    importing
      !IV_DUMMY type CHAR1 optional
    exporting
      !ET_DOCBO type /GICOM/DOCBO_TT
      !ET_TRADTYP type /GICOM/TRADTYP_TT
      !ET_DTYPAF type /GICOM/DTYPAF_TT .
  methods SELECT_DATA_ELEMENTS
    returning
      value(RT_DEP_DTEL) type /GICOM/DTEL_DEP_TT .
  methods SELECT_LANG_DESCR
    returning
      value(RT_LANG_DESCR) type TFW_T002T_TAB .
  methods SELECT_TEMPLATE_ASSIGN_FIELDS
    exporting
      !ET_TMPAFLD type /GICOM/TMAFLD_TT .
  methods SELECT_ACTIVITY_ACTIONS
    exporting
      !ET_ACTIONS type /GICOM/TAFACTNT_T .
  methods SELECT_ASSIGNED_APPROVAL_FLOWS
    exporting
      !ET_BO_APPR type /GICOM/BO_APPR_TT .
  methods SELECT_WORK_STATUS
    returning
      value(RST_WRK_STAT) type /GICOM/WRK_STAT_A_STT .
  methods SELECT_ENHANCEMENT_CONFIG
    exporting
      !ET_CEFDEF type /GICOM/CEFDEF_TT
      !ET_CEFDEFT type /GICOM/CEFDEFT_TT
      !ET_CEFSRC type /GICOM/TCEFSRC_A_TT
      !ET_CEFTRG type /GICOM/TCEFTRG_A_TT .
  methods SELECT_REMINDER_EVENTS
    returning
      value(RT_EVENT) type /GICOM/BO_RMDR_EVENT_TT .
  methods SELECT_REMINDER_RULES
    returning
      value(RT_RULE) type /GICOM/BO_RMDR_RULE_TT .
  methods SELECT_REMINDER_ACTOR_TYPES
    returning
      value(RT_ACTOR_TYPE) type /GICOM/BO_RMDR_ACTOR_TYPE_TT .
  methods SELECT_REMINDER_ORG_UNIT_TYPES
    returning
      value(RT_ORG_UNIT_TYPE) type /GICOM/BO_RMDR_ORG_TYPE_TT .
endinterface.
