CLASS /gicom/cx_no_trans_rules_short DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_not_found
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

    DATA:
        gv_message              TYPE string.

    CONSTANTS:

      BEGIN OF gc_text,
        msgid TYPE symsgid      VALUE '/GICOM/MSG_CCS_01',
        msgno TYPE symsgno      VALUE '131',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF gc_text .

  METHODS constructor
    IMPORTING
        io_previous             LIKE previous OPTIONAL.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CX_NO_TRANS_RULES_SHORT IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
   super->constructor( previous = io_previous ).

   me->if_t100_message~t100key = gc_text.

  ENDMETHOD.
ENDCLASS.
