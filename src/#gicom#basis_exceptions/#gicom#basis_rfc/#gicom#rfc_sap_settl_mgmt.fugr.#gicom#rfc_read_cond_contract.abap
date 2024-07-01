FUNCTION /GICOM/RFC_READ_COND_CONTRACT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_EXT_GUID_CC) TYPE  /GICOM/CCS_GUID
*"  EXPORTING
*"     VALUE(ES_HEAD) TYPE  /GICOM/CCS_BAPICCHEADOS_S
*"     VALUE(EV_NOT_FOUND) TYPE  /GICOM/ABAP_BOOL
*"     VALUE(EV_CC_NUMBER) TYPE  /GICOM/CCS_WCB_COCO_NUM
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  CHANGING
*"     VALUE(CT_ELIGIBLE) TYPE  /GICOM/CCS_BAPICCITEMO_TT
*"     VALUE(CT_CONDITION_KEY) TYPE  /GICOM/CCS_BAPICCCOND_KEYO_TT
*"     VALUE(CT_CONDITION_ITEM) TYPE  /GICOM/CCS_BAPICCCOND_ITMO_TT
*"     VALUE(CT_EXTENSION) TYPE  /GICOM/CCS_BAPIPAREX_TT
*"     VALUE(CT_HEAD_TEXT) TYPE  /GICOM/CCS_BAPICCHEADTEXT_TT
*"     VALUE(CT_ELIGIBLE_TEXT) TYPE  /GICOM/CCS_BAPICCITEMTEXT_TT
*"     VALUE(CT_RETURN) TYPE  BAPIRETTAB
*"     VALUE(CT_SCALE) TYPE  /GICOM/CCS_BAPICCSCALEO_TT
*"     VALUE(CT_BUSINESS_VOLUME_BASE) TYPE  /GICOM/CCS_BAPICCBVBO_TT
*"     VALUE(CT_CALENDAR) TYPE  /GICOM/CCS_BAPICCCALO_TT
*"     VALUE(CT_CONDITION_VALIDITY) TYPE  /GICOM/BAPI_CC_COND_VALID_TT
*"----------------------------------------------------------------------
DATA lo_exception TYPE REF TO /gicom/cx_root.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).

      NEW /gicom/cl_dso_sap_settl_mngt( )->read_condition_contract(
        EXPORTING
          iv_ext_guid_cc           = iv_ext_guid_cc
        IMPORTING
          es_head                  = es_head
          ev_not_found             = ev_not_found
          ev_cc_number             = ev_cc_number
        CHANGING
          ct_eligible              = ct_eligible
          ct_condition_key         = ct_condition_key
          ct_condition_item        = ct_condition_item
          ct_extension             = ct_extension
          ct_head_text             = ct_head_text
          ct_eligible_text         = ct_eligible_text
          ct_return                = ct_return
          ct_scale                 = ct_scale
          ct_business_volume_base  = ct_business_volume_base
          ct_calendar              = ct_calendar
          ct_condition_validity    = ct_condition_validity
      ).

    CATCH /gicom/cx_internal_error INTO lo_exception.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.


ENDFUNCTION.
