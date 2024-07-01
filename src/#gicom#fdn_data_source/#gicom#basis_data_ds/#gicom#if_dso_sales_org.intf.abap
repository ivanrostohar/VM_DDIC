INTERFACE /gicom/if_dso_sales_org
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_sales_orgs
    EXPORTING
      !et_sales_orgs     TYPE /gicom/csales_org_a_stt
      !et_sales_orgs_txt TYPE /gicom/csales_org_txt_a_stt .

  METHODS insert_sales_organizations
    IMPORTING
      it_sales_organizations_txt TYPE /gicom/_sas_og_t_a_tt
      it_sales_organizations TYPE /gicom/_sas_og_a_tt
      iv_commit TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_sales_organizations
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_sales_organizations
    IMPORTING
        it_selopt TYPE ddshselops
    RETURNING
      VALUE(rt_sales_organizations) TYPE /gicom/_sas_og_t_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.


ENDINTERFACE.
