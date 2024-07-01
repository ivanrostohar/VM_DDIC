CLASS /gicom/cl_dso_sap_settl_mngt DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_sap_settl_mngt .
    INTERFACES if_badi_interface .

    ALIASES cancel_cc_multiple_settlement
      FOR /gicom/if_dso_sap_settl_mngt~cancel_cc_multiple_settlement .
    ALIASES cancel_consolidate_cust_settl
      FOR /gicom/if_dso_sap_settl_mngt~cancel_consolidate_cust_settl .
    ALIASES cancel_consolidate_supp_settl
      FOR /gicom/if_dso_sap_settl_mngt~cancel_consolidate_supp_settl .
    ALIASES cancel_manual_settlement_doc
      FOR /gicom/if_dso_sap_settl_mngt~cancel_manual_settlement_doc .
    ALIASES change_condition_contract
      FOR /gicom/if_dso_sap_settl_mngt~change_condition_contract .
    ALIASES create_manual_settlement_doc
      FOR /gicom/if_dso_sap_settl_mngt~create_settl_request .
    ALIASES create_sap_coco_settl_document
      FOR /gicom/if_dso_sap_settl_mngt~create_settl_run .
    ALIASES do_commit
      FOR /gicom/if_dso_sap_settl_mngt~do_commit .
    ALIASES do_rollback
      FOR /gicom/if_dso_sap_settl_mngt~do_rollback .
    ALIASES get_ccs_cust
      FOR /gicom/if_dso_sap_settl_mngt~get_ccs_cust .
    ALIASES read_condition_contract
      FOR /gicom/if_dso_sap_settl_mngt~read_condition_contract .
    ALIASES select_cancellation_reason
      FOR /gicom/if_dso_sap_settl_mngt~select_cancellation_reason .
    ALIASES select_condition_types
      FOR /gicom/if_dso_sap_settl_mngt~select_condition_types .
    ALIASES select_pricing_procedure
      FOR /gicom/if_dso_sap_settl_mngt~select_pricing_procedure .
    ALIASES select_settlement_customizing
      FOR /gicom/if_dso_sap_settl_mngt~select_settlement_customizing .
    ALIASES sync_condition_contract
      FOR /gicom/if_dso_sap_settl_mngt~sync_condition_contract .
    ALIASES attach_docs_to_sap_settl_req
      FOR /gicom/if_dso_sap_settl_mngt~attach_docs_to_sap_settl_req.
    ALIASES create_doc_entry
      FOR /gicom/if_dso_sap_settl_mngt~create_doc_entry.
    ALIASES change_application_status
      FOR /gicom/if_dso_sap_settl_mngt~change_application_status.
    ALIASES trigger_settl_req_message_out
      FOR /gicom/if_dso_sap_settl_mngt~trigger_settl_req_message_out.
    ALIASES select_wbrk_data
      FOR /gicom/if_dso_sap_settl_mngt~select_wbrk_analysis_data.
    ALIASES select_cdhdr_of_wbrk
      FOR /gicom/if_dso_sap_settl_mngt~select_cdhdr_of_wbrk.

    ALIASES insert_condition_types
      FOR /gicom/if_dso_sap_settl_mngt~insert_condition_types.
    ALIASES delete_condition_types
      FOR /gicom/if_dso_sap_settl_mngt~delete_condition_types.
    ALIASES read_condition_types
      FOR /gicom/if_dso_sap_settl_mngt~read_condition_types.

    ALIASES insert_pricing_procedures
      FOR /gicom/if_dso_sap_settl_mngt~insert_pricing_procedures.
    ALIASES delete_pricing_procedures
      FOR /gicom/if_dso_sap_settl_mngt~delete_pricing_procedures.
    ALIASES read_pricing_procedures
      FOR /gicom/if_dso_sap_settl_mngt~read_pricing_procedures.

    ALIASES insert_settlement_process_type
      FOR /gicom/if_dso_sap_settl_mngt~insert_settlement_process_type.
    ALIASES delete_settlement_process_type
      FOR /gicom/if_dso_sap_settl_mngt~delete_settlement_process_type.
    ALIASES read_settlement_process_type
      FOR /gicom/if_dso_sap_settl_mngt~read_settlement_process_type.

    ALIASES insert_settlement_docu_type
      FOR /gicom/if_dso_sap_settl_mngt~insert_settlement_docu_type.
    ALIASES delete_settlement_docu_type
      FOR /gicom/if_dso_sap_settl_mngt~delete_settlement_docu_type.
    ALIASES read_settlement_docu_type
      FOR /gicom/if_dso_sap_settl_mngt~read_settlement_docu_type.

    ALIASES insert_cc_types_customizing
      FOR /gicom/if_dso_sap_settl_mngt~insert_cc_types_customizing.
    ALIASES delete_cc_types_customizing
      FOR /gicom/if_dso_sap_settl_mngt~delete_cc_types_customizing.
    ALIASES read_cc_types_customizing
      FOR /gicom/if_dso_sap_settl_mngt~read_cc_types_customizing.

    ALIASES insert_cancellation_reasons
      FOR /gicom/if_dso_sap_settl_mngt~insert_cancellation_reasons.
    ALIASES delete_cancellation_reasons
      FOR /gicom/if_dso_sap_settl_mngt~delete_cancellation_reasons.
    ALIASES read_cancellation_reasons
      FOR /gicom/if_dso_sap_settl_mngt~read_cancellation_reasons.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS:
      get_badi
        RETURNING
          VALUE(rb_badi) TYPE REF TO /gicom/badi_ds_sap_settl_mngt.
