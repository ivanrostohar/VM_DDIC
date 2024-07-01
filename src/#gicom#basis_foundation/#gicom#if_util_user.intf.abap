INTERFACE /gicom/if_util_user
  PUBLIC .

  METHODS user_details
    IMPORTING
      !iv_user               TYPE xubname OPTIONAL
    RETURNING
      VALUE(rs_user_details) TYPE /gicom/user_details_s
    RAISING
      /gicom/cx_internal_error.

  METHODS get_user_name
    IMPORTING
      !iv_user      TYPE xubname OPTIONAL
    EXPORTING
      !ev_firstname TYPE ad_namefir
      !ev_lastname  TYPE ad_namelas
    RAISING
      /gicom/cx_internal_error.

  METHODS user_existence
    IMPORTING
      !iv_user            TYPE uname
    RETURNING
      VALUE(rs_existence) TYPE /gicom/abap_bool.

  METHODS validate_email
    IMPORTING
      !iv_email       TYPE string
    RETURNING
      VALUE(rv_valid) TYPE /gicom/abap_bool.

  METHODS fill_created_changed_txt
    CHANGING
      !cs_created_changed TYPE any
    RAISING
      /gicom/cx_internal_error.

  METHODS get_users_list
    IMPORTING
      !iv_user  TYPE xubname OPTIONAL
    EXPORTING
      !userlist TYPE bapiusname.

  METHODS get_user_name_with_salu
    IMPORTING
      !iv_user             TYPE uname
    RETURNING
      VALUE(rv_salut_name) TYPE string.

ENDINTERFACE.
