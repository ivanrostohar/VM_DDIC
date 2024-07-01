INTERFACE /gicom/if_util_gos
  PUBLIC .

  CLASS-METHODS delete_file
    IMPORTING
      is_gos_comm TYPE /gicom/gos_comm_s
    RAISING
      /gicom/cx_internal_error .

ENDINTERFACE.
