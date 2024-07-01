CLASS /gicom/cx_wings_enh_error DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_root_appl
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:

      constructor
        IMPORTING
          previous TYPE REF TO cx_root OPTIONAL.
ENDCLASS.



CLASS /GICOM/CX_WINGS_ENH_ERROR IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor(
      iv_code = 499
      previous = previous
    ).

    me->if_t100_message~t100key = VALUE #(
      msgid = '/GICOM/MSG_WINGS'
      msgno = '034'
      "An error occurred while processing an enhancement.
    ).

    MESSAGE e034(/GICOM/MSG_WINGS) INTO DATA(lv_dummy) ##NEEDED.

    me->if_t100_dyn_msg~msgty = 'E'.

  ENDMETHOD.
ENDCLASS.
