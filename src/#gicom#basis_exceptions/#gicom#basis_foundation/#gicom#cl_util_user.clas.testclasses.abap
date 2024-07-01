CLASS ltc_get_user_name DEFINITION FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    METHODS get_user_name FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_get_user_name IMPLEMENTATION.

  METHOD get_user_name.

    DATA ls_user_details TYPE /gicom/user_details_s.
    ls_user_details = VALUE #(
      logondata = VALUE #( accnt = 'HEINZ' )
      adress = VALUE #( firstname = 'Karl' lastname = 'Heinz' nickname = 'HEINZ' )
      defaults = VALUE #( )
      email = VALUE #( )
    ).

    DATA(lo_user_double) = CAST /gicom/if_sap_user( cl_abap_testdouble=>create( '/gicom/if_sap_user' ) ).
    cl_abap_testdouble=>configure_call( lo_user_double )->ignore_all_parameters(  )->set_parameter( name = 'es_logondata'  value = ls_user_details-logondata )->set_parameter( name = 'es_address' value = ls_user_details-adress ).

    lo_user_double->bapi_user_get_detail( iv_username =  'HEINZ' ).

    "when
    DATA(lo_cut) = NEW /gicom/cl_util_user( ).

    lo_cut->go_sap_user = lo_user_double.

    lo_cut->get_user_name(
      EXPORTING
        iv_user                  = 'HEINZ'
      IMPORTING
        ev_firstname             = DATA(lv_firstname)
        ev_lastname              = DATA(lv_lastname)
    ).

    "then
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  =     'Karl'
        act                  =     lv_firstname
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  =     'Heinz'
        act                  =     lv_lastname
    ).
  ENDMETHOD.
ENDCLASS.




