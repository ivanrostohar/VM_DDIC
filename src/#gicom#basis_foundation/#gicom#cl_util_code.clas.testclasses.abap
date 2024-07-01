*"* use this source file for your ABAP unit test classes
CLASS ltc_adjust_source_line DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.

    CLASS-DATA:

      sv_include    TYPE program,

      sv_class_name TYPE seoclsname VALUE '/GICOM/CL_UTIL_CODE'.

    CLASS-METHODS:

      class_setup,

      class_teardown.


    METHODS:

      runs_with_rfc FOR TESTING,

      runs_without_rfc FOR TESTING.

ENDCLASS.

CLASS ltc_adjust_source_line IMPLEMENTATION.

  METHOD runs_without_rfc.
    DATA(lv_line) = 4.

    DATA(lv_adjusted_line) = /gicom/cl_util_code=>adjust_source_line(
      iv_line    = lv_line
      iv_clsname = sv_class_name
      iv_include = sv_include
    ).

    cl_abap_unit_assert=>assert_equals(
      exp = '47'
      act = lv_adjusted_line
    ).
  ENDMETHOD.

  METHOD runs_with_rfc.
    DATA(lv_line) = 4.

    /gicom/cl_system=>set_current_task( 'DUMMY' ).

    DATA(lv_adjusted_line) = /gicom/cl_util_code=>adjust_source_line(
      iv_line    = lv_line
      iv_clsname = sv_class_name
      iv_include = sv_include
    ).

    cl_abap_unit_assert=>assert_equals(
      exp = '47'
      act = lv_adjusted_line
    ).

    /gicom/cl_system=>reset_current_task( ).
  ENDMETHOD.

  METHOD class_setup.
    sv_include = cl_oo_classname_service=>get_method_include( VALUE #( clsname = '/GICOM/CL_UTIL_CODE' cpdname = 'ADJUST_SOURCE_LINE' ) ).
  ENDMETHOD.

  METHOD class_teardown.
    /gicom/cl_system=>reset_current_task( ).
  ENDMETHOD.

ENDCLASS.