ENDCLASS.



CLASS /gicom/cl_dso_sap_settl_mngt IMPLEMENTATION.


  METHOD /gicom/if_dso_sap_settl_mngt~cancel_consolidate_supp_settl.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->cancel_consolidate_supp_settl
      EXPORTING
        iv_invoice_date        = iv_invoice_date
        iv_cancellation_reason = iv_cancellation_reason
        it_head_data_in        = it_head_data_in
      RECEIVING
        rt_message             = rt_message.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~change_condition_contract.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->change_condition_contract
      EXPORTING
        is_head_data  = is_head_data
        is_head_datax = is_head_datax
      IMPORTING
        es_head_datao = es_head_datao
      CHANGING
        ct_calendar   = ct_calendar
        ct_calendarx  = ct_calendarx
        ct_return     = ct_return.
  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~cancel_consolidate_cust_settl.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->cancel_consolidate_cust_settl
      EXPORTING
        iv_invoice_date        = iv_invoice_date
        iv_cancellation_reason = iv_cancellation_reason
        it_head_data_in        = it_head_data_in
      RECEIVING
        rt_message             = rt_message.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~create_doc_entry.
    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->create_doc_entry
      EXPORTING
        is_document        = is_document
      IMPORTING
        et_return          = et_return
        et_document_header = et_document_header
        et_document_items  = et_document_items.

  ENDMETHOD.


  METHOD  /gicom/if_dso_sap_settl_mngt~select_cancellation_reason.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->select_cancellation_reason
      IMPORTING
        et_document_reason_txt = et_document_reason_txt
        et_document_reason     = et_document_reason.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~do_commit.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->do_commit
      EXPORTING
        iv_bapi  = iv_bapi
        iv_local = iv_local.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~do_rollback.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->do_rollback
      EXPORTING
        iv_bapi  = iv_bapi
        iv_local = iv_local.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~get_ccs_cust.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->get_ccs_cust
      IMPORTING
        et_cond_contract_type = et_cond_contract_type
        et_bvb_type_deep      = et_bvb_type_deep
        et_bvb_tab_deep       = et_bvb_tab_deep
        et_bvb_tab_fieldname  = et_bvb_tab_fieldname.
  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~sync_condition_contract.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->sync_condition_contract
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
        et_return                    = et_return.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~cancel_manual_settlement_doc.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->cancel_manual_settlement_doc
      EXPORTING
        iv_invoice_date        = iv_invoice_date
        iv_cancellation_reason = iv_cancellation_reason
        it_head_data_in        = it_head_data_in
      RECEIVING
        rt_return              = rt_return.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~select_condition_types.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->select_condition_types
      RECEIVING
        rt_condition_types = rt_condition_types.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~select_pricing_procedure.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->select_pricing_procedure
      RECEIVING
        rt_pricing_procedure = rt_pricing_procedure.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~select_settlement_customizing.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->select_settlement_customizing
      IMPORTING
        et_document_type = et_document_type
        et_process_type  = et_process_type.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~cancel_cc_multiple_settlement.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->cancel_cc_multiple_settlement
      EXPORTING
        iv_invoice_date         = iv_invoice_date
        iv_cancellation_reason  = iv_cancellation_reason
        iv_exclude_delete       = iv_exclude_delete
        it_cond_cntr_identifier = it_cond_cntr_identifier
        it_settl_date           = it_settl_date
        it_use_case_type        = it_use_case_type
      IMPORTING
        et_cancel_doc           = et_cancel_doc
        et_error_contract       = et_error_contract
        et_map_for_ext_guid     = et_map_for_ext_guid
        et_message              = et_message.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~create_settl_run.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->create_settl_run
      EXPORTING
        iv_external_guid        = iv_external_guid
        iv_settlement_date      = iv_settlement_date
        iv_settlement_date_type = iv_settlement_date_type
        iv_testrun              = iv_testrun
        iv_invoice_date         = iv_invoice_date
        iv_document_date        = iv_document_date
        iv_with_items           = iv_with_items
      IMPORTING
        es_settle_head_out      = es_settle_head_out
        et_settle_doc_out       = et_settle_doc_out
        et_head_data_out        = et_head_data_out
        et_item_data_out        = et_item_data_out
        et_extension_out        = et_extension_out
        et_return               = et_return.

  ENDMETHOD.


  METHOD get_badi.
    GET BADI rb_badi.
  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~change_application_status.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->change_application_status
      EXPORTING
        iv_application_status = iv_application_status
        iv_document_number    = iv_document_number
      RECEIVING
        rt_return             = rt_return.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~attach_docs_to_sap_settl_req.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->attach_docs_to_sap_settl_req
      EXPORTING
        iv_stl_doc_no = iv_stl_doc_no
      CHANGING
        ct_documents  = ct_documents.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~create_settl_request.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->create_settl_request
      EXPORTING
        is_document      = is_document
      IMPORTING
        et_return        = et_return
        et_item_data_out = et_item_data_out
        et_head_data_out = et_head_data_out
        et_extension_out = et_extension_out.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~read_condition_contract.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->read_condition_contract
      EXPORTING
        iv_ext_guid_cc          = iv_ext_guid_cc
      IMPORTING
        es_head                 = es_head
        ev_not_found            = ev_not_found
        ev_cc_number            = ev_cc_number
      CHANGING
        ct_eligible             = ct_eligible
        ct_condition_key        = ct_condition_key
        ct_condition_item       = ct_condition_item
        ct_extension            = ct_extension
        ct_head_text            = ct_head_text
        ct_eligible_text        = ct_eligible_text
        ct_return               = ct_return
        ct_scale                = ct_scale
        ct_business_volume_base = ct_business_volume_base
        ct_calendar             = ct_calendar
        ct_condition_validity   = ct_condition_validity.

  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~trigger_settl_req_message_out.
    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->trigger_settl_req_message_out
      EXPORTING
        iv_stl_doc_no = iv_stl_doc_no
      RECEIVING
        rt_return     = rt_return.

  ENDMETHOD.

    METHOD /gicom/if_dso_sap_settl_mngt~select_cdhdr_of_wbrk.
    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->select_cdhdr_of_wbrk
      RECEIVING
        rt_cdhdr    = rt_cdhdr.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_settl_mngt~select_WBRK_analysis_data.
    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->select_wbrk_analysis_data
      RECEIVING
        rt_wbrk     = rt_wbrk.


  ENDMETHOD.


  METHOD delete_pricing_procedures.

    DELETE FROM /gicom/_pr_proc.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD insert_pricing_procedures.

    DATA lt_pricing_procedures TYPE TABLE OF /gicom/_pr_proc.

    lt_pricing_procedures = CORRESPONDING #( it_pricing_procedures ).

    INSERT /gicom/_pr_proc FROm TABLE lt_pricing_procedures ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_PR_PROC' SY-SUBRC.

     ENDIF.

  ENDMETHOD.

  METHOD read_pricing_procedures.

    "Generating WHERE clause
    IF it_selopt IS NOT INITIAL.
      DATA(lv_where) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
        it_selopt = it_selopt
        iv_statement = '2'
      ).
    ENDIF.

     "Security check: check where clause
    IF lv_where <> space.
      DATA(lv_whilelist) = lv_where.
      TRY.
         lv_where = cl_abap_dyn_prg=>check_whitelist_str(
                      val       = lv_where
                      whitelist = lv_whilelist
                    ).

        CATCH cx_abap_not_in_whitelist INTO DATA(lx_exception).
          RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lx_exception ) .
      ENDTRY.
    ENDIF.

    SELECT
      *
    FROM
      /gicom/_pr_proc
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_pricing_procedures
    WHERE
      (lv_where).

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).
    ENDIF.


  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~delete_condition_types.

    DELETE FROM /gicom/_cnd_typ.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~insert_condition_types.

    DATA lt_condition_types TYPE TABLE OF /gicom/_cnd_typ.

    lt_condition_types = CORRESPONDING #( it_condition_types ).

    INSERT /gicom/_cnd_typ FROM TABLE lt_condition_types.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_CND_TYP' SY-SUBRC.

     ENDIF.


  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~read_condition_types.

    "Generating WHERE clause
    IF it_selopt IS NOT INITIAL.
      DATA(lv_where) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
        it_selopt    = it_selopt
        iv_statement = '2'
      ).
    ENDIF.

     "Security check: check where clause
    IF lv_where NE space.
      DATA(lv_whilelist) = lv_where.
      TRY.
         lv_where = cl_abap_dyn_prg=>check_whitelist_str(
                      val       = lv_where
                      whitelist = lv_whilelist
                    ).

        CATCH cx_abap_not_in_whitelist INTO DATA(lx_exception).
          RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lx_exception ) .
      ENDTRY.
    ENDIF.

    SELECT
      *
    FROM
      /gicom/_cnd_typ
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_condition_types
    WHERE
      (lv_where).

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~delete_settlement_process_type.

    DELETE FROM /gicom/_proc_typ.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~insert_settlement_process_type.

    DATA lt_settlement_process_type TYPE TABLE OF /gicom/_proc_typ.

    lt_settlement_process_type = CORRESPONDING #( it_settlement_process_type ).

    INSERT /gicom/_proc_typ FROm TABLE lt_settlement_process_type.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_PROC_TYP' SY-SUBRC.

     ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~read_settlement_process_type.

    "Generating WHERE clause
    IF it_selopt IS NOT INITIAL.
      DATA(lv_where) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
        it_selopt   = it_selopt
        iv_statement = '2'
      ).
    ENDIF.

     "Security check: check where clause
    IF lv_where NE space.
      DATA(lv_whilelist) = lv_where.
      TRY.
         lv_where = cl_abap_dyn_prg=>check_whitelist_str(
                      val       = lv_where
                      whitelist = lv_whilelist
                    ).

        CATCH cx_abap_not_in_whitelist INTO DATA(lx_exception).
          RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lx_exception ) .
      ENDTRY.
    ENDIF.

    SELECT
      *
    FROM
      /gicom/_proc_typ
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_settlement_process_type
    WHERE
      (lv_where).

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~delete_settlement_docu_type.

    DELETE FROM /gicom/_doc_typ.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~insert_settlement_docu_type.

    DATA lt_settlement_document_type TYPE TABLE OF /gicom/_doc_typ.

    lt_settlement_document_type = CORRESPONDING #( it_settlement_document_type ).

    INSERT /gicom/_doc_typ FROm TABLE lt_settlement_document_type.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_DOC_TYP' SY-SUBRC.

     ENDIF.


  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~read_settlement_docu_type.

    "Generating WHERE clause
    IF it_selopt IS NOT INITIAL.
      DATA(lv_where) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
        it_selopt   = it_selopt
        iv_statement = '2'
      ).
    ENDIF.

     "Security check: check where clause
    IF lv_where <> space.
      DATA(lv_whilelist) = lv_where.
      TRY.
         lv_where = cl_abap_dyn_prg=>check_whitelist_str(
                      val       = lv_where
                      whitelist = lv_whilelist
                    ).

        CATCH cx_abap_not_in_whitelist INTO DATA(lx_exception).
          RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lx_exception ) .
      ENDTRY.
    ENDIF.

    SELECT
      *
    FROM
      /gicom/_doc_typ
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_settlement_document_type
    WHERE
      (lv_where).

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).
    ENDIF.


  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~delete_cc_types_customizing.

    DELETE FROM /gicom/_coco_typ.
    DELETE FROM /gicom/_bvb_fc.
    DELETE FROM /gicom/_bvb_fcf.
    DELETE FROM /gicom/_bvb_tab .
    DELETE FROM /gicom/_bvb_scf.

    IF iv_commit = abap_true.
     COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~insert_cc_types_customizing.

    DATA : lt_condition_contract_type TYPE TABLE OF /gicom/_coco_typ,
           lt_bvb_type_deep           TYPE TABLE OF /gicom/_bvb_fc,
           lt_bvb_tab_deep            TYPE TABLE OF /gicom/_bvb_tab,
           lt_bvb_field_combinations_deep TYPE TABLE OF /gicom/_bvb_fcf,
           lt_bvb_tab_scf TYPE TABLE OF /gicom/_bvb_scf.

