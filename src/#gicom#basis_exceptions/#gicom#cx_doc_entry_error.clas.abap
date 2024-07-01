CLASS /gicom/cx_doc_entry_error DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_internal_error
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        previous LIKE previous OPTIONAL .
ENDCLASS.



CLASS /GICOM/CX_DOC_ENTRY_ERROR IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    me->if_t100_message~t100key = VALUE #( msgid = '/GICOM/MSG_APM_GENRL'
                                           msgno = 020 ).

  ENDMETHOD.
ENDCLASS.
