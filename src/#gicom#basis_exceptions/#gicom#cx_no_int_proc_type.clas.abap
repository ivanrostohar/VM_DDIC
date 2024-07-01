CLASS /gicom/cx_no_int_proc_type DEFINITION " Think of a self-explanatory name
  PUBLIC
  INHERITING FROM /gicom/cx_root " Choose the correct super-class
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA:

        gv_agrmt_id TYPE /gicom/agrmt_id .             " Define instance attributes for each text-variable of the message in your message class

    CONSTANTS:

      BEGIN OF gc_text,                             " Define a message for your exception
        msgid TYPE symsgid VALUE '/GICOM/MSG_AGRMNT_01',
        msgno TYPE symsgno VALUE '249',
        attr1 TYPE scx_attrname VALUE 'GV_AGRMT_ID',      " Fill the fields attr1 through attr4 with the names of the attributes for the corresponding text-variable
        attr2 TYPE scx_attrname VALUE '',           " All four fields attr1 through attr4 have to be present here, even if they are empty, or the framework won't recognize it as a t100_message-key
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF gc_text .

    METHODS constructor
      IMPORTING
        io_previous LIKE previous OPTIONAL   " Think if this is necessary, io_previous might not always make sense
        iv_agrmt_id TYPE /gicom/agrmt_id. " Supply relevant information

ENDCLASS.



CLASS /GICOM/CX_NO_INT_PROC_TYPE IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = io_previous ). " Make sure to supply io_previous to the super class
    me->gv_agrmt_id = iv_agrmt_id .                            " Pass information to corresponding attributes

    me->if_t100_message~t100key = gc_text.         " Use your constant as the message key

  ENDMETHOD.
ENDCLASS.