CLASS ltc_user_details DEFINITION FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS.
  PUBLIC SECTION.
    CLASS-DATA:
      mo_cut TYPE REF TO /gicom/cl_util_user.

  PRIVATE SECTION.
    CLASS-METHODS:
      class_setup.

    METHODS:
      "!This Method calls the method with parameter and gets it back
      user_details_is_given FOR TESTING RAISING cx_static_check,
      "!This Method calls the method without parameter and gets back sy-uname
      user_details_not_supplied FOR TESTING RAISING cx_static_check,
      "!This Method calls the method with an initial parameter and gets back sy-uname
      user_details_is_initial FOR TESTING RAISING cx_static_check,
      "!This Method checks that the method raises an exception when lt_error has the line type = 'E'
      user_details_raises_error FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_user_details IMPLEMENTATION.

  METHOD user_details_is_given.

    "given
    DATA ls_user_details TYPE /gicom/user_details_s.
    ls_user_details = VALUE #(
      logondata = VALUE #( accnt = 'HEINZ' )
      adress = VALUE #( firstname = 'Peter' lastname = 'Heinz' nickname = 'HEINZ' )
      defaults = VALUE #( )
      email = VALUE #( )
    ).

    DATA(lo_user_double) = CAST /gicom/if_sap_user( cl_abap_testdouble=>create( '/gicom/if_sap_user' ) ).
    cl_abap_testdouble=>configure_call( lo_user_double )->ignore_all_parameters(  )->set_parameter( name = 'es_logondata'  value = ls_user_details-logondata )->set_parameter( name = 'es_address' value = ls_user_details-adress ).

    lo_user_double->bapi_user_get_detail( iv_username =  'HEINZ' ).

    "when
    mo_cut->go_sap_user = lo_user_double.

    DATA(ls_user_data_act) = mo_cut->user_details( iv_user =  'HEINZ').

    "then
    cl_abap_unit_assert=>assert_equals(
      act = ls_user_data_act
      exp = ls_user_details
      msg = 'Returned user data mismatch expected value'
    ).

  ENDMETHOD.

  METHOD user_details_not_supplied.

    "given
    /gicom/cl_system=>set_username( 'HEINZ' ).

    DATA(lv_user_exp) = /gicom/cl_system=>get_username(  ).

    DATA ls_user_details TYPE /gicom/user_details_s.
    ls_user_details = VALUE #(
      logondata = VALUE #( accnt = 'HEINZ' )
      adress = VALUE #( firstname = 'Peter' lastname = 'Heinz' nickname = 'HEINZ' )
      defaults = VALUE #( )
      email = VALUE #( )
    ).

    DATA(lo_user_double) = CAST /gicom/if_sap_user( cl_abap_testdouble=>create( '/gicom/if_sap_user' ) ).
    cl_abap_testdouble=>configure_call( lo_user_double )->ignore_all_parameters(  )->set_parameter( name = 'es_logondata'  value = ls_user_details-logondata )->set_parameter( name = 'es_address' value = ls_user_details-adress ).

    lo_user_double->bapi_user_get_detail( iv_username =  'HEINZ' ).

    "when
    mo_cut->go_sap_user = lo_user_double.
    DATA(ls_user_data_act) = mo_cut->user_details( ).

    "then
    cl_abap_unit_assert=>assert_equals(
      act = ls_user_data_act
      exp = ls_user_details
      msg = 'Returned user data mismatch expected value'
    ).

    /gicom/cl_system=>reset_username(  ).

  ENDMETHOD.


  METHOD user_details_is_initial.

    "given
    /gicom/cl_system=>set_username( 'HEINZ' ).

    DATA ls_user_details TYPE /gicom/user_details_s.
    ls_user_details = VALUE #(
      logondata = VALUE #( accnt = 'HEINZ' )
      adress = VALUE #( firstname = 'Peter' lastname = 'Heinz' nickname = 'HEINZ' )
      defaults = VALUE #( )
      email = VALUE #( )
    ).

    DATA(lo_user_double) = CAST /gicom/if_sap_user( cl_abap_testdouble=>create( '/gicom/if_sap_user' ) ).
    cl_abap_testdouble=>configure_call( lo_user_double )->ignore_all_parameters(  )->set_parameter( name = 'es_logondata'  value = ls_user_details-logondata )->set_parameter( name = 'es_address' value = ls_user_details-adress ).

    lo_user_double->bapi_user_get_detail( iv_username =  'HEINZ' ).

    "when
    mo_cut->go_sap_user = lo_user_double.
    DATA(ls_user_data_act) = mo_cut->user_details( iv_user =  ' ').

    "then
    cl_abap_unit_assert=>assert_equals(
      act = ls_user_data_act
      exp = ls_user_details
      msg = 'Returned user data mismatch expected value'
    ).

    /gicom/cl_system=>reset_username(  ).

  ENDMETHOD.


  METHOD user_details_raises_error.
    "given
    DATA(lt_return) = VALUE bapiret2_t( ( type = 'E' message = 'This is not a User' )  ).

    DATA(lo_user_double) = CAST /gicom/if_sap_user( cl_abap_testdouble=>create( '/gicom/if_sap_user' ) ).
    cl_abap_testdouble=>configure_call( lo_user_double )->ignore_all_parameters(  )->set_parameter( name = 'ct_return '  value = lt_return ).

    lo_user_double->bapi_user_get_detail( iv_username =  '' ).

    "when
    mo_cut->go_sap_user = lo_user_double.
    TRY.
      mo_cut->user_details( iv_user = 'NOTuser').
        CATCH /gicom/cx_internal_error.
          DATA(lv_error_thrown) = abap_true.
    ENDTRY.

    "Then
    cl_abap_unit_assert=>assert_true(
      act = lv_error_thrown
      msg = 'Expected Expectation not raised'
    ).
  ENDMETHOD.

  METHOD class_setup.
    mo_cut = NEW /gicom/cl_util_user( ).
  ENDMETHOD.

ENDCLASS.



