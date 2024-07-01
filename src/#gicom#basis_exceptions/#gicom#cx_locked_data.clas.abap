CLASS /gicom/cx_locked_data DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_root_ds
  FINAL
  CREATE PUBLIC .

public section.

  methods CONSTRUCTOR
    importing
      textid    LIKE textid OPTIONAL
      !PREVIOUS like PREVIOUS optional .
  PRIVATE SECTION.

    CONSTANTS:
      co_code   TYPE /gicom/http_code VALUE '423',
      co_reason TYPE /gicom/http_reason VALUE 'Locked'.

ENDCLASS.



CLASS /GICOM/CX_LOCKED_DATA IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
        iv_code = me->co_code
        iv_reason = /gicom/cx_locked_data=>co_reason
        textid = textid
        previous = previous
    ).
  ENDMETHOD.
ENDCLASS.
