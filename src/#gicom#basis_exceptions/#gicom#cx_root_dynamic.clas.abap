CLASS /gicom/cx_root_dynamic DEFINITION
  PUBLIC
  ABSTRACT
  INHERITING FROM cx_dynamic_check
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES:
      if_t100_dyn_msg,

      /gicom/ix_http_exception,

      /gicom/ix_has_callstack.

    ALIASES:

      get_http_code   FOR /gicom/ix_http_exception~get_http_code,

      get_http_reason FOR /gicom/ix_http_exception~get_http_reason,

      get_callstack   FOR /gicom/ix_has_callstack~get_callstack.

    METHODS:
      constructor
        IMPORTING
          iv_code   TYPE /gicom/http_code DEFAULT '500'
          iv_reason TYPE /gicom/http_reason DEFAULT 'Internal Server Error'
          textid    LIKE textid OPTIONAL
          previous  LIKE previous OPTIONAL.

  PRIVATE SECTION.

    DATA:

      gv_http_code        TYPE /gicom/http_code,

      gv_http_reason      TYPE /gicom/http_reason,

      gt_source_callstack TYPE abap_callstack,

      gt_callstack        TYPE /gicom/abap_callstack_tt.

ENDCLASS.



CLASS /GICOM/CX_ROOT_DYNAMIC IMPLEMENTATION.


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
    rv_code_reason = me->gv_http_reason.
  ENDMETHOD.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
      textid   = textid
      previous = previous
    ).

    me->gv_http_code   = iv_code.
    me->gv_http_reason = iv_reason.

    CALL FUNCTION 'SYSTEM_CALLSTACK'
      IMPORTING
        callstack = me->gt_source_callstack.
  ENDMETHOD.
ENDCLASS.
