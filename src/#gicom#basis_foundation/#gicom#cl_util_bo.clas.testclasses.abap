*"* use this source file for your ABAP unit test classes
CLASS ltc_create_bo_id DEFINITION FOR TESTING
RISK LEVEL HARMLESS
DURATION SHORT.

  PRIVATE SECTION.

    METHODS no_optional_par1 FOR TESTING.

    METHODS ng_vers_id_1 FOR TESTING RAISING cx_static_check.

    METHODS vers_char3_no_char2 FOR TESTING RAISING cx_static_check.

    METHODS cntr_varno_1_addno_1 FOR TESTING RAISING cx_static_check.

    METHODS cntr_varno_2x1_addno_2x1 FOR TESTING RAISING cx_static_check.
    METHODS setup.

ENDCLASS.




CLASS ltc_create_bo_id IMPLEMENTATION.


  METHOD setup. "This is a special instance method, called before each test method

    TEST-INJECTION convex_remtloc_create_bo_id.

      CASE iv_id.
        WHEN '1'. "TODO: RIGHT VALUES
          <lv_deref> = '0000000001'.
        WHEN OTHERS.
      ENDCASE.

    END-TEST-INJECTION.

  ENDMETHOD.


  METHOD no_optional_par1.

    DATA lv_id TYPE /gicom/ng_id VALUE '1'.


    "when
    DATA(lv_bo_id) = /gicom/cl_util_bo=>create_bo_id( iv_id = lv_id ).

    DATA lv_exp TYPE /gicom/bo_id VALUE '0000000001'.


    cl_abap_unit_assert=>assert_equals( exp = lv_exp act = lv_bo_id ).


  ENDMETHOD.

  METHOD vers_char3_no_char2.

    DATA lv_id TYPE char10 VALUE '1'.

    DATA lv_vers TYPE char3 VALUE '1'.

    DATA lv_no TYPE char2 VALUE '1'.

    "when
    DATA(lv_bo_id) = /gicom/cl_util_bo=>create_bo_id( iv_id = lv_id iv_version = lv_vers iv_no = lv_no ).

    DATA lv_exp TYPE /gicom/bo_id VALUE '000000000100101'.


    cl_abap_unit_assert=>assert_equals( exp = lv_exp act = lv_bo_id ).

  ENDMETHOD.

  METHOD ng_vers_id_1.

    DATA lv_id TYPE /gicom/ng_id VALUE '1'.

    DATA lv_vers_id TYPE /gicom/ng_ver_no VALUE '1'.


    "when
    DATA(lv_bo_id) = /gicom/cl_util_bo=>create_bo_id( iv_id = lv_id iv_version = lv_vers_id ).

    DATA lv_exp TYPE /gicom/bo_id VALUE '0000000001001'.


    cl_abap_unit_assert=>assert_equals( exp = lv_exp act = lv_bo_id ).
  ENDMETHOD.



  METHOD cntr_varno_1_addno_1.

    DATA lv_id TYPE /gicom/ng_id VALUE '1'.

    DATA lv_vers_id TYPE /gicom/contract_var_no  VALUE '1'.

    DATA lv_no TYPE /gicom/addend_no VALUE '1'.


    "when
    DATA(lv_bo_id) = /gicom/cl_util_bo=>create_bo_id( iv_id = lv_id iv_version = lv_vers_id iv_no = lv_no ).

    DATA lv_exp TYPE /gicom/bo_id VALUE '000000000100101'.


    cl_abap_unit_assert=>assert_equals( exp = lv_exp act = lv_bo_id ).
  ENDMETHOD.


  METHOD cntr_varno_2x1_addno_2x1.

    DATA lv_id TYPE /gicom/ng_id VALUE '1'.

    DATA lv_vers_id TYPE /gicom/contract_var_no  VALUE '11'.

    DATA lv_no TYPE /gicom/addend_no VALUE '11'.


    "when
    DATA(lv_bo_id) = /gicom/cl_util_bo=>create_bo_id( iv_id = lv_id iv_version = lv_vers_id iv_no = lv_no ).

    DATA lv_exp TYPE /gicom/bo_id VALUE '000000000101111'.


    cl_abap_unit_assert=>assert_equals( exp = lv_exp act = lv_bo_id ).
  ENDMETHOD.


ENDCLASS.

CLASS ltc_get_dtel_for_bo DEFINITION FOR TESTING
RISK LEVEL HARMLESS
DURATION SHORT.
  PRIVATE SECTION.


    METHODS lifnr FOR TESTING RAISING cx_static_check.
    METHODS kunnr FOR TESTING RAISING cx_static_check.
    METHODS bu_partner FOR TESTING RAISING cx_static_check.
    METHODS ngr_id FOR TESTING RAISING cx_static_check.
    METHODS others FOR TESTING RAISING cx_static_check.



