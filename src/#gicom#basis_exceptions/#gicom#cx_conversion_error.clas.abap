CLASS /gicom/cx_conversion_error DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_root_dynamic
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS:

      constructor
        IMPORTING
          textid    LIKE textid OPTIONAL
          previous  LIKE previous OPTIONAL.

ENDCLASS.



CLASS /GICOM/CX_CONVERSION_ERROR IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor(
        textid    = textid
        previous  = previous
    ).

  ENDMETHOD.
ENDCLASS.
