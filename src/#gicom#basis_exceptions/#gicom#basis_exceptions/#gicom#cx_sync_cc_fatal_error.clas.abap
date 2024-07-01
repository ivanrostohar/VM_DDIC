CLASS /gicom/cx_sync_cc_fatal_error DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_internal_error
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        previous LIKE previous OPTIONAL .
ENDCLASS.



CLASS /GICOM/CX_SYNC_CC_FATAL_ERROR IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    me->if_t100_message~t100key = VALUE #( msgid = '/GICOM/MSG_CCS_01'
                                           msgno = 071 ).

  ENDMETHOD.
ENDCLASS.
