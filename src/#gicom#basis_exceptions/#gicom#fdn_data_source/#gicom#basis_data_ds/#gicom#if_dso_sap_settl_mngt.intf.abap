INTERFACE /gicom/if_dso_sap_settl_mngt
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS get_ccs_cust
    EXPORTING
      !et_cond_contract_type TYPE /gicom/ccs_cntyp_tt
      !et_bvb_type_deep      TYPE /gicom/ccs_bvb_type_deep_tt
      !et_bvb_tab_deep       TYPE /gicom/ccs_bvb_tab_deep_tt
      et_bvb_tab_fieldname TYPE /gicom/_bvb_tab_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_root_ds .
  METHODS select_cancellation_reason
    EXPORTING
      !et_document_reason_txt TYPE /gicom/sap_sm_canc_reas_txt_tt
      !et_document_reason     TYPE /gicom/sap_sm_cancel_reason_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS select_pricing_procedure
    RETURNING
      VALUE(rt_pricing_procedure) TYPE /gicom/sap_sm_pricing_proc_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS select_condition_types
    RETURNING
      VALUE(rt_condition_types) TYPE /gicom/sap_sm_cond_types_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS select_settlement_customizing
    EXPORTING
      !et_document_type TYPE /gicom/sap_sm_doc_type_tt
      !et_process_type  TYPE /gicom/sap_sm_process_type_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS sync_condition_contract
    IMPORTING
      !is_head                      TYPE /gicom/ccs_bapicchead_s
      !is_head_set                  TYPE /gicom/ccs_bapiccheadx_s
      !iv_condition_contract_number TYPE /gicom/ccs_wcb_coco_num
      !is_eligible_set              TYPE /gicom/ccs_bapiccitemx_s
      !is_condition_item_set        TYPE /gicom/ccs_bapicccond_itmx_s
      !is_condition_key_set         TYPE /gicom/ccs_bapicccond_keyx_s
      !it_eligible                  TYPE /gicom/ccs_wcb_bapiccitem_tt
      !it_condition_key             TYPE /gicom/ccs_bapicccond_key_tt
      !it_condition_item            TYPE /gicom/ccs_bapicccond_item_tt
      !it_extension                 TYPE /gicom/ccs_bapiparex_tt
      !it_head_text                 TYPE /gicom/ccs_bapicchedtxtchng_tt
      !it_eligible_text             TYPE /gicom/ccs_bapiccitmtxtchng_tt
      !it_scale                     TYPE /gicom/ccs_wcb_bapiccscale_tt
      !it_business_volume_base      TYPE /gicom/ccs_wcb_bapiccbvb_tt
      !it_calendar                  TYPE /gicom/ccs_bapicccal_tt
      it_condition_item_text        TYPE /gicom/ccs_bapiccconditmtxt_tt
    EXPORTING
      !et_return                    TYPE bapirettab
    RAISING
      /gicom/cx_internal_error .
  METHODS create_settl_request
    IMPORTING
      !is_document      TYPE /gicom/sap_sm_manual_doc_s
    EXPORTING
      !et_return        TYPE /gicom/bapiret_tt
      !et_head_data_out TYPE /gicom/sap_sm_man_head_out_tt
      !et_item_data_out TYPE /gicom/sap_sm_manual_item_tt
      !et_extension_out TYPE /gicom/ccs_bapiparex_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS create_doc_entry
    IMPORTING
      !is_document        TYPE /gicom/sap_doc_entry_s
    EXPORTING
      !et_return          TYPE /gicom/bapiret_tt
      !et_document_header TYPE /gicom/sap_doc_entry_head_tt
      !et_document_items  TYPE /gicom/sap_doc_entry_item_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS cancel_manual_settlement_doc
    IMPORTING
      !iv_invoice_date        TYPE /gicom/date_post
      !iv_cancellation_reason TYPE /gicom/sap_sm_cancel_reason
      !it_head_data_in        TYPE /gicom/sap_sm_cancel_headin_tt
    RETURNING
      VALUE(rt_return)        TYPE /gicom/bapiret_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS create_settl_run
    IMPORTING
      !iv_external_guid        TYPE /gicom/ccs_wcb_ext_guid
      !iv_settlement_date      TYPE /gicom/ccs_wb2_settlement_date
      !iv_settlement_date_type TYPE /gicom/stl_date_type_stettle
      !iv_invoice_date         TYPE /gicom/date_post
      !iv_document_date        TYPE /gicom/date_document
      !iv_with_items           TYPE /gicom/sap_sm_x_setl_with_item DEFAULT abap_true
      !iv_testrun              TYPE /gicom/sap_sm_x_testrun
    EXPORTING
      !es_settle_head_out      TYPE /gicom/sap_sm_cc_settl_head_s
      !et_settle_doc_out       TYPE /gicom/sap_sm_stl_doc_out_tt
      !et_head_data_out        TYPE /gicom/sap_sm_stl_head_out_tt
      !et_item_data_out        TYPE /gicom/sap_sm_stl_item_out_tt
      !et_extension_out        TYPE /gicom/ccs_bapiparex_tt
      !et_return               TYPE /gicom/bapiret_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS do_commit
    IMPORTING
      !iv_bapi  TYPE /gicom/abap_bool OPTIONAL
      !iv_local TYPE /gicom/abap_bool OPTIONAL
    RAISING
      /gicom/cx_database_error
      /gicom/cx_root_ds .
  METHODS do_rollback
    IMPORTING
      !iv_bapi  TYPE /gicom/abap_bool OPTIONAL
      !iv_local TYPE /gicom/abap_bool OPTIONAL
    RAISING
      /gicom/cx_root_ds
      /gicom/cx_database_error .
  METHODS read_condition_contract
    IMPORTING
      !iv_ext_guid_cc          TYPE /gicom/ccs_guid
    EXPORTING
      !es_head                 TYPE /gicom/ccs_bapiccheados_s
      !ev_not_found            TYPE /gicom/abap_bool
      !ev_cc_number            TYPE /gicom/ccs_wcb_coco_num
    CHANGING
      !ct_eligible             TYPE /gicom/ccs_bapiccitemo_tt
      !ct_condition_key        TYPE /gicom/ccs_bapicccond_keyo_tt
      !ct_condition_item       TYPE /gicom/ccs_bapicccond_itmo_tt
      !ct_extension            TYPE /gicom/ccs_bapiparex_tt
      !ct_head_text            TYPE /gicom/ccs_bapiccheadtext_tt
      !ct_eligible_text        TYPE /gicom/ccs_bapiccitemtext_tt
      !ct_return               TYPE bapirettab
      !ct_scale                TYPE /gicom/ccs_bapiccscaleo_tt
      !ct_business_volume_base TYPE /gicom/ccs_bapiccbvbo_tt
      !ct_calendar             TYPE /gicom/ccs_bapicccalo_tt
      !ct_condition_validity   TYPE /gicom/bapi_cc_cond_valid_tt
    RAISING
      /gicom/cx_internal_error .
  METHODS cancel_cc_multiple_settlement
    IMPORTING
      !iv_invoice_date         TYPE /gicom/date_post
      !iv_cancellation_reason  TYPE /gicom/sap_sm_cancel_reason
      !iv_exclude_delete       TYPE /gicom/sap_sm_x_exclude_delete
      !it_cond_cntr_identifier TYPE /gicom/ccs_bapiccidentifier_tt
      !it_settl_date           TYPE /gicom/ccs_bapi_rngsetldate_tt
      !it_use_case_type        TYPE /gicom/ccs_bapi_rngusecase_tt
    EXPORTING
      !et_cancel_doc           TYPE /gicom/ccs_bapicctodoc_tt
      !et_error_contract       TYPE /gicom/ccs_bapicctodoc_tt
      !et_map_for_ext_guid     TYPE /gicom/ccs_bapiccidentifier_tt
      !et_message              TYPE /gicom/bapiret_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS cancel_consolidate_supp_settl
    IMPORTING
      !iv_invoice_date        TYPE /gicom/date_post
      !iv_cancellation_reason TYPE /gicom/sap_sm_cancel_reason
      !it_head_data_in        TYPE /gicom/sap_sm_cancel_headin_tt
    RETURNING
      VALUE(rt_message)       TYPE /gicom/bapiret_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS cancel_consolidate_cust_settl
    IMPORTING
      !iv_invoice_date        TYPE /gicom/date_post
      !iv_cancellation_reason TYPE /gicom/sap_sm_cancel_reason
      !it_head_data_in        TYPE /gicom/sap_sm_cancel_headin_tt
    RETURNING
      VALUE(rt_message)       TYPE /gicom/bapiret_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS change_condition_contract
    IMPORTING
      !is_head_data  TYPE /gicom/ccs_bapicchead_s
      !is_head_datax TYPE /gicom/ccs_bapiccheadx_s
    EXPORTING
      !es_head_datao TYPE /gicom/ccs_bapiccheados_s
    CHANGING
      !ct_calendar   TYPE /gicom/ccs_bapicccal_tt
      !ct_calendarx  TYPE /gicom/ccs_bapicccalx_tt
      !ct_return     TYPE /gicom/bapiret_tt
    RAISING
      /gicom/cx_internal_error .
  METHODS attach_docs_to_sap_settl_req
    IMPORTING
      !iv_stl_doc_no TYPE /gicom/sap_sm_doc_nr_sgl
    CHANGING
      !ct_documents  TYPE /gicom/document_data_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS change_application_status
    IMPORTING
      !iv_application_status TYPE /gicom/sap_sm_app_status
      !iv_document_number    TYPE /gicom/doc_number
    RETURNING
      VALUE(rt_return)       TYPE /gicom/bapiret_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS trigger_settl_req_message_out
    IMPORTING
      !iv_stl_doc_no   TYPE /gicom/sap_sm_doc_nr_sgl
    RETURNING
      VALUE(rt_return) TYPE /gicom/bapiret_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS select_wbrk_analysis_data
    RETURNING
      VALUE(rt_wbrk) TYPE /gicom/wbrk_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS select_cdhdr_of_wbrk
    RETURNING
      VALUE(rt_cdhdr) TYPE cdhdr_tab
    RAISING
      /gicom/cx_root_ds .


  METHODS insert_pricing_procedures
    IMPORTING
      it_pricing_procedures TYPE  /gicom/_pr_proc_a_tt
      iv_commit             TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_pricing_procedures
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_pricing_procedures
    IMPORTING
      it_selopt                    TYPE ddshselops OPTIONAL
    RETURNING
      VALUE(rt_pricing_procedures) TYPE /gicom/_pr_proc_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.

  METHODS insert_condition_types
    IMPORTING
      it_condition_types TYPE  /gicom/_cnd_typ_a_tt
      iv_commit          TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_condition_types
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_condition_types
    IMPORTING
      it_selopt                 TYPE ddshselops OPTIONAL
    RETURNING
      VALUE(rt_condition_types) TYPE /gicom/_cnd_typ_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.

  METHODS insert_settlement_process_type
    IMPORTING
      it_settlement_process_type TYPE  /gicom/_proc_typ_a_tt
      iv_commit                  TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_settlement_process_type
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_settlement_process_type
    IMPORTING
      it_selopt                         TYPE ddshselops OPTIONAL
    RETURNING
      VALUE(rt_settlement_process_type) TYPE /gicom/_proc_typ_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.

  METHODS insert_settlement_docu_type
    IMPORTING
      it_settlement_document_type TYPE  /gicom/_doc_typ_a_tt
      iv_commit                   TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_settlement_docu_type
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_settlement_docu_type
    IMPORTING
      it_selopt                          TYPE ddshselops OPTIONAL
    RETURNING
      VALUE(rt_settlement_document_type) TYPE /gicom/_doc_typ_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.

  METHODS insert_cc_types_customizing
    IMPORTING
      it_condition_contract_type     TYPE  /gicom/_coco_typ_a_tt
      it_bvb_type_deep               TYPE /gicom/_bvb_fc_a_tt
      it_bvb_tab_deep                TYPE /gicom/_bvb_tab_a_tt
      it_bvb_field_combinations_deep TYPE /gicom/_bvb_fcf_a_tt
      it_bvb_tab_scf                 TYPE /gicom/_bvb_scf_a_tt
      iv_commit                      TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_cc_types_customizing
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_cc_types_customizing
    EXPORTING
      et_condition_contract_type     TYPE  /gicom/_coco_typ_a_tt
      et_bvb_type_deep               TYPE /gicom/_bvb_fc_a_tt
      et_bvb_tab_deep                TYPE /gicom/_bvb_tab_a_tt
      et_bvb_field_combinations_deep TYPE /gicom/_bvb_fcf_a_tt
      et_bvb_tab_split_fields        TYPE /gicom/_bvb_scf_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.

  METHODS insert_cancellation_reasons
    IMPORTING
      it_cancellation_reasons_txt TYPE /gicom/_canc_rst_a_tt
      it_cancellation_reasons     TYPE /gicom/_canc_rs_a_tt
      iv_commit                   TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_cancellation_reasons
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_cancellation_reasons

    RETURNING
      VALUE(rt_cancellation_reasons) TYPE /gicom/_canc_rst_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.


ENDINTERFACE.
