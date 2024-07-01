CLASS /gicom/cx_inconsistent_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM /gicom/cx_root_dynamic.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          textid   LIKE textid OPTIONAL
          previous LIKE previous OPTIONAL.

  PRIVATE SECTION.

    CONSTANTS:
      co_code   TYPE /gicom/http_code VALUE '409',
      co_reason TYPE /gicom/http_reason VALUE 'Inconsistent data'.

ENDCLASS.



CLASS /GICOM/CX_INCONSISTENT_DATA IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
        iv_code = me->co_code
        iv_reason = /gicom/cx_inconsistent_data=>co_reason
        textid = textid
        previous = previous
    ).
  ENDMETHOD.
ENDCLASS.
