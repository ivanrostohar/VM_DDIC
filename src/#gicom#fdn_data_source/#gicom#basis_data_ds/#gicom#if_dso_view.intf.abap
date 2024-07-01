INTERFACE /gicom/if_dso_view
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select
    IMPORTING
      !itr_view_key TYPE /gicom/tvw_key_rtt OPTIONAL
      !it_view_key  TYPE /gicom/tvw_key_tt
    EXPORTING
      !et_view_doc  TYPE /gicom/tvw_doc_a_tt .
  METHODS select_wl
    EXPORTING
      !et_views_wl TYPE /gicom/tvw_wl_tt .
  METHODS save_data
    IMPORTING
      !iv_tabname TYPE tabname
      !it_insert  TYPE table
      !it_update  TYPE table
      !it_delete  TYPE table
    RAISING
      /gicom/cx_internal_error .
  METHODS generate_control_id
    RETURNING
      VALUE(rv_ctrl_id) TYPE /gicom/ctrl_id
    RAISING
      /gicom/cx_internal_error .
  METHODS lock_view
    IMPORTING
      !is_key TYPE /gicom/tvw_key_s
    RAISING
      /gicom/cx_locked_data .
  METHODS unlock_view
    IMPORTING
      !is_key TYPE /gicom/tvw_key_s
    RAISING
      /gicom/cx_locked_data .
  METHODS is_view_existed
    IMPORTING
      !iv_view_name     TYPE /gicom/view_name
    RETURNING
      VALUE(rv_existed) TYPE char1 .
  METHODS is_view_definition_existed
    IMPORTING
      !iv_view_name     TYPE /gicom/view_name
    RETURNING
      VALUE(rv_existed) TYPE char1 .
ENDINTERFACE.
