interface /GICOM/IF_DSO_COND_GROUP
  public .


  interfaces IF_BADI_INTERFACE .

  methods SELECT
    importing
      !IT_SELOPT type DDSHSELOPS optional
      !ITR_COND_GRP type /GICOM/COND_GROUP_RTT optional
    exporting
      !ET_COND_GRP type /GICOM/COND_GRP_A_TT
      !ET_COND_GRP_TXT type /GICOM/COND_GROUP_TXT_TT
      !ET_COND_GRP_REL type /GICOM/COND_GRP_REL_A_TT
      !ET_COND_GROUP_CONTR_TYPE_REL type /GICOM/CONTRACT_TYPE_CGR_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods INSERT
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !IV_SKIP_ADMIN type ABAP_BOOL default ABAP_FALSE
      !IT_CONDITION_GROUP type /GICOM/COND_GRP_A_TT
    returning
      value(RT_CONDITION_GROUP) type /GICOM/COND_GRP_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods UPDATE
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !IV_SKIP_ADMIN type ABAP_BOOL default ABAP_FALSE
      !IT_CONDITION_GROUP type /GICOM/COND_GRP_A_TT
    returning
      value(RT_CONDITION_GROUP) type /GICOM/COND_GRP_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods DELETE
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !ITR_CONDITION_GROUP type /GICOM/COND_GROUP_RTT
    raising
      /GICOM/CX_ROOT_DS .
  methods SELECT_GROUPS_FOR_TYPES
    importing
      !ITR_COND_TYPE type /GICOM/COND_TYPE_RTT
      !ITR_PROCESS type /GICOM/COND_GRP_PROCESS_RTT optional
    returning
      value(RT_COND_GROUP) type /GICOM/COND_GRP_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods SELECT_DRAFT
    importing
      !IT_SELOPT type DDSHSELOPS
      !ITR_COND_GRP type /GICOM/COND_GROUP_RTT
    exporting
      !ET_COND_GRP type /GICOM/CONG_GRP_DRAFT_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods INSERT_DRAFT
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !IV_SKIP_ADMIN type ABAP_BOOL default ABAP_FALSE
      !IT_CONDITION_GROUP type /GICOM/CONG_GRP_DRAFT_A_TT
    returning
      value(RT_CONDITION_GROUP) type /GICOM/CONG_GRP_DRAFT_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods UPDATE_DRAFT
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !IV_SKIP_ADMIN type ABAP_BOOL default ABAP_FALSE
      !IT_CONDITION_GROUP type /GICOM/CONG_GRP_DRAFT_A_TT
    returning
      value(RT_CONDITION_GROUP) type /GICOM/CONG_GRP_DRAFT_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods DELETE_DRAFT
    importing
      !IV_COMMIT type ABAP_BOOL default ABAP_TRUE
      !ITR_CONDITION_GROUP type /GICOM/COND_GROUP_RTT
    raising
      /GICOM/CX_ROOT_DS .
  methods SELECT_ASSIGNED_COND_TYPES
    importing
      !ITR_CONDITION_GROUP type /GICOM/COND_GROUP_RTT
    returning
      value(rt_cond_types) type /gicom/cond_type_tt
    raising
      /GICOM/CX_ROOT_DS .
endinterface.
