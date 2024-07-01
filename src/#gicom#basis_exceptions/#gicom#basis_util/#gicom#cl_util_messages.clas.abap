CLASS /gicom/cl_util_messages DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-DATA:
      go_instance TYPE REF TO /gicom/if_util_messages.

    INTERFACES /gicom/if_constants_util_msg .

    ALIASES cv_type_error
      FOR /gicom/if_constants_util_msg~cv_type_error .
    ALIASES cv_type_info
      FOR /gicom/if_constants_util_msg~cv_type_info .
    ALIASES cv_type_success
      FOR /gicom/if_constants_util_msg~cv_type_success .
    ALIASES cv_type_warning
      FOR /gicom/if_constants_util_msg~cv_type_warning .

    CONSTANTS cv_agreement_id TYPE /gicom/agrmt_id VALUE 'AGRMT_ID' ##NO_TEXT.
    CONSTANTS cv_sim_fragment_id TYPE /gicom/sim_frgmt_id VALUE 'FRGMT_ID' ##NO_TEXT.

    CLASS-METHODS get_instance
      RETURNING VALUE(ro_util_messages_instance) TYPE REF TO /gicom/if_util_messages.

    CLASS-METHODS inject_instance
      IMPORTING io_util_messages_instance TYPE REF TO /gicom/if_util_messages.

    CLASS-METHODS display_bapiret2
      IMPORTING
        it_bapiret2 TYPE /gicom/bapiret2_tt.

    CLASS-METHODS split_string_in_parts
      IMPORTING
        iv_string         TYPE string
        iv_lengh_per_part TYPE i
      RETURNING
        VALUE(rt_string)  TYPE /gicom/string_tt.

    CLASS-METHODS convt_exception_to_table
      IMPORTING
        !io_exception   TYPE REF TO cx_root
      RETURNING
        VALUE(rt_error) TYPE bapiret2_t .
    CLASS-METHODS convt_table_to_exception
      IMPORTING
        !it_table             TYPE bapiret2_t
        VALUE(iv_errors_only) TYPE abap_bool DEFAULT abap_true
      RETURNING
        VALUE(ro_exception)   TYPE REF TO /gicom/cx_internal_error
      RAISING
        /gicom/cx_internal_error .
    METHODS add_gicom_message
      IMPORTING
        !iv_msgid   TYPE sy-msgid
        !iv_number  TYPE sy-msgno
        !iv_par1    TYPE sy-msgv1 OPTIONAL
        !iv_par2    TYPE sy-msgv2 OPTIONAL
        !iv_par3    TYPE sy-msgv3 OPTIONAL
        !iv_par4    TYPE sy-msgv4 OPTIONAL
        !iv_type    TYPE bapireturn-type
        !is_context TYPE /gicom/appl_log_context_s .
    METHODS add_bapiret_message
      IMPORTING
        !is_message TYPE bapiret2 .
    METHODS save_appl_log
      IMPORTING
        !iv_do_commit   TYPE xflag
      EXPORTING
        !et_log_numbers TYPE bal_t_lgnm
        !ev_log_handle  TYPE balloghndl
      RAISING
        /gicom/cx_internal_error .
    METHODS constructor
      IMPORTING
        !iv_object            TYPE balobj_d OPTIONAL
        !iv_subobject         TYPE balsubobj OPTIONAL
        !iv_msgid             TYPE sy-msgid OPTIONAL
        !is_context_head      TYPE /gicom/appl_log_context_s OPTIONAL
        !iv_user_exit_log     TYPE baluef OPTIONAL
        !iv_user_exit_log_typ TYPE baluet OPTIONAL
        !iv_user_exit_msg     TYPE baluef OPTIONAL
        !iv_user_exit_msg_typ TYPE baluet OPTIONAL
        !iv_extnumber         TYPE balnrext OPTIONAL .
    CLASS-METHODS get_bapiret_from_message
      IMPORTING
        !iv_msgid         TYPE sy-msgid DEFAULT sy-msgid
        !iv_number        TYPE sy-msgno DEFAULT sy-msgno
        !iv_par1          TYPE sy-msgv1 DEFAULT sy-msgv1
        !iv_par2          TYPE sy-msgv2 DEFAULT sy-msgv2
        !iv_par3          TYPE sy-msgv3 DEFAULT sy-msgv3
        !iv_par4          TYPE sy-msgv4 DEFAULT sy-msgv4
        !iv_type          TYPE bapireturn-type DEFAULT sy-msgty
      RETURNING
        VALUE(rs_bapiret) TYPE bapiret2 .
    CLASS-METHODS get_bapiret_from_message_2
      IMPORTING
        !iv_msgid         TYPE sy-msgid DEFAULT sy-msgid
        !iv_number        TYPE sy-msgno DEFAULT sy-msgno
        !iv_par1          TYPE sy-msgv1 DEFAULT sy-msgv1
        !iv_par2          TYPE sy-msgv2 DEFAULT sy-msgv2
        !iv_par3          TYPE sy-msgv3 DEFAULT sy-msgv3
        !iv_par4          TYPE sy-msgv4 DEFAULT sy-msgv4
        !iv_type          TYPE bapireturn-type DEFAULT sy-msgty
        !iv_bo_id         TYPE /gicom/bo_id OPTIONAL
        !iv_bo_typ        TYPE /gicom/bo_typ OPTIONAL
      RETURNING
        VALUE(rs_bapiret) TYPE /gicom/bapiret2 .

    CLASS-METHODS get_bapiret_from_exception
      IMPORTING
        !io_exception      TYPE REF TO cx_root
      RETURNING
        VALUE(rs_bapiret2) TYPE bapiret2 .

    CLASS-METHODS get_bapiret_from_exception_2
      IMPORTING
        !io_exception      TYPE REF TO cx_root
        !iv_bo_id          TYPE /gicom/bo_id
        !iv_bo_typ         TYPE /gicom/bo_typ
      RETURNING
        VALUE(rs_bapiret2) TYPE /gicom/bapiret2 .

    CLASS-METHODS get_bapi_from_exception_chain
      IMPORTING
        !io_exception      TYPE REF TO cx_root
      RETURNING
        VALUE(rt_messages) TYPE /gicom/bapiret2_tt.

    CLASS-METHODS get_gic_bapiret_from_exception
      IMPORTING
        !io_exception           TYPE REF TO /gicom/cx_root
      RETURNING
        VALUE(rs_gicom_bapiret) TYPE /gicom/bapiret2 .

    CLASS-METHODS get_message_from_exception
      IMPORTING
        io_exception      TYPE REF TO cx_root
      RETURNING
        VALUE(rs_message) TYPE symsg.


    "! Create a message out of the import parameters and add the message to the given table
    "! @parameter iv_msgid | message class
    "! @parameter iv_number | message number
    "! @parameter iv_type | message type
    "! @parameter iv_par1 | message variable 1
    "! @parameter iv_par2 | message variable 2
    "! @parameter iv_par3 | message variable 3
    "! @parameter iv_par4 | message variable 4
    "! @parameter ct_message | table that has to contain the new message
    CLASS-METHODS create_and_add_msg_to_table
      IMPORTING
        !iv_msgid   TYPE sy-msgid
        !iv_number  TYPE sy-msgno
        !iv_type    TYPE bapireturn-type
        !iv_par1    TYPE sy-msgv1 OPTIONAL
        !iv_par2    TYPE sy-msgv2 OPTIONAL
        !iv_par3    TYPE sy-msgv3 OPTIONAL
        !iv_par4    TYPE sy-msgv4 OPTIONAL
      CHANGING
        !ct_message TYPE bapirettab .
    CLASS-METHODS start_message_log
      IMPORTING
        !iv_aplobj            TYPE balobj_d
        !iv_subobj            TYPE balsubobj
        !iv_collect_all       TYPE char1 DEFAULT 'X'
        !iv_user_exit_log     TYPE baluef OPTIONAL
        !iv_user_exit_log_typ TYPE baluet OPTIONAL
        !iv_user_exit_msg     TYPE baluef OPTIONAL
        !iv_user_exit_msg_typ TYPE baluet OPTIONAL
        !iv_extnumber         TYPE balnrext OPTIONAL .
    CLASS-METHODS display_message_log
      IMPORTING
        !is_display_environment TYPE /gicom/s_applog_disp_envr OPTIONAL.
    CLASS-METHODS save_message_log
      IMPORTING
        !iv_aplobj          TYPE balobj_d OPTIONAL
        !iv_subobj          TYPE balsubobj OPTIONAL
        !iv_set_update_task TYPE char1 OPTIONAL
        !iv_log_number      TYPE balognr OPTIONAL
        !iv_ext_number      TYPE balnrext OPTIONAL
      EXPORTING
        !ev_log_number      TYPE balognr
      CHANGING
        !cv_log_handle      TYPE balloghndl OPTIONAL .
    CLASS-METHODS add_message
      IMPORTING
        !iv_aplobj            TYPE balobj_d OPTIONAL
        !iv_subobj            TYPE balsubobj OPTIONAL
        !iv_user_exit_msg     TYPE baluef OPTIONAL
        !iv_user_exit_msg_typ TYPE baluet OPTIONAL
        !is_context           TYPE /gicom/applog_context_s OPTIONAL
      RAISING
        /gicom/cx_unresolved_message .
    CLASS-METHODS add_exception
      IMPORTING
        !io_exception    TYPE REF TO if_t100_message
        !iv_aplobj       TYPE balobj_d OPTIONAL
        !iv_subobj       TYPE balsubobj OPTIONAL
        !is_context      TYPE /gicom/applog_context_s OPTIONAL
        VALUE(iv_strict) TYPE abap_bool DEFAULT abap_true
      CHANGING
        !ct_error        TYPE /gicom/bapiret_tt OPTIONAL
      RAISING
        /gicom/cx_unresolved_message .
    CLASS-METHODS set_message_context
      IMPORTING
        !iv_objkey  TYPE any OPTIONAL
        !iv_docvar  TYPE any OPTIONAL
        !iv_ctxtab  TYPE any OPTIONAL
        !iv_ctxval  TYPE any OPTIONAL
        !is_context TYPE /gicom/applog_context_s OPTIONAL .
    CLASS-METHODS get_reference
      IMPORTING
        !iv_aplobj    TYPE balobj_d OPTIONAL
        !iv_subobj    TYPE balsubobj OPTIONAL
      RETURNING
        VALUE(ro_log) TYPE REF TO /gicom/cl_util_messages .
    CLASS-METHODS set_infocus_obj
      IMPORTING
        !iv_aplobj TYPE balobj_d
        !iv_subobj TYPE balsubobj
      CHANGING
        !cv_subrc  TYPE sy-subrc .
    CLASS-METHODS get_message_context
      EXPORTING
        !es_context TYPE /gicom/applog_context_s .
    CLASS-METHODS get_messages
      IMPORTING
        !iv_aplobj      TYPE balobj_d OPTIONAL
        !iv_subobj      TYPE balsubobj OPTIONAL
      EXPORTING
        !ev_json        TYPE string
        !et_messages    TYPE bal_tt_msg
        !et_bapiret_ui  TYPE /gicom/bapiret_ui_tt
        !et_ui_messages TYPE /gicom/bmsg_ui_tt
        !et_bapiret     TYPE /gicom/bapiret_tt .
    CLASS-METHODS init_messages
      IMPORTING
        !iv_aplobj   TYPE balobj_d OPTIONAL
        !iv_subobj   TYPE balsubobj OPTIONAL
        !iv_init_all TYPE char1 OPTIONAL .
    CLASS-METHODS refresh_messages .
    CLASS-METHODS error_exists
      IMPORTING
        !it_message_table      TYPE /gicom/bapiret_tt
      RETURNING
        VALUE(rv_error_exists) TYPE /gicom/abap_bool
      RAISING
        RESUMABLE(/gicom/cx_internal_error) .
    CLASS-METHODS fill_context_structure
      IMPORTING
        !iv_context_key   TYPE /gicom/applogctxtab
        !iv_context_value TYPE /gicom/applogctxval
      RETURNING
        VALUE(rs_context) TYPE /gicom/applog_context_s .
    CLASS-METHODS conv_bapiret_to_ui_msgs
      IMPORTING
        !it_bapiret     TYPE /gicom/bapiret_tt
      CHANGING
        !ct_ui_messages TYPE /gicom/bmsg_ui_tt .
    CLASS-METHODS set_message_exit
      IMPORTING
        !iv_user_exit_msg     TYPE baluef OPTIONAL
        !iv_user_exit_msg_typ TYPE baluet OPTIONAL .
    CLASS-METHODS convert_context_to_ui_struc
      IMPORTING
        !it_messages       TYPE /gicom/bapiret_ui_tt
      RETURNING
        VALUE(rt_messages) TYPE /gicom/bapiret_ui_tt .
    CLASS-METHODS convert_ui_table_to_bapiret
      IMPORTING
        !it_messages          TYPE /gicom/bmsg_ui_tt
      RETURNING
        VALUE(rt_ui_messages) TYPE /gicom/bapiret_ui_tt .
    CLASS-METHODS capture_message
      IMPORTING
        !iv_aplobj            TYPE balobj_d OPTIONAL
        !iv_subobj            TYPE balsubobj OPTIONAL
        !iv_user_exit_msg     TYPE baluef OPTIONAL
        !iv_user_exit_msg_typ TYPE baluet OPTIONAL
        !iv_msgid             TYPE sy-msgid
        !iv_number            TYPE sy-msgno
        !iv_par1              TYPE sy-msgv1 OPTIONAL
        !iv_par2              TYPE sy-msgv2 OPTIONAL
        !iv_par3              TYPE sy-msgv3 OPTIONAL
        !iv_par4              TYPE sy-msgv4 OPTIONAL
        !iv_type              TYPE bapireturn-type
        !is_context           TYPE /gicom/applog_context_s OPTIONAL .
  PROTECTED SECTION.

    DATA gt_messages TYPE /gicom/appl_log_message_tty .
    DATA gv_extnumber TYPE balnrext .
    DATA gv_object TYPE balobj_d .
    DATA gv_subobject TYPE balsubobj .
    DATA gv_prog TYPE balprog .
    DATA gs_context_head TYPE /gicom/appl_log_context_s .
    DATA gs_callback_log TYPE bal_s_clbk .
    DATA gs_callback_msg TYPE bal_s_clbk .
    DATA gv_msgid TYPE sy-msgid .


  PRIVATE SECTION.

    TYPES:
      BEGIN OF gst_local_messages,
        handle   TYPE balloghndl,
        messages TYPE bal_t_msgr,
      END OF gst_local_messages,

      gtt_local_messages TYPE SORTED TABLE OF gst_local_messages WITH UNIQUE KEY handle.

    CLASS-DATA st_local_messages TYPE gtt_local_messages.

    CLASS-DATA gv_log_handle TYPE balloghndl .
    DATA gv_infocus_aplobj TYPE balobj_d .
    DATA gv_infocus_subobj TYPE balsubobj .
    DATA gv_infocus_extnumber TYPE balnrext .
    DATA gs_context TYPE /gicom/applog_context_s .
    DATA gs_environment TYPE /gicom/applog_envr_s .
    DATA gt_log_numbers TYPE bal_t_lgnm .
    CLASS-DATA gt_log_handles TYPE /gicom/applog_handles_tt .
    CLASS-DATA go_log TYPE REF TO /gicom/cl_util_messages .
    DATA go_json_writer TYPE REF TO cl_sxml_string_writer .
    CLASS-DATA:
      gt_log_instances TYPE TABLE OF REF TO /gicom/cl_util_messages .

    CLASS-METHODS add_exception_resolve_param
      IMPORTING
        !i_exc        TYPE REF TO if_t100_message
        !i_attr       TYPE clike
      RETURNING
        VALUE(r_msgv) TYPE symsgv .


    CLASS-METHODS get_generic_exception_message
      IMPORTING
        io_exception      TYPE REF TO cx_root
      RETURNING
        VALUE(rs_message) TYPE symsg.

