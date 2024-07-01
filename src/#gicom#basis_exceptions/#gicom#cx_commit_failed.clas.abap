CLASS /gicom/cx_commit_failed DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_database_error
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !iv_code     TYPE /gicom/http_code
        !iv_reason   TYPE /gicom/http_reason
        !textid      LIKE if_t100_message=>t100key OPTIONAL
        !previous    LIKE previous OPTIONAL
        !iv_sy_subrc TYPE syst_subrc DEFAULT sy-subrc  .

    DATA gv_sy_subrc TYPE syst_subrc.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CX_COMMIT_FAILED IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous
        iv_code = iv_code
        iv_reason = iv_reason
    ).

    me->if_t100_message~t100key = VALUE #(
      msgid = '/GICOM/MSG_GENERAL'
      msgno = '014'
      attr1 = 'GV_SY_SUBRC'
    ).

    me->gv_sy_subrc = iv_sy_subrc.
  ENDMETHOD.
ENDCLASS.
