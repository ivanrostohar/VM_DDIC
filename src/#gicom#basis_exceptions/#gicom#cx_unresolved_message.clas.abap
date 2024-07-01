CLASS /gicom/cx_unresolved_message DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_root_dynamic
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !textid   LIKE textid OPTIONAL
        !previous LIKE previous OPTIONAL .
  PRIVATE SECTION.
    CONSTANTS:
      co_code   TYPE /gicom/http_code VALUE '499',
      co_reason TYPE /gicom/http_reason VALUE 'Unresolved message'.

ENDCLASS.



CLASS /GICOM/CX_UNRESOLVED_MESSAGE IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor(
        iv_code   = /gicom/cx_unresolved_message=>co_code "404
        iv_reason = /gicom/cx_unresolved_message=>co_reason
        textid    = textid
        previous  = previous
                    ).
  ENDMETHOD.
ENDCLASS.
