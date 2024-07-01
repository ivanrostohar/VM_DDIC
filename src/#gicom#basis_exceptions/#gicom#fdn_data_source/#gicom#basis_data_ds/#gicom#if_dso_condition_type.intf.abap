interface /GICOM/IF_DSO_CONDITION_TYPE
  public .


  interfaces IF_BADI_INTERFACE .

  methods SELECT_TITLE
    importing
      !I_PARTNER type /GICOM/OID_PARTNER_NG optional
    exporting
      !ET_COND_TITLE type /GICOM/TCND_TIT_A_TT.
  methods SELECT
    importing
      !IT_SELOPT type DDSHSELOPS optional
      !ITR_COND_TYPE type /GICOM/COND_TYPE_RTT optional
      !IV_VALID type /GICOM/VALID_TO optional               "default SY-DATUM
    exporting
      !ET_CONDITION_TYPES type /GICOM/CONDITION_TYPE_A_TT
      !ET_CONDITION_TYPES_TXT type /GICOM/CONDITION_TYPE_TXT_TT
      !ET_AGRMT_DEFAULTS type /GICOM/AGRMT_DFLT_TT
      !ET_CONDITION_TITLE type /GICOM/TCND_TIT_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods SELECT_TITLES
    importing
      !IV_PARTNER type /GICOM/OID_PARTNER_NG optional
      !ITR_COND_TYPE type /GICOM/COND_TYPE_RTT
    exporting
      !ET_TITLE type /GICOM/CONDITION_TYPE_TXT_TT
      !ET_PARTNER_TITLE type /GICOM/TCND_TIT_A_TT.
  methods SELECT_AGRMT_DEFAULTS
    importing
      !ITR_COND_TYPE type /GICOM/COND_TYPE_RTT
    returning
      value(RT_AGRMT_DFLT) type /GICOM/AGRMT_DFLT_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods INSERT
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !IV_SKIP_ADMIN type ABAP_BOOL default ABAP_FALSE
      !IT_CONDITION_TYPE type /GICOM/CONDITION_TYPE_A_TT
    returning
      value(RT_CONDITION_TYPE) type /GICOM/CONDITION_TYPE_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods UPDATE
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !IV_SKIP_ADMIN type ABAP_BOOL default ABAP_FALSE
      !IT_CONDITION_TYPE type /GICOM/CONDITION_TYPE_A_TT
    returning
      value(RT_CONDITION_TYPE) type /GICOM/CONDITION_TYPE_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods DELETE
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !ITR_COND_TYPE type /GICOM/COND_TYPE_RTT
    raising
      /GICOM/CX_ROOT_DS .
  methods SELECT_DRAFT
    importing
      !IT_SELOPT type DDSHSELOPS optional
      !ITR_COND_TYPE type /GICOM/COND_TYPE_RTT optional
      !IV_VALID type /GICOM/VALID_TO optional
    exporting
      !ET_CONDITION_TYPE type /GICOM/COND_TYPE_DRAFT_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods INSERT_DRAFT
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !IV_SKIP_ADMIN type ABAP_BOOL default ABAP_FALSE
      !IT_CONDITION_TYPE type /GICOM/COND_TYPE_DRAFT_A_TT
    returning
      value(RT_CONDITION_TYPE) type /GICOM/COND_TYPE_DRAFT_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods UPDATE_DRAFT
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !IV_SKIP_ADMIN type ABAP_BOOL default ABAP_FALSE
      !IT_CONDITION_TYPE type /GICOM/COND_TYPE_DRAFT_A_TT
    returning
      value(RT_CONDITION_TYPE) type /GICOM/COND_TYPE_DRAFT_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods DELETE_DRAFT
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !ITR_COND_TYPE type /GICOM/COND_TYPE_RTT
    raising
      /GICOM/CX_ROOT_DS .
  methods CHECK_COND_TYPE_WHERE_USED
    importing
      !IV_COND_TYPE type /GICOM/COND_TYPE
    raising
      /GICOM/CX_ROOT_DS.
  METHODS check_cond_type_exists
    IMPORTING
      !iv_cond_type      TYPE /gicom/cond_type OPTIONAL
      !iv_ref_obj_id    TYPE /gicom/ref_obj_id OPTIONAL
      !iv_calc_schema_id TYPE  /gicom/prprcd_id  OPTIONAL
      !iv_cond_grp_abbrev TYPE /gicom/cond_group_abbrev OPTIONAL
    RAISING
      /gicom/cx_root_ds.
endinterface.
