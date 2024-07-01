INTERFACE /gicom/if_dso_company_code
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_company_codes
    RETURNING
      VALUE(rt_cuco) TYPE /gicom/company_code_a_tt
    RAISING
      /gicom/cx_root_ds .

  METHODS insert_company_codes
    IMPORTING
      it_company_codes TYPE  /gicom/_ccode_a_tt
      iv_commit TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_company_codes
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_company_codes
    IMPORTING
       it_selopt              TYPE ddshselops
    RETURNING
      VALUE(rt_company_codes) TYPE /gicom/_ccode_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.

ENDINTERFACE.
