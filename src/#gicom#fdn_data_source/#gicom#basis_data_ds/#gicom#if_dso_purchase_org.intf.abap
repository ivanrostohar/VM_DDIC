INTERFACE /gicom/if_dso_purchase_org
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_purchase_orgs
    EXPORTING
      !et_purchase_orgs TYPE /gicom/cpurchase_org_a_stt
    RAISING
      /gicom/cx_rfc_error  .

  METHODS insert_purchase_organzations
    IMPORTING
      it_purchasing_organizations TYPE /gicom/_pur_og_t_a_tt
      iv_commit TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_purchase_organizations
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_purchase_organizations
    IMPORTING
        it_selopt TYPE ddshselops
    RETURNING
      VALUE(rt_purchasing_organizations) TYPE /gicom/_pur_og_t_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.


ENDINTERFACE.
