interface /GICOM/IF_DSO_REPOS_ENG
  public .


  interfaces IF_BADI_INTERFACE .

  methods CLASS_IF_EXISTENCE_CHECK
    importing
      !IV_CLASS_NAME type SEOCLSNAME
    returning
      value(RV_NOT_EXISTS) type XFELD
    raising
      /GICOM/CX_NOT_FOUND .
  methods CREATE_CLASS
    importing
      !IV_DEVCLASS type DEVCLASS optional
      !IV_SUPERCLASS type SEOCLSNAME optional
      !IS_CLASS type VSEOCLASS
      !IT_INTERFACE type SEO_CLSKEYS optional
    exporting
      !EV_CLASS type SEOCLSNAME
      !EV_TRKORR type TRKORR
    returning
      value(RV_SUBRC) type SY-SUBRC .
  methods CREATE_FUNCTION
    importing
      !IV_FUNCNAME type RS38L-NAME
      !IV_FUNC_POOL type RS38L-AREA
      !IV_SHORT_TEXT type RS38L_FTXT optional
      !IT_SOURCE type RSFB_SOURCE optional
    changing
      !CV_TRKORR type TRKORR
      !CT_EXC_LIST type RSFB_EXC optional
      !CT_EXP_PARAMS type RSFB_EXP optional
      !CT_IMP_PARAMS type RSFB_IMP optional
      !CT_PAR_DOCU type SIW_TAB_RSFDO optional
      !CT_TAB_PARAMS type RSFB_TBL optional
      !CT_CHA_PARAMS type RSFB_CHA
    returning
      value(RV_FUN_INCLUDE) type RS38L-INCLUDE .
  methods DELETE_CLASS
    importing
      !IV_CLASS type SEOCLSNAME
    exporting
      !EV_TRKORR type TRKORR .
  methods GET_CLASS
    importing
      !IV_CLASSNAME type SEOCLSNAME
    returning
      value(RS_CLASS) type VSEOCLASS .
  methods GET_CLASS_INTERFACES
    importing
      !IV_CLASS_NAME type SEOCLSNAME
    returning
      value(RT_INTERFACES) type SEO_RELKEYS .
  methods GET_INCLUDES
    importing
      !IV_CLASS_NAME type SEOCLSNAME
    returning
      value(RT_INCLUDE) type SEOP_METHODS_W_INCLUDE .
  methods GET_INTERFACE
    importing
      !IV_INTERFACE type SEOCLSNAME
    returning
      value(RS_INTERFACE) type VSEOINTERF .
  methods GET_SOURCE_METHODS
    importing
      !IV_CLASS_NAME type SEOCLSNAME
    returning
      value(RT_SOURCE) type /GICOM/CMETHOD_SOURCE_TT .
endinterface.
