CLASS /gicom/cl_dso_sap_settl_api_s4 DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cl_dso_sap_settl_mngt
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

***********************************************************************************************************************
***  use /gicom/cl_dso_sap_setl_bapi_s4 instead
***********************************************************************************************************************

    METHODS /gicom/if_dso_sap_settl_mngt~cancel_cc_multiple_settlement
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~cancel_consolidate_cust_settl
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~cancel_consolidate_supp_settl
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~cancel_manual_settlement_doc
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~create_settl_request
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~create_settl_run
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~do_commit
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~do_rollback
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~get_ccs_cust
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~read_condition_contract
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~select_condition_types
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~select_pricing_procedure
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~select_settlement_customizing
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~sync_condition_contract
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~change_condition_contract
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~attach_docs_to_sap_settl_req
        REDEFINITION.
    METHODS /gicom/if_dso_sap_settl_mngt~create_doc_entry
        REDEFINITION.
    METHODS /gicom/if_dso_sap_settl_mngt~select_wbrk_analysis_data
        REDEFINITION .
    METHODS /gicom/if_dso_sap_settl_mngt~select_cdhdr_of_wbrk
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES: BEGIN OF tt_to_busvolfldcombntypefld,
             results TYPE TABLE OF /gicom/bvb_field_comb_field_s WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_to_busvolfldcombntypefld.

    TYPES: BEGIN OF ts_busvolfldcombnsettype.
             INCLUDE TYPE /gicom/bvb_field_comb_type_s.
    TYPES:   to_busvolfldcombntypefldassgmt TYPE tt_to_busvolfldcombntypefld,
           END OF ts_busvolfldcombnsettype.

    TYPES: BEGIN OF tt_to_busvolfldcombnsettypeass,
             results TYPE TABLE OF ts_busvolfldcombnsettype WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_to_busvolfldcombnsettypeass.

    TYPES: BEGIN OF ts_gicom_cc_type.
             INCLUDE TYPE /gicom/a_cndncontrtype_s.
    TYPES:   to_busvolfldcombnsettypeassgmt TYPE tt_to_busvolfldcombnsettypeass,
           END OF ts_gicom_cc_type.

ENDCLASS.



CLASS /GICOM/CL_DSO_SAP_SETTL_API_S4 IMPLEMENTATION.


  METHOD /gicom/if_dso_sap_settl_mngt~cancel_consolidate_cust_settl.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~attach_docs_to_sap_settl_req.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~change_condition_contract.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~sync_condition_contract.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~create_doc_entry.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~do_rollback.

    "Rollback (for BAPI and local)
    DATA: ls_return TYPE bapiret2.

    "1. Rollback local
    IF iv_local EQ abap_true.

      ROLLBACK WORK.

      IF sy-subrc NE 0 OR ls_return-type EQ 'E'.

        "Error handling
        RAISE EXCEPTION NEW /gicom/cx_rollback_failed(
            iv_code   = 500
            iv_reason = COND #(  WHEN ls_return-type EQ 'E' THEN ls_return-message ELSE CONV #( TEXT-001 ) )
            iv_sy_subrc = sy-subrc
        ).

      ENDIF.

    ENDIF.

    "2. Rollback for BAPI
    IF iv_bapi EQ abap_true.

      CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'
        IMPORTING
          return = ls_return.

      IF sy-subrc NE 0 OR ls_return-type EQ 'E'.

        "Error handling
        RAISE EXCEPTION NEW /gicom/cx_rollback_failed(
            iv_code   = 500
            iv_reason = COND #(  WHEN ls_return-type EQ 'E' THEN ls_return-message ELSE CONV #( TEXT-001 ) )
            iv_sy_subrc = sy-subrc
        ).

      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~cancel_manual_settlement_doc.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~get_ccs_cust.

    DATA: ls_cond_contract_type TYPE /gicom/ccs_cntyp_s,
          lt_cc_type_api        TYPE TABLE OF ts_gicom_cc_type.


    DATA(lo_client) = /gicom/cl_odata_client_factory=>create( ).
    lo_client->execute( EXPORTING iv_rfc_object      = /gicom/cl_rfc_manager=>cv_ccs
                                  iv_entity_set      = 'A_CndnContrType'
                                  "it_selopt         = it_selopt
                                  it_expand_clauses  = VALUE #( ( `to_BusVolFldCombnSetTypeAssgmt/to_BusVolFldCombnTypeFldAssgmt` ) )
                                  iv_service_name    = /gicom/cl_odata_client_factory=>cv_path_api_cond_cntr_type
                        IMPORTING e_result           = lt_cc_type_api ).

    LOOP AT lt_cc_type_api REFERENCE INTO DATA(lr_cc_type_api).

      " Condition contract type
      ls_cond_contract_type-contract_type   = lr_cc_type_api->*-cndncontrtype.
      ls_cond_contract_type-busvolbase_type = lr_cc_type_api->*-busvolfldcombnset.
      ls_cond_contract_type-owner_type      = lr_cc_type_api->*-cndncontrpartnercat.
      ls_cond_contract_type-eligible_type   = lr_cc_type_api->*-cndncontreligiblecat.
      ls_cond_contract_type-category        = lr_cc_type_api->*-cndncontrclassfctntype.
      ls_cond_contract_type-no_condition    = lr_cc_type_api->*-cndncontrhasnoconditions.
      ls_cond_contract_type-rebate_type     = lr_cc_type_api->*-cndncontrsettlmttype.
      ls_cond_contract_type-ui_change       = lr_cc_type_api->*-cndncontrchangeability.
      ls_cond_contract_type-settl_part_type = lr_cc_type_api->*-cndncontrprtlsettlmtcat.

      APPEND ls_cond_contract_type TO et_cond_contract_type.

      " Business volume base
      LOOP AT lr_cc_type_api->*-to_busvolfldcombnsettypeassgmt-results REFERENCE INTO DATA(lr_api_field_combination).

        APPEND INITIAL LINE TO et_bvb_type_deep ASSIGNING FIELD-SYMBOL(<ls_bvb_deep>).
        <ls_bvb_deep>-busvolbase_type = lr_api_field_combination->*-busvolfldcombnset.
        <ls_bvb_deep>-fc_group        = lr_api_field_combination->*-busvolfldcombngroup.
        <ls_bvb_deep>-fieldcomb       = lr_api_field_combination->*-busvolfieldcombntype.
        <ls_bvb_deep>-x_validity      = lr_api_field_combination->*-busvolfldcombnvaldtyisallwd.

        LOOP AT lr_api_field_combination->*-to_busvolfldcombntypefldassgmt-results REFERENCE INTO DATA(lr_api_fields).

          APPEND INITIAL LINE TO <ls_bvb_deep>-fields ASSIGNING FIELD-SYMBOL(<ls_fields>).
          <ls_fields>-fieldcomb       = lr_api_fields->*-busvolfieldcombntype.
          <ls_fields>-fieldname       = lr_api_fields->*-busvolfldcombnextfieldname.
          <ls_fields>-initial_allowed = lr_api_fields->*-busvolfldcombnfldinitisallwd.

        ENDLOOP.

      ENDLOOP.

    ENDLOOP.

    " et_bvb_tab_deep: Business volume base table data - Split criteria fields
    " This data is missing and the logic needs to be adjusted after SAP provides us all the data

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~cancel_cc_multiple_settlement.


  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~select_condition_types.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~select_pricing_procedure.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~select_settlement_customizing.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~cancel_consolidate_supp_settl.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~create_settl_request.