CLASS ltc_user_existence DEFINITION FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS.
  PUBLIC SECTION.
    CLASS-DATA:
      mo_cut TYPE REF TO /gicom/cl_util_user.

  PRIVATE SECTION.
    CLASS-METHODS:
      class_setup.

    METHODS:
      "!This Method checks that abap_true is given back if the name exists
      user_exists FOR TESTING RAISING cx_static_check,
      "!This Method checks that abap_false is given back if the name does not exist
      user_does_not_exist FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_user_existence IMPLEMENTATION.

  METHOD class_setup.
    mo_cut = NEW /gicom/cl_util_user( ).
  ENDMETHOD.

  METHOD user_exists.
    "given
    DATA(ls_return) = VALUE bapiret2( number = '088' ).

    DATA(lo_user_double) = CAST /gicom/if_sap_user( cl_abap_testdouble=>create( '/gicom/if_sap_user' ) ).
    cl_abap_testdouble=>configure_call( lo_user_double )->ignore_all_parameters(  )->set_parameter( name = 'es_return'  value = ls_return ).

    lo_user_double->bapi_user_existence_check( iv_username =  '' ).

    "when
    mo_cut->go_sap_user = lo_user_double.
    DATA(lb_act) = mo_cut->user_existence( iv_user = 'HEINZ').

    "then
    cl_abap_unit_assert=>assert_true(
        act = lb_act
        msg = 'Existing user was not found.'
    ).

  ENDMETHOD.


  METHOD user_does_not_exist.
    DATA(ls_return) = VALUE bapiret2( number = '124' ).

    DATA(lo_user_double) = CAST /gicom/if_sap_user( cl_abap_testdouble=>create( '/gicom/if_sap_user' ) ).
    cl_abap_testdouble=>configure_call( lo_user_double )->ignore_all_parameters(  )->set_parameter( name = 'es_return'  value = ls_return ).

    lo_user_double->bapi_user_existence_check( iv_username =  '' ).

    "when
    mo_cut->go_sap_user = lo_user_double.
    DATA(lb_act) = mo_cut->user_existence( iv_user = 'HEINZ').

    "then
    cl_abap_unit_assert=>assert_false(
        act = lb_act
        msg = 'Existing user was not found.'
    ).

  ENDMETHOD.

ENDCLASS.




CLASS ltc_validate_email DEFINITION FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS.
  PUBLIC SECTION.
    CLASS-DATA:
      mo_cut TYPE REF TO /gicom/cl_util_user.

  PRIVATE SECTION.

    CLASS-METHODS:
      class_setup.

    METHODS:
    "!This Method checks that abap_true is given back if the email is valid
    validate_email_match FOR TESTING RAISING cx_static_check,
    "!This Method checks that abap_false is given back if the email is invalid
    validate_email_no_match FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_validate_email IMPLEMENTATION.

  METHOD class_setup.
    mo_cut = NEW /gicom/cl_util_user( ).
  ENDMETHOD.

  METHOD validate_email_match.
    "given
    DATA(lv_valid_email) = `user@gicom.com`.

    "when
    DATA(lv_act) = mo_cut->validate_email( lv_valid_email ).

    "then
    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = abap_true
        act                  = lv_act
    ).

  ENDMETHOD.

  METHOD validate_email_no_match.
    "given
    DATA(lv_invalid_email) = `NotAnEmailJustAString`.

    "when
    DATA(lv_act) = mo_cut->validate_email( iv_email = lv_invalid_email ).

    "then
    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = abap_false
        act                  = lv_act
    ).

  ENDMETHOD.

ENDCLASS.




