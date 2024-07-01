class /GICOM/CX_SAP_CALL_ERROR definition
  public
  inheriting from /GICOM/CX_ROOT
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IV_FUNCTION_MODULE type STRING
      !IV_SUBRC type SYST_SUBRC
      !IT_BAPIRET type /GICOM/BAPIRET2_TT optional
      !IV_MSG type ABAP_BOOL optional .
  methods GET_BAPIRET
    returning
      value(RT_BAPIRET) type /GICOM/BAPIRET2_TT .
  PRIVATE SECTION.

    DATA:

      gt_bapiret TYPE /gicom/bapiret2_tt.

ENDCLASS.



CLASS /GICOM/CX_SAP_CALL_ERROR IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( ).

    IF it_bapiret IS SUPPLIED.
      me->gt_bapiret = it_bapiret.
    ENDIF.

    me->if_t100_message~t100key = VALUE #(
      msgid = '/GICOM/MSG_FOUNDAT'
      msgno = '048'
      attr1 = iv_function_module
      attr2 = iv_subrc
    ).
  ENDMETHOD.


  METHOD get_bapiret.
    rt_bapiret = me->gt_bapiret.
  ENDMETHOD.
ENDCLASS.
