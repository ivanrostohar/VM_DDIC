INTERFACE /gicom/if_constants_ccs
  PUBLIC .

  CONSTANTS:
    BEGIN OF c_tpara,
      bvb_cash         TYPE /gicom/key_para VALUE 'X_CCS_BVB_CASH',
      bvb_immediate    TYPE /gicom/key_para VALUE 'X_CCS_BVB_IMMEDIATE',
      bvb_subsequent   TYPE /gicom/key_para VALUE 'X_CCS_BVB_SUBSEQUENT',
      bvb_undefined    TYPE /gicom/key_para VALUE 'X_CCS_BVB_UNDEFINED',
      split_cash       TYPE /gicom/key_para VALUE 'X_CCS_SPLIT_AGRMT_ID_CASH',
      split_immediate  TYPE /gicom/key_para VALUE 'X_CCS_SPLIT_AGRMT_ID_IMMEDIATE',
      split_subsequent TYPE /gicom/key_para VALUE 'CCS_SPLIT_AGRMT_ID',
      split_undefined  TYPE /gicom/key_para VALUE 'X_CCS_SPLIT_AGRMT_ID_UNDEFINED',
      start_date       TYPE /gicom/key_para VALUE 'CCS_START_DATE',
      stan_passive_run TYPE /gicom/key_para VALUE 'X_APM_STAN_PASSIVE_SETTL_RUN',
    END OF c_tpara.

ENDINTERFACE.
