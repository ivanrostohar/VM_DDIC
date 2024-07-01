INTERFACE /gicom/if_dso_calc_head
  PUBLIC .

  INTERFACES if_badi_interface .

  METHODS:

    insert
      IMPORTING
        is_calc_head        TYPE /gicom/calc_head_a_s
      RETURNING
        VALUE(rs_calc_head) TYPE /gicom/calc_head_a_s
      RAISING
        /gicom/cx_root_ds,

    select_for_id
      IMPORTING
        iv_id               TYPE /gicom/calc_id
      RETURNING
        VALUE(rs_calc_head) TYPE /gicom/calc_head_a_s
      RAISING
        /gicom/cx_root_ds,

    select_for_data
      IMPORTING
        !iv_class           TYPE /gicom/calc_class
        !iv_prprcd_sender   TYPE /gicom/prprcd_sender
        !iv_prprcd_rcv      TYPE /gicom/prprcd_rcv
      RETURNING
        VALUE(rs_calc_head) TYPE /gicom/calc_head_a_s
      RAISING
        /gicom/cx_root_ds.

ENDINTERFACE.
