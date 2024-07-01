FUNCTION /GICOM/RFC_CHANGE_COND_CONTR.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IS_HEAD_DATA) TYPE  /GICOM/CCS_BAPICCHEAD_S
*"     VALUE(IS_HEAD_DATAX) TYPE  /GICOM/CCS_BAPICCHEADX_S
*"  EXPORTING
*"     VALUE(ES_HEAD_DATAO) TYPE  /GICOM/CCS_BAPICCHEADOS_S
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  CHANGING
*"     VALUE(CT_CALENDAR) TYPE  /GICOM/CCS_BAPICCCAL_TT
*"     VALUE(CT_CALENDARX) TYPE  /GICOM/CCS_BAPICCCALX_TT
*"     VALUE(CT_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA lo_exception TYPE REF TO /gicom/cx_root.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).

      NEW /gicom/cl_dso_sap_settl_mngt( )->change_condition_contract(
        EXPORTING
          is_head_data             =     is_head_data
          is_head_datax            =     is_head_datax
        IMPORTING
          es_head_datao            =     es_head_datao
        CHANGING
          ct_calendar              =     ct_calendar
          ct_calendarx             =     ct_calendarx
          ct_return                =     ct_return
      ).
    CATCH /gicom/cx_internal_error INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).
  ENDTRY.

ENDFUNCTION.
