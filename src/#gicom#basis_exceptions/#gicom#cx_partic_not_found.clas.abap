class /GICOM/CX_PARTIC_NOT_FOUND definition
  public
  inheriting from /GICOM/CX_NOT_FOUND
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional .

ENDCLASS.



CLASS /GICOM/CX_PARTIC_NOT_FOUND IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor(
        textid    = textid
        previous  = previous
    ).
  ENDMETHOD.
ENDCLASS.