ENDCLASS.



CLASS /GICOM/CL_UTIL_MESSAGES IMPLEMENTATION.


  METHOD add_bapiret_message.
**
**  Author: Patrick Böhm  - gicom GmbH
**  Date:   07.12.2016
**  Mantis: 12030
**
**  Description:
**    Add table with messages into local message table
**
***********************************************************************************************************
***********************************************************************************************************
*** 0. Declarations
***********************************************************************************************************

***********************************************************************************************************
*** 1. Add message to table
***********************************************************************************************************

    me->add_gicom_message( EXPORTING iv_msgid   = is_message-id
                                     iv_number  = is_message-number
                                     iv_par1    = is_message-message_v1
                                     iv_par2    = is_message-message_v2
                                     iv_par3    = is_message-message_v3
                                     iv_par4    = is_message-message_v4
                                     iv_type    = is_message-type
                                     is_context = gs_context_head ).

  ENDMETHOD.


  METHOD add_exception.
    " -------------------------------------------------------------------------------
    " M. Andreschak, Gicom GmbH
    "
    " This method adds an given exception to the BAL using the ADD_MESSAGE method.
    " The given exception is supposed to implement IF_T100_MESSAGE, or IF_T100_DYN_MSG.
    " (HINT: basically, all /GICOM/-Exceptions do so.)
    "
    " If multiple exceptions are queued together using the 'previous'-attribute,
    " (for example after calling /GICOM/CL_UTIL_MESSAGES=>ERROR_EXISTS or
    " /GICOM/CL_UTIL_MESSAGES=>CONVT_TABLE_TO_EXCEPTION ), those exceptions
    " are added sequentially, starting with the _NEWEST_.
    "
    "ToDo: (This reversed order could be confusing for the user. Maybe we should change this methods logic?)
    "
    " If a message can not be resolved, either because it's MESSAGE_ID or MESSAGE_TYPE
    " is initial, or no BAL - that was created with the COLLECT_ALL parameter -
    " is available within the current envoirement yet, an exception
    " /GICOM/CX_UNRESOLVED_MESSAGE is raised.
    "
    " ATTENTION: This exception will itself point to the LAST PROCESSED exception,
    " REGARDLESS of wether this particular message WAS RESOLVED OR NOT.
    " Those particular messages, that actually could not be resolved, are collected in
    " CT_ERROR.
    " -------------------------------------------------------------------------------

    DATA lv_raise         TYPE        abap_bool.
    DATA lx_exception     TYPE REF TO cx_root.
    DATA lx_previous      TYPE REF TO cx_root.
    DATA lf_t100_msg      TYPE REF TO if_t100_message.
    DATA ls_symsg         TYPE        symsg.


    lx_exception ?= io_exception.

    " TODO: This needs to be reworked to probably use GET_BAPIRET_FROM_EXCEPTION to avoid code reduncancy
    WHILE lx_exception IS BOUND.
      TRY.
          "TG20180629 Quick Fix
          " Moved the following statement into the TRY block because
          " CX_SY_MOVE_CAST_ERROR is raised there in case of
          " lx_exception EQ CX_SHM_INCONSISTENT.
          " TODO: Review this fix
          lf_t100_msg  = CAST if_t100_message( lx_exception ).
          ls_symsg-msgty = COND syst-msgty( LET    lv_type = CAST if_t100_dyn_msg( lf_t100_msg )->msgty
                                            IN     WHEN ( lv_type IS NOT INITIAL )
                                                   THEN   lv_type
                                                   ELSE THROW cx_sy_move_cast_error( ) ).
        CATCH cx_sy_move_cast_error.
          ls_symsg-msgty = 'E'.
      ENDTRY.

      ASSIGN:
        lf_t100_msg->('IF_T100_MESSAGE~T100KEY-ATTR1') TO FIELD-SYMBOL(<lv_attr1>),
        lf_t100_msg->('IF_T100_MESSAGE~T100KEY-ATTR2') TO FIELD-SYMBOL(<lv_attr2>),
        lf_t100_msg->('IF_T100_MESSAGE~T100KEY-ATTR3') TO FIELD-SYMBOL(<lv_attr3>),
        lf_t100_msg->('IF_T100_MESSAGE~T100KEY-ATTR4') TO FIELD-SYMBOL(<lv_attr4>).

      IF <lv_attr1> IS ASSIGNED.
        ls_symsg-msgv1 = add_exception_resolve_param( i_exc  = lf_t100_msg
                                                      i_attr = <lv_attr1> ).
      ENDIF.

      IF <lv_attr2> IS ASSIGNED.
        ls_symsg-msgv2 = add_exception_resolve_param(  i_exc  = lf_t100_msg
                                                       i_attr = <lv_attr2> ).
      ENDIF.

      IF <lv_attr3> IS ASSIGNED.
        ls_symsg-msgv3 = add_exception_resolve_param(  i_exc  = lf_t100_msg
                                                       i_attr = <lv_attr3> ).
      ENDIF.

      IF <lv_attr4> IS ASSIGNED.
        ls_symsg-msgv4 = add_exception_resolve_param(  i_exc  = lf_t100_msg
                                                       i_attr = <lv_attr4> ).
      ENDIF.

      TRY.
          ls_symsg = COND symsg( LET given    = CORRESPONDING symsg( lf_t100_msg->t100key        )
                                     fallback = VALUE symsg( msgid = lf_t100_msg->default_textid-msgid
                                                             msgno = 467
                                                             msgv1 = cl_abap_classdescr=>get_class_name( lx_exception ) )
                                 IN WHEN given IS NOT INITIAL
                                    THEN CORRESPONDING #( BASE ( ls_symsg )  given      EXCEPT msgty msgv1 msgv2 msgv3 msgv4 )
                                    ELSE CORRESPONDING #( BASE ( ls_symsg )  fallback   EXCEPT msgty ) ).

          MESSAGE ID     ls_symsg-msgid
                  TYPE   ls_symsg-msgty
                  NUMBER ls_symsg-msgno
                  WITH   ls_symsg-msgv1 ls_symsg-msgv2 ls_symsg-msgv3 ls_symsg-msgv4
                  INTO DATA(lv_dummy).


          /gicom/cl_util_messages=>add_message(
            EXPORTING
              iv_aplobj               = iv_aplobj
              iv_subobj               = iv_subobj
              is_context              = is_context
            EXCEPTIONS
              OTHERS                  = 1
          ).

        CATCH /gicom/cx_unresolved_message.
          lv_raise = abap_true.

          " Meh...
          ASSERT lx_exception IS INSTANCE OF /gicom/cx_root.

          APPEND CORRESPONDING #( get_bapiret_from_exception( CAST #( lx_exception ) ) )
              TO ct_error.
      ENDTRY.

      lx_exception = lx_exception->previous.
    ENDWHILE.

    IF lv_raise IS NOT INITIAL.
      RAISE EXCEPTION TYPE /gicom/cx_unresolved_message
        EXPORTING
          previous = lx_exception.
    ENDIF.
  ENDMETHOD.


  METHOD add_exception_resolve_param.
    DATA lx_exception     TYPE REF TO cx_root.
    IF i_exc IS BOUND.
      lx_exception ?= i_exc.
    ENDIF.

    IF  i_attr       IS NOT INITIAL
    AND lx_exception IS BOUND.
      ASSIGN lx_exception->(i_attr) TO FIELD-SYMBOL(<lv_attr_val>).

      IF <lv_attr_val> IS ASSIGNED
      AND cl_abap_typedescr=>describe_by_data( <lv_attr_val> )->kind = cl_abap_typedescr=>kind_elem.
        r_msgv = <lv_attr_val>.
      ENDIF.

      UNASSIGN <lv_attr_val>.
    ENDIF.
  ENDMETHOD.


  METHOD add_gicom_message.
**
**  Author: Patrick Böhm  - gicom GmbH
**  Date:   28.11.2016
**  Mantis: 12030
**
**  Description:
**    Creation and adding an message to table
**
***********************************************************************************************************
***********************************************************************************************************
*** 0. Delarations
***********************************************************************************************************
    DATA: ls_bapiret2 TYPE bapiret2,
          ls_message  TYPE /gicom/appl_log_message_s,
          lv_msgid    TYPE sy-msgid.

***********************************************************************************************************
*** 1. Create message
***********************************************************************************************************
    IF iv_msgid IS NOT INITIAL.
      lv_msgid  = iv_msgid.
    ELSE.
      lv_msgid  = gv_msgid.
    ENDIF.

    /gicom/cl_sap_standard=>balw_bapireturn_get2(
       EXPORTING
         iv_type   = iv_type
         iv_cl     = lv_msgid
         iv_number = iv_number
         iv_par1   = iv_par1
         iv_par2   = iv_par2
         iv_par3   = iv_par3
         iv_par4   = iv_par4
       IMPORTING
         es_return = ls_bapiret2 ).

    ls_message-bapiret2 = ls_bapiret2.
    ls_message-context  = is_context.

***********************************************************************************************************
*** 2. Add entry to table
***********************************************************************************************************
    APPEND ls_message TO gt_messages.

  ENDMETHOD.


  METHOD add_message.
***********************************************************************
*                      METHOD ADD_MESSAGE                             *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :                                                     *
*  Mantis       :   12232                                             *
*                                                                     *
*  Description  :   Add Message                                       *
*                                                                     *
***********************************************************************
    DATA: ls_bal_msg     TYPE bal_s_msg,

          lwa_log_handle TYPE /gicom/applog_handles_s,

          lo_log         TYPE REF TO /gicom/cl_util_messages.

    FIELD-SYMBOLS: <lwa_msg> TYPE bal_s_msg.


    IF  iv_aplobj IS NOT INITIAL
    AND iv_subobj IS NOT INITIAL.

      lo_log ?= /gicom/cl_util_messages=>get_reference( iv_aplobj = iv_aplobj
                                                        iv_subobj = iv_subobj ).

      READ TABLE gt_log_handles INTO lwa_log_handle
            WITH KEY aplobj = iv_aplobj
                     subobj = iv_subobj.

    ELSEIF NOT iv_aplobj IS INITIAL AND
               iv_subobj IS INITIAL.

      lo_log ?= /gicom/cl_util_messages=>get_reference( iv_aplobj = iv_aplobj ).

      READ TABLE gt_log_handles INTO lwa_log_handle
        WITH KEY aplobj = iv_aplobj
                 subobj = space.

    ELSE.
      lo_log ?= /gicom/cl_util_messages=>get_reference( ).

      READ TABLE gt_log_handles INTO lwa_log_handle
            WITH KEY aplobj = lo_log->gv_infocus_aplobj
                     subobj = lo_log->gv_infocus_subobj.

    ENDIF.


    IF lo_log->gs_environment-collect_all = space.
      IF sy-cprog = 'SAPMSSYC'.
        "SMO --> nothing
        RETURN.
      ELSEIF sy-batch = 'X' OR sy-cprog = 'SAPMHTTP' OR sy-cprog CS 'RS_AUNIT_SBOX'.
        RAISE EXCEPTION TYPE /gicom/cx_unresolved_message
          MESSAGE ID sy-msgid
          TYPE sy-msgty
          NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ELSE.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
           WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
    ENDIF.

    IF sy-subrc = 0.

      gv_log_handle = lwa_log_handle-handle.

      ls_bal_msg-msgid = sy-msgid.
      ls_bal_msg-msgty = sy-msgty.
      ls_bal_msg-msgno = sy-msgno.
      ls_bal_msg-msgv1 = sy-msgv1.
      ls_bal_msg-msgv2 = sy-msgv2.
      ls_bal_msg-msgv3 = sy-msgv3.
      ls_bal_msg-msgv4 = sy-msgv4.

*    Set sorting and problem class
      CASE ls_bal_msg-msgty.
        WHEN 'S'.
          ls_bal_msg-probclass  = space.  "other
          ls_bal_msg-alsort     = '5'.
        WHEN 'I' .
          ls_bal_msg-probclass  = '4'.    "additional information
          ls_bal_msg-alsort     = '1'.
        WHEN 'W'.
          ls_bal_msg-probclass  = '3'.    "medium
          ls_bal_msg-alsort     = '4'.
        WHEN 'E'.
          ls_bal_msg-probclass  = '2'.     "important
          ls_bal_msg-alsort     = '3'.
        WHEN 'A' OR 'X'.
          ls_bal_msg-probclass  = '1'.     "very important
          ls_bal_msg-alsort     = '2'.
      ENDCASE.

      "Context data
      IF is_context IS INITIAL.
        ls_bal_msg-context-tabname = lo_log->gs_context-ctxtab.
        ls_bal_msg-context-value = lo_log->gs_context-ctxval.
      ELSE.

        ls_bal_msg-context-tabname = is_context-ctxtab.
        ls_bal_msg-context-value = is_context-ctxval.

      ENDIF.

      IF iv_user_exit_msg IS INITIAL AND iv_user_exit_msg_typ IS INITIAL.
        ls_bal_msg-params-callback-userexitf = lo_log->gs_callback_msg-userexitf.
        ls_bal_msg-params-callback-userexitt = lo_log->gs_callback_log-userexitt.
      ELSE.
        ls_bal_msg-params-callback-userexitf = iv_user_exit_msg.
        ls_bal_msg-params-callback-userexitt = iv_user_exit_msg_typ.
      ENDIF.

      TRY.
          IF NOT /gicom/cl_aunit_utilities=>is_unit_test_active( ).
            /gicom/cl_sap_appl_log=>bal_log_msg_add(
              iv_log_handle = gv_log_handle
              is_msg        = ls_bal_msg
            ).

          ELSE.
            ASSIGN /gicom/cl_util_messages=>st_local_messages[ handle = gv_log_handle ] TO FIELD-SYMBOL(<ls_local_messages>).

            IF <ls_local_messages> IS NOT ASSIGNED.
              DATA ls_local_message TYPE gst_local_messages.
              ls_local_message-handle = gv_log_handle.
              INSERT ls_local_message INTO TABLE /gicom/cl_util_messages=>st_local_messages.
              ASSIGN /gicom/cl_util_messages=>st_local_messages[ handle = gv_log_handle ] TO <ls_local_messages>.
            ENDIF.

            INSERT VALUE #(
              msgnumber = ls_bal_msg-msgno
              msgty     = ls_bal_msg-msgty
              msgid     = ls_bal_msg-msgid
              msgno     = ls_bal_msg-msgno
              msgv1     = ls_bal_msg-msgv1
              msgv2     = ls_bal_msg-msgv2
              msgv3     = ls_bal_msg-msgv3
              msgv4     = ls_bal_msg-msgv4
              msgv1_src = ls_bal_msg-msgv1_src
              msgv2_src = ls_bal_msg-msgv2_src
              msgv3_src = ls_bal_msg-msgv3_src
              msgv4_src = ls_bal_msg-msgv4_src
              detlevel  = ls_bal_msg-detlevel
              probclass = ls_bal_msg-probclass
              alsort    = ls_bal_msg-alsort
              time_stmp = ls_bal_msg-time_stmp
              msg_count = ls_bal_msg-msg_count
              context   = ls_bal_msg-context
              params    = ls_bal_msg-params
            ) INTO TABLE <ls_local_messages>-messages ASSIGNING FIELD-SYMBOL(<ls_temp>).

          ENDIF.

        CATCH /gicom/cx_sap_call_error.
          IF  sy-msgid IS NOT INITIAL
          AND sy-msgty IS NOT INITIAL
          AND sy-msgno IS NOT INITIAL.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO sy-msgli.
          ENDIF.

      ENDTRY.

    ELSE.
      IF sy-batch = 'X' OR sy-cprog = 'SAPMHTTP' OR sy-cprog CS 'RS_AUNIT_SBOX'.
        RAISE EXCEPTION TYPE /gicom/cx_unresolved_message
          MESSAGE ID sy-msgid
          TYPE sy-msgty
          NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ELSE.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD split_string_in_parts.
    rt_string = /gicom/cl_sap_standard=>split_string_in_parts(
      EXPORTING
        iv_string         = iv_string
        iv_lengh_per_part = iv_lengh_per_part
    ).
  ENDMETHOD.


  METHOD constructor.
