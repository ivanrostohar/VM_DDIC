*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations


CLASS lcl_facade DEFINITION.

  PUBLIC SECTION.
    INTERFACES /gicom/if_number_range_objects.

ENDCLASS.

CLASS lcl_facade IMPLEMENTATION.

  METHOD /gicom/if_number_range_objects~get_next_number.
    /gicom/cl_number_range_objects=>get_next_number(
      EXPORTING
        iv_proc_snro   = iv_proc_snro
      IMPORTING
        ev_next_number = ev_next_number
    ).
  ENDMETHOD.

  METHOD /gicom/if_number_range_objects~get_next_number_and_skip.
    /gicom/cl_number_range_objects=>get_next_number_and_skip(
      EXPORTING
        iv_proc_snro   = iv_proc_snro
        iv_skip        = iv_skip
      IMPORTING
        ev_next_number = ev_next_number
    ).
  ENDMETHOD.

ENDCLASS.
