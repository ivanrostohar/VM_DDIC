INTERFACE /gicom/if_number_range_objects
  PUBLIC .

  METHODS:
    get_next_number
      IMPORTING
        !iv_proc_snro TYPE /gicom/proc_snro
      EXPORTING
        !ev_next_number TYPE ANY
      RAISING
        /gicom/cx_internal_error,

    get_next_number_and_skip
      IMPORTING
        !iv_proc_snro TYPE /gicom/proc_snro
        !iv_skip TYPE I
      EXPORTING
        !ev_next_number TYPE ANY
      RAISING
        /gicom/cx_internal_error .

ENDINTERFACE.
