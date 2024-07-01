CLASS /gicom/cx_bo_id_illegal_length DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_illegal_arguments
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_bo_id  TYPE /gicom/bo_id
        iv_bo_typ TYPE /gicom/bo_typ

        previous  LIKE previous OPTIONAL.

ENDCLASS.



CLASS /GICOM/CX_BO_ID_ILLEGAL_LENGTH IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    me->if_t100_message~t100key = VALUE #(
      msgid = '/GICOM/MSG_FOUNDAT'
      msgno = '046'
      attr1 = iv_bo_id
      attr2 = iv_bo_typ
    ).
  ENDMETHOD.
ENDCLASS.
