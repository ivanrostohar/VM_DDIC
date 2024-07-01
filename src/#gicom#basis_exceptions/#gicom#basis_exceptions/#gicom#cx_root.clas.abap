CLASS /gicom/cx_root DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES:

        if_t100_dyn_msg,

        /gicom/ix_http_exception,

        /gicom/ix_has_callstack.

    ALIASES:

        get_http_code   FOR /gicom/ix_http_exception~get_http_code,

        get_http_reason FOR /gicom/ix_http_exception~get_http_reason,

        get_callstack FOR /gicom/ix_has_callstack~get_callstack.

    METHODS constructor
      IMPORTING
        iv_code   TYPE /gicom/http_code DEFAULT '500'
        iv_reason TYPE /gicom/http_reason DEFAULT 'Internal Server Error'
        textid    LIKE textid OPTIONAL
        previous  LIKE previous OPTIONAL.

    " -- TODO: This method should be moved to an interface (/gicom/ix_override_exception)
    METHODS
      set_params
        IMPORTING
          iv_msg_class TYPE symsgid
          iv_msg_num   TYPE symsgno
          iv_msg_type  TYPE symsgty
          iv_msg_par1  TYPE symsgv
          iv_msg_par2  TYPE symsgv
          iv_msg_par3  TYPE symsgv
          iv_msg_par4  TYPE symsgv.

    " -- TODO: This method should be moved to an interface (/gicom/ix_override_exception)
    METHODS
      set_external_source_pos
        IMPORTING
          iv_external_program_name TYPE syrepid
          iv_external_include_name TYPE syrepid
          iv_external_source_line  TYPE i.

    METHODS
      get_source_position REDEFINITION.

  PRIVATE SECTION.

    DATA:
      gv_http_code             TYPE /gicom/http_code,
      gv_code_reason           TYPE /gicom/http_reason,

      gt_source_callstack      TYPE abap_callstack,
      gt_callstack             TYPE /gicom/abap_callstack_tt,

      gv_external_program_name TYPE syrepid,
      gv_external_include_name TYPE syrepid,
      gv_external_source_line  TYPE i.
ENDCLASS.



CLASS /GICOM/CX_ROOT IMPLEMENTATION.


  METHOD /gicom/ix_has_callstack~get_callstack.
    " Initialize the call stack lazily if it has not been initialized yet
    IF me->gt_callstack IS INITIAL AND me->gt_source_callstack IS NOT INITIAL.

      DATA ls_gicom_callstack TYPE /gicom/abap_callstack_s.
      LOOP AT me->gt_source_callstack ASSIGNING FIELD-SYMBOL(<ls_callstack>).

        ls_gicom_callstack = CORRESPONDING #( <ls_callstack> ).

        cl_oo_classname_service=>get_method_by_include(
          EXPORTING
            incname             = <ls_callstack>-include
          RECEIVING
            mtdkey              = DATA(lv_method_info)
          EXCEPTIONS
            class_not_existing  = 1
            method_not_existing = 2
            OTHERS              = 3
        ).

***********************************************************************************************************************
***  If existing add OO Details to callstack entry
***********************************************************************************************************************
        IF sy-subrc = 0.
          DATA(lv_adjusted_source_line) = /gicom/cl_util_code=>adjust_source_line(
            iv_line          = <ls_callstack>-line
            iv_clsname       = lv_method_info-clsname
            iv_include       = <ls_callstack>-include
          ).

          ls_gicom_callstack-class = lv_method_info-clsname.
          ls_gicom_callstack-method = lv_method_info-cpdname.
          ls_gicom_callstack-source_line = lv_adjusted_source_line.

        ENDIF.

        APPEND ls_gicom_callstack TO me->gt_callstack.

      ENDLOOP.
    ENDIF.

    rt_callstack = me->gt_callstack.

  ENDMETHOD.


  METHOD /gicom/ix_http_exception~get_http_code.
    rv_error_code = me->gv_http_code.
  ENDMETHOD.


  METHOD /gicom/ix_http_exception~get_http_reason.
    rv_code_reason = me->gv_code_reason.
  ENDMETHOD.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
        textid = textid
        previous = previous
    ).

    me->gv_http_code = iv_code.
    me->gv_code_reason = iv_reason.


***********************************************************************************************************************
***  Get call stack to display in UI5
***********************************************************************************************************************
    CALL FUNCTION 'SYSTEM_CALLSTACK'
      IMPORTING
        callstack = me->gt_source_callstack.
  ENDMETHOD.


  METHOD get_source_position.
    IF me->gv_external_program_name IS INITIAL AND
       me->gv_external_include_name IS INITIAL AND
       me->gv_external_source_line  IS INITIAL.

      super->get_source_position(
        IMPORTING
          program_name = program_name
          include_name = include_name
          source_line  = source_line
      ).
    ELSE.
      program_name = me->gv_external_program_name.
      include_name = me->gv_external_include_name.
      source_line  = me->gv_external_source_line.
    ENDIF.
  ENDMETHOD.


  METHOD set_external_source_pos.
    me->gv_external_program_name = iv_external_program_name.
    me->gv_external_include_name = iv_external_include_name.
    me->gv_external_source_line  = iv_external_source_line.
  ENDMETHOD.


  METHOD set_params.

    if_t100_message~t100key-msgid = iv_msg_class.
    if_t100_message~t100key-msgno = iv_msg_num.

    " Dynamic assign because the interface parameters are on R3 not existing
    ASSIGN me->('IF_T100_DYN_MSG~MSGTY') TO FIELD-SYMBOL(<lv_msgty>).
    CHECK sy-subrc EQ 0.
    <lv_msgty> = iv_msg_type.

    ASSIGN me->('IF_T100_DYN_MSG~MSGV1') TO FIELD-SYMBOL(<lv_msgv1>).
    CHECK sy-subrc EQ 0.
    <lv_msgv1> = iv_msg_par1.

    ASSIGN me->('IF_T100_DYN_MSG~MSGV2') TO FIELD-SYMBOL(<lv_msgv2>).
    CHECK sy-subrc EQ 0.
    <lv_msgv2> = iv_msg_par2.

    ASSIGN me->('IF_T100_DYN_MSG~MSGV3') TO FIELD-SYMBOL(<lv_msgv3>).
    CHECK sy-subrc EQ 0.
    <lv_msgv3> = iv_msg_par3.

    ASSIGN me->('IF_T100_DYN_MSG~MSGV4') TO FIELD-SYMBOL(<lv_msgv4>).
    CHECK sy-subrc EQ 0.
    <lv_msgv4> = iv_msg_par4.

  ENDMETHOD.
ENDCLASS.
