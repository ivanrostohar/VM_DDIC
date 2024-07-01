INTERFACE /gicom/if_dso_description
  PUBLIC .

  METHODS select_description
    IMPORTING
      !iv_domain      TYPE string
      !iv_where_exp   TYPE string
      !iv_value       TYPE string
    RETURNING
      VALUE(rv_descr) TYPE string
    RAISING
      /gicom/cx_root_ds.

ENDINTERFACE.
