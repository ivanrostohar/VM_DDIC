CLASS /gicom/cx_not_implemented DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_root_dynamic
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS /gicom/cx_not_implemented TYPE sotr_conc VALUE '00155D1468011ED6ABE4CE8617AC55E7' ##NO_TEXT.

    METHODS constructor
      IMPORTING
        !textid   LIKE textid OPTIONAL
        !previous LIKE previous OPTIONAL .
ENDCLASS.



CLASS /GICOM/CX_NOT_IMPLEMENTED IMPLEMENTATION.


  METHOD constructor  ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor(
        textid    = textid
        previous  = previous
    ).

    IF me->if_t100_message~t100key IS INITIAL.
      me->if_t100_message~t100key = VALUE #(
        msgid = '/GICOM/MSG_FOUNDAT'
        msgno = '044'
      ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
