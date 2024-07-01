CLASS /gicom/cx_change_cc_fatal_err DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_internal_error
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !iv_ext_guid_cc TYPE /gicom/ccs_guid
        !previous       LIKE previous OPTIONAL .

    DATA gv_ext_guid_cc TYPE /gicom/ccs_guid.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CX_CHANGE_CC_FATAL_ERR IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).
    me->if_t100_message~t100key = VALUE #( msgid = '/GICOM/MSG_CCS_01'
                                           msgno = '125'
                                           attr1 = 'gv_ext_guid_cc' ).

    me->gv_ext_guid_cc        = iv_ext_guid_cc.
    me->if_t100_dyn_msg~msgv1 = iv_ext_guid_cc.
    me->if_t100_dyn_msg~msgty = 'E'.
  ENDMETHOD.
ENDCLASS.
