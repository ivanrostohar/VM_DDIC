INTERFACE /gicom/if_constants_bo
  PUBLIC .


  CONSTANTS cv_bo_contract_type TYPE oj_name VALUE '/GICOM/V01' ##NO_TEXT.
  CONSTANTS cv_bo_cntr TYPE oj_name VALUE '/GICOM/V02' ##NO_TEXT.
  CONSTANTS cv_bo_cntr_var TYPE oj_name VALUE '/GICOM/V03' ##NO_TEXT.
  CONSTANTS cv_bo_addend TYPE oj_name VALUE '/GICOM/V04' ##NO_TEXT.
  CONSTANTS cv_bo_condition_type TYPE oj_name VALUE '/GICOM/V05' ##NO_TEXT.
  CONSTANTS cv_bo_agrmt TYPE oj_name VALUE '/GICOM/V06' ##NO_TEXT.
  CONSTANTS cv_bo_negotiation_round_type TYPE oj_name VALUE '/GICOM/V07' ##NO_TEXT.
  CONSTANTS cv_bo_ngr TYPE oj_name VALUE '/GICOM/V08' ##NO_TEXT.
  CONSTANTS cv_bo_ng TYPE oj_name VALUE '/GICOM/V09' ##NO_TEXT.
  CONSTANTS cv_bo_appt TYPE oj_name VALUE '/GICOM/V10' ##NO_TEXT.
  CONSTANTS cv_bo_settle_run TYPE oj_name VALUE '/GICOM/V11' ##NO_TEXT.
  CONSTANTS cv_bo_settle_doc TYPE oj_name VALUE '/GICOM/V12' ##NO_TEXT.
  CONSTANTS cv_bo_turnover_adjustment TYPE oj_name VALUE '/GICOM/V13' ##NO_TEXT.
  CONSTANTS cv_bo_pricelist TYPE oj_name VALUE '/GICOM/V14'.
  CONSTANTS cv_bo_dummy TYPE oj_name VALUE '/GICOM/DUM' ##NO_TEXT.
***********************************************************************************************************************
  CONSTANTS cv_bo_suppl TYPE oj_name VALUE 'LFA1' ##NO_TEXT.
  CONSTANTS cv_bo_cust TYPE oj_name VALUE 'KNA1' ##NO_TEXT.
  CONSTANTS cv_bo_bupa TYPE oj_name VALUE 'BUS1006' ##NO_TEXT.
  CONSTANTS cv_bo_cocode TYPE oj_name VALUE 'BUS0002' ##NO_TEXT.
  CONSTANTS cv_bo_plant TYPE oj_name VALUE 'BUS0008' ##NO_TEXT.
  CONSTANTS cv_bo_sales_org TYPE oj_name VALUE 'BUS0006' ##NO_TEXT.
  CONSTANTS cv_bo_purch_org TYPE oj_name VALUE 'BUS0007' ##NO_TEXT.
  CONSTANTS cv_bo_matgrp TYPE oj_name VALUE 'BUS1072' ##NO_TEXT.
  CONSTANTS cv_bo_purch_grp TYPE oj_name VALUE 'T024' ##NO_TEXT.
  CONSTANTS cv_bo_division TYPE oj_name VALUE 'TSPA' ##NO_TEXT.
  CONSTANTS cv_bo_distribution_channel TYPE oj_name VALUE 'TVTW' ##NO_TEXT.
  CONSTANTS cv_bo_cost_center TYPE oj_name VALUE 'BUS0012' ##NO_TEXT.
  CONSTANTS cv_bo_condition_contract TYPE oj_name VALUE 'BUS2235' ##NO_TEXT.
  CONSTANTS cv_bo_simulation_agreement TYPE oj_name VALUE '/GICOM/V15' ##NO_TEXT.
  CONSTANTS:
    BEGIN OF cs_bo_cntr_aplprs,
      addendum   TYPE /gicom/baplprs VALUE 'ADDEND',
      cancel     TYPE /gicom/baplprs VALUE 'CANCEL',
      correction TYPE /gicom/baplprs VALUE 'CORRECTION',
      invalidate TYPE /gicom/baplprs VALUE 'INVALIDATE',
      modific    TYPE /gicom/baplprs VALUE 'MODIFIC',
      release    TYPE /gicom/baplprs VALUE 'RELEASE',
      terminate  TYPE /gicom/baplprs VALUE 'TERMINATE',
    END OF cs_bo_cntr_aplprs .
  CONSTANTS cv_bo_prodh TYPE oj_name VALUE 'BUS10017' ##NO_TEXT.
ENDINTERFACE.
