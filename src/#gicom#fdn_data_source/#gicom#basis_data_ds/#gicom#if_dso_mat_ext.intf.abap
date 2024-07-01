INTERFACE /gicom/if_dso_mat_ext
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select
    IMPORTING
      itr_matnr           TYPE /gicom/matnr_rtt OPTIONAL
      itr_attr_obj_id     TYPE /gicom/attr_obj_id_rtt OPTIONAL
      itr_oid             TYPE /gicom/oid_rtt OPTIONAL
      itr_type            TYPE /gicom/mat_attr_type_rtt OPTIONAL
      itr_grp_type          TYPE /GICOM/EVAL_GRP_RTT OPTIONAL
      itr_x_use_history    TYPE /gicom/abap_bool_rtt
      itr_x_use_simulation TYPE /gicom/abap_bool_rtt
      iv_valid_from       TYPE /gicom/valid_from OPTIONAL
      iv_valid_to         TYPE /gicom/valid_to OPTIONAL
      itr_bo_typ_change   TYPE /gicom/bo_typ_rtt OPTIONAL
      itr_bo_id_change    TYPE /gicom/bo_id_rtt OPTIONAL
    EXPORTING
      !et_mat_ext          TYPE /gicom/mat_ext_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS insert
    IMPORTING
      !it_mat_ext TYPE /gicom/mat_ext_tt
      !iv_commit  TYPE /gicom/abap_bool DEFAULT abap_true
    EXPORTING
      !et_mat_ext TYPE /gicom/mat_ext_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS delete
    IMPORTING
      !it_mat_ext    TYPE /gicom/mat_ext_tt OPTIONAL
      !iv_commit     TYPE /gicom/abap_bool DEFAULT abap_true
      !iv_delete_all TYPE /gicom/abap_bool OPTIONAL
    RAISING
      /gicom/cx_root_ds .
  METHODS update
    IMPORTING
      !it_mat_ext TYPE /gicom/mat_ext_tt
      !iv_commit  TYPE /gicom/abap_bool DEFAULT abap_true
    EXPORTING
      !et_mat_ext TYPE /gicom/mat_ext_tt
    RAISING
      /gicom/cx_root_ds .
ENDINTERFACE.
