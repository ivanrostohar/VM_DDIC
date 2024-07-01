INTERFACE /gicom/if_dso_org_unit_int
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select
    IMPORTING
      !iv_valid_for TYPE sy-datum
    EXPORTING
      !et_orgunit TYPE /gicom/organization_tty
      !et_orgrel TYPE /gicom/torg_rel_a_tt
      !et_orgrel_dir TYPE /gicom/torg_rel_a_tt
      !et_ararel TYPE /gicom/ara_rel_tty .
  METHODS select_data
    IMPORTING
      !iv_model TYPE /gicom/corgmodel
      !iv_dyn_model TYPE /gicom/corgmodel
      !iv_valid_from TYPE /gicom/valid_from
      !iv_valid_to TYPE /gicom/valid_to
      !iv_draft_tables TYPE char1
      !iv_version TYPE /gicom/version
      !iv_all_rels TYPE char1 DEFAULT 'X'
    RETURNING
      VALUE(rt_om_doc) TYPE /gicom/com_doc_a_tt
    RAISING
      /gicom/cx_not_found .
  METHODS save_data
    IMPORTING
      !iv_tabname TYPE tabname
      !it_insert TYPE table
      !it_update TYPE table
      !it_delete TYPE table
    RAISING
      /gicom/cx_internal_error .
  METHODS lock_org_model
    IMPORTING
      !iv_model TYPE /gicom/corgmodel
      !iv_valid_from TYPE /gicom/valid_from
    RAISING
      /gicom/cx_locked_data .
  METHODS unlock_org_model
    IMPORTING
      !iv_model TYPE /gicom/corgmodel
      !iv_valid_from TYPE /gicom/valid_from .
  METHODS generate_key
    RETURNING
      VALUE(rv_next_number) TYPE /gicom/oid
    RAISING
      /gicom/cx_internal_error .
  METHODS unique_check_level
    IMPORTING
      !iv_level TYPE /gicom/orglvl
    RETURNING
      VALUE(rv_exist) TYPE char1 .
  METHODS select_class
    EXPORTING
      !et_orglvl TYPE /gicom/torg_lvl_tt
      !et_orglvlrl TYPE /gicom/torglvlrl_tt .
  METHODS validate_unit_relation
    IMPORTING
      !iv_parent TYPE /gicom/attr_obj_id
      !iv_child TYPE /gicom/attr_obj_id
      !iv_valid_from TYPE /gicom/valid_from
      !iv_valid_to TYPE /gicom/valid_to
    EXPORTING
      !ev_valid TYPE /gicom/abap_bool .
  METHODS get_priority_by_oid
    IMPORTING
      !iv_group TYPE /gicom/oid_grp
      !iv_member TYPE /gicom/oid_member
      !iv_valid_date TYPE /gicom/valid_from
    RETURNING
      VALUE(rv_priority) TYPE /gicom/hier_prio
    EXCEPTIONS
      /gicom/cx_root_ds .
  METHODS get_children_units
    IMPORTING
      !iv_oid TYPE /gicom/oid
      !iv_level TYPE /gicom/orglvl
      !iv_role TYPE /gicom/bupa_internal_role
      !iv_valid_date TYPE /gicom/valid_from
    EXPORTING
      !et_int_oid TYPE /gicom/oid_tt
      !et_ext_oid TYPE /gicom/oid_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS get_parent_units
    IMPORTING
      !iv_oid TYPE /gicom/oid
      !iv_level TYPE /gicom/orglvl
      !iv_role TYPE /gicom/bupa_internal_role
      !iv_valid_date TYPE /gicom/valid_from
    EXPORTING
      !et_int_oid TYPE /gicom/oid_tt
      !et_ext_oid TYPE /gicom/oid_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS get_breakdown_levels  "MOD AB 17.08.2021 M.20001
    IMPORTING
      !iv_valid_date TYPE /gicom/valid_from
    RETURNING
      VALUE(rt_level) TYPE /gicom/orglvl_tt "MOD AB 17.08.2021 M.20001
    RAISING
      /gicom/cx_root_ds .
  "! Compare two org levels, returning whether the first parameter is higher (1), the same level (0) or lower (-1) in the hierarchy than the second parameter. ATTN: this is NOT a comparison of the priority VALUES in the table, but the exact opposite!
  "! @parameter iv_level_1 | Organizational level to compare
  "! @parameter iv_level_2 | Organizational level to compare with
  "! @parameter iv_effective_date |
  "! @parameter rv_result |
  METHODS compare_levels_by_priority
    IMPORTING
      !iv_level_1 TYPE /gicom/orglvl
      !iv_level_2 TYPE /gicom/orglvl
      !iv_effective_date TYPE /gicom/valid_from
    RETURNING
      VALUE(rv_result) TYPE int2 .
  METHODS get_org_parent_direct
    IMPORTING
      !iv_org_id TYPE /gicom/oid
      !iv_effective_date TYPE sy-datum
      !iv_rel_type TYPE /gicom/type_relo
    RETURNING
      VALUE(rt_org_oid) TYPE /gicom/oid_tt .
ENDINTERFACE.
