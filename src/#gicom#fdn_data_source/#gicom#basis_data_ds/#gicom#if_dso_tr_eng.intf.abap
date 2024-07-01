interface /GICOM/IF_DSO_TR_ENG
  public .


  interfaces IF_BADI_INTERFACE .

  methods ASSIGN_DOMA_TO_TRANSPORT_REQ
    importing
      !IV_DEVCLASS type DEVCLASS optional
      !IV_TRKORR type TRKORR optional
      !IT_OBJNAME type TTTABNAME
    returning
      value(RV_TRKORR) type TRKORR .
  methods ASSIGN_DTEL_TO_TRANSPORT_REQ
    importing
      !IV_DEVCLASS type DEVCLASS optional
      !IV_TRKORR type TRKORR optional
      !IT_OBJNAME type TTTABNAME
    returning
      value(RV_TRKORR) type TRKORR .
  methods ASSIGN_OBJS_TO_TRANSPORT_REQ
    importing
      !IV_TRKORR type TRKORR optional
    changing
      !CT_E071 type TREDT_OBJECTS
      !CT_E071K type TREDT_KEYS optional
    returning
      value(RV_TRKORR) type TRKORR
    raising
      /GICOM/CX_SAP_CALL_ERROR.

  methods ASSIGN_STRUC_TO_TRANSPORT_REQ
    importing
      !IV_DEVCLASS type DEVCLASS optional
      !IV_TRKORR type TRKORR optional
      !IT_OBJNAME type TTTABNAME
    returning
      value(RV_TRKORR) type TRKORR .
  methods ASSIGN_TABLE_TO_TRANSPORT_REQ
    importing
      !IV_DEVCLASS type DEVCLASS optional
      !IV_TRKORR type TRKORR optional
      !IT_OBJNAME type TTTABNAME
    returning
      value(RV_TRKORR) type TRKORR .
  methods ASSIGN_TTYPE_TO_TRANSPORT_REQ
    importing
      !IV_DEVCLASS type DEVCLASS optional
      !IV_TRKORR type TRKORR optional
      !IT_OBJNAME type TTTABNAME
    returning
      value(RV_TRKORR) type TRKORR .
  methods CREATE_TRANSPORT_REQUEST
    importing
      !IV_PACKAGE type DEVCLASS optional
    exporting
      !ES_TR_REQ_COMM type /GICOM/TRNSPT_REQ_COMM_S .
  methods CREATE_TRANSPORT_TASK
    exporting
      !ES_TR_REQ_COMM type /GICOM/TRNSPT_REQ_COMM_S
    returning
      value(RV_TASK) type TRKORR .
  methods SELECT_TRANS_REQS_FOR_USER
    importing
      !IV_UNAME type TR_AS4USER default SY-UNAME
      !IV_CLIENT type MANDT default SY-MANDT
      !IV_TR_TYPE type TRFUNCTION default 'K'
    returning
      value(RT_E07T) type TT_E07T .
  methods SELECT_TRANS_REQ_FOR_KEY
    importing
      !IV_TABNAME type TABNAME
      !IV_KEY type TROBJ_NAME
    returning
      value(RV_TRKORR) type TRKORR .
  methods SELECT_TRANS_REQ_FOR_OBJECT
    importing
      !IV_OBJECT type TROBJTYPE
      !IV_OBJ_NAME type TROBJ_NAME
    returning
      value(RV_TRKORR) type TRKORR .
endinterface.
