INTERFACE /gicom/ix_has_callstack
  PUBLIC .

  METHODS:

    get_callstack
      RETURNING
        VALUE(rt_callstack) TYPE /gicom/abap_callstack_tt.

ENDINTERFACE.