**
**  Author: Patrick Böhm  - gicom GmbH
**  Date:   12.12.2016
**  Mantis: 12030
**
**  Description:
**    Initialization of variables
**
***********************************************************************************************************
***********************************************************************************************************
*** 0. Declarations
***********************************************************************************************************
    gv_object                 = iv_object.

* ApplicationLog subobject
    gv_subobject              = iv_subobject.

* Message class
    gv_msgid                  = iv_msgid.

* program name, who creates log
    gv_prog                   = sy-repid.

* Callback for log
    gs_callback_log-userexitf = iv_user_exit_log.
    gs_callback_log-userexitt = iv_user_exit_log_typ.

* Callback for message
    gs_callback_msg-userexitf = iv_user_exit_msg.
    gs_callback_msg-userexitt = iv_user_exit_msg_typ.

* Log-Header context
    gs_context_head           = is_context_head.

* Log - external identification number
    IF iv_extnumber IS NOT INITIAL.
      gv_extnumber              = iv_extnumber.
    ENDIF.

  ENDMETHOD.


  METHOD fill_context_structure.

    rs_context-ctxtab = iv_context_key.
    rs_context-ctxval = iv_context_value.

  ENDMETHOD.


  METHOD capture_message.


    "******************************************************************************************************************
    "***    Convert message into text format
    "******************************************************************************************************************
    MESSAGE ID iv_msgid
       TYPE iv_type NUMBER iv_number
       WITH iv_par1 iv_par2 iv_par3 iv_par4
       INTO sy-msgli.


    "******************************************************************************************************************
    "Add message
    "******************************************************************************************************************
    TRY.
        /gicom/cl_util_messages=>add_message(
          EXPORTING
            iv_aplobj            = iv_aplobj
            iv_subobj            = iv_subobj
            iv_user_exit_msg     = iv_user_exit_msg
            iv_user_exit_msg_typ = iv_user_exit_msg_typ
            is_context           = is_context
        ).
      CATCH /gicom/cx_unresolved_message.
    ENDTRY.

  ENDMETHOD.


  METHOD convt_exception_to_table.
    DATA lx_exception TYPE REF TO cx_root.

    lx_exception = io_exception.

    WHILE lx_exception IS BOUND.
      APPEND get_bapiret_from_exception( CAST #( lx_exception ) ) TO rt_error.
      lx_exception = lx_exception->previous.
    ENDWHILE.
  ENDMETHOD.


  METHOD convt_table_to_exception.
    DATA lx_tf100_message  TYPE REF TO   /gicom/cx_internal_error.
    DATA lx_tf100_previous TYPE REF TO   /gicom/cx_internal_error.

    CHECK it_table IS NOT INITIAL.


    "------------------------------------------------------------------------------
    " Look for an error message in the given table
    "------------------------------------------------------------------------------
    LOOP AT it_table INTO DATA(ls_message).
      IF  iv_errors_only IS NOT INITIAL
      AND ls_message-type NA 'XEA'.
        CONTINUE.
      ENDIF.

      IF  ls_message-id      IS INITIAL
      AND ls_message-number  IS INITIAL
      AND ls_message-message IS NOT INITIAL.
        TRY.
            ls_message-id      = 'BL'.
            ls_message-number  = '001'.
            ls_message-message_v1  = ls_message-message+0(50)  .
            ls_message-message_v2  = ls_message-message+50(50) .
            ls_message-message_v3  = ls_message-message+100(50).
            ls_message-message_v4  = ls_message-message+150(50).
          CATCH cx_sy_range_out_of_bounds.
            ##NO_HANDLER
        ENDTRY.
      ENDIF.

      DATA(lv_type) = COND char1( WHEN ls_message-type IS NOT INITIAL THEN ls_message-type ELSE 'S' ).

      "----------------------------------------------------------------------------
      " Wrap BAPIRET-Message into Exception
      "----------------------------------------------------------------------------
      TRY.
          RAISE EXCEPTION TYPE /gicom/cx_internal_error
            MESSAGE ID ls_message-id
            TYPE lv_type
            NUMBER ls_message-number
            WITH
            ls_message-message_v1 ls_message-message_v2
            ls_message-message_v3 ls_message-message_v4
            EXPORTING
              previous = lx_tf100_previous.

        CATCH /gicom/cx_internal_error INTO lx_tf100_message.
          lx_tf100_previous = lx_tf100_message.
          ro_exception      = lx_tf100_message.
      ENDTRY.
    ENDLOOP.

    "------------------------------------------------------------------------------
    " Raise
    "------------------------------------------------------------------------------
    IF sy-subrc = 0.
      " Do we want to try/catch this? or rather get it
      IF ro_exception IS NOT SUPPLIED.
        RAISE EXCEPTION ro_exception.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD conv_bapiret_to_ui_msgs.
***********************************************************************
*                      METHOD CONV_BAPIRET_TO_UI_MSGS                 *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :                                                     *
*  Mantis       :   12232                                             *
*                                                                     *
*  Description  :   Convert Bapiret to UI Messages                    *
*                                                                     *
***********************************************************************

    DATA: lwa_ui_msg TYPE /gicom/bmsg_ui_s.
    CHECK it_bapiret IS NOT INITIAL.

    LOOP AT it_bapiret INTO DATA(lwa_bapiret).
      MOVE-CORRESPONDING lwa_bapiret TO lwa_ui_msg.
      APPEND lwa_ui_msg TO ct_ui_messages.
    ENDLOOP.

  ENDMETHOD.


  METHOD create_and_add_msg_to_table.
**
**  Author: Patrick Böhm - gicom GmbH
**  Date:   18.01.2017
**  Mantis:
**
**  Description:
**    Create and add a bapiret2-Message to the table
**
***********************************************************************************************************
***********************************************************************************************************
*** 0. Declarations
***********************************************************************************************************

***********************************************************************************************************
*** 1. create message
***********************************************************************************************************

    DATA(ls_bapiret) = /gicom/cl_util_messages=>get_bapiret_from_message(
                       iv_msgid   = iv_msgid
                       iv_number  = iv_number
                       iv_par1    = iv_par1
                       iv_par2    = iv_par2
                       iv_par3    = iv_par3
                       iv_par4    = iv_par4
                       iv_type    = iv_type
                   ).


***********************************************************************************************************
*** 2. Add message to table
***********************************************************************************************************

    APPEND ls_bapiret TO ct_message.

  ENDMETHOD.


  METHOD display_message_log.
***********************************************************************
*                      METHOD DISPLAY_MESSAGE_LOG                     *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :                                                     *
*  Mantis       :   12232                                             *
*                                                                     *
*  Description  :   Display Messages                                  *
*                                                                     *
***********************************************************************

    DATA: lv_tabname         TYPE tabname,

          ls_display_profile TYPE bal_s_prof,

          lwa_fcat           TYPE lvc_s_fcat,
          lwa_bal_fcat       TYPE bal_s_fcat,
          lwa_log_handle     TYPE /gicom/applog_handles_s,

          lt_messages        TYPE bal_t_msgr,
          lt_log_handles     TYPE bal_t_logh,
          lt_fcat            TYPE lvc_t_fcat,

          lo_log             TYPE REF TO /gicom/cl_util_messages.

    "Get refreance of the message engine
    lo_log ?=  /gicom/cl_util_messages=>get_reference( ).

    IF lo_log IS BOUND.
      "Get the details for current context
      READ TABLE gt_log_handles INTO lwa_log_handle
            WITH KEY handle = gv_log_handle.

      IF sy-subrc = 0.

        TRY.
            /gicom/cl_sap_appl_log=>bal_log_read(
              EXPORTING
                iv_log_handle  = gv_log_handle
              IMPORTING
                et_msg        = lt_messages ).

          CATCH /gicom/cx_sap_call_error.
            CLEAR lt_messages.

        ENDTRY.

        IF  sy-subrc = 0
        AND lt_messages IS NOT INITIAL.

          "Get the display profile parameters
          /gicom/cl_sap_appl_log=>bal_dsp_profile_popup_get(
            IMPORTING
              es_display_profile = ls_display_profile
            EXCEPTIONS
              OTHERS              = 1 ).

          IF  sy-subrc <> 0
          AND sy-msgid IS NOT INITIAL
          AND sy-msgty IS NOT INITIAL
          AND sy-msgno IS NOT INITIAL.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          ENDIF.

          "Set the additional parameters for Display profile
          ls_display_profile-use_grid = abap_true.
          ls_display_profile-disvariant-report = sy-repid.
          ls_display_profile-disvariant-handle = 'LOG'.

          "Set the context details to current log
          IF NOT lo_log->gs_context IS INITIAL.

            lv_tabname = lo_log->gs_context-ctxtab.

            TRY.
                /gicom/cl_sap_standard=>lvc_fieldcatalog_merge(
                  EXPORTING
                    iv_structure_name      = lv_tabname
                  CHANGING
                    ct_fieldcat            = lt_fcat ).
              CATCH /gicom/cx_sap_call_error.
                " no exception, just default in error case
                CLEAR lt_fcat.
            ENDTRY.

            IF sy-subrc = 0.
              LOOP AT lt_fcat INTO lwa_fcat.
                lwa_bal_fcat-ref_table = lv_tabname.
                lwa_bal_fcat-ref_field = lwa_fcat-fieldname.
                lwa_bal_fcat-col_pos = lwa_fcat-col_pos.
                APPEND lwa_bal_fcat TO ls_display_profile-mess_fcat.
              ENDLOOP.
            ENDIF.

          ENDIF.

          INSERT gv_log_handle INTO TABLE lt_log_handles.

          "Display the Log

          TRY.
              /gicom/cl_sap_appl_log=>bal_dsp_log_display( is_display_profile = ls_display_profile
                                                           it_log_handle      = lt_log_handles ).

            CATCH /gicom/cx_sap_call_error.
              IF  sy-msgid IS NOT INITIAL
              AND sy-msgty IS NOT INITIAL
              AND sy-msgno IS NOT INITIAL.
                MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                   WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
              ENDIF.

          ENDTRY.

          TRY.
              /gicom/cl_sap_appl_log=>bal_glb_memory_refresh( iv_refresh_all            = space
                                                              it_logs_to_be_refreshed   = lt_log_handles ).

            CATCH /gicom/cx_sap_call_error.

          ENDTRY.

          CLEAR: lo_log->gs_context.

        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD error_exists.
    "------------------------------------------------------------------------------
    " This method checks, whether there is an error message inside the given
    " internal table. A message is considered to be an error message, when
    " its type is 'A', 'E', 'X'.
    "
    " The method either returns a boolean flag ( 'X' = Error Messages found,
    "  ' ' = No Error Messages found ), in case this return parameter is requested
    " by the calling programm. Otherwise, it raises an Exception
    " /GICOM/CX_INTERNAL_ERROR containing the Error message.
    "
    " This Exception implements IF_T100_DYN_MSG. Therefore, it can be used directly
    " with the MESSAGE statement. If multiple errors are given with the internal
    " table, they will be wrapped into a 'queued exception':
    " In this case, an exception points to its predecessors using the PREVIOUS attribute.
    "
    " Hint: Exceptions raised by this method (or basically any other exception
    " implementing IF_T100_MSG) can be added to the BAL using ADD_EXCEPTION( ... ).
    "------------------------------------------------------------------------------
    DATA lx_tf100_message  TYPE REF TO   /gicom/cx_internal_error.
    DATA lx_tf100_previous TYPE REF TO   /gicom/cx_internal_error.

    "------------------------------------------------------------------------------
    " Look for an error message in the given table
    "------------------------------------------------------------------------------
    DATA(lt_error_table) = VALUE bapiret2_t( FOR each_line IN it_message_table  WHERE ( type = 'E' OR type = 'A' OR type = 'X' )
                                    ( CORRESPONDING #( each_line ) )
                           ).
    "------------------------------------------------------------------------------
    " Wrap into exception
    "------------------------------------------------------------------------------
    IF lt_error_table IS NOT INITIAL.
      IF rv_error_exists IS NOT SUPPLIED.
        /gicom/cl_util_messages=>convt_table_to_exception( lt_error_table ).
      ELSE.
        rv_error_exists = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD convert_ui_table_to_bapiret.
    DATA: ls_ui_table     TYPE /gicom/bapiret_ui_s,
          lt_ui_table     TYPE /gicom/bapiret_ui_tt,
          ls_ui_key_value TYPE /gicom/key_value_string_s.

    LOOP AT it_messages INTO DATA(lwa_messages).
      CLEAR ls_ui_table.
      MOVE-CORRESPONDING lwa_messages TO ls_ui_table.
      IF lwa_messages-context IS NOT INITIAL.
        ls_ui_key_value-key = CONV #( lwa_messages-context-tabname ).
        ls_ui_key_value-value = CONV #( lwa_messages-context-value ).
        APPEND ls_ui_key_value TO ls_ui_table-ui_info.
      ENDIF.

      APPEND ls_ui_table TO rt_ui_messages.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_bapiret_from_exception.
**
**  Author:  Nikolas Heitkamp - gicom GmbH
**  Date:   02.12.2016
**  Mantis:
**
**  Description:
**    Get BAPIRET-Message out of an exception
**
***********************************************************************************************************
***********************************************************************************************************
*** 0. Declarations
***********************************************************************************************************
    DATA: lv_par1 TYPE sy-msgv1,
          lv_par2 TYPE sy-msgv2,
          lv_par3 TYPE sy-msgv3,
          lv_par4 TYPE sy-msgv4.

***********************************************************************************************************
*** 1.  Extract BAPIRET
***********************************************************************************************************
    IF io_exception IS INSTANCE OF if_t100_message.
      DATA(ls_message) = /gicom/cl_util_messages=>get_message_from_exception( io_exception ).

      /gicom/cl_sap_standard=>balw_bapireturn_get2(
        EXPORTING
          iv_type   = ls_message-msgty
          iv_cl     = ls_message-msgid
          iv_number = ls_message-msgno
          iv_par1   = ls_message-msgv1
          iv_par2   = ls_message-msgv2
          iv_par3   = ls_message-msgv3
          iv_par4   = ls_message-msgv4
        IMPORTING
          es_return = rs_bapiret2
      ).

    ELSE.

      DATA(ls_message_exc) = /gicom/cl_util_messages=>get_generic_exception_message( io_exception ).

      /gicom/cl_sap_standard=>balw_bapireturn_get2(
        EXPORTING
          iv_type   = ls_message_exc-msgty
          iv_cl     = ls_message_exc-msgid
          iv_number = ls_message_exc-msgno
          iv_par1   = ls_message_exc-msgv1
          iv_par2   = ls_message_exc-msgv2
          iv_par3   = ls_message_exc-msgv3
          iv_par4   = ls_message_exc-msgv4
        IMPORTING
          es_return = rs_bapiret2 ).

    ENDIF.

  ENDMETHOD.


  METHOD get_message_from_exception.
    IF io_exception IS INSTANCE OF if_t100_dyn_msg.
      DATA(lo_dyn_msg) = CAST if_t100_dyn_msg( io_exception ).

      " This might be empty
      IF lo_dyn_msg->msgty IS NOT INITIAL.
        rs_message = VALUE #(
          msgid = lo_dyn_msg->if_t100_message~t100key-msgid
          msgno = lo_dyn_msg->if_t100_message~t100key-msgno
          msgty = lo_dyn_msg->msgty
          msgv1 = lo_dyn_msg->msgv1
          msgv2 = lo_dyn_msg->msgv2
          msgv3 = lo_dyn_msg->msgv3
          msgv4 = lo_dyn_msg->msgv4
        ).

        RETURN.
      ENDIF.
    ENDIF.

    " Otherwise, if we are either not a dyn_msg or the dyn_msg fields are emtpy,
    " we -try- to look for the values by assigning the field(s).
    IF io_exception IS INSTANCE OF if_t100_message.
      DATA(lo_t100_msg) = CAST if_t100_message( io_exception ).

      IF lo_t100_msg->t100key-msgid IS NOT INITIAL.

        " Fill the structure initially
        rs_message = VALUE #(
          msgid = lo_t100_msg->t100key-msgid
          msgno = lo_t100_msg->t100key-msgno
          msgty = 'E'
        ).

        " First, we try to assign the fields by attribute name
        ASSIGN io_exception->(lo_t100_msg->t100key-attr1) TO FIELD-SYMBOL(<lv_attr1>).
        ASSIGN io_exception->(lo_t100_msg->t100key-attr2) TO FIELD-SYMBOL(<lv_attr2>).
        ASSIGN io_exception->(lo_t100_msg->t100key-attr3) TO FIELD-SYMBOL(<lv_attr3>).
        ASSIGN io_exception->(lo_t100_msg->t100key-attr4) TO FIELD-SYMBOL(<lv_attr4>).

        " If this did not work, we have some old-school gicom thingy and we use the
        " attribute field as a value.
        IF <lv_attr1> IS NOT ASSIGNED.
          ASSIGN lo_t100_msg->t100key-attr1 TO <lv_attr1>.
        ENDIF.

        IF <lv_attr2> IS NOT ASSIGNED.
          ASSIGN lo_t100_msg->t100key-attr2 TO <lv_attr2>.
        ENDIF.

        IF <lv_attr3> IS NOT ASSIGNED.
          ASSIGN lo_t100_msg->t100key-attr3 TO <lv_attr3>.
        ENDIF.

        IF <lv_attr4> IS NOT ASSIGNED.
          ASSIGN lo_t100_msg->t100key-attr4 TO <lv_attr4>.
        ENDIF.

        " Try to move the fields to the structure, clearing if it cannot be moved
        TRY.
            rs_message-msgv1 = CONV #( <lv_attr1> ).

          CATCH cx_root.
            CLEAR rs_message-msgv1.

        ENDTRY.

        TRY.
            rs_message-msgv2 = CONV #( <lv_attr2> ).

          CATCH cx_root.
            CLEAR rs_message-msgv2.

        ENDTRY.

        TRY.
            rs_message-msgv3 = CONV #( <lv_attr3> ).

          CATCH cx_root.
            CLEAR rs_message-msgv3.

        ENDTRY.

        TRY.
            rs_message-msgv4 = CONV #( <lv_attr4> ).

          CATCH cx_root.
            CLEAR rs_message-msgv4.

        ENDTRY.

        RETURN.
      ENDIF.
    ENDIF.

    " In all other cases, there is no message here so we set the "Unhandled exception [class name]".
    rs_message = /gicom/cl_util_messages=>get_generic_exception_message( io_exception ).

  ENDMETHOD.


  METHOD get_bapiret_from_message.

    DATA: ls_return_temp TYPE bapiret2.

    /gicom/cl_sap_standard=>balw_bapireturn_get2(
      EXPORTING
        iv_type   = iv_type
        iv_cl     = iv_msgid
        iv_number = iv_number
        iv_par1   = iv_par1
        iv_par2   = iv_par2
        iv_par3   = iv_par3
        iv_par4   = iv_par4
      IMPORTING
        es_return = rs_bapiret ).

