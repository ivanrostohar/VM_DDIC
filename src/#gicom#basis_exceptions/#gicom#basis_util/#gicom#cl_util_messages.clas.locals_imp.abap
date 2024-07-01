*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"DO NOT MOVE ANYTHING BETWEEN THIS L.5
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
CLASS lcx_not_t100_with_source_pos DEFINITION
  INHERITING FROM cx_static_check
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          io_previous TYPE REF TO cx_root OPTIONAL.
ENDCLASS.


CLASS lcx_not_t100_with_source_pos IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = io_previous ).
  ENDMETHOD.

ENDCLASS.



CLASS lcl_test_helper_source_pos DEFINITION.
  PUBLIC SECTION.
    METHODS:
      raise_exception_on_line42
        IMPORTING
          io_previous TYPE REF TO cx_root OPTIONAL
        RAISING
          lcx_not_t100_with_source_pos.
ENDCLASS.


CLASS lcl_test_helper_source_pos IMPLEMENTATION.
  METHOD raise_exception_on_line42.
    RAISE EXCEPTION NEW lcx_not_t100_with_source_pos( io_previous ).
  ENDMETHOD.
ENDCLASS.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"DO NOT MOVE ANYTHING BETWEEN THIS L.46
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

CLASS lcl_facade DEFINITION.

  PUBLIC SECTION.

    INTERFACES /gicom/if_util_messages.

ENDCLASS.

CLASS lcl_facade IMPLEMENTATION.

  METHOD /gicom/if_util_messages~get_bapiret_from_exception.
    rs_bapiret2 = /gicom/cl_util_messages=>get_bapiret_from_exception( io_exception ).
  ENDMETHOD.

  METHOD /gicom/if_util_messages~get_messages.
    DATA(lt_parameters) = VALUE abap_parmbind_tab(
      (
        name  = 'IV_APLOBJ'
        kind  = cl_abap_objectdescr=>exporting
        value = REF #( iv_aplobj )
      )
      (
        name  = 'IV_SUBOBJ'
        kind  = cl_abap_objectdescr=>exporting
        value = REF #( iv_subobj )
      )
    ).

    IF ev_json IS SUPPLIED.
      INSERT VALUE #(
        name  = 'EV_JSON'
        kind  = cl_abap_objectdescr=>importing
        value = REF #( ev_json )
      ) INTO TABLE lt_parameters.
    ENDIF.

    IF et_bapiret IS SUPPLIED.
      INSERT VALUE #(
        name  = 'ET_BAPIRET'
        kind  = cl_abap_objectdescr=>importing
        value = REF #( et_bapiret )
      ) INTO TABLE lt_parameters.
    ENDIF.

    IF et_bapiret_ui IS SUPPLIED.
      INSERT VALUE #(
        name  = 'ET_BAPIRET_UI'
        kind  = cl_abap_objectdescr=>importing
        value = REF #( et_bapiret_ui )
      ) INTO TABLE lt_parameters.
    ENDIF.

    IF et_messages IS SUPPLIED.
      INSERT VALUE #(
        name  = 'ET_MESSAGES'
        kind  = cl_abap_objectdescr=>importing
        value = REF #( et_messages )
      ) INTO TABLE lt_parameters.
    ENDIF.

    IF et_ui_messages IS SUPPLIED.
      INSERT VALUE #(
        name  = 'ET_UI_MESSAGES'
        kind  = cl_abap_objectdescr=>importing
        value = REF #( et_ui_messages )
      ) INTO TABLE lt_parameters.
    ENDIF.

    CALL METHOD /gicom/cl_util_messages=>('GET_MESSAGES')
      PARAMETER-TABLE
      lt_parameters.

    IF 1 = 2.
      " For where-used reference
      /gicom/cl_util_messages=>get_messages(
        EXPORTING
          iv_aplobj      = iv_aplobj
          iv_subobj      = iv_subobj
        IMPORTING
          ev_json        = ev_json
          et_messages    = et_messages
          et_bapiret_ui  = et_bapiret_ui
          et_ui_messages = et_ui_messages
          et_bapiret     = et_bapiret
      ).
    ENDIF.
  ENDMETHOD.

  METHOD /gicom/if_util_messages~add_message.
    /gicom/cl_util_messages=>add_message(
      iv_aplobj            = iv_aplobj
      iv_subobj            = iv_subobj
      iv_user_exit_msg     = iv_user_exit_msg
      iv_user_exit_msg_typ = iv_user_exit_msg_typ
      is_context           = is_context
    ).
  ENDMETHOD.

ENDCLASS.