ENDCLASS.

CLASS ltc_get_dtel_for_bo IMPLEMENTATION.

  METHOD lifnr.

    DATA(lv_dtel) = /gicom/cl_util_bo=>get_dtel_for_bo( iv_bo_typ = 'LFA1' ).

    cl_abap_unit_assert=>assert_equals( exp = 'LIFNR' act = lv_dtel ).


  ENDMETHOD.

  METHOD kunnr.

    DATA(lv_dtel) = /gicom/cl_util_bo=>get_dtel_for_bo( iv_bo_typ = 'KNA1' ).

    cl_abap_unit_assert=>assert_equals( exp = 'KUNNR' act = lv_dtel ).

  ENDMETHOD.

  METHOD bu_partner.

    DATA(lv_dtel) = /gicom/cl_util_bo=>get_dtel_for_bo( iv_bo_typ = 'BUS1006' ).

    cl_abap_unit_assert=>assert_equals( exp = 'BU_PARTNER' act = lv_dtel ).

  ENDMETHOD.

  METHOD ngr_id.

    DATA(lv_dtel) = /gicom/cl_util_bo=>get_dtel_for_bo( iv_bo_typ = '/GICOM/V08' ).

    cl_abap_unit_assert=>assert_equals( exp = '/GICOM/NGR_ID' act = lv_dtel ).

  ENDMETHOD.

  METHOD others.

    DATA(lt_bo_types) = VALUE /gicom/bo_typ_tt(
    ( '/GICOM/V04' )
    ( '/GICOM/V06' )
    ( '/GICOM/V10' )
    ( '/GICOM/V02' )
    ( '/GICOM/V03' )
    ( 'BUS0002' )
    ( 'BUS1072' )
    ( '/GICOM/V09' )
    ( 'BUS0008' )
    ( 'T024' )
    ( 'BUS0006' )
    ( '' )
     ).

    LOOP AT lt_bo_types ASSIGNING FIELD-SYMBOL(<lv_bo_type>).

      TRY.
          DATA(lv_dtel) = /gicom/cl_util_bo=>get_dtel_for_bo( iv_bo_typ = <lv_bo_type> ).
          cl_abap_unit_assert=>fail( 'Exception did not occur as expected' ).

        CATCH /gicom/cx_no_data.
          "Success!!
      ENDTRY.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.


CLASS ltc_split_bo_id DEFINITION FOR TESTING
RISK LEVEL HARMLESS
DURATION SHORT.
  PUBLIC SECTION.
    CLASS-METHODS convex_rem_to_loc IMPORTING iv_input TYPE clike EXPORTING ev_output TYPE clike.
    CLASS-METHODS convex_loc_to_rem IMPORTING iv_input TYPE clike EXPORTING ev_output TYPE clike.
  PRIVATE SECTION.



    METHODS bo_ngr FOR TESTING RAISING cx_static_check.
    METHODS bo_ng FOR TESTING RAISING cx_static_check.
    METHODS bo_addend FOR TESTING RAISING cx_static_check.
    METHODS bo_agrmt FOR TESTING RAISING cx_static_check.
    METHODS bo_cntr_var FOR TESTING RAISING cx_static_check.
    METHODS others FOR TESTING RAISING cx_static_check.
    METHODS bo_ngr_lth_exc FOR TESTING RAISING cx_static_check.
    METHODS bo_ng_lth_exc FOR TESTING RAISING cx_static_check.
    METHODS bo_addend_lth_exc FOR TESTING RAISING cx_static_check.
    METHODS bo_agrmt_lth_exc FOR TESTING RAISING cx_static_check.
    METHODS bo_cntr_var_lth_exc FOR TESTING RAISING cx_static_check.
    METHODS setup.




ENDCLASS.



