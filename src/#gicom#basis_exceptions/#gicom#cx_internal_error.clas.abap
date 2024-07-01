CLASS /gicom/cx_internal_error DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_root_ds
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      co_code   TYPE /gicom/http_code VALUE '500',
      co_reason TYPE /gicom/http_reason VALUE 'Internal Server Error'.

    METHODS constructor
      IMPORTING
        iv_code   TYPE /gicom/http_code         DEFAULT /gicom/cx_internal_error=>co_code
        iv_reason TYPE /gicom/http_reason       DEFAULT /gicom/cx_internal_error=>co_reason
        textid    LIKE textid OPTIONAL
        previous  LIKE previous OPTIONAL.


ENDCLASS.



CLASS /GICOM/CX_INTERNAL_ERROR IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor(
        iv_code   = iv_code
        iv_reason = iv_reason
        textid    = textid
        previous  = previous
    ).

  ENDMETHOD.
ENDCLASS.