CLASS lcx_dyn_msg DEFINITION
  INHERITING FROM /gicom/cx_root
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          iv_msgid     TYPE symsgid OPTIONAL
          iv_msgno     TYPE symsgno OPTIONAL
          iv_msgty     TYPE symsgty OPTIONAL
          iv_variable1 TYPE symsgv  OPTIONAL
          iv_variable2 TYPE symsgv  OPTIONAL
          iv_variable3 TYPE symsgv  OPTIONAL
          iv_variable4 TYPE symsgv  OPTIONAL
          io_previous  TYPE REF TO cx_root  OPTIONAL.

ENDCLASS.

CLASS lcx_dyn_msg IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = io_previous ).

    me->if_t100_message~t100key-msgid = iv_msgid.
    me->if_t100_message~t100key-msgno = iv_msgno.
    me->if_t100_dyn_msg~msgty         = iv_msgty.
    me->if_t100_dyn_msg~msgv1         = iv_variable1.
    me->if_t100_dyn_msg~msgv2         = iv_variable2.
    me->if_t100_dyn_msg~msgv3         = iv_variable3.
    me->if_t100_dyn_msg~msgv4         = iv_variable4.
  ENDMETHOD.

ENDCLASS.



CLASS lcx_msg DEFINITION
  INHERITING FROM cx_static_check
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES: if_t100_message.

    DATA:
      gv_variable1 TYPE /gicom/agrmt_id,
      gv_variable2 TYPE /gicom/agrmt_id,
      gv_variable3 TYPE /gicom/agrmt_id,
      gv_variable4 TYPE /gicom/agrmt_id.

    METHODS:
      constructor
        IMPORTING
          iv_msgid     TYPE symsgid OPTIONAL
          iv_msgno     TYPE symsgno OPTIONAL
          iv_variable1 TYPE symsgv  OPTIONAL
          iv_variable2 TYPE symsgv  OPTIONAL
          iv_variable3 TYPE symsgv  OPTIONAL
          iv_variable4 TYPE symsgv  OPTIONAL
          io_previous  TYPE REF TO cx_root  OPTIONAL.

ENDCLASS.

CLASS lcx_msg IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = io_previous ).

    me->gv_variable1 = iv_variable1.
    me->gv_variable2 = iv_variable2.
    me->gv_variable3 = iv_variable3.
    me->gv_variable4 = iv_variable4.

    me->if_t100_message~t100key-msgid = iv_msgid.
    me->if_t100_message~t100key-msgno = iv_msgno.
    me->if_t100_message~t100key-attr1 = 'gv_variable1'.
    me->if_t100_message~t100key-attr2 = 'gv_variable2'.
    me->if_t100_message~t100key-attr3 = 'gv_variable3'.
    me->if_t100_message~t100key-attr4 = 'gv_variable4'.

  ENDMETHOD.

ENDCLASS.



CLASS lcx_msg_wrong_parameter DEFINITION
  INHERITING FROM cx_static_check
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES: if_t100_message.

    METHODS:
      constructor
        IMPORTING
          iv_msgid     TYPE symsgid OPTIONAL
          iv_msgno     TYPE symsgno OPTIONAL
          iv_variable1 TYPE symsgv  OPTIONAL
          iv_variable2 TYPE symsgv  OPTIONAL
          iv_variable3 TYPE symsgv  OPTIONAL
          iv_variable4 TYPE symsgv  OPTIONAL
          io_previous  TYPE REF TO cx_root  OPTIONAL.

ENDCLASS.

CLASS lcx_msg_wrong_parameter IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = io_previous ).

    me->if_t100_message~t100key-msgid = iv_msgid.
    me->if_t100_message~t100key-msgno = iv_msgno.
    me->if_t100_message~t100key-attr1 = iv_variable1.
    me->if_t100_message~t100key-attr2 = iv_variable2.
    me->if_t100_message~t100key-attr3 = iv_variable3.
    me->if_t100_message~t100key-attr4 = iv_variable4.

  ENDMETHOD.

ENDCLASS.



CLASS lcx_not_t100_no_source_pos DEFINITION
  INHERITING FROM cx_static_check
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          io_previous TYPE REF TO cx_root  OPTIONAL.
ENDCLASS.

CLASS lcx_not_t100_no_source_pos IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = io_previous ).
  ENDMETHOD.

ENDCLASS.


CLASS lcx_not_t100_with_source_hack DEFINITION
  INHERITING FROM cx_static_check
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          io_previous TYPE REF TO cx_root  OPTIONAL,

      get_source_position REDEFINITION.
ENDCLASS.

CLASS lcx_not_t100_with_source_hack IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = io_previous ).
  ENDMETHOD.

  METHOD get_source_position.
    "ev_program_name
    program_name = '/GICOM/CL_UTIL_MESSAGES=======CI'.
    "ev_include_name
    include_name = '/GICOM/CL_UTIL_MESSAGES=======CCAU'.
    "ev_source_line
    source_line = 16.
  ENDMETHOD.

ENDCLASS.
