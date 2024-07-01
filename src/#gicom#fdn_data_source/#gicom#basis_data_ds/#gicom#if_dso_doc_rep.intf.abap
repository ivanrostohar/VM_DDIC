INTERFACE /gicom/if_dso_doc_rep
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_doc_list
    IMPORTING
      !it_anchor TYPE /gicom/anchor_tt
    EXPORTING
      !et_docreps_list TYPE /gicom/docreps_comm_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS select_document
    IMPORTING
      !it_docid TYPE /gicom/docid_tt
    EXPORTING
      !et_docreps_doc TYPE /gicom/docreps_doc_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS db_update
    IMPORTING
      !iv_tabname TYPE tabname
      !it_insert TYPE table
      !it_update TYPE table
      !it_delete TYPE table
    RAISING
      /gicom/cx_root_ds .
  METHODS document_upload
    CHANGING
      !cs_docreps TYPE /gicom/docreps_s
    RAISING
      /gicom/cx_root_ds .
  METHODS document_delete
    IMPORTING
      !iv_docid TYPE so_entryid
      !iv_bo_type TYPE /gicom/bo_typ    "INS AC - M. 19417
      !iv_anchor TYPE /gicom/bo_id      "INS AC - M. 19417
    RAISING
      /gicom/cx_root_ds .
  METHODS select_file
    IMPORTING
      !iv_docid TYPE so_entryid
      !iv_bo_type TYPE /gicom/bo_typ    "INS AC - M. 19417
      !iv_anchor TYPE /gicom/bo_id      "INS AC - M. 19417
    EXPORTING
      !ev_file_content TYPE xstring .
  METHODS search_doc_list
    IMPORTING
      !iv_pattern TYPE /gicom/tag
      !is_anchor TYPE /gicom/anchor_s
    EXPORTING
      !et_docreps_list TYPE /gicom/docreps_comm_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS logid_get
    IMPORTING
      !iv_docid TYPE so_entryid
    EXPORTING
      !ev_logid TYPE /gicom/logid .
  METHODS select_generated_document
    CHANGING
      !cs_docreps TYPE /gicom/docreps_s
    RAISING
      /gicom/cx_root_ds .
  METHODS get_form_description
    IMPORTING
      !iv_form_name TYPE /gicom/tmpl_name
      !iv_langu TYPE sy-langu
      !iv_tmpl_type TYPE /gicom/tmpl_type
    RETURNING
      VALUE(rv_description) TYPE /gicom/descr_60 .
  METHODS get_template_existance
    IMPORTING
      !iv_template_name TYPE string
      !iv_template_type TYPE char10
    RETURNING
      VALUE(ev_exist) TYPE abap_bool .
    METHODS update_anchor
      IMPORTING
        !iv_run_id TYPE /gicom/settlement_run_id
        !itr_docrep_id TYPE /gicom/docrep_id_rtt
      RAISING
        /gicom/cx_root_ds.
ENDINTERFACE.
