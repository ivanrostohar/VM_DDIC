INTERFACE /gicom/if_dso_service_type
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select
    EXPORTING
      VALUE(et_service_type)      TYPE /gicom/service_type_a_tt
      VALUE(et_service_type_calc) TYPE /gicom/service_calc_a_tt
      VALUE(et_service_type_rel)  TYPE /gicom/service_type_rel_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS insert_service_type
    IMPORTING
      !it_service_type       TYPE /gicom/service_type_a_tt
      !iv_commit             TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rt_service_type) TYPE /gicom/service_type_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS insert_service_type_calc
    IMPORTING
      !it_service_type_calc       TYPE /gicom/service_calc_a_tt
      !iv_commit                  TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rt_service_type_calc) TYPE /gicom/service_calc_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS insert_service_type_rel
    IMPORTING
      !it_service_type_rel       TYPE /gicom/service_type_rel_a_tt
      !iv_commit                 TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rt_service_type_rel) TYPE /gicom/service_type_rel_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS delete_service_type_calc
    IMPORTING
      !it_service_type_calc TYPE /gicom/service_calc_a_tt
      !iv_commit            TYPE /gicom/abap_bool DEFAULT abap_true
    RAISING
      /gicom/cx_root_ds .
  METHODS delete_service_type_rel
    IMPORTING
      !it_service_type_rel TYPE /gicom/service_type_rel_a_tt
      !iv_commit           TYPE /gicom/abap_bool DEFAULT abap_true
    RAISING
      /gicom/cx_root_ds .
  METHODS update_service_type
    IMPORTING
      !it_service_type       TYPE /gicom/service_type_a_tt
      !iv_commit             TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rt_service_type) TYPE /gicom/service_type_a_tt
    RAISING
      /gicom/cx_root_ds .
ENDINTERFACE.
