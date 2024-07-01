class /GICOM/CX_ALINK_DOC_TYPE_AMB definition
  public
  inheriting from /GICOM/CX_CUSTOMIZING_ERROR
  final
  create public .

public section.

    METHODS constructor
      IMPORTING
        !iv_file_extension TYPE string
        previous LIKE previous OPTIONAL.

ENDCLASS.



CLASS /GICOM/CX_ALINK_DOC_TYPE_AMB IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    me->if_t100_message~t100key = VALUE #(
      msgid = '/GICOM/MSG_GENERAL'
      msgno = '052'
      attr1 = iv_file_extension
    ).
  ENDMETHOD.
ENDCLASS.
