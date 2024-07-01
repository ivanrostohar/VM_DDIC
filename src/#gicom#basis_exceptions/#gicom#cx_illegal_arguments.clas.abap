CLASS /gicom/cx_illegal_arguments DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_root_dynamic
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_code   TYPE /gicom/http_code DEFAULT '500'
        iv_reason TYPE /gicom/http_reason DEFAULT 'Internal Server Error'
        textid    TYPE sotr_conc OPTIONAL
        previous  TYPE REF TO cx_root OPTIONAL.

ENDCLASS.



CLASS /GICOM/CX_ILLEGAL_ARGUMENTS IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor(
        iv_code   = iv_code
        iv_reason = iv_reason
        textid    = textid
        previous  = previous
    ).

  ENDMETHOD.
ENDCLASS.
