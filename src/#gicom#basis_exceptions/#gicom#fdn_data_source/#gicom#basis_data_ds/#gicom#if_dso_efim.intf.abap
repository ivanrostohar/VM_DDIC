INTERFACE /gicom/if_dso_efim
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS check_assignments
    IMPORTING
      !itr_bo_typ    TYPE /gicom/bo_typ_rtt
      !itr_enhname   TYPE /gicom/enhname_rtt
      !itr_appl_type TYPE /gicom/appl_type_rtt
    RAISING
      /gicom/cx_root_ds.
  METHODS duplicates_check
    IMPORTING
      !iv_enhname TYPE enhname
    RAISING
      /gicom/cx_root_ds
      /gicom/cx_duplicate_data .
  METHODS lock_enhancement
    IMPORTING
      !iv_enhname TYPE enhname
    RAISING
      /gicom/cx_root_ds.
  METHODS save_data
    IMPORTING
      !iv_tabname TYPE tabname
      !it_insert  TYPE table
      !it_update  TYPE table
      !it_delete  TYPE table
    RAISING
      /gicom/cx_root_ds.
  METHODS select_assignments_bo_typ
    IMPORTING
      !itr_bo_typ           TYPE /gicom/bo_typ_rtt
    RETURNING
      VALUE(rt_assignments) TYPE /gicom/cefimasgn_a_tt .
  METHODS select_enhancement
    IMPORTING
      !itr_bo_typ           TYPE /gicom/bo_typ_rtt OPTIONAL
      !itr_enhname          TYPE /gicom/enhname_rtt OPTIONAL
      !itr_assignment       TYPE /gicom/appl_type_rtt OPTIONAL
      !itr_spot             TYPE /gicom/spot_rtt OPTIONAL
      !itr_seq_num          TYPE /gicom/seq_step_rtt OPTIONAL
      !is_selection         TYPE /gicom/selection_s OPTIONAL
    RETURNING
      VALUE(rt_enhance_doc) TYPE /gicom/cefim_doc_a_tt
    RAISING
      /gicom/cx_root_ds.
  METHODS select_wl
    IMPORTING
      !itr_bo_typ      TYPE /gicom/bo_typ_rtt
    RETURNING
      VALUE(rt_header) TYPE /gicom/cefimhdr_a_tt
    RAISING
      /gicom/cx_root_ds.
  METHODS unlock_enhancement
    IMPORTING
      !iv_enhname TYPE enhname .
  METHODS select_enh_by_assignment
    IMPORTING
      !itr_bo_typ       TYPE /gicom/bo_typ_rtt
      !itr_appl_type    TYPE /gicom/appl_type_rtt
    RETURNING
      VALUE(rt_enhname) TYPE /gicom/enhname_tt .
  METHODS check_rule_class
    IMPORTING
      !iv_class      TYPE /gicom/impl_class
    RETURNING
      VALUE(rv_flag) TYPE xfeld .
ENDINTERFACE.
