CLASS /gicom/cx_duplicate_data DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_root_appl
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CX_DUPLICATE_DATA IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
*  IF_T100_MESSAGE~T100KEY = TEXTID.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
