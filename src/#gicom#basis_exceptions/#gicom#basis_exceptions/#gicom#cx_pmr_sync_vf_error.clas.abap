CLASS /gicom/cx_pmr_sync_vf_error DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_internal_error
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        previous LIKE previous OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CX_PMR_SYNC_VF_ERROR IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    me->if_t100_message~t100key = VALUE #( msgid = '/GICOM/MSG_PMR_01' msgno = 020 ).
  ENDMETHOD.
ENDCLASS.
