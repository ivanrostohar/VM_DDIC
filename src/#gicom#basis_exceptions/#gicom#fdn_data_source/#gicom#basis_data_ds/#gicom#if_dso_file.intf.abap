INTERFACE /gicom/if_dso_file
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_for_id
    IMPORTING
      !iv_guid       TYPE /gicom/guid_file
    RETURNING
      VALUE(rs_file) TYPE /gicom/file_s_a
    RAISING
      /gicom/cx_root_ds.
  METHODS select
    IMPORTING
      !iv_bo_id     TYPE /gicom/bo_id
      !iv_bo_typ    TYPE /gicom/bo_typ
      !iv_date_from TYPE /gicom/timestmps OPTIONAL
      !iv_date_to   TYPE /gicom/timestmps OPTIONAL
    EXPORTING
      !et_file      TYPE /gicom/file_tt_a
      !et_error     TYPE bapiret2_t
    RAISING
      /gicom/cx_root_ds .
  METHODS select_ftype
    EXPORTING
      !et_type  TYPE /gicom/ftyp_tt
      !et_error TYPE bapiret2_t
    RAISING
      /gicom/cx_root_ds .
  METHODS select_ftypesub
    IMPORTING
      !itr_type   TYPE /gicom/ftyp_rtt OPTIONAL
    EXPORTING
      !et_typesub TYPE /gicom/ftypsub_tt
      !et_error   TYPE bapiret2_t
    RAISING
      /gicom/cx_root_ds .
  METHODS insert
    IMPORTING
      !it_file   TYPE /gicom/file_tt_a
      !iv_commit TYPE /gicom/abap_bool DEFAULT abap_true
    EXPORTING
      !et_file   TYPE /gicom/file_tt_a
      !et_error  TYPE bapiret2_t
    RAISING
      /gicom/cx_root_ds .
  METHODS delete
    IMPORTING
      !it_r_file_id TYPE /gicom/guid_file_rtt
      !iv_commit    TYPE /gicom/abap_bool DEFAULT 'X'
    EXPORTING
      !et_error     TYPE bapiret2_t
    RAISING
      /gicom/cx_root_ds .
  METHODS update
    IMPORTING
      !it_file   TYPE /gicom/file_tt_a
      !iv_commit TYPE /gicom/abap_bool DEFAULT 'X'
    EXPORTING
      !et_file   TYPE /gicom/file_tt_a
      !et_error  TYPE bapiret2_t
    RAISING
      /gicom/cx_root_ds .
  METHODS change_importance
    IMPORTING
              !iv_guid                        TYPE /gicom/guid_file
    EXPORTING
              !et_error                       TYPE bapiret2_t
    RETURNING VALUE(rv_new_importance_status) TYPE /gicom/important
    RAISING
        /gicom/cx_root_ds .
ENDINTERFACE.
