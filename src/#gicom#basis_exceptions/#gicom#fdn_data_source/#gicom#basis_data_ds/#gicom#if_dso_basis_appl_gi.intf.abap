INTERFACE /gicom/if_dso_basis_appl_gi
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS insert_bopara
    IMPORTING
      !it_bo_para       TYPE /gicom/bopara_a_tt
      iv_commit         TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rt_bo_para) TYPE /gicom/bopara_a_tt
    RAISING
      /gicom/cx_root_ds.
  METHODS select_bopara
    IMPORTING
      !iv_bo_id                TYPE /gicom/bo_id
      !iv_bo_typ               TYPE /gicom/bo_typ
      !itr_bo_para             TYPE /gicom/key_para_bo_rtt
    RETURNING
      VALUE(rt_bo_para_values) TYPE /gicom/bopara_a_tt
    RAISING
      /gicom/cx_root_ds.
  METHODS update_bopara
    IMPORTING
      !is_bo_para       TYPE /gicom/bopara_a_s
      iv_commit         TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rs_bo_para) TYPE /gicom/bopara_a_s
    RAISING
      /gicom/cx_root_ds.
  METHODS delete_bopara
    IMPORTING
      !iv_bo_typ       TYPE /gicom/bo_typ
      !iv_bo_id        TYPE /gicom/bo_id
      !itr_bo_para_key TYPE /gicom/key_para_bo_rtt
      iv_commit         TYPE /gicom/abap_bool DEFAULT abap_true
    RAISING
      /gicom/cx_root_ds.
ENDINTERFACE.
