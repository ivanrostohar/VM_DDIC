INTERFACE /gicom/if_dso_businesspartner
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_relations
    IMPORTING
      it_partner          TYPE /gicom/bupa_id_tt
    RETURNING
      VALUE(rt_relations) TYPE fsbp_bapi_relations_tty.

  METHODS select
    IMPORTING
      it_partner                 TYPE /gicom/bupa_id_tt
    RETURNING
      VALUE(rt_businesspartners) TYPE /gicom/bupa_a_tt
    RAISING
      /gicom/cx_root_ds .

  METHODS search
    IMPORTING
      !iv_name_1                 TYPE /gicom/name OPTIONAL
      !iv_name_2                 TYPE /gicom/name OPTIONAL
      !iv_person                 TYPE boolean DEFAULT abap_undefined
    RETURNING
      VALUE(rt_businesspartners) TYPE /gicom/bupa_a_tt
    RAISING
      /gicom/cx_root_ds .

  METHODS search_by_date
    IMPORTING
      iv_valid_date              TYPE /gicom/date
    RETURNING
      VALUE(rt_businesspartners) TYPE /gicom/bupa_a_tt
    RAISING
      /gicom/cx_root_ds .

  METHODS select_address
    IMPORTING
      !iv_bu_id         TYPE /gicom/bu_partner
      !iv_bu_type       TYPE /gicom/bo_typ
    RETURNING
      VALUE(rt_address) TYPE /gicom/address_tt
    RAISING
      /gicom/cx_root_ds.

  METHODS insert_business_partners
    IMPORTING
      it_business_partners TYPE /gicom/_bupa_a_tt
      it_business_partner_relation TYPE /gicom/_bupa_rel_a_tt
      it_business_partner_role TYPE /gicom/_bupa_rol_a_tt
      it_business_partner_message TYPE /gicom/_bupa_msg_a_tt
      iv_commit TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_business_partners
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_business_partners
    IMPORTING
      it_selopt          TYPE ddshselops OPTIONAL
      iv_activity        TYPE /gicom/activity_allowed DEFAULT /gicom/if_const_record_status=>cv_activity_display_allowed
    EXPORTING
      et_business_partners TYPE /gicom/_bupa_a_tt
      et_business_partner_relation TYPE /gicom/_bupa_rel_a_tt
      et_business_partner_role TYPE /gicom/_bupa_rol_a_tt
      et_business_partner_message TYPE /gicom/_bupa_msg_a_tt
    RAISING
      /gicom/cx_internal_error.


  METHODS insert_bp_relations
    IMPORTING
      it_bp_relations TYPE /gicom/_bp_rels_a_tt
      iv_commit TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_bp_relations
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_bp_relations
    RETURNING
      VALUE(rt_bp_relations)   TYPE /gicom/_bp_rels_a_tt.


  METHODS is_using_business_partner
    RETURNING
      VALUE(rv_using_business_partner) TYPE abap_bool.


ENDINTERFACE.
