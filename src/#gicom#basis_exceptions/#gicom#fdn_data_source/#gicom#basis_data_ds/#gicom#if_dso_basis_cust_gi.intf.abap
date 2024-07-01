interface /GICOM/IF_DSO_BASIS_CUST_GI
  public .


  interfaces IF_BADI_INTERFACE .

  methods SELECT_PARA_VALUES
    importing
      !ITR_PARA_KEY type /GICOM/KEY_PARA_RTT
    returning
      value(RT_PARA_VALUES) type /GICOM/PARA_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods SELECT_TPROCESS
    returning
      value(RS_TPROCESS) type /GICOM/TPROCESS_DATA_S .
  methods SELECT_DIMENSION_RANKING
    returning
      value(RT_DIM_RANK) type /GICOM/DIM_RANK_A_TT
    raising
      /GICOM/CX_ROOT_DS .
  methods SELECT_SYSTEM_CONSTANTS
    returning
      value(RS_CONSTANTS) type /GICOM/TSYSCONST_DATA_S
    raising
      /GICOM/CX_NOT_FOUND .
  methods INSERT_SYSTEM_CONSTANTS
    importing
      !IS_SYS_CONSTANTS type /GICOM/TSYSCONST_DATA_S
      !IV_COMMIT type ABAP_BOOL default 'X' .
  methods UPDATE_SYSTEM_CONSTANTS
    importing
      !IS_SYS_CONSTANTS type /GICOM/TSYSCONST_DATA_S
      !IV_COMMIT type ABAP_BOOL default 'X' .
endinterface.