***********************************************************************************************************************
***  Read long text and add to bapiret if available
***********************************************************************************************************************
    DATA lt_text TYPE STANDARD TABLE OF bapitgb.
    DATA lv_long_text TYPE string.
    DATA lv_message TYPE bapi_msg .
    CLEAR: lt_text, ls_return_temp.

    /gicom/cl_sap_standard=>bapi_message_getdetail(
      EXPORTING
        iv_id         = iv_msgid
        iv_number     = iv_number
        iv_textformat = 'ASC'
        iv_message_v1 = iv_par1
        iv_message_v2 = iv_par2
        iv_message_v3 = iv_par3
        iv_message_v4 = iv_par4
      IMPORTING
        es_return     = ls_return_temp
        ev_message    = lv_message
      CHANGING
        ct_text       = lt_text ).

    IF lines( lt_text ) GT 0 AND ls_return_temp-type NE 'E'.

      TRY.
          /gicom/cl_sap_conversion=>swa_string_from_table(
          EXPORTING
            it_character_table            = lt_text
            iv_keep_trailing_spaces       = space
          IMPORTING
            ev_character_string           = lv_long_text ).

        CATCH /gicom/cx_sap_call_error.
          CLEAR lv_long_text.
      ENDTRY.

      IF lv_long_text IS NOT INITIAL.
        " Quick fix incoming. The width of the lt_table is char(255) which means the SAP function module concatenates each line in the table together
        " ensuring that each line still has the 255 char length even if one line might be way shorter.  ty SAP 👏
        REPLACE ALL OCCURRENCES OF REGEX `[ ]{2,}` IN lv_long_text WITH ` `.

        " Now we replace the placeholder values with the real values for easier consumption in UI5
        REPLACE ALL OCCURRENCES OF '&1' IN lv_long_text WITH iv_par1.
        REPLACE ALL OCCURRENCES OF '&2' IN lv_long_text WITH iv_par2.
        REPLACE ALL OCCURRENCES OF '&3' IN lv_long_text WITH iv_par3.
        REPLACE ALL OCCURRENCES OF '&4' IN lv_long_text WITH iv_par4.

        rs_bapiret-message = lv_long_text. " The long text also contains the "non long text text"

        IF NOT rs_bapiret-message CS lv_message.
          rs_bapiret-message = |{ lv_message } { rs_bapiret-message }|.
        ENDIF.

      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD get_bapiret_from_exception_2.
    rs_bapiret2 = /gicom/cl_util_messages=>get_bapiret_from_exception( io_exception = io_exception ).
    rs_bapiret2-bo_id = iv_bo_id.
    rs_bapiret2-bo_type = iv_bo_typ.
  ENDMETHOD.


  METHOD get_gic_bapiret_from_exception.
