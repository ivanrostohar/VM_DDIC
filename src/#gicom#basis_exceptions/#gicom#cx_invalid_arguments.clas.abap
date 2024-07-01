CLASS /gicom/cx_invalid_arguments DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_root_ds
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
    constructor
    importing
        textid   LIKE textid OPTIONAL
        previous LIKE previous OPTIONAL.

  PRIVATE SECTION.
    CONSTANTS:
      co_code   TYPE /gicom/http_code VALUE '419', "Because the ICF likes to send 400 on session timeout >_>
      co_reason TYPE /gicom/http_reason VALUE 'Bad Request'.

ENDCLASS.



CLASS /GICOM/CX_INVALID_ARGUMENTS IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
        iv_code   = /gicom/cx_invalid_arguments=>co_code
        iv_reason = /gicom/cx_invalid_arguments=>co_reason
        textid = textid
        previous = previous
    ).
  ENDMETHOD.
ENDCLASS.
