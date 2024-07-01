FUNCTION /gicom/rfc_sync_cond_contract.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IS_HEAD) TYPE  /GICOM/CCS_BAPICCHEAD_S
*"     VALUE(IS_HEAD_SET) TYPE  /GICOM/CCS_BAPICCHEADX_S
*"     VALUE(IV_CONDITION_CONTRACT_NUMBER) TYPE
*"        /GICOM/CCS_WCB_COCO_NUM
*"     VALUE(IS_ELIGIBLE_SET) TYPE  /GICOM/CCS_BAPICCITEMX_S
*"     VALUE(IS_CONDITION_ITEM_SET) TYPE  /GICOM/CCS_BAPICCCOND_ITMX_S
*"     VALUE(IS_CONDITION_KEY_SET) TYPE  /GICOM/CCS_BAPICCCOND_KEYX_S
*"     VALUE(IT_ELIGIBLE) TYPE  /GICOM/CCS_WCB_BAPICCITEM_TT
*"     VALUE(IT_CONDITION_KEY) TYPE  /GICOM/CCS_BAPICCCOND_KEY_TT
*"     VALUE(IT_CONDITION_ITEM) TYPE  /GICOM/CCS_BAPICCCOND_ITEM_TT
*"     VALUE(IT_EXTENSION) TYPE  /GICOM/CCS_BAPIPAREX_TT
*"     VALUE(IT_HEAD_TEXT) TYPE  /GICOM/CCS_BAPICCHEDTXTCHNG_TT
*"     VALUE(IT_ELIGIBLE_TEXT) TYPE  /GICOM/CCS_BAPICCITMTXTCHNG_TT
*"     VALUE(IT_SCALE) TYPE  /GICOM/CCS_WCB_BAPICCSCALE_TT
*"     VALUE(IT_BUSINESS_VOLUME_BASE) TYPE  /GICOM/CCS_WCB_BAPICCBVB_TT
*"     VALUE(IT_CALENDAR) TYPE  /GICOM/CCS_BAPICCCAL_TT
*"     VALUE(IT_CONDITION_ITEM_TEXT) TYPE
*"        /GICOM/CCS_BAPICCCONDITMTXT_TT
*"  EXPORTING
*"     VALUE(ET_RETURN_RFC) TYPE  /GICOM/BAPIRET_TT
*"     VALUE(ET_RETURN) TYPE  BAPIRETTAB
*"----------------------------------------------------------------------
DATA lo_exception TYPE REF TO /gicom/cx_root.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).

      NEW /gicom/cl_dso_sap_settl_mngt( )->sync_condition_contract(
        EXPORTING
          is_head                      = is_head
          is_head_set                  = is_head_set
          iv_condition_contract_number = iv_condition_contract_number
          is_eligible_set              = is_eligible_set
          is_condition_item_set        = is_condition_item_set
          is_condition_key_set         = is_condition_key_set
          it_eligible                  = it_eligible
          it_condition_key             = it_condition_key
          it_condition_item            = it_condition_item
          it_extension                 = it_extension
          it_head_text                 = it_head_text
          it_eligible_text             = it_eligible_text
          it_scale                     = it_scale
          it_business_volume_base      = it_business_volume_base
          it_calendar                  = it_calendar
          it_condition_item_text       = it_condition_item_text
        IMPORTING
          et_return                    = et_return
      ).

    CATCH /gicom/cx_internal_error INTO lo_exception.

      et_return_rfc = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.






ENDFUNCTION.
