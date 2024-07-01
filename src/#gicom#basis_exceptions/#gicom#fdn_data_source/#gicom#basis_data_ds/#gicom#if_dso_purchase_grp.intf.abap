INTERFACE /gicom/if_dso_purchase_grp
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_purchase_grps
    EXPORTING
      !et_purchase_grps TYPE /gicom/cpurchase_grp_a_stt .

  METHODS insert_purchasing_groups
    IMPORTING
      it_purchasing_groups TYPE /gicom/_pur_gr_t_a_tt
      iv_commit            TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_purchasing_groups
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_purchasing_groups
    IMPORTING
      it_selopt  TYPE ddshselops
    RETURNING
      VALUE(rt_purchasing_groups) TYPE /gicom/_pur_gr_t_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.

ENDINTERFACE.
