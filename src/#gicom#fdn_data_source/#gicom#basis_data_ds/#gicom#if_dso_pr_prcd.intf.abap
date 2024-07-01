interface /GICOM/IF_DSO_PR_PRCD
  public .


  interfaces IF_BADI_INTERFACE .

  methods SELECT
    importing
      !IT_SELOPT type DDSHSELOPS optional
      !ITR_ID type /GICOM/PRPRCD_ID_RTT optional
    returning
      value(RT_PR_PRCD) type /GICOM/PRPRCD_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods INSERT
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !IV_SKIP_ADMIN type ABAP_BOOL default ABAP_FALSE
      !IT_CALCULATION_SCHEMA type /GICOM/PRPRCD_A_TT
    returning
      value(RT_CALCULATION_SCHEMA) type /GICOM/PRPRCD_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods UPDATE
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !IV_SKIP_ADMIN type ABAP_BOOL default ABAP_FALSE
      !IT_CALCULATION_SCHEMA type /GICOM/PRPRCD_A_TT
    returning
      value(RT_CALCULATION_SCHEMA) type /GICOM/PRPRCD_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods DELETE
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !ITR_CALC_SCHEMA type /GICOM/PRPRCD_ID_RTT
    raising
      /GICOM/CX_ROOT_DS .
  methods SELECT_DRAFT
    importing
      !IT_SELOPT type DDSHSELOPS optional
      !ITR_ID type /GICOM/PRPRCD_ID_RTT optional
    returning
      value(RT_PR_PRCD) type /GICOM/PRPRCD_DRAFT_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods INSERT_DRAFT
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !IV_SKIP_ADMIN type ABAP_BOOL default ABAP_FALSE
      !IT_CALCULATION_SCHEMA type /GICOM/PRPRCD_DRAFT_A_TT
    returning
      value(RT_CALCULATION_SCHEMA) type /GICOM/PRPRCD_DRAFT_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods UPDATE_DRAFT
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !IV_SKIP_ADMIN type ABAP_BOOL default ABAP_FALSE
      !IT_CALCULATION_SCHEMA type /GICOM/PRPRCD_DRAFT_A_TT
    returning
      value(RT_CALCULATION_SCHEMA) type /GICOM/PRPRCD_DRAFT_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods DELETE_DRAFT
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !ITR_CALC_SCHEMA type /GICOM/PRPRCD_ID_RTT
    raising
      /GICOM/CX_ROOT_DS .
  methods CHECK_CALC_SCHEMA_WHERE_USED
    importing
      !IV_ID type /GICOM/PRPRCD_ID
    raising
      /GICOM/CX_ROOT_DS .
endinterface.
