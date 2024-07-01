INTERFACE /gicom/if_dso_time_ref
  PUBLIC .

  INTERFACES if_badi_interface.

  METHODS select_id
    IMPORTING
      !is_time_ref    TYPE /gicom/time_ref_a_s
    RETURNING
      VALUE(rv_time_ref_id) TYPE /gicom/time_ref_id
    RAISING
      /gicom/cx_internal_error .

  METHODS select_details
    IMPORTING
      !iv_time_ref_id TYPE /gicom/time_ref_id
    RETURNING
      VALUE(rs_time_ref)    TYPE /gicom/time_ref_a_s
    RAISING
      /gicom/cx_internal_error .


ENDINTERFACE.