CLASS ltc_fill_created_changed_txt DEFINITION FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA go_instance TYPE REF TO /gicom/if_util_user.

    METHODS:
      fill_created_changed_txt FOR TESTING RAISING cx_static_check,
      wrong_import_structure FOR TESTING RAISING cx_static_check,
      wrong_username FOR TESTING RAISING cx_static_check,
      half_wrong_import_structure FOR TESTING RAISING cx_static_check,
      wanted_field_stuct_change FOR TESTING RAISING cx_static_check,
      wrong_import_type FOR TESTING RAISING cx_static_check.

    TYPES: BEGIN OF created_changed_struct,
             created_by                 TYPE xubname,
             last_changed_by            TYPE xubname,
             created_by_name_first      TYPE ad_namefir,
             created_by_name_last       TYPE ad_namelas,
             last_changed_by_name_first TYPE ad_namefir,
             last_changed_by_name_last  TYPE ad_namelas,
             extra_field                TYPE abap_bool,
           END OF created_changed_struct.

    TYPES: BEGIN OF half_wrong_struct,
             created_by                 TYPE xubname,
             last_changed_by            TYPE xubname,
             created_by_name_first      TYPE ad_namefir,
             created_by_name_last       TYPE ad_namelas,
             created_at_time            TYPE /gicom/time,
             created_at_date            TYPE /gicom/date,
           END OF half_wrong_struct.

ENDCLASS.

