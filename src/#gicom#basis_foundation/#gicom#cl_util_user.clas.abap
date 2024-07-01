CLASS /gicom/cl_util_user DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-DATA:
      go_sap_user TYPE REF TO /gicom/if_sap_user,
      go_instance TYPE REF TO /gicom/if_util_user.


    METHODS constructor.
    CLASS-METHODS class_constructor.

    METHODS user_details
       importing
        iv_user  type xubname optional
       returning
        Value(rs_user_details)  type /gicom/user_details_s
       raising /gicom/cx_internal_error  .

    METHODS get_user_name
      IMPORTING
                !iv_user      TYPE xubname OPTIONAL
      EXPORTING
                !ev_firstname TYPE ad_namefir
                !ev_lastname  TYPE ad_namelas
      RAISING   /gicom/cx_internal_error .

    CLASS-METHODS get_instance
      RETURNING VALUE(ro_util_user_instance) TYPE REF TO /gicom/if_util_user.

    CLASS-METHODS inject_instance
      IMPORTING io_util_user_instance TYPE REF TO /gicom/if_util_user.


    CLASS-METHODS user_existence
      IMPORTING
        !iv_user            TYPE uname
      RETURNING
        VALUE(rs_existence) TYPE /gicom/abap_bool .
    CLASS-METHODS validate_email
      IMPORTING
        !iv_email       TYPE string
      RETURNING
        VALUE(rv_valid) TYPE /gicom/abap_bool .
    CLASS-METHODS fill_created_changed_txt
      CHANGING
        !cs_created_changed TYPE any
      RAISING
        /gicom/cx_internal_error .
    CLASS-METHODS get_users_list
      IMPORTING
        !iv_user  TYPE xubname OPTIONAL
      EXPORTING
        !userlist TYPE bapiusname .
    CLASS-METHODS get_user_name_with_salu
      IMPORTING
        !iv_user    TYPE uname
      RETURNING
        VALUE(rv_salut_name) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS /GICOM/CL_UTIL_USER IMPLEMENTATION.


  METHOD validate_email.

    TRY.
      DATA(lr_matcher) = cl_abap_matcher=>create(
                          pattern = `\w+([\.\-\äÄöÖüÜß\w+])*@([\w\-\äÄöÖüÜß]+\.)*([\w\-\äÄöÖüÜß]+)` ##NO_TEXT
                          "pattern = `\w+(\.\w+)*@(\w+\.)+(\w{2,4})`
                          ignore_case = abap_true
                          text = iv_email ).
      DATA(lv_success) = lr_matcher->match( ).

      IF lv_success EQ abap_false.
        RAISE EXCEPTION TYPE cx_sy_matcher.
      ENDIF.
        CATCH cx_sy_matcher cx_sy_regex.
          rv_valid = abap_false.
      EXIT.
    ENDTRY.

    rv_valid = abap_true.

  ENDMETHOD.


  METHOD get_user_name_with_salu.

    IF iv_user IS NOT INITIAL.
      DATA(ls_user_details) = go_instance->user_details( iv_user ).

      rv_salut_name = |{ ls_user_details-adress-title_p } { ls_user_details-adress-fullname }|.
    ENDIF.

  ENDMETHOD.


  METHOD fill_created_changed_txt.
    ASSIGN COMPONENT 'CREATED_BY' OF STRUCTURE cs_created_changed TO FIELD-SYMBOL(<lv_created>).
    CHECK sy-subrc EQ 0.
    ASSIGN COMPONENT 'LAST_CHANGED_BY' OF STRUCTURE cs_created_changed TO FIELD-SYMBOL(<lv_changed>).
    CHECK sy-subrc EQ 0.

    ASSIGN COMPONENT 'CREATED_BY_NAME_FIRST' OF STRUCTURE cs_created_changed TO FIELD-SYMBOL(<lv_cre_first>).
    CHECK sy-subrc EQ 0.
    ASSIGN COMPONENT 'CREATED_BY_NAME_LAST' OF STRUCTURE cs_created_changed TO FIELD-SYMBOL(<lv_cre_last>).
    CHECK sy-subrc EQ 0.

    ASSIGN COMPONENT 'LAST_CHANGED_BY_NAME_FIRST' OF STRUCTURE cs_created_changed TO FIELD-SYMBOL(<lv_cha_first>).
    CHECK sy-subrc EQ 0.
    ASSIGN COMPONENT 'LAST_CHANGED_BY_NAME_LAST' OF STRUCTURE cs_created_changed TO FIELD-SYMBOL(<lv_cha_last>).
    CHECK sy-subrc EQ 0.

    /gicom/cl_util_user=>get_instance( )->get_user_name(
      EXPORTING
        iv_user      = <lv_created>
      IMPORTING
        ev_firstname = <lv_cre_first>
        ev_lastname  = <lv_cre_last>
    ).

    /gicom/cl_util_user=>get_instance( )->get_user_name(
      EXPORTING
        iv_user      = <lv_changed>
      IMPORTING
        ev_firstname = <lv_cha_first>
        ev_lastname  = <lv_cha_last>
    ).
  ENDMETHOD.


  METHOD inject_instance.
    go_instance = io_util_user_instance.
  ENDMETHOD.


  METHOD user_existence.
    DATA: ls_return TYPE bapiret2,
          lv_user   TYPE xubname.

    lv_user = iv_user.

    go_sap_user->bapi_user_existence_check(
     EXPORTING
       iv_username = lv_user
     IMPORTING
       es_return   = ls_return ).

    IF ls_return-number EQ '088'.   "matching of message no
      rs_existence = abap_true.
    ELSE.
      rs_existence = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD get_users_list.

  ENDMETHOD.


  METHOD get_instance.
    IF go_instance IS NOT BOUND.
      go_instance = NEW lcl_facade( ).
    ENDIF.
    ro_util_user_instance = go_instance.
  ENDMETHOD.


  METHOD constructor.
    go_sap_user = NEW /gicom/cl_sap_user( ).
    go_instance = NEW lcl_facade( ).
  ENDMETHOD.


  METHOD class_constructor.
    go_sap_user = NEW /gicom/cl_sap_user( ).
    go_instance = NEW lcl_facade( ).
  ENDMETHOD.


  METHOD get_user_name.

    DATA(ls_user_details) = me->user_details(
        iv_user = iv_user
    ).

    ev_firstname = ls_user_details-adress-firstname.
    ev_lastname = ls_user_details-adress-lastname.

  ENDMETHOD.


  METHOD user_details.
    DATA lt_error TYPE bapiret2_t.

    DATA(lv_user) = /gicom/cl_system=>get_username( iv_user ).

    go_sap_user->bapi_user_get_detail(
      EXPORTING
        iv_username      = lv_user
        iv_cache_results = 'X'
      IMPORTING
        es_logondata     = rs_user_details-logondata
        es_defaults      = rs_user_details-defaults
        es_address       = rs_user_details-adress
      CHANGING
        ct_return        = lt_error
        ct_addsmtp       = rs_user_details-email ).

    IF line_exists( lt_error[ type = 'E' ] ).
      RAISE EXCEPTION TYPE /gicom/cx_internal_error.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