**
**  Author: Patrick Böhm - gicom GmbH
**  Date:   02.12.2016
**  Mantis:
**
**  Description:
**    get gicom BAPIRET-Message out of an exception
**
***********************************************************************************************************
***********************************************************************************************************
*** 0. Declarations
***********************************************************************************************************

    DATA: ls_bapiret TYPE bapiret2.

***********************************************************************************************************
*** 1.  Extract BAPIRET
***********************************************************************************************************

    ls_bapiret = /gicom/cl_util_messages=>get_bapiret_from_exception( io_exception = io_exception ).

    /gicom/cl_util_table=>move_structure(
      EXPORTING
        is_source      = ls_bapiret
      IMPORTING
        es_destination = rs_gicom_bapiret
    ).

***********************************************************************************************************
*** 2.  Get Exception class name
***********************************************************************************************************

    rs_gicom_bapiret-ex_class_name = cl_abap_classdescr=>get_class_name( p_object = io_exception ).

  ENDMETHOD.


  METHOD get_messages.
***********************************************************************
*                      METHOD GET_MESSAGES                            *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :                                                     *
*  Mantis       :   12232                                             *
*                                                                     *
*  Description  :   Messages Get                                      *
*                                                                     *
***********************************************************************
    DATA: lv_xjson         TYPE xstring,
          lv_msg_text(255) TYPE c,

          lwa_log_handle   TYPE /gicom/applog_handles_s,
          lwa_msg          TYPE bal_s_msg,
          lwa_bapiret      TYPE /gicom/bapiret2,
          lwa_bapiret_ui   TYPE /gicom/bapiret_ui_s,
          lwa_ui_msg       TYPE /gicom/bmsg_ui_s,
          lwa_json_msg     TYPE /gicom/s_message,

          lt_bal_msgr      TYPE bal_t_msgr,
          lt_handles       TYPE /gicom/applog_handles_tt,
          lt_json_msg      TYPE /gicom/t_message,

          lo_log           TYPE REF TO /gicom/cl_util_messages,
          lo_xslt_err      TYPE REF TO cx_xslt_exception,
          lo_sy_ref        TYPE REF TO cx_sy_ref_is_initial.