CLASS ltc_split_bo_id IMPLEMENTATION.

  METHOD setup.

    TEST-INJECTION convex_remtloc_addend.
      ltc_split_bo_id=>convex_rem_to_loc( EXPORTING iv_input = param1 IMPORTING ev_output = param1 ).
    END-TEST-INJECTION.
    TEST-INJECTION convex_remtloc_agrmt.
      ltc_split_bo_id=>convex_rem_to_loc( EXPORTING iv_input = param1 IMPORTING ev_output = param1 ).
    END-TEST-INJECTION.
    TEST-INJECTION convex_remtloc_cntr_var.
      ltc_split_bo_id=>convex_rem_to_loc( EXPORTING iv_input = param1 IMPORTING ev_output = param1 ).
    END-TEST-INJECTION.
    TEST-INJECTION convex_remtloc_ngr.
      ltc_split_bo_id=>convex_rem_to_loc( EXPORTING iv_input = param1 IMPORTING ev_output = param1 ).
    END-TEST-INJECTION.
    TEST-INJECTION convex_remtloc_ng.
      ltc_split_bo_id=>convex_rem_to_loc( EXPORTING iv_input = param1 IMPORTING ev_output = param1 ).
    END-TEST-INJECTION.

    TEST-INJECTION convex_loctrem_addend.
      ltc_split_bo_id=>convex_loc_to_rem( EXPORTING iv_input = iv_bo_id IMPORTING ev_output = lv_bo_id ).
    END-TEST-INJECTION.
    TEST-INJECTION convex_loctrem_agrmt.
      ltc_split_bo_id=>convex_loc_to_rem( EXPORTING iv_input = iv_bo_id IMPORTING ev_output = lv_bo_id ).
    END-TEST-INJECTION.
    TEST-INJECTION convex_loctrem_cntr_var.
      ltc_split_bo_id=>convex_loc_to_rem( EXPORTING iv_input = iv_bo_id IMPORTING ev_output = lv_bo_id ).
    END-TEST-INJECTION.
    TEST-INJECTION convex_loctrem_ng.
      ltc_split_bo_id=>convex_loc_to_rem( EXPORTING iv_input = iv_bo_id IMPORTING ev_output = lv_bo_id ).
    END-TEST-INJECTION.


  ENDMETHOD.

  METHOD convex_rem_to_loc.

    CASE iv_input.
      WHEN '1234'.
        ev_output = '0000001234'.
    ENDCASE.

  ENDMETHOD.

  METHOD convex_loc_to_rem.

    CASE iv_input.
      WHEN '0000001234'.
        ev_output = '1234'.
      WHEN '0000001234001'.
        ev_output = '1234001'.
      WHEN '000000123400101'.
        ev_output = '123400101'.
      WHEN '11111111111'.
        ev_output = '11111111111'.
    ENDCASE.

  ENDMETHOD.


  METHOD bo_ngr.


    DATA lv_bo_id TYPE /gicom/bo_id VALUE '0000001234'.

    /gicom/cl_util_bo=>split_bo_id( EXPORTING iv_bo_id = lv_bo_id iv_bo_typ = '/GICOM/V08'
    IMPORTING
    param1 = DATA(param1)
    param2 = DATA(param2)
    param3 = DATA(param3)
    param4 = DATA(param4)
    param5 = DATA(param5)
     ).

    cl_abap_unit_assert=>assert_equals( exp = '0000001234' act = param1  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param2  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param3  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param4  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param5  ).



  ENDMETHOD.

  METHOD bo_ng.

    DATA lv_bo_id TYPE /gicom/bo_id VALUE '0000001234001'.

    /gicom/cl_util_bo=>split_bo_id( EXPORTING iv_bo_id = lv_bo_id iv_bo_typ = '/GICOM/V09'
    IMPORTING
    param1 = DATA(param1)
    param2 = DATA(param2)
    param3 = DATA(param3)
    param4 = DATA(param4)
    param5 = DATA(param5)     ).

    cl_abap_unit_assert=>assert_equals( exp = '0000001234' act = param1  ).
    cl_abap_unit_assert=>assert_equals( exp = '001' act = param2  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param3  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param4  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param5  ).

  ENDMETHOD.

  METHOD bo_addend.

    DATA lv_bo_id TYPE /gicom/bo_id VALUE '000000123400101'.

    /gicom/cl_util_bo=>split_bo_id( EXPORTING iv_bo_id = lv_bo_id iv_bo_typ = '/GICOM/V04'
    IMPORTING
    param1 = DATA(param1)
    param2 = DATA(param2)
    param3 = DATA(param3)
    param4 = DATA(param4)
    param5 = DATA(param5)     ).

    cl_abap_unit_assert=>assert_equals( exp = '0000001234' act = param1  ).
    cl_abap_unit_assert=>assert_equals( exp = '001' act = param2  ).
    cl_abap_unit_assert=>assert_equals( exp = '01' act = param3  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param4  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param5  ).

  ENDMETHOD.

  METHOD bo_agrmt.
    DATA lv_bo_id TYPE /gicom/bo_id VALUE '0000001234'.

    /gicom/cl_util_bo=>split_bo_id( EXPORTING iv_bo_id = lv_bo_id iv_bo_typ = '/GICOM/V06'
    IMPORTING
    param1 = DATA(param1)
    param2 = DATA(param2)
    param3 = DATA(param3)
    param4 = DATA(param4)
    param5 = DATA(param5)     ).

    cl_abap_unit_assert=>assert_equals( exp = '0000001234' act = param1  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param2  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param3  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param4  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param5  ).



  ENDMETHOD.

  METHOD bo_cntr_var.

    DATA lv_bo_id TYPE /gicom/bo_id VALUE '0000001234001'.

    /gicom/cl_util_bo=>split_bo_id( EXPORTING iv_bo_id = lv_bo_id iv_bo_typ = '/GICOM/V03'
    IMPORTING
    param1 = DATA(param1)
    param2 = DATA(param2)
    param3 = DATA(param3)
    param4 = DATA(param4)
    param5 = DATA(param5)     ).

    cl_abap_unit_assert=>assert_equals( exp = '0000001234' act = param1  ).
    cl_abap_unit_assert=>assert_equals( exp = '001' act = param2  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param3  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param4  ).
    cl_abap_unit_assert=>assert_equals( exp = '' act = param5  ).



  ENDMETHOD.

  METHOD others.

    DATA lv_bo_id TYPE /gicom/bo_id VALUE '0000001234'.
    TRY.
        /gicom/cl_util_bo=>split_bo_id( EXPORTING iv_bo_id = lv_bo_id iv_bo_typ = 'PANCAKES' ).
        cl_abap_unit_assert=>fail( 'Exception did not occur as expected' ).
      CATCH /gicom/cx_invalid_arguments.
        " Yeah cool it's working
    ENDTRY.



  ENDMETHOD.


  METHOD bo_ngr_lth_exc.

