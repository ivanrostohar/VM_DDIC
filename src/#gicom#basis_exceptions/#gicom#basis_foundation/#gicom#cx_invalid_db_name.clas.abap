CLASS /gicom/cx_invalid_db_name DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_illegal_arguments
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_db_name TYPE /gicom/db_name

        previous  LIKE previous OPTIONAL.

ENDCLASS.



CLASS /GICOM/CX_INVALID_DB_NAME IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    me->if_t100_message~t100key = VALUE #(
      msgid = '/GICOM/MSG_FOUNDAT'
      msgno = '047'
      attr1 = iv_db_name
    ).
  ENDMETHOD.
ENDCLASS.
