CLASS /gicom/cx_to_intf_multiple_rcv DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_to_interface_root
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message.

    CONSTANTS:
      BEGIN OF gc_default,
        msgid TYPE symsgid      VALUE '/GICOM/ZK_TO_INTERF',
        msgno TYPE symsgno      VALUE 045,
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF gc_default.

    METHODS constructor
      IMPORTING
        previous  LIKE previous OPTIONAL
        is_textid LIKE if_t100_message=>t100key OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CX_TO_INTF_MULTIPLE_RCV IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    IF is_textid IS SUPPLIED.
      if_t100_message~t100key = is_textid.
    ELSE.
      if_t100_message~t100key = gc_default.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