*    DATA lt_return TYPE /gicom/bapiret2_tt.
*    DATA(lt_headdata)       = is_document-head.
*    DATA(lt_itemdata)       = is_document-item.
*    DATA(lt_vendorcondin)   = is_document-vendor_cond.
*    DATA(lt_customercondin) = is_document-customer_cond.
*
*    CALL FUNCTION 'BAPI_SINGLESETTREQS_CREATEMULT'
*      EXPORTING
*        exit_after_first_error = abap_false
*      TABLES
*        headdata               = lt_headdata
*        itemdata               = lt_itemdata
*        vendorcondin           = lt_vendorcondin
*        customercondin         = lt_customercondin
*        return                 = lt_return.
*
*    rt_return = CORRESPONDING #( lt_return ).
  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~create_settl_run.
*    DATA lt_return TYPE /gicom/bapiret2_tt.
*
*    " TODO - Fill Condition contract number
*    CALL FUNCTION 'BAPI_CONDITION_CONTRACT_SETTLE'
*      EXPORTING
*        conditioncontractnumber = ''
*        externalguid            = iv_external_guid
*        settlementdate          = iv_settlement_date
*        testrun                 = iv_testrun
*        invoicedate             = iv_invoice_date
*        documentdate            = iv_document_date
**       billreason              =
*        withitems               = iv_with_items
**       settlementdatetype      =
*      IMPORTING
*        settleheadout           = es_settle_head_out
*      TABLES
*        settledocout            = et_settle_doc_out
*        headdataout             = et_head_data_out
*        itemdataout             = et_item_data_out
*        return                  = lt_return
*        extensionout            = et_extension_out.
*
*    IF line_exists( lt_return[ type = /gicom/if_constants_ddl=>c_message_type-error ] ).
*      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
*          iv_function_module = 'BAPI_CONDITION_CONTRACT_SETTLE'
*          iv_subrc           = sy-subrc
*          it_bapiret         = lt_return
*      ).
*    ENDIF.
*
*    et_return_table = CORRESPONDING #( lt_return ).
  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~do_commit.

    "Commit (for BAPI and local)
    DATA: ls_return TYPE bapiret2,
          lv_msg    TYPE symsgv.

    "1. Commit for BAPI
    IF iv_bapi EQ abap_true.

      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait   = abap_true
        IMPORTING
          return = ls_return.

      IF sy-subrc NE 0 OR ls_return-type EQ 'E'.

        "Exception Handling
        RAISE EXCEPTION NEW /gicom/cx_commit_failed(
            iv_code   = 500
            iv_reason = COND #(  WHEN ls_return-type EQ 'E' THEN ls_return-message ELSE TEXT-001 )
            iv_sy_subrc = sy-subrc
        ).

      ENDIF.

    ENDIF.

    "2. Commit local
    IF iv_local EQ abap_true.

      COMMIT WORK AND WAIT.

      IF sy-subrc NE 0 OR ls_return-type EQ 'E'.

        "Exception Handling
        RAISE EXCEPTION NEW /gicom/cx_commit_failed(
            iv_code   = 500
            iv_reason = COND #(  WHEN ls_return-type EQ 'E' THEN ls_return-message ELSE TEXT-001 )
            iv_sy_subrc = sy-subrc
        ).

      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~read_condition_contract.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~select_cdhdr_of_wbrk.
    RAISE EXCEPTION NEW /gicom/cx_not_implemented( ).
  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~select_wbrk_analysis_data.
    RAISE EXCEPTION NEW /gicom/cx_not_implemented( ).
  ENDMETHOD.
ENDCLASS.
