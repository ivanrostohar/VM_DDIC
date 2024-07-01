CLASS /gicom/cx_no_breakdown_level DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_not_found " Choose the correct super-class
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA:

        gv_from TYPE /gicom/valid_from ,             " Define instance attributes for each text-variable of the message in your message class
        gv_to   TYPE /gicom/valid_to .             " Define instance attributes for each text-variable of the message in your message class

    CONSTANTS:

      BEGIN OF gc_text,                             " Define a message for your exception
        msgid TYPE symsgid VALUE '/GICOM/MSG_CCS_01',
        msgno TYPE symsgno VALUE '129',
        attr1 TYPE scx_attrname VALUE 'GV_FROM',      " Fill the fields attr1 through attr4 with the names of the attributes for the corresponding text-variable
        attr2 TYPE scx_attrname VALUE 'GV_TO',           " All four fields attr1 through attr4 have to be present here, even if they are empty, or the framework won't recognize it as a t100_message-key
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF gc_text .

    METHODS constructor
      IMPORTING
        io_previous LIKE previous OPTIONAL   " Think if this is necessary, io_previous might not always make sense
        iv_from     TYPE /gicom/valid_from
        iv_to       TYPE /gicom/valid_to. " Supply relevant information

ENDCLASS.



CLASS /GICOM/CX_NO_BREAKDOWN_LEVEL IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = io_previous ). " Make sure to supply io_previous to the super class
    me->gv_from = iv_from .                            " Pass information to corresponding attributes
    me->gv_to   = iv_to .                            " Pass information to corresponding attributes

    me->if_t100_message~t100key = gc_text.         " Use your constant as the message key

  ENDMETHOD.
ENDCLASS.
