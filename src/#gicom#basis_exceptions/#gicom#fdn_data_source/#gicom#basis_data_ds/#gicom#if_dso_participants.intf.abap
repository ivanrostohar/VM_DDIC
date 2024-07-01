INTERFACE /gicom/if_dso_participants
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_particrel_types
    EXPORTING
      !et_types TYPE /gicom/particrel_type_tt .
  METHODS select
    IMPORTING
      !it_partic_id TYPE /gicom/partic_id_rtt OPTIONAL
      !it_selopt    TYPE ddshselops OPTIONAL
      !iv_include_deleted TYPE /gicoM/abap_bool DEFAULT abap_false
    EXPORTING
      !et_partic    TYPE /gicom/participants_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.
  METHODS select_by_id
    IMPORTING
      !itr_bo_id TYPE /gicom/bo_id_rtt
      !iv_bo_typ TYPE /gicom/bo_typ
      !iv_include_deleted TYPE /gicoM/abap_bool DEFAULT abap_false
      !iv_include_inactive TYPE /gicom/abap_bool DEFAULT abap_false
    EXPORTING
      !et_partic TYPE /gicom/participants_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.
  METHODS insert
    IMPORTING
      !it_partic    TYPE /gicom/participants_a_tt
    EXPORTING
      !ev_partic_id TYPE /gicom/partic_id
    RAISING
      /gicom/cx_internal_error .
  METHODS delete
    IMPORTING
      !it_r_partic_id TYPE /gicom/partic_id_rtt
    RAISING
      /gicom/cx_internal_error .
  METHODS add_relations
    IMPORTING
      !it_particrel TYPE /gicom/particrel_tt
    RAISING
      /gicom/cx_internal_error .
  METHODS delete_relations
    IMPORTING
      !iv_bo_id  TYPE /gicom/bo_id
      !iv_bo_typ TYPE /gicom/bo_typ
    RAISING
      /gicom/cx_root_ds .
  METHODS update
    IMPORTING
      !it_partic TYPE /gicom/participants_a_tt
    RAISING
      /gicom/cx_internal_error.
    METHODS deactivate_partic
      IMPORTING
        !iv_id TYPE /gicom/partic_id
      RAISING
        /gicom/cx_internal_error.
    METHODS edit_partic
      IMPORTING
        !is_partic TYPE /gicom/partic
      RAISING
        /gicom/cx_internal_error.
ENDINTERFACE.