****export messages to extranal use
****1.if any application object subobject is specified we can export that messages.
****2.if no spcific app obj and subobj then we can collect infocus application object and subobject messages.

    "Get Reference
    lo_log ?= /gicom/cl_util_messages=>get_reference( ).
    IF lo_log IS BOUND.

      IF NOT iv_aplobj IS INITIAL AND
         NOT iv_subobj IS INITIAL.

        READ TABLE gt_log_handles INTO lwa_log_handle
              WITH KEY aplobj = iv_aplobj
                       subobj = iv_subobj.
        IF sy-subrc = 0.
          APPEND lwa_log_handle TO lt_handles.
        ENDIF.

      ELSEIF NOT iv_aplobj IS INITIAL.

        LOOP AT gt_log_handles INTO lwa_log_handle
                         WHERE aplobj = iv_aplobj.
          APPEND lwa_log_handle TO lt_handles.
        ENDLOOP.

      ELSE.

        READ TABLE gt_log_handles INTO lwa_log_handle
              WITH KEY aplobj = lo_log->gv_infocus_aplobj
                       subobj = lo_log->gv_infocus_subobj.
        IF sy-subrc = 0.
          APPEND lwa_log_handle TO lt_handles.
        ENDIF.

      ENDIF.

      IF NOT lt_handles IS INITIAL.

        LOOP AT lt_handles INTO lwa_log_handle.

          CLEAR: lwa_json_msg, lt_bal_msgr.

          "Read the message for current log handle
          TRY.
              IF NOT /gicom/cl_aunit_utilities=>is_unit_test_active( ).
                /gicom/cl_sap_appl_log=>bal_log_read(
                  EXPORTING
                    iv_log_handle  = lwa_log_handle-handle
                  IMPORTING
                    et_msg        = lt_bal_msgr
                ).

              ELSE.
                lt_bal_msgr = VALUE #( /gicom/cl_util_messages=>st_local_messages[ handle = lwa_log_handle-handle ]-messages OPTIONAL ).

              ENDIF.

            CATCH /gicom/cx_sap_call_error.
              CLEAR lt_bal_msgr.

          ENDTRY.

          IF sy-subrc = 0
          AND NOT lt_bal_msgr IS INITIAL.
            LOOP AT lt_bal_msgr INTO DATA(lwa_bal_msgr).

              "Message Log Table
              IF et_messages IS REQUESTED.
                lwa_msg = CORRESPONDING #(  BASE ( lwa_msg ) lwa_bal_msgr ).
                APPEND lwa_msg TO et_messages.
              ENDIF.

              "Bapiret Log Table
              IF et_bapiret IS SUPPLIED.

                lwa_bapiret-type            = lwa_bal_msgr-msgty.
                lwa_bapiret-id              = lwa_bal_msgr-msgid.
                lwa_bapiret-number          = lwa_bal_msgr-msgno.
                lwa_bapiret-message_v1      = lwa_bal_msgr-msgv1.
                lwa_bapiret-message_v2      = lwa_bal_msgr-msgv2.
                lwa_bapiret-message_v3      = lwa_bal_msgr-msgv3.
                lwa_bapiret-message_v4      = lwa_bal_msgr-msgv4.
                lwa_bapiret-system          = sy-sysid.

                MESSAGE ID     lwa_bal_msgr-msgid
                        TYPE   lwa_bal_msgr-msgty
                        NUMBER lwa_bal_msgr-msgno
                        INTO   lwa_bapiret-message
                        WITH   lwa_bal_msgr-msgv1 lwa_bal_msgr-msgv2 lwa_bal_msgr-msgv3 lwa_bal_msgr-msgv4.


                APPEND lwa_bapiret TO et_bapiret.
              ENDIF.

              " Standard UI message table
              IF et_bapiret_ui IS SUPPLIED.

                lwa_bapiret_ui-type            = lwa_bal_msgr-msgty.
                lwa_bapiret_ui-id              = lwa_bal_msgr-msgid.
                lwa_bapiret_ui-number          = lwa_bal_msgr-msgno.
                lwa_bapiret_ui-message_v1      = lwa_bal_msgr-msgv1.
                lwa_bapiret_ui-message_v2      = lwa_bal_msgr-msgv2.
                lwa_bapiret_ui-message_v3      = lwa_bal_msgr-msgv3.
                lwa_bapiret_ui-message_v4      = lwa_bal_msgr-msgv4.
                lwa_bapiret_ui-system          = sy-sysid.

                MESSAGE ID     lwa_bal_msgr-msgid
                        TYPE   lwa_bal_msgr-msgty
                        NUMBER lwa_bal_msgr-msgno
                        INTO   lwa_bapiret_ui-message
                        WITH   lwa_bal_msgr-msgv1 lwa_bal_msgr-msgv2 lwa_bal_msgr-msgv3 lwa_bal_msgr-msgv4.


                APPEND lwa_bapiret_ui TO et_bapiret_ui.
              ENDIF.

              "UI Message Log Table
              IF et_ui_messages IS SUPPLIED.

                MESSAGE ID     lwa_bal_msgr-msgid
                        TYPE   lwa_bal_msgr-msgty
                        NUMBER lwa_bal_msgr-msgno
                        INTO   lwa_ui_msg-message
                        WITH   lwa_bal_msgr-msgv1 lwa_bal_msgr-msgv2 lwa_bal_msgr-msgv3 lwa_bal_msgr-msgv4.

                lwa_ui_msg-id = lwa_bal_msgr-msgid.
                lwa_ui_msg-type = lwa_bal_msgr-msgty.
                lwa_ui_msg-number = lwa_bal_msgr-msgno.
                lwa_ui_msg-context = lwa_bal_msgr-context.
                lwa_ui_msg-system = sy-sysid.

                APPEND lwa_ui_msg TO et_ui_messages.

              ENDIF.

              "Message Log for JSON format
              IF ev_json IS REQUESTED.
                APPEND INITIAL LINE TO lwa_json_msg-messages
                        ASSIGNING FIELD-SYMBOL(<lwa_json_msgr>).
                IF <lwa_json_msgr> IS ASSIGNED.

                  "Message Type
                  <lwa_json_msgr>-msgty = lwa_bal_msgr-msgty.

                  "Message Text
                  IF lwa_bal_msgr-msg_txt IS INITIAL.
                    CLEAR lv_msg_text.

                    "Get text from message data
                    /gicom/cl_sap_appl_log=>bal_dsp_txt_msg_read(
                      EXPORTING
                        iv_msgid        = lwa_bal_msgr-msgid
                        iv_msgno        = lwa_bal_msgr-msgno
                        iv_msgv1        = lwa_bal_msgr-msgv1
                        iv_msgv2        = lwa_bal_msgr-msgv2
                        iv_msgv3        = lwa_bal_msgr-msgv3
                        iv_msgv4        = lwa_bal_msgr-msgv4
                      IMPORTING
                        ev_message_text = lv_msg_text ).

                    <lwa_json_msgr>-msg_txt = lv_msg_text.

                  ELSE.
                    <lwa_json_msgr>-msg_txt = lwa_bal_msgr-msg_txt.
                  ENDIF.

                ENDIF.
              ENDIF.

            ENDLOOP.
          ENDIF.

          "Message Log for JSON format
          IF ev_json IS REQUESTED.
            "Fill Object & Sub Object
            lwa_json_msg-aplobj = lwa_log_handle-aplobj.
            lwa_json_msg-subobj = lwa_log_handle-subobj.

            "Collect into final table
            APPEND lwa_json_msg TO lt_json_msg.
          ENDIF.

        ENDLOOP.

        "Convert Messages table into JSON format
        IF ev_json IS REQUESTED.

          "Instantiate the JSON Writer
          IF NOT lo_log->go_json_writer IS BOUND.
            lo_log->go_json_writer = cl_sxml_string_writer=>create(
                                          type = if_sxml=>co_xt_json ).
          ENDIF.

          "Transform the messages table
          TRY.
              CALL TRANSFORMATION id
                SOURCE messages = lt_json_msg
                RESULT XML lo_log->go_json_writer.

            CATCH cx_xslt_exception INTO lo_xslt_err.
            CATCH cx_sy_ref_is_initial INTO lo_sy_ref.
          ENDTRY.

          IF lo_log->go_json_writer IS BOUND.
            "Get the output
            lv_xjson = lo_log->go_json_writer->get_output( ).

            "Convert Xtsring into String
            IF lv_xjson IS NOT INITIAL.
              /gicom/cl_sap_conversion=>ecatt_conv_xstring_to_string(
                EXPORTING
                  iv_xstring = lv_xjson
                IMPORTING
                  ev_string  = ev_json ).
            ENDIF.
          ENDIF.

        ENDIF.

      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD get_message_context.
***********************************************************************
*                      METHOD GET_MESSAGE_CONTEXT                     *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :                                                     *
*  Mantis       :   12232                                             *
*                                                                     *
*  Description  :   Message Context Get                               *
*                                                                     *
***********************************************************************
    DATA lo_log TYPE REF TO /gicom/cl_util_messages.

    "Get reference
    lo_log ?=  /gicom/cl_util_messages=>get_reference( ).

    IF lo_log IS BOUND.
      "Set message engine context to external structure
      es_context =  lo_log->gs_context.
    ENDIF.

  ENDMETHOD.


  METHOD get_reference.
***********************************************************************
*                      METHOD GET_REFERENCE                           *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :                                                     *
*  Mantis       :   12232                                             *
*                                                                     *
*  Description  :   Reference Get                                     *
*                                                                     *
***********************************************************************

    IF go_log IS NOT BOUND.
      "Create Reference
      CREATE OBJECT go_log.
    ENDIF.

    ro_log = go_log.
  ENDMETHOD.


  METHOD init_messages.
***********************************************************************
*                      METHOD INIT_MESSAGES                           *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :                                                     *
*  Mantis       :   12232                                             *
*                                                                     *
*  Description  :   Clear Messages                                    *
*                                                                     *
***********************************************************************
    DATA: lv_lines        TYPE i,

          lwa_log_handles TYPE /gicom/applog_handles_s,

          lt_log_handles  TYPE /gicom/applog_handles_tt,

          lo_log          TYPE REF TO /gicom/cl_util_messages.

    "Get Instances.
    lo_log ?=  /gicom/cl_util_messages=>get_reference( ).

    IF lo_log IS BOUND.

      IF iv_init_all IS INITIAL.

        IF  iv_aplobj IS NOT INITIAL
        AND iv_subobj IS NOT INITIAL.

          READ TABLE gt_log_handles INTO lwa_log_handles
                WITH KEY aplobj = iv_aplobj
                         subobj = iv_subobj.
          IF sy-subrc = 0.
            APPEND lwa_log_handles TO lt_log_handles.
          ENDIF.

        ELSEIF iv_aplobj IS NOT INITIAL
           AND iv_subobj IS INITIAL.

          LOOP AT gt_log_handles INTO lwa_log_handles
                                WHERE aplobj = iv_aplobj.
            APPEND lwa_log_handles TO lt_log_handles.
          ENDLOOP.

        ELSE.

          READ TABLE gt_log_handles INTO lwa_log_handles
          WITH KEY aplobj = lo_log->gv_infocus_aplobj
                   subobj = lo_log->gv_infocus_subobj.
          IF sy-subrc = 0.
            APPEND lwa_log_handles TO lt_log_handles.
          ENDIF.

        ENDIF.
      ELSE.
        APPEND LINES OF gt_log_handles TO lt_log_handles.
      ENDIF.

      DELETE gt_log_handles WHERE aplobj = iv_aplobj                  " ANDRESCHAK - (added)
                            AND   subobj = iv_subobj.


      CLEAR: gv_log_handle,
             lo_log.                    " ANDRESCHAK  - (added)

    ENDIF.

  ENDMETHOD.


  METHOD refresh_messages.
