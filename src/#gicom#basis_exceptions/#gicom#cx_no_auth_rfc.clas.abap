class /GICOM/CX_NO_AUTH_RFC definition
  public
  inheriting from /GICOM/CX_RFC_ERROR
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional .
  PRIVATE SECTION.
    CONSTANTS:
      co_code   TYPE /gicom/http_code VALUE '404',
      co_reason TYPE /gicom/http_reason VALUE 'Not Found'.

ENDCLASS.



CLASS /GICOM/CX_NO_AUTH_RFC IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor(
        iv_code   = /gicom/cx_no_auth_rfc=>co_code "404
        iv_reason = /gicom/cx_no_auth_rfc=>co_reason
        textid    = textid
        previous  = previous
    ).
  ENDMETHOD.
ENDCLASS.
