CLASS /gicom/cx_illegal_auth_cust DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_illegal_arguments
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_user  TYPE syst_uname DEFAULT sy-uname
        previous TYPE REF TO cx_root OPTIONAL.
ENDCLASS.



CLASS /gicom/cx_illegal_auth_cust IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous  = previous ).

    me->if_t100_message~t100key = VALUE #(
      msgid = '/GICOM/MSG_FOUNDAT'
      msgno = 079
      attr1 = iv_user
    ).

    IF 1 = 2.
    " For Where-Used-List
      MESSAGE e079(/GICOM/MSG_FOUNDAT) WITH iv_user INTO DATA(lv_dummy).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
