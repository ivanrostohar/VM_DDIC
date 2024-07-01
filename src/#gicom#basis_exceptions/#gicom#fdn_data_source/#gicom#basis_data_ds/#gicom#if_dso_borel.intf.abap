INTERFACE /gicom/if_dso_borel
  PUBLIC .

  INTERFACES if_badi_interface .

  METHODS delete_borel
    IMPORTING
      !it_borel  TYPE /gicom/borel_a_tt
      !iv_commit TYPE /gicom/abap_bool DEFAULT abap_true.
  METHODS delete_borel_by_bo
    IMPORTING
      !it_type          TYPE /gicom/type_rel_rtt OPTIONAL
      !iv_bo_type       TYPE /gicom/bo_typ OPTIONAL
      !iv_guid          TYPE /gicom/guid OPTIONAL
      !it_bo_id         TYPE /gicom/bo_id_stt OPTIONAL
      !iv_type_rel_flag TYPE /gicom/type_rel_flag DEFAULT 'BOB'
      !iv_commit        TYPE /gicom/abap_bool DEFAULT abap_true
    RAISING
      /gicom/cx_invalid_arguments.
  METHODS insert_borel
    IMPORTING
      !it_borel       TYPE /gicom/borel_a_tt
      !iv_commit      TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rt_borel) TYPE /gicom/borel_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS select_borel_by_bo
    IMPORTING
      !it_type          TYPE /gicom/type_rel_rtt OPTIONAL
      !iv_bo_type       TYPE /gicom/bo_typ OPTIONAL
      !iv_guid          TYPE /gicom/guid OPTIONAL
      !it_bo_id         TYPE /gicom/bo_id_stt OPTIONAL
      !iv_type_rel_flag TYPE /gicom/type_rel_flag  DEFAULT 'BOB'
    EXPORTING
      !et_borel         TYPE /gicom/borel_a_tt
    RAISING
      /gicom/cx_invalid_arguments
      /gicom/cx_no_data.
  METHODS select_borel_by_guid
    IMPORTING
      !iv_guid  TYPE /gicom/guid_ref
    EXPORTING
      !et_borel TYPE /gicom/borel_a_tt
    RAISING
      /gicom/cx_no_data.
  METHODS select_borel_by_type_rel
    IMPORTING
      !it_type      TYPE /gicom/type_rel_rtt
      !iv_bo_type_1 TYPE /gicom/bo_typ OPTIONAL
      !it_bo_id_1   TYPE /gicom/bo_id_stt OPTIONAL
      !iv_guid_1    TYPE /gicom/guid OPTIONAL
      !iv_bo_type_2 TYPE /gicom/bo_typ OPTIONAL
      !it_bo_id_2   TYPE /gicom/bo_id_stt OPTIONAL
      !iv_guid_2    TYPE /gicom/guid OPTIONAL
    EXPORTING
      !et_borel     TYPE /gicom/borel_a_tt
    RAISING
      /gicom/cx_invalid_arguments
      /gicom/cx_no_data .
  METHODS select_for_bo
    IMPORTING
      iv_bo_type TYPE /gicom/bo_typ
      it_bo_id   TYPE /gicom/bo_id_stt
    RETURNING
      VALUE(rt_borel)   TYPE /gicom/borel_a_tt.
ENDINTERFACE.
