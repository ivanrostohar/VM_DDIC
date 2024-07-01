INTERFACE /gicom/if_dso_bupa_role
  PUBLIC.

  INTERFACES:
    if_badi_interface.

  METHODS:
    select
      RETURNING
        VALUE(rt_tbuparole) TYPE /gicom/tbuparole_a_tt
      RAISING
        /gicom/cx_root_ds.

  METHODS insert_bupa_roles
    IMPORTING
      it_bupa_roles TYPE /gicom/_bp_roles_a_tt
      iv_commit TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_bupa_roles
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_bupa_roles
    RETURNING
      VALUE(rt_bupa_roles) TYPE /gicom/_bp_roles_a_tt
    RAISING
      /gicom/cx_not_found.

ENDINTERFACE.
