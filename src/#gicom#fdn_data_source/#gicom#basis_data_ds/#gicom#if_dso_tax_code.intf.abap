INTERFACE /gicom/if_dso_tax_code
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS read_tax_data
    IMPORTING
      !iv_tax_code  TYPE mwskz
      !iv_country   TYPE land1
    RETURNING
      VALUE(rs_tax) TYPE /gicom/tax_s
    RAISING
      /gicom/cx_not_found .
  METHODS select_tax_codes
    RETURNING
      VALUE(RT_TAX_codes) TYPE /gicom/sap_tax_code_tt
    RAISING
      /gicom/cx_root_ds .

  METHODS insert_tax_codes
    IMPORTING
      it_tax_codes TYPE  /gicom/_tax_rate_a_tt
      it_tax_codes_text TYPE /gicom/_tax_ratt_a_tt
      iv_commit TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_tax_codes
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_tax_codes
    IMPORTING
       it_selopt TYPE ddshselops
    EXPORTING
      et_tax_codes      TYPE /gicom/_tax_rate_a_tt
      et_tax_codes_text TYPE /gicom/_tax_ratt_a_tt
   RAISING
      /gicom/cx_internal_error.

ENDINTERFACE.
