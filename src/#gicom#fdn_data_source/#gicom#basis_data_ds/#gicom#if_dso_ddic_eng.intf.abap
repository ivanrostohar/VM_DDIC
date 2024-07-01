interface /GICOM/IF_DSO_DDIC_ENG
  public .


  interfaces IF_BADI_INTERFACE .

  methods ACTIVATE_TABLE
    importing
      !IV_TABNAME type DDOBJNAME
    returning
      value(RV_SUBRC) type SY-SUBRC .
  methods GET_TABLE
    importing
      !IV_TABNAME type TABNAME
      !IV_LANG type SY-LANGU
    exporting
      !EV_STATE type DDGOTSTATE
      !ES_DD02V type DD02V
      !ES_DD09V type DD09V
      !ET_DD03P type DD03PTAB .
  methods PUT_TABLE
    importing
      !IV_TABNAME type DDOBJNAME
      !IS_DD02V_WA type DD02V
      !IS_DD09L_WA type DD09V
      !IT_DD03P_TAB type DD03PTAB
      !IV_TRKORR type TRKORR optional
      !IV_DEVCLASS type DEVCLASS
    returning
      value(RV_SUBRC) type SY-SUBRC .
  methods ACTIVATE_TTYP
    importing
      !IV_TABNAME type DDOBJNAME
    returning
      value(RV_SUBRC) type SY-SUBRC .
  methods PUT_TTYP
    importing
      !IV_TABNAME type DDOBJNAME
      !IS_DD40V type DD40V
      !IV_TRKORR type TRKORR optional
      !IV_DEVCLASS type DEVCLASS
    returning
      value(RV_SUBRC) type SY-SUBRC .
  methods ACTIVATE_DATAELEMENT
    importing
      !IV_NAME type DDOBJNAME
    returning
      value(RV_SUBRC) type SY-SUBRC .
  methods PUT_DATAELEMENT
    importing
      !IV_NAME type DDOBJNAME
      !IS_DD04V type DD04V
      !IV_TRKORR type TRKORR optional
      !IV_DEVCLASS type DEVCLASS
    returning
      value(RV_SUBRC) type SY-SUBRC .
  methods GET_DATAELEMENT
    importing
      !IV_NAME type DDOBJNAME
      !IV_LANG type SY-LANGU
    exporting
      !EV_STATE type DDGOTSTATE
      !ES_DD04V type DD04V .
  methods ACTIVATE_DOMAIN
    importing
      !IV_NAME type DDOBJNAME
    returning
      value(RV_SUBRC) type SY-SUBRC .
  methods GET_DOMAIN
    importing
      !IV_NAME type DDOBJNAME
      !IV_LANG type SY-LANGU
    exporting
      !EV_STATE type DDGOTSTATE
      !ES_DD01V type DD01V
      !ET_DD07V type DD07V_TAB .
  methods PUT_DOMAIN
    importing
      !IV_NAME type DDOBJNAME
      !IS_DD01V type DD01V
      !IT_DD07V type DD07V_TAB
      !IV_TRKORR type TRKORR optional
      !IV_DEVCLASS type DEVCLASS
    returning
      value(RV_SUBRC) type SY-SUBRC .
  methods GET_VIEW
    importing
      !IV_NAME type DDOBJNAME
      !IV_LANGU type SY-LANGU
    exporting
      !EV_STATE type DDGOTSTATE
      !ES_DD25V type DD25V
      !ES_DD09L type DD09V
      !ET_DD26V type DD26VTAB
      !ET_DD27P type DD27PTAB
      !ET_DD28J type /GICOM/DD28J_TT
      !ET_DD28V type DD28VTAB .
  methods GET_DEVCLASS_FROM_OBJECT
    importing
      !IV_PGMID type PGMID
      !IV_OBJECT type TROBJTYPE
      !IV_OBJNAME type SOBJ_NAME
    returning
      value(RS_DEVCLASS) type TRDEVCLASS .
  methods GET_PGMID_FOR_OBJECT
    importing
      !IV_OBJTYPE type TROBJTYPE
    returning
      value(RS_TYPE) type KO100 .
  methods GET_FIELDS_OF_STRUCTURE
    importing
      !IV_DATATYPE type /GICOM/DATATYPE
    exporting
      !ES_TTYPE_INFO type DD40V
    returning
      value(RT_FIELDS) type DFIES_TABLE .
  methods GET_TEXTTABLE
    importing
      !IV_STRUCTURE type TABNAME
    returning
      value(RV_TEXT_TABLE) type TABNAME .
  methods GET_FIELDINFO
    importing
      !IV_STRUCTURE type DDOBJNAME
      !IV_FIELDNAME type DFIES-FIELDNAME optional
      !IV_LANGU type SY-LANGU optional
      !IV_LVC_FCAT_REQUIRED type ABAP_BOOL optional
    exporting
      !ET_LVC_FCAT type LVC_T_FCAT
    returning
      value(RT_FIELDS) type DFIES_TABLE .
  methods GET_DEVCLASS_FOR_OBJECT
    importing
      !IV_OBJTYPE type TROBJTYPE
      !IV_OBJNAME type SOBJ_NAME
    exporting
      !EV_DEVCLASS type DEVCLASS .
  methods DELETE_DDIC_OBJECT
    importing
      !IV_OBJNAME type DDOBJNAME
      !IV_OBJTYPE type DDEUTYPE
      !IV_TRKORR type TRKORR optional .
  methods SELECT_TEXTTABLE_DATA
    importing
      !IV_TABNAME type TABNAME
      !IV_LANGU type SPRAS default SY-LANGU
      !IV_DESCR_FIELD type FIELDNAME optional
    returning
      value(RT_VALUES) type TIHTTPNVP
    raising
      /GICOM/CX_ROOT_DS .
  methods GET_SHLP_NAME
    importing
      !IV_TABNAME type DFIES-TABNAME
      !IV_FIELDNAME type DFIES-FIELDNAME
    exporting
      !ES_SHLP type SHLP_DESCR .
endinterface.