*
    lt_condition_contract_type = CORRESPONDING #( it_condition_contract_type ).

    INSERT /gicom/_coco_typ FROM TABLE lt_condition_contract_type ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_COCO_TYP' SY-SUBRC.

     ENDIF.

    lt_bvb_type_deep = CORRESPONDING #( it_bvb_type_deep ).

    INSERT /gicom/_bvb_fc FROM TABLE lt_bvb_type_deep ACCEPTING DUPLICATE KEYS..

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_BVB_FC' SY-SUBRC.

    ENDIF.

    lt_bvb_field_combinations_deep = CORRESPONDING #( it_bvb_field_combinations_deep ).

    INSERT /gicom/_bvb_fcf FROM TABLE lt_bvb_field_combinations_deep ACCEPTING DUPLICATE KEYS..

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_BVB_FCF' SY-SUBRC.

    ENDIF.

    lt_bvb_tab_deep = CORRESPONDING #( it_bvb_tab_deep ).

    INSERT /gicom/_bvb_tab FROM TABLE lt_bvb_tab_deep ACCEPTING DUPLICATE KEYS..

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_BVB_TAB' SY-SUBRC.

    ENDIF.

    lt_bvb_tab_scf = CORRESPONDING #( it_bvb_tab_scf ).

    INSERT /gicom/_bvb_scf FROM TABLE lt_bvb_tab_scf ACCEPTING DUPLICATE KEYS..

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_BVB_SCF' SY-SUBRC.

    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~read_cc_types_customizing.

    SELECT
      *
    FROM
      /gicom/_coco_typ
    INTO
      CORRESPONDING FIELDS OF TABLE @et_condition_contract_type.

    IF sy-subrc <> 0.
       RAISE EXCEPTION NEW /gicom/cx_not_found(  ).
     ENDIF.

     SELECT
       *
     FROM
       /gicom/_bvb_fc
     INTO
       CORRESPONDING FIELDS OF TABLE @et_bvb_type_deep.

     IF sy-subrc = 0 AND et_bvb_type_deep IS NOT INITIAL.

      SELECT
       *
      FROM
       /gicom/_bvb_fcf
      INTO
        CORRESPONDING FIELDS OF TABLE @et_bvb_field_combinations_deep
      FOR ALL ENTRIES IN @et_bvb_type_deep
      WHERE
        fieldcomb = @et_bvb_type_deep-fieldcomb.

      ELSE.
        RAISE EXCEPTION NEW /gicom/cx_not_found(  ).
     ENDIF.

     SELECT
       *
     FROM
       /gicom/_bvb_tab
     INTO
       CORRESPONDING FIELDS OF TABLE @et_bvb_tab_deep.

     IF sy-subrc = 0 AND et_bvb_tab_deep IS NOT INITIAL.

        SELECT
          *
        FROM
          /GICOM/_BVB_SCF
        INTO
        CORRESPONDING FIELDS OF TABLE @et_bvb_tab_split_fields.

     else.

       RAISE EXCEPTION NEW /gicom/cx_not_found(  ).
     ENDIF.


  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~delete_cancellation_reasons.

    DELETE FROM /gicom/_canc_rst .
    DELETE FROM /gicom/_canc_rs.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~insert_cancellation_reasons.

    DATA lt_cancellation_reasons TYPE TABLE OF /gicom/_canc_rs.

    lt_cancellation_reasons = CORRESPONDING #( it_cancellation_reasons  ).

    INSERT /gicom/_canc_rs FROM TABLE lt_cancellation_reasons ACCEPTING DUPLICATE KEYS.
    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_CANC_RS' SY-SUBRC.

    ENDIF.


    DATA lt_cancellation_reasons_txt TYPE TABLE OF /gicom/_canc_rst.

    lt_cancellation_reasons_txt = CORRESPONDING #( it_cancellation_reasons_txt  ).

    INSERT /gicom/_canc_rst FROM TABLE lt_cancellation_reasons_txt ACCEPTING DUPLICATE KEYS.
    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_CANC_RST' SY-SUBRC.

    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_sap_settl_mngt~read_cancellation_reasons.

    DATA(lv_language) = /gicom/cl_system=>get_language(  ).

    SELECT
      canc_reason~reason_cancellation,
      @lv_language AS langu,
      text~title
    FROM
      /gicom/_canc_rs AS canc_reason

      LEFT JOIN /gicom/_canc_rst AS text ON
        canc_reason~reason_cancellation = text~reason_cancellation AND
        text~langu = @lv_language
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_cancellation_reasons.

    IF sy-subrc <> 0.
       RAISE EXCEPTION NEW /gicom/cx_not_found(  ).
     ENDIF.

  ENDMETHOD.

ENDCLASS.
