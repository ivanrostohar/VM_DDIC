INTERFACE /gicom/if_dso_user
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_users
    RETURNING
      VALUE(rt_users) TYPE /gicom/buser_tt
    RAISING
      /gicom/cx_root_ds .

  METHODS select
    IMPORTING
      !it_usernames   TYPE /gicom/username_tty
    RETURNING
      VALUE(rt_users) TYPE /gicom/user_tty
    RAISING
      /gicom/cx_root_ds .

  METHODS insert_users
    IMPORTING
      it_users TYPE /gicom/_user_a_tt
      iv_commit TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_users
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_users
    IMPORTING
       it_selopt  TYPE ddshselops
    RETURNING
      VALUE(rt_users) TYPE /gicom/_user_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.

ENDINTERFACE.