*
*    DATA lv_bo_id TYPE /gicom/bo_id VALUE '0000000000'.
*
*    TRY.
*        /gicom/cl_util_bo=>split_bo_id( EXPORTING iv_bo_id = lv_bo_id iv_bo_typ = '/GICOM/V08'
*         ).
*        cl_abap_unit_assert=>fail( 'Exception /gicom/cx_bo_id_illegal_length did not occur as expected' ).
*      CATCH /gicom/cx_bo_id_illegal_length INTO DATA(lo_exc).
*
*    ENDTRY.



  ENDMETHOD.

  METHOD bo_ng_lth_exc.

    DATA lv_bo_id TYPE /gicom/bo_id VALUE '000000123'.

    TRY.
        /gicom/cl_util_bo=>split_bo_id( EXPORTING iv_bo_id = lv_bo_id iv_bo_typ = '/GICOM/V09'
         ).
        cl_abap_unit_assert=>fail( 'Exception /gicom/cx_bo_id_illegal_length did not occur as expected' ).
      CATCH /gicom/cx_bo_id_illegal_length INTO DATA(lo_exc).
    ENDTRY.

  ENDMETHOD.

  METHOD bo_addend_lth_exc.

    DATA lv_bo_id TYPE /gicom/bo_id VALUE '00000012345'.

    TRY.
        /gicom/cl_util_bo=>split_bo_id( EXPORTING iv_bo_id = lv_bo_id iv_bo_typ = '/GICOM/V04'
         ).
        cl_abap_unit_assert=>fail( 'Exception /gicom/cx_bo_id_illegal_length did not occur as expected' ).
      CATCH /gicom/cx_bo_id_illegal_length INTO DATA(lo_exc).
    ENDTRY.

  ENDMETHOD.

  METHOD bo_agrmt_lth_exc.
    DATA lv_bo_id TYPE /gicom/bo_id VALUE '0000000000'.
    TRY.
        /gicom/cl_util_bo=>split_bo_id( EXPORTING iv_bo_id = lv_bo_id iv_bo_typ = '/GICOM/V06'
        ).
        cl_abap_unit_assert=>fail( 'Exception /gicom/cx_bo_id_illegal_length did not occur as expected' ).
      CATCH /gicom/cx_bo_id_illegal_length INTO DATA(lo_exc).
    ENDTRY.


  ENDMETHOD.

  METHOD bo_cntr_var_lth_exc.

    DATA lv_bo_id TYPE /gicom/bo_id VALUE '000000123'.
    TRY.
        /gicom/cl_util_bo=>split_bo_id( EXPORTING iv_bo_id = lv_bo_id iv_bo_typ = '/GICOM/V03'
       ).
        cl_abap_unit_assert=>fail( 'Exception /gicom/cx_bo_id_illegal_length did not occur as expected' ).
      CATCH /gicom/cx_bo_id_illegal_length INTO DATA(lo_exc).
    ENDTRY.


  ENDMETHOD.








ENDCLASS.
