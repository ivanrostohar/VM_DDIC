CLASS /gicom/cx_insert_failed DEFINITION
  PUBLIC
    INHERITING FROM /gicom/cx_db_operation_failed
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:

      constructor
        IMPORTING
          io_previous  TYPE REF TO /gicom/cx_root OPTIONAL
          iv_dbtab     TYPE /gicom/string
          iv_subrc     TYPE sysubrc.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CX_INSERT_FAILED IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( io_previous = io_previous ).

    MESSAGE
      ID '/GICOM/MSG_BASIS_DS'
      TYPE 'E'
      NUMBER '000'
      WITH
        iv_dbtab
        iv_subrc
      INTO DATA(lv_msg_dummy).

    me->if_t100_message~t100key = VALUE #(
      msgid = '/GICOM/MSG_BASIS_DS'
      msgno = '000'
      attr1 = iv_dbtab
      attr2 = iv_subrc
    ).

    me->if_t100_dyn_msg~msgty = 'E'.
  ENDMETHOD.
ENDCLASS.
