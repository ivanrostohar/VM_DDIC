INTERFACE /gicom/if_util_messages
  PUBLIC .

  METHODS:

    add_message
      IMPORTING
        iv_aplobj            TYPE balobj_d OPTIONAL
        iv_subobj            TYPE balsubobj OPTIONAL
        iv_user_exit_msg     TYPE baluef OPTIONAL
        iv_user_exit_msg_typ TYPE baluet OPTIONAL
        is_context           TYPE /gicom/applog_context_s OPTIONAL
      RAISING
        /gicom/cx_unresolved_message,

    get_bapiret_from_exception
      IMPORTING
        io_exception       TYPE REF TO cx_root
      RETURNING
        VALUE(rs_bapiret2) TYPE bapiret2,

    get_messages
      IMPORTING
        iv_aplobj      TYPE balobj_d OPTIONAL
        iv_subobj      TYPE balsubobj OPTIONAL
      EXPORTING
        ev_json        TYPE string
        et_messages    TYPE bal_tt_msg
        et_bapiret_ui  TYPE /gicom/bapiret_ui_tt
        et_ui_messages TYPE /gicom/bmsg_ui_tt
        et_bapiret     TYPE /gicom/bapiret_tt.

ENDINTERFACE.
