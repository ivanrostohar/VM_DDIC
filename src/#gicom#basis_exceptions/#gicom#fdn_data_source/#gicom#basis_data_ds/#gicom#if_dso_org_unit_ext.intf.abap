INTERFACE /gicom/if_dso_org_unit_ext
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS anonymize_business_partners
    IMPORTING
      !it_bupa  TYPE /gicom/bupa_id_tt
    EXPORTING
      !ev_count TYPE /gicom/counter
    RAISING
      /gicom/cx_root_ds .
  METHODS insert
    IMPORTING
      !is_org    TYPE /gicom/organization_st
      !iv_commit TYPE /gicom/abap_bool DEFAULT abap_false
    EXPORTING
      !es_org    TYPE /gicom/organization_st
    RAISING
      /gicom/cx_internal_error .
  METHODS update_by_bo
    IMPORTING
      !is_org TYPE /gicom/organization_st
    EXPORTING
      !es_org TYPE /gicom/organization_st
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found .
  METHODS update_by_id
    IMPORTING
      !is_org TYPE /gicom/organization_st
    EXPORTING
      !es_org TYPE /gicom/organization_st
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found .
  METHODS select_by_bo
    IMPORTING
      !iv_bo_typ TYPE /gicom/bo_typ_repr
      !iv_bo_id  TYPE /gicom/bo_id_repr
    EXPORTING
      !es_org    TYPE /gicom/organization_st
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found .
  METHODS select_by_id
    IMPORTING
      !iv_oid TYPE /gicom/oid
    EXPORTING
      !es_org TYPE /gicom/organization_st
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found .
  METHODS select_by_ids
    IMPORTING
      !it_oid       TYPE /gicom/oid_tt
    RETURNING
      VALUE(rt_org) TYPE /gicom/organization_tty
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found .
  METHODS select_data
    IMPORTING
      !iv_model           TYPE /gicom/corgmodel
      !iv_sync_supplier   TYPE /gicom/csync_supplier
      !iv_sync_customer   TYPE /gicom/csync_customer
      !it_supplier_bukrs  TYPE /gicom/cbukrs_tt
      !it_customer_bukrs  TYPE /gicom/cbukrs_tt
    EXPORTING
      !et_bukrs_suppliers TYPE /gicom/csupplier_bukrs_tt
      !et_bukrs_customers TYPE /gicom/ccustomer_bukrs_tt
      !et_org_ext         TYPE /gicom/comorgext_a_tt
      !et_supp_org_ext    TYPE /gicom/comorgext_a_tt
      !et_cust_org_ext    TYPE /gicom/comorgext_a_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select
    IMPORTING
      !iv_model      TYPE /gicom/corgmodel
      !iv_dyn_model  TYPE /gicom/corgmodeld
      !iv_valid_from TYPE /gicom/valid_from
      !iv_valid_to   TYPE /gicom/valid_to
      !iv_customer   TYPE /gicom/abap_bool
      !iv_supplier   TYPE /gicom/abap_bool
    EXPORTING
      !et_org_ext    TYPE /gicom/comorgext_a_tt
      !et_orgrel     TYPE /gicom/orgextrel_a_tt
      !et_artrel     TYPE /gicom/mat_ext_agr_tt .
  METHODS save_data
    IMPORTING
      !iv_tabname TYPE tabname
      !it_insert  TYPE table
      !it_update  TYPE table
      !it_delete  TYPE table
    RAISING
      /gicom/cx_internal_error
      cx_abap_not_a_table
      cx_abap_not_in_package .
  METHODS select_ext_all
    IMPORTING
      !iv_model      TYPE /gicom/corgmodel
      !iv_dyn_model  TYPE /gicom/corgmodeld
      !iv_valid_from TYPE /gicom/valid_from
      !iv_valid_to   TYPE /gicom/valid_to
      !it_customers  TYPE /gicom/bupa_a_tt
      !it_suppliers  TYPE /gicom/bupa_a_tt
    EXPORTING
      !et_org_ext    TYPE /gicom/comorgext_a_tt
      !et_orgrel     TYPE /gicom/orgextrel_a_tt
      !et_artrel     TYPE /gicom/mat_ext_agr_tt .
  METHODS generate_key
    RETURNING
      VALUE(rv_next_number) TYPE /gicom/oid
    RAISING
      /gicom/cx_internal_error .
  METHODS select_ext_rel
    IMPORTING
      !iv_valid_from TYPE /gicom/valid_from
      !iv_valid_to   TYPE /gicom/valid_to
    EXPORTING
      !et_extrels    TYPE /gicom/orgextrel_a_tt .
  METHODS select_all_org_units
    IMPORTING
      !itr_oid           TYPE /gicom/oid_partner_rtt
    RETURNING
      VALUE(rt_org_unit) TYPE /gicom/organization_std_tt
    RAISING
      /gicom/cx_root_ds .
  "INS BEGIN AB M.19674
  METHODS select_org_ext_parent_deep
    IMPORTING
      !iv_org            TYPE /gicom/oid
      !iv_effective_date TYPE sy-datum
    RETURNING
      VALUE(rt_org_unit) TYPE /gicom/orgextrel_a_tt .
  "INS END AB M.19674
ENDINTERFACE.
