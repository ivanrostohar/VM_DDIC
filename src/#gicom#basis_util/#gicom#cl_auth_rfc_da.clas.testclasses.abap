"* use this source file for your ABAP unit test classes
CLASS ltc_authority_check DEFINITION FINAL FOR TESTING
  INHERITING FROM /gicom/cl_aunit_test
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    CLASS-METHODS:

      class_setup.

    METHODS:

      check_fail             FOR TESTING,
      check_rfc_object_valid FOR TESTING,
      check_user_valid       FOR TESTING.

ENDCLASS.


CLASS ltc_authority_check IMPLEMENTATION.


  METHOD class_setup.
    /gicom/cl_system=>set_username( 'UNITTEST' ).
  ENDMETHOD.


  METHOD check_user_valid.
    "given
    TEST-INJECTION authcheck.
      IF lv_user = 'UNITTEST'.
        sy-subrc = 0.
      ELSE.
        sy-subrc = 4.
      ENDIF.
    END-TEST-INJECTION.

    "when
    /gicom/cl_auth_rfc_da=>authority_check(
      EXPORTING
        iv_rfc_object = /gicom/cl_rfc_manager=>cv_org_units
      IMPORTING
        ev_authorized = DATA(lv_authorized)
    ).

    "then
    cl_abap_unit_assert=>assert_true(
      EXPORTING
        act   = lv_authorized
        msg   = 'Expected authorization check to be successful'
    ).

  ENDMETHOD.


  METHOD check_rfc_object_valid.
    "given
    TEST-INJECTION authcheck.
      IF iv_rfc_object = /gicom/cl_rfc_manager=>cv_org_units.
        sy-subrc = 0.
      ELSE.
        sy-subrc = 4.
      ENDIF.
    END-TEST-INJECTION.

    "when
    /gicom/cl_auth_rfc_da=>authority_check(
      EXPORTING
        iv_rfc_object = /gicom/cl_rfc_manager=>cv_org_units
      IMPORTING
        ev_authorized = DATA(lv_authorized)
    ).

    "then
    cl_abap_unit_assert=>assert_true(
      EXPORTING
        act   = lv_authorized
        msg   = 'Expected authorization check to be successful'
    ).
  ENDMETHOD.


  METHOD check_fail.
    "given
    TEST-INJECTION authcheck.
      sy-subrc = 4.
    END-TEST-INJECTION.

    "when
    TRY.
        /gicom/cl_auth_rfc_da=>authority_check(
          EXPORTING
            iv_rfc_object = /gicom/cl_rfc_manager=>cv_org_units
          IMPORTING
            ev_authorized = data(lv_authorized)
        ).

      CATCH /gicom/cx_no_auth_rfc.
        cl_abap_unit_assert=>assert_false(
          EXPORTING
            act   = lv_authorized
            msg   = 'Expected authorization check to fail'
        ).
        RETURN.
    ENDTRY.

    "then
    cl_abap_unit_assert=>fail( msg = 'Expected authorization check to fail' ).
  ENDMETHOD.


ENDCLASS.
