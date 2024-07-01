INTERFACE /gicom/if_dso_txr
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select
    IMPORTING
      !itr_key    TYPE /gicom/ttxr_key_rtt
    EXPORTING
      !et_txr_doc TYPE /gicom/ttxr_doc_a_tt .
  METHODS select_wl
    IMPORTING
      !iv_appl_name   TYPE /gicom/appl_name
      !iv_appl_obj_id TYPE /gicom/appl_obj_id
    EXPORTING
      !et_txr_wl      TYPE /gicom/ttxr_wl_a_tt .
  METHODS save_data
    IMPORTING
      !iv_tabname TYPE tabname
      !it_insert  TYPE table
      !it_update  TYPE table
      !it_delete  TYPE table
    RAISING
      /gicom/cx_internal_error .
  METHODS lock_txr
    IMPORTING
      !is_txr TYPE /gicom/ttxr_key_s
    RAISING
      /gicom/cx_locked_data .
  METHODS unlock_txr
    IMPORTING
      !is_txr TYPE /gicom/ttxr_key_s .
  METHODS generate_key
    RETURNING
      VALUE(rv_id) TYPE /gicom/text_id
    RAISING
      /gicom/cx_internal_error .
  METHODS is_assignments_exists
    IMPORTING
      !iv_appl_name     TYPE /gicom/appl_name
      !iv_appl_obj_id   TYPE /gicom/appl_obj_id
    RETURNING
      VALUE(rv_text_id) TYPE /gicom/text_id .
  METHODS get_text_ids
    IMPORTING
      !it_txr_rel       TYPE /gicom/ttxr_rel_a_tt
    RETURNING
      VALUE(rt_txr_rel) TYPE /gicom/ttxr_rel_a_tt .
  METHODS get_texts
    IMPORTING
      !it_txr_rel       TYPE /gicom/ttxr_rel_a_tt
    RETURNING
      VALUE(rt_txr_rel) TYPE /gicom/ttxr_rel_a_tt .
ENDINTERFACE.