***********************************************************************
*                      METHOD REFRESH_MESSAGES                        *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :                                                     *
*  Mantis       :   12232                                             *
*                                                                     *
*  Description  :   Messages Refresh                                  *
*                                                                     *
***********************************************************************
    DATA lo_log TYPE REF TO /gicom/cl_util_messages.

    "Get instances.
    lo_log ?=  /gicom/cl_util_messages=>get_reference( ).
    IF lo_log IS BOUND.

      READ TABLE lo_log->gt_log_handles TRANSPORTING NO FIELDS
            WITH KEY aplobj = lo_log->gv_infocus_aplobj
                     subobj = lo_log->gv_infocus_subobj.

      IF sy-subrc = 0.
        /gicom/cl_util_messages=>init_messages(
                  iv_aplobj = lo_log->gv_infocus_aplobj
                  iv_subobj = lo_log->gv_infocus_subobj ).
      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD save_appl_log.
**
**  Author: Patrick Böhm - gicom GmbH
**  Date:   30.11.2016
**  Mantis: 12030
**
**  Description:
**    Write application log
**
**    !ATTENTION!: Using of context needs a callback (is_callback_log)! (otherwise context will not be created)
**
***********************************************************************************************************
***********************************************************************************************************
*** 0. Declarations
***********************************************************************************************************
    DATA: lv_log_handle        TYPE balloghndl,
          lv_string            TYPE string,
          lt_dfies_log_context TYPE dfies_table,
          lt_log_handle_temp   TYPE bal_t_logh,
          lt_log_numbers       TYPE bal_t_lgnm,
          ls_log               TYPE bal_s_log,
          ls_param             TYPE bal_s_par,
          ls_log_message       TYPE bal_s_msg.

    FIELD-SYMBOLS: <ls_dfies>   TYPE dfies,
                   <lv_value>   TYPE any,
                   <ls_message> TYPE /gicom/appl_log_message_s.

***********************************************************************************************************
*** 1. Preperation
***********************************************************************************************************
    CLEAR: ev_log_handle.

* Load definition of context
    IF lt_dfies_log_context IS INITIAL.

      /gicom/cl_util_ddic=>get_ddic_def( EXPORTING iv_obj_name = '/GICOM/APPL_LOG_CONTEXT_S'
                                          CHANGING et_dfies    = lt_dfies_log_context
      ).

    ENDIF.

    DELETE ADJACENT DUPLICATES FROM gt_messages COMPARING ALL FIELDS.

***********************************************************************************************************
*** 2. Save Log
***********************************************************************************************************

    "***********************************************************************************************************
    "*** 2.1 Create head
    "***********************************************************************************************************
    " Generel data
    ls_log-extnumber = gv_extnumber.
    ls_log-object    = gv_object.
    ls_log-subobject = gv_subobject.

    ls_log-aluser    = /gicom/cl_system=>get_username( ).
    ls_log-alprog    = gv_prog.
    ls_log-altcode   = sy-tcode.

    ls_log-aldate    = /gicom/cl_system=>get_date( ).
    ls_log-altime    = /gicom/cl_system=>get_time( ).

    IF sy-batch = 'X'.
      ls_log-almode = 'B'. "Batch-Mode
    ELSEIF sy-binpt = 'X'.
      ls_log-almode = 'I'. "Batch Input-Mode
    ELSE.
      ls_log-almode = 'D'. "Dialog-Mode
    ENDIF.

    ls_log-context-tabname = '/GICOM/APPL_LOG_CONTEXT_S'.
    lv_string = gs_context_head.
    ls_log-context-value = lv_string.

    LOOP AT lt_dfies_log_context ASSIGNING <ls_dfies>.

      ls_param-parname = <ls_dfies>-fieldname.

      ASSIGN COMPONENT <ls_dfies>-fieldname OF STRUCTURE gs_context_head TO <lv_value>.
      IF sy-subrc = 0.

        IF <lv_value> IS NOT INITIAL.

          ls_param-parvalue = <lv_value>.
          APPEND ls_param TO ls_log-params-t_par.

        ELSE.
          "Value is initial --> continue
          CONTINUE.
        ENDIF.

      ELSE.
        RAISE EXCEPTION TYPE /gicom/cx_internal_error
          MESSAGE ID '/GICOM/MSG_FOUNDAT'
          TYPE 'E'
          NUMBER '001'
          WITH <ls_dfies>-fieldname.

      ENDIF.

    ENDLOOP.

* Create Callback
    ls_log-params-callback = gs_callback_log.

    "********************************************************************************************************
    "*** 2.2 Create application log
    "********************************************************************************************************

    TRY.
        /gicom/cl_sap_appl_log=>bal_log_create(
          EXPORTING
            is_log                 = ls_log
          IMPORTING
            ev_log_handle          = lv_log_handle ).

      CATCH /gicom/cx_sap_call_error INTO DATA(lo_ex).
        RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lo_ex ).
    ENDTRY.

    "********************************************************************************************************
    "*** 2.3 Add message
    "********************************************************************************************************
    LOOP AT gt_messages ASSIGNING <ls_message>.

      CLEAR: ls_log_message.

      ls_log_message-msgty   = <ls_message>-bapiret2-type.
      ls_log_message-msgid   = <ls_message>-bapiret2-id.
      ls_log_message-msgno   = <ls_message>-bapiret2-number.
      ls_log_message-msgv1   = <ls_message>-bapiret2-message_v1.
      ls_log_message-msgv2   = <ls_message>-bapiret2-message_v2.
      ls_log_message-msgv3   = <ls_message>-bapiret2-message_v3.
      ls_log_message-msgv4   = <ls_message>-bapiret2-message_v4.

*       Set context
      ls_log_message-context-tabname = '/GICOM/APPL_LOG_CONTEXT_S'.
      lv_string = <ls_message>-context.
      ls_log_message-context-value = lv_string.

      LOOP AT lt_dfies_log_context ASSIGNING <ls_dfies>.

        ls_param-parname = <ls_dfies>-fieldname.

        ASSIGN COMPONENT <ls_dfies>-fieldname OF STRUCTURE <ls_message>-context TO <lv_value>.
        IF sy-subrc = 0.

          IF <lv_value> IS NOT INITIAL.

            ls_param-parvalue = <lv_value>.
            APPEND ls_param TO ls_log_message-params-t_par.

          ELSE.
            "Value is initial --> cpntinue
            CONTINUE.
          ENDIF.

        ELSE.

          RAISE EXCEPTION TYPE /gicom/cx_internal_error
            MESSAGE ID '/GICOM/MSG_FOUNDAT'
            TYPE 'E'
            NUMBER '001'
            WITH <ls_dfies>-fieldname.

        ENDIF.
      ENDLOOP.

*       Set Callback
      ls_log_message-params-callback = gs_callback_msg.

*       Set sorting and problem class
      CASE ls_log_message-msgty.
        WHEN 'S'.
          ls_log_message-probclass  = space.  "other
          ls_log_message-alsort     = '5'.
        WHEN 'I' .
          ls_log_message-probclass  = '4'.    "additional information
          ls_log_message-alsort     = '1'.
        WHEN 'W'.
          ls_log_message-probclass  = '3'.    "medium
          ls_log_message-alsort     = '4'.
        WHEN 'E'.
          ls_log_message-probclass  = '2'.     "important
          ls_log_message-alsort     = '3'.
        WHEN 'A' OR 'X'.
          ls_log_message-probclass  = '1'.     "very important
          ls_log_message-alsort     = '2'.
      ENDCASE.

      TRY.
          /gicom/cl_sap_appl_log=>bal_log_msg_add(
            EXPORTING
              iv_log_handle     = lv_log_handle
              is_msg          = ls_log_message ).

        CATCH /gicom/cx_sap_call_error INTO DATA(lo_ex2).
          RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lo_ex2 ).
      ENDTRY.

    ENDLOOP.


    "********************************************************************************************************
    "*** 2.4 Save Log
    "********************************************************************************************************
    APPEND lv_log_handle TO lt_log_handle_temp.

    TRY.
        /gicom/cl_sap_appl_log=>bal_db_save(
          EXPORTING
            iv_client         = sy-mandt
            it_log_handle   = lt_log_handle_temp
          IMPORTING
            et_new_lognumbers = lt_log_numbers ).

      CATCH /gicom/cx_sap_call_error INTO DATA(lo_ex3).
        RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lo_ex3 ).
    ENDTRY.

***********************************************************************************************************
*** 3. Returning
***********************************************************************************************************
    et_log_numbers  = lt_log_numbers.
    ev_log_handle   = lv_log_handle.

*   COMMIT, if wished
    IF iv_do_commit = 'X'.

      COMMIT WORK AND WAIT.

    ENDIF.

***********************************************************************************************************
*** 3. Clear written entries
***********************************************************************************************************
    REFRESH gt_messages.

  ENDMETHOD.


  METHOD save_message_log.
***********************************************************************
*                      METHOD SAVE_MESSAGE_LOG                        *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :                                                     *
*  Mantis       :   12232                                             *
*                                                                     *
*  Description  :   Save Messages                                     *
*                                                                     *
***********************************************************************

    DATA: lwa_log_handle     TYPE /gicom/applog_handles_s,
          lwa_log_number     TYPE bal_s_lgnm,
          lwa_new_log_number TYPE bal_s_lgnm,

          lt_log_handles     TYPE bal_t_logh,
          lt_messages        TYPE bal_tt_msg,
          lt_new_log_numbers TYPE bal_t_lgnm,

          lo_log             TYPE REF TO /gicom/cl_util_messages.

    "Get instance
    lo_log ?=  /gicom/cl_util_messages=>get_reference( ).

    IF  iv_aplobj IS NOT INITIAL
    AND iv_subobj IS NOT INITIAL.
      "Get handle for that object
      READ TABLE gt_log_handles INTO lwa_log_handle
            WITH KEY aplobj = iv_aplobj
                     subobj = iv_subobj.

    ELSE.
      "Get handle for infocus object
      READ TABLE gt_log_handles INTO lwa_log_handle
            WITH KEY aplobj = lo_log->gv_infocus_aplobj
                     subobj = lo_log->gv_infocus_subobj.

    ENDIF.

    IF sy-subrc = 0.
      INSERT lwa_log_handle-handle INTO TABLE lt_log_handles.

      "save message log
      TRY.
          IF NOT /gicom/cl_aunit_utilities=>is_unit_test_active( ).
            /gicom/cl_sap_appl_log=>bal_db_save(
              EXPORTING
                it_log_handle     = lt_log_handles
                iv_in_update_task = iv_set_update_task
              IMPORTING
                et_new_lognumbers = lt_new_log_numbers
            ).
          ENDIF.

        CATCH /gicom/cx_sap_call_error.

          CLEAR lt_new_log_numbers.

          IF sy-msgid IS NOT INITIAL
          AND sy-msgno IS NOT INITIAL
          AND sy-msgty IS NOT  INITIAL.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO sy-msgli.
          ENDIF.

      ENDTRY.

      IF lt_new_log_numbers IS NOT INITIAL.
        LOOP AT lt_new_log_numbers INTO lwa_new_log_number.
          INSERT lwa_new_log_number INTO TABLE lo_log->gt_log_numbers.
        ENDLOOP.
      ENDIF.

