*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_facade DEFINITION.

  PUBLIC SECTION.

    INTERFACES /gicom/if_util_user.

ENDCLASS.

CLASS lcl_facade IMPLEMENTATION.

  METHOD /gicom/if_util_user~fill_created_changed_txt.
       /gicom/cl_util_user=>fill_created_changed_txt(
         CHANGING
           cs_created_changed = cs_created_changed
       ).
  ENDMETHOD.

  METHOD /gicom/if_util_user~get_users_list.
        /gicom/cl_util_user=>get_users_list(
          EXPORTING
            iv_user  = iv_user
          IMPORTING
            userlist = userlist
        ).
  ENDMETHOD.

  METHOD /gicom/if_util_user~get_user_name.
        NEW /gicom/cl_util_user( )->get_user_name(
          EXPORTING
            iv_user      = iv_user
          IMPORTING
            ev_firstname = ev_firstname
            ev_lastname  = ev_lastname
        ).
  ENDMETHOD.

  METHOD /gicom/if_util_user~get_user_name_with_salu.
        rv_salut_name = /gicom/cl_util_user=>get_user_name_with_salu( iv_user ).
  ENDMETHOD.

  METHOD /gicom/if_util_user~user_details.
        rs_user_details = NEW /gicom/cl_util_user( )->user_details( iv_user ).
  ENDMETHOD.

  METHOD /gicom/if_util_user~user_existence.
        rs_existence = /gicom/cl_util_user=>user_existence( iv_user ).
  ENDMETHOD.

  METHOD /gicom/if_util_user~validate_email.
        rv_valid = /gicom/cl_util_user=>validate_email( iv_email ).
  ENDMETHOD.

ENDCLASS.