CLASS ltc_fill_created_changed_txt IMPLEMENTATION.

  METHOD fill_created_changed_txt.
    "given
    DATA(ls_user_exp) = VALUE created_changed_struct(
      created_by                    = 'MÜLLER'
      last_changed_by               = 'BAUM'
      created_by_name_first         = 'Max'
      created_by_name_last          = 'Müller'
      last_changed_by_name_first    = 'Paul'
      last_changed_by_name_last     = 'Baum'
    ).

    DATA(ls_user) = VALUE created_changed_struct( created_by = 'MÜLLER' last_changed_by = 'BAUM' ).

    DATA(lo_util_user_double) = CAST /gicom/if_util_user( cl_abap_testdouble=>create( '/gicom/if_util_user' ) ).
    cl_abap_testdouble=>configure_call( lo_util_user_double )->set_parameter( name = 'ev_firstname' value = 'Max')->set_parameter( name = 'ev_lastname' value = 'Müller' ).
    lo_util_user_double->get_user_name( iv_user = ls_user_exp-created_by ).

    cl_abap_testdouble=>configure_call( lo_util_user_double )->set_parameter( name = 'ev_firstname' value = 'Paul')->set_parameter( name = 'ev_lastname' value = 'Baum' ).
    lo_util_user_double->get_user_name( iv_user = ls_user_exp-last_changed_by ).

    /gicom/cl_util_user=>inject_instance( io_util_user_instance = lo_util_user_double ).

    "when
    /gicom/cl_util_user=>fill_created_changed_txt( CHANGING cs_created_changed = ls_user ).

    "then
    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp = ls_user_exp
        act = ls_user
    ).
  ENDMETHOD.

  METHOD wrong_username.
    "given
    DATA ls_user TYPE created_changed_struct.
    ls_user-created_by      = 'NOTAUSERNAME'.
    ls_user-last_changed_by = 'ALSONOTAUSER'.

    DATA(lo_util_user_double) = CAST /gicom/if_util_user( cl_abap_testdouble=>create( '/gicom/if_util_user' ) ).
    cl_abap_testdouble=>configure_call( lo_util_user_double )->ignore_all_parameters( )->raise_exception( NEW /gicom/cx_internal_error( ) ).
    lo_util_user_double->get_user_name( ).

    /gicom/cl_util_user=>inject_instance(
      io_util_user_instance =  lo_util_user_double
    ).

    "when
    TRY.
      /gicom/cl_util_user=>fill_created_changed_txt( CHANGING cs_created_changed = ls_user ).
        CATCH /gicom/cx_internal_error.
        DATA(lv_exception_thrown) = abap_true.
    ENDTRY.

    "then
    cl_abap_unit_assert=>assert_true(
      act = lv_exception_thrown
      msg = 'Expected exception was not raised.' ).

  ENDMETHOD.

  METHOD wrong_import_structure.
    "given
    DATA(ls_agrmt_agr) = VALUE /gicom/agrmt_agr_a_s( id = '5' oid_art_grp = '0123456789' ).
    DATA(ls_agrmt_agr_exp) = ls_agrmt_agr.

    DATA(lo_user_double) = CAST /gicom/if_util_user( cl_abap_testdouble=>create( '/gicom/if_util_user' ) ).
    cl_abap_testdouble=>configure_call( lo_user_double )->ignore_all_parameters(  )->set_parameter( name = 'ev_firstname' value = 'Peter')->set_parameter( name = 'ev_lastname' value = 'Heinz' ).

    lo_user_double->get_user_name( iv_user =  'HEINZ' ).

    /gicom/cl_util_user=>inject_instance(
      io_util_user_instance =  lo_user_double
    ).

    "when
    /gicom/cl_util_user=>fill_created_changed_txt( CHANGING cs_created_changed = ls_agrmt_agr ).

    "then
    cl_abap_unit_assert=>assert_equals(
      act = ls_agrmt_agr
      exp = ls_agrmt_agr_exp
      msg = 'Structure was unexpectedly updated.' ).

  ENDMETHOD.


  METHOD half_wrong_import_structure.
    "given
     DATA ls_hw_imp_struc_act type half_wrong_struct.
     DATA(ls_hw_imp_struc_exp) = ls_hw_imp_struc_act.

    "when
    /gicom/cl_util_user=>fill_created_changed_txt(
      CHANGING
        cs_created_changed = ls_hw_imp_struc_act
    ).

    "then
    cl_abap_unit_assert=>assert_equals(
      exp = ls_hw_imp_struc_exp
      act = ls_hw_imp_struc_act
    ).

  ENDMETHOD.

  METHOD wanted_field_stuct_change.
    "given
    DATA(ls_user_exp) = VALUE created_changed_struct(
      created_by                    = 'MÜLLER'
      last_changed_by               = 'BAUM'
      created_by_name_first         = 'Max'
      created_by_name_last          = 'Müller'
      last_changed_by_name_first    = 'Paul'
      last_changed_by_name_last     = 'Baum'
      extra_field                   = abap_true
    ).

    DATA(ls_user) = VALUE created_changed_struct( created_by = ls_user_exp-created_by last_changed_by = ls_user_exp-last_changed_by ).

    DATA(lo_util_user_double) = CAST /gicom/if_util_user( cl_abap_testdouble=>create( '/gicom/if_util_user' ) ).
    cl_abap_testdouble=>configure_call( lo_util_user_double )->set_parameter( name = 'ev_firstname' value = 'Max')->set_parameter( name = 'ev_lastname' value = 'Müller' ).
    lo_util_user_double->get_user_name( iv_user = ls_user_exp-created_by ).

    cl_abap_testdouble=>configure_call( lo_util_user_double )->set_parameter( name = 'ev_firstname' value = 'Paul')->set_parameter( name = 'ev_lastname' value = 'Baum' ).
    lo_util_user_double->get_user_name( iv_user = ls_user_exp-last_changed_by ).

    /gicom/cl_util_user=>inject_instance( io_util_user_instance = lo_util_user_double ).

    "when
    /gicom/cl_util_user=>fill_created_changed_txt( CHANGING cs_created_changed = ls_user ).

    "then
    cl_abap_unit_assert=>assert_true(
      EXPORTING
        act = ls_user_exp-extra_field
        msg = 'Unwanted change of the extra field.'
    ).
  ENDMETHOD.

  METHOD wrong_import_type.
    "given
    DATA(lv_variable) = '0'.
    DATA(lv_variable_exp) = lv_variable.

    "when
    /gicom/cl_util_user=>fill_created_changed_txt( CHANGING cs_created_changed = lv_variable ).

    "then
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = lv_variable
        exp = lv_variable_exp
        msg = 'Given Object should be initial.'
    ).
  ENDMETHOD.

ENDCLASS.