*      IF sy-batch NE space.   "Why only in case of batch?
      /gicom/cl_util_messages=>refresh_messages( ).
*      ENDIF.

      READ TABLE lt_new_log_numbers INTO lwa_new_log_number INDEX 1.
      IF sy-subrc = 0.
        ev_log_number = lwa_new_log_number-lognumber.
        cv_log_handle = gv_log_handle = lwa_log_handle-handle.
      ELSE.
        ev_log_number = iv_log_number.
        cv_log_handle = gv_log_handle = cv_log_handle.
      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD set_infocus_obj.
***********************************************************************
*                      METHOD SET_INFOCUS_OBJ                         *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :                                                     *
*  Mantis       :   12232                                             *
*                                                                     *
*  Description  :   Message Infocus Set                               *
*                                                                     *
***********************************************************************
    DATA: lwa_log_handle TYPE /gicom/applog_handles_s,

          lo_log         TYPE REF TO /gicom/cl_util_messages.

    "Get Instance
    lo_log ?=  /gicom/cl_util_messages=>get_reference( ).

    IF lo_log IS BOUND.
      READ TABLE gt_log_handles INTO lwa_log_handle
            WITH KEY aplobj = iv_aplobj
                     subobj = iv_subobj.
      IF sy-subrc = 0.
        lo_log->gv_infocus_aplobj = iv_aplobj.
        lo_log->gv_infocus_subobj = iv_aplobj.
        lo_log->gs_environment-collect_all = abap_true.
        gv_log_handle = lwa_log_handle-handle.
        cv_subrc = sy-subrc.
      ELSE.
        cv_subrc = 4.
        CLEAR gv_log_handle.
      ENDIF.

    ELSE.
      cv_subrc = 4.
      CLEAR gv_log_handle.
    ENDIF.

  ENDMETHOD.


  METHOD set_message_context.
***********************************************************************
*                      METHOD SET_MESSAGE_CONTEXT                     *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :                                                     *
*  Mantis       :   12232                                             *
*                                                                     *
*  Description  :   Set Context Data                                  *
*                                                                     *
***********************************************************************
    DATA lo_log TYPE REF TO /gicom/cl_util_messages.

    lo_log ?=  /gicom/cl_util_messages=>get_reference( ).

    IF lo_log IS BOUND.
      "Assign external context to message engine

      IF is_context IS SUPPLIED.
        lo_log->gs_context = is_context.

      ELSEIF iv_objkey IS SUPPLIED
          OR iv_docvar IS SUPPLIED
          OR iv_ctxtab IS SUPPLIED
          OR iv_ctxval IS SUPPLIED.
        lo_log->gs_context-objkey = iv_objkey.
        lo_log->gs_context-docvar = iv_docvar.
        lo_log->gs_context-ctxtab = iv_ctxtab.
        lo_log->gs_context-ctxval = iv_ctxval.
      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD set_message_exit.
***********************************************************************
*                      METHOD SET_MESSAGE_EXIT                        *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :                                                     *
*  Mantis       :   12232                                             *
*                                                                     *
*  Description  :   Set Exit for Message                              *
*                                                                     *
***********************************************************************
    DATA lo_log TYPE REF TO /gicom/cl_util_messages.

    lo_log ?=  /gicom/cl_util_messages=>get_reference( ).

    IF lo_log IS BOUND.
      "Assign exit to message engine
      IF iv_user_exit_msg IS SUPPLIED.
        lo_log->gs_callback_msg-userexitf = iv_user_exit_msg.
      ELSEIF iv_user_exit_msg_typ IS SUPPLIED.
        lo_log->gs_callback_msg-userexitt = iv_user_exit_msg_typ.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD start_message_log.
***********************************************************************
*                      METHOD START_MESSAGE_LOG                       *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :                                                     *
*  Mantis       :   12232                                             *
*                                                                     *
*  Description  :   Initialize Message Log                            *
*                                                                     *
***********************************************************************

    DATA: lwa_log_handles TYPE /gicom/applog_handles_s,
          lwa_log         TYPE bal_s_log.

    DATA: lo_log TYPE REF TO /gicom/cl_util_messages.

    "Get Instances.
    lo_log ?=  /gicom/cl_util_messages=>get_reference( ).

    "Load Object & Subobject into current instance
    lo_log->gv_infocus_aplobj = iv_aplobj.
    lo_log->gv_infocus_subobj = iv_subobj.

*program name, who creates log
    lo_log->gv_prog                   = sy-repid.

* Callback for log
    lo_log->gs_callback_log-userexitf = iv_user_exit_log.
    lo_log->gs_callback_log-userexitt = iv_user_exit_log_typ.

* Callback for message
    lo_log->gs_callback_msg-userexitf = iv_user_exit_msg.
    lo_log->gs_callback_msg-userexitt = iv_user_exit_msg_typ.
*   Log - external identification number
    IF iv_extnumber IS NOT INITIAL.
      lo_log->gv_extnumber              = iv_extnumber.
    ENDIF.

    "Check the handle for current Object & Sub Object
    READ TABLE gt_log_handles INTO lwa_log_handles
          WITH KEY aplobj = lo_log->gv_infocus_aplobj
                   subobj = lo_log->gv_infocus_subobj.

    IF sy-subrc = 0.
      gv_log_handle = lwa_log_handles-handle.

      IF sy-batch IS INITIAL.

        TRY.
            IF NOT /gicom/cl_aunit_utilities=>is_unit_test_active( ).
              /gicom/cl_sap_appl_log=>bal_log_msg_delete_all( iv_log_handle  = gv_log_handle ).

            ELSE.
              DELETE /gicom/cl_util_messages=>st_local_messages WHERE handle = gv_log_handle.

            ENDIF.

          CATCH /gicom/cx_sap_call_error.
            IF sy-msgid IS NOT INITIAL
            AND sy-msgty IS NOT INITIAL
            AND sy-msgno IS NOT INITIAL.
              MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO sy-msgli.
            ENDIF.
        ENDTRY.

      ENDIF.

    ELSE.
      lwa_log-object = iv_aplobj.
      lwa_log-subobject = iv_subobj.
      lwa_log-extnumber = iv_extnumber.
      lwa_log-params-callback-userexitf = iv_user_exit_log.
      lwa_log-params-callback-userexitt = iv_user_exit_log_typ.
      lwa_log-aluser = /gicom/cl_system=>get_username( ).

      "Create a new handle for log
      TRY.
          IF NOT /gicom/cl_aunit_utilities=>is_unit_test_active( ).
            /gicom/cl_sap_appl_log=>bal_log_create(
              EXPORTING
                is_log        = lwa_log
              IMPORTING
                ev_log_handle = gv_log_handle
            ).

          ELSE.
            gv_log_handle = /gicom/cl_util_guid=>get_guid_22( ).

            INSERT VALUE #( handle = gv_log_handle ) INTO TABLE /gicom/cl_util_messages=>st_local_messages.

          ENDIF.

        CATCH /gicom/cx_sap_call_error.
          IF  sy-msgid IS NOT INITIAL
          AND sy-msgty IS NOT INITIAL
          AND sy-msgno IS NOT INITIAL.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO sy-msgli.
          ENDIF.

      ENDTRY.

      "Set Collect all flag as X in environment variables
      lo_log->gs_environment-collect_all = abap_true.

      "Collect the details
      lwa_log_handles-aplobj = lwa_log-object.
      lwa_log_handles-subobj = lwa_log-subobject.
      lwa_log_handles-handle = gv_log_handle.
      APPEND lwa_log_handles TO gt_log_handles.

    ENDIF.

  ENDMETHOD.


  METHOD get_bapiret_from_message_2.
    /gicom/cl_util_messages=>get_bapiret_from_message(
      EXPORTING
        iv_msgid   = iv_msgid
        iv_number  = iv_number
        iv_par1    = iv_par1
        iv_par2    = iv_par2
        iv_par3    = iv_par3
        iv_par4    = iv_par4
        iv_type    = iv_type
      RECEIVING
        rs_bapiret = DATA(ls_bapiret)
    ).

    MOVE-CORRESPONDING ls_bapiret TO rs_bapiret.

    rs_bapiret-bo_id = iv_bo_id.
    rs_bapiret-bo_type = iv_bo_typ.
  ENDMETHOD.


  METHOD display_bapiret2.
    CALL FUNCTION '/GICOM/BAPIRET2_SHOW'
      TABLES
        i_bapiret2_tab = it_bapiret2.
  ENDMETHOD.


  METHOD get_bapi_from_exception_chain.
    DATA(lo_exception) = io_exception.

    WHILE lo_exception IS BOUND.
      INSERT /gicom/cl_util_messages=>get_bapiret_from_exception( io_exception = lo_exception ) INTO TABLE rt_messages.

      lo_exception = lo_exception->previous.
    ENDWHILE.
  ENDMETHOD.


  METHOD get_generic_exception_message.
    io_exception->get_source_position(
      IMPORTING
        program_name = DATA(lv_prog_name)
        include_name = DATA(lv_include_name)
        source_line  = DATA(lv_source_line)
    ).

    rs_message = VALUE #(
      msgid = '/GICOM/MSG_FOUNDAT'
      msgno = '033'
      msgty = /gicom/if_constants_ddl=>c_message_type-error
      msgv1 = cl_abap_classdescr=>describe_by_object_ref( p_object_ref = io_exception )->get_relative_name( )
      msgv2 = lv_prog_name
      msgv3 = lv_include_name
      msgv4 = lv_source_line
    ).
  ENDMETHOD.


  METHOD get_instance.
    IF go_instance IS NOT BOUND.
      go_instance = NEW lcl_facade( ).
    ENDIF.
    ro_util_messages_instance = go_instance.
  ENDMETHOD.


  METHOD inject_instance.
    go_instance = io_util_messages_instance.
  ENDMETHOD.


  METHOD convert_context_to_ui_struc.

    DATA(lt_messages) = it_messages.

    LOOP AT lt_messages ASSIGNING FIELD-SYMBOL(<fs_message>) WHERE ui_info IS NOT INITIAL.

      LOOP AT <fs_message>-ui_info ASSIGNING FIELD-SYMBOL(<fs_ui_info>).
        IF <fs_ui_info>-key = '/GICOM/AGRMT_ID'.
          <fs_ui_info>-key = cv_agreement_id.
        ELSEIF <fs_ui_info>-key = '/GICOM/SIM_FRGMT_ID'.
          <fs_ui_info>-key = cv_sim_fragment_id.
        ENDIF.
      ENDLOOP.

    ENDLOOP.

    rt_messages = lt_messages.

  ENDMETHOD.
ENDCLASS.
