interface /GICOM/IF_DSO_DIMENSION
  public .


  interfaces IF_BADI_INTERFACE .

  methods SELECT_DIM_ID_FOR_DIM_DATA
    importing
      !IS_DIMENSION type /GICOM/DIM_A_S
    returning
      value(RV_DIM_ID) type /GICOM/DIM_ID
    raising
      /gicom/cx_root_ds.
  methods SELECT_DIM_FOR_DIM_ID
    importing
      !IV_DIM_ID type /GICOM/DIM_ID
    returning
      value(RS_DIMENSION) type /GICOM/DIM_A_S
    raising
      /gicom/cx_root_ds.
  methods SELECT_DIM_LIST_FOR_DIM_ID
    importing
      !IT_DIM_ID type /GICOM/DIM_ID_RTT
    returning
      value(RT_DIMENSION) type /GICOM/DIM_A_TT
    raising
      /gicom/cx_root_ds.
  methods SELECT_DIM_LIST_FOR_DIM_DATA
    importing
      !IT_R_OID_SENDER type /GICOM/OID_SENDER_RTT
      !IT_R_OID_RCV type /GICOM/OID_RCV_RANGE_TT
      !IT_R_OID_ART_GRP type /GICOM/OID_ART_GRP_RTT
      !IT_R_GROUPING type /GICOM/GRP_R_TT
      !IT_R_SOURCING_TYPE type /GICOM/SOURCING_TYPE_RTT
      !IT_R_MATNR type /GICOM/MATNR_RTT
      !IT_R_SERVICE_TYPE type /GICOM/SERVICE_TYPE_RTT
    returning
      value(RT_DIM) type /GICOM/DIM_A_TT
    raising
      /gicom/cx_root_ds.
endinterface.
