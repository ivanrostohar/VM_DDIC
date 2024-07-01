interface /GICOM/IF_DSO_VIEWM
  public .


  interfaces IF_BADI_INTERFACE .

  methods SELECT
    importing
      !IV_VIEW_NAME type /GICOM/VIEW_NAME
      !IT_KEY type TIHTTPNVP optional
    exporting
      !ES_VIEWM_DATA type /GICOM/VIEWDATA_A_S .
  methods SAVE_DATA
    importing
      !IV_TRKORR type TRKORR optional
      !IT_VIEWM_DOC type /GICOM/VIEWM_DOC_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods LOCK_VIEW_DATA
    importing
      !IV_VIEW_NAME type VIEWNAME
    raising
      /GICOM/CX_LOCKED_DATA
      /GICOM/CX_NOT_FOUND .
  methods UNLOCK_VIEW_DATA
    importing
      !IV_VIEW_NAME type VIEWNAME
    raising
      /GICOM/CX_NOT_FOUND .
  methods SELECT_WL
    importing
      !IV_VIEW_NAME type VIEWNAME
      !IT_KEY type TIHTTPNVP optional
    exporting
      !ET_VIEWM_DATA type /GICOM/VIEWDATA_A_TT .
  methods GET_VIEWCLUSTER_DEFINITION
    importing
      !IV_VC_NAME type VCL_NAME
    exporting
      !ES_VCLDIR_ENTRY type /GICOM/VCLDIR_A_S
      !ET_VCLSTRUC type /GICOM/VCLSTRUC_A_TT
      !ET_VCLSTDEP type /GICOM/VCLSTDEP_A_TT
      !ET_VCLMF type /GICOM/VCLMF_A_TT
    raising
      /GICOM/CX_NOT_FOUND .
  methods GET_DDIC_TYPE
    importing
      !IV_OBJ_NAME type SOBJ_NAME
    returning
      value(RV_DDIC_TYPE) type TROBJTYPE
    raising
      /GICOM/CX_NOT_FOUND .
  methods SELECT_LANG_TEXTS
    exporting
      !ET_T002T type /GICOM/T002T_TT .
endinterface.
