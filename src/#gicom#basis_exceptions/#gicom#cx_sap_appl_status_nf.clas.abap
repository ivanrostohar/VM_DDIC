CLASS /gicom/cx_sap_appl_status_nf DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_not_found
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_work_status TYPE /gicom/stl_work_status
                io_previous    LIKE previous OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CX_SAP_APPL_STATUS_NF IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = io_previous ).
    me->if_t100_message~t100key = VALUE #(
    msgid = '/GICOM/MSG_APM_GENRL'
    msgno = '041'
    attr1 = iv_work_status
    ).
    me->if_t100_dyn_msg~msgty = 'E'.
  ENDMETHOD.
ENDCLASS.
