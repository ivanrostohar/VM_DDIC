FUNCTION /GICOM/RFC_READ_COST_CENTER.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_COST_CENTERS) TYPE  /GICOM/CCOST_CENTER_A_STT
*"     VALUE(ET_COST_CENTERS_TXT) TYPE  /GICOM/CCOST_CENTER_TXT_A_STT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
DATA: lo_exception TYPE REF TO /gicom/cx_root_da.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_cost_center ).

      NEW /gicom/cl_dso_cost_center( )->select_cost_centers(
      IMPORTING
          et_cost_centers = et_cost_centers
          et_cost_centers_txt = et_cost_centers_txt ).

    CATCH /gicom/cx_root_da INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.




ENDFUNCTION.
