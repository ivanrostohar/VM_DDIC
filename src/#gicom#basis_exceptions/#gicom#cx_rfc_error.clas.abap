CLASS /gicom/cx_rfc_error DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_root_dynamic
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_code   TYPE /gicom/http_code DEFAULT '500'
        iv_reason TYPE /gicom/http_reason DEFAULT 'RFC Error'
        !textid   LIKE textid OPTIONAL
        !previous LIKE previous OPTIONAL .

ENDCLASS.



CLASS /GICOM/CX_RFC_ERROR IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
        iv_code = iv_code
        iv_reason = iv_reason
        textid = textid
        previous = previous
    ).
  ENDMETHOD.
ENDCLASS.
