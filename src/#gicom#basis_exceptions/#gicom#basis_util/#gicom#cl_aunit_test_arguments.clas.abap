CLASS /gicom/cl_aunit_test_arguments DEFINITION
  PUBLIC
  CREATE PUBLIC
  FOR TESTING.

  PUBLIC SECTION.

    INTERFACES:

      if_abap_testdouble_arguments.

    ALIASES:

      get_param_changing          FOR if_abap_testdouble_arguments~get_param_changing,

      get_param_importing         FOR if_abap_testdouble_arguments~get_param_importing,

      has_next_parameter          FOR if_abap_testdouble_arguments~has_next_parameter,

      is_changing_param_supplied  FOR if_abap_testdouble_arguments~is_changing_param_supplied,

      is_importing_param_supplied FOR if_abap_testdouble_arguments~is_importing_param_supplied,

      next_parameter              FOR if_abap_testdouble_arguments~next_parameter,

      reset_iterator              FOR if_abap_testdouble_arguments~reset_iterator,

      size_of                     FOR if_abap_testdouble_arguments~size_of.

    METHODS:

      constructor
        IMPORTING
          io_arguments TYPE REF TO if_abap_testdouble_arguments,

      ignore_parameter
        IMPORTING
          iv_parameter_name TYPE abap_parmname.

  PRIVATE SECTION.

    DATA:

      go_arguments           TYPE REF TO if_abap_testdouble_arguments,

      gtr_ignored_parameters TYPE RANGE OF abap_parmname.

ENDCLASS.



CLASS /GICOM/CL_AUNIT_TEST_ARGUMENTS IMPLEMENTATION.


  METHOD constructor.
    go_arguments = io_arguments.
  ENDMETHOD.


  METHOD ignore_parameter.
    INSERT VALUE #(
      sign   = 'I'
      option = 'EQ'
      low    = iv_parameter_name
    ) INTO TABLE gtr_ignored_parameters.
  ENDMETHOD.


  METHOD if_abap_testdouble_arguments~get_param_changing.
    value = go_arguments->get_param_changing( name ).
  ENDMETHOD.


  METHOD if_abap_testdouble_arguments~get_param_importing.
    value = go_arguments->get_param_importing( name ).
  ENDMETHOD.


  METHOD if_abap_testdouble_arguments~has_next_parameter.
    result = go_arguments->has_next_parameter( ).
  ENDMETHOD.


  METHOD if_abap_testdouble_arguments~is_changing_param_supplied.
    result = go_arguments->is_changing_param_supplied( name ).
  ENDMETHOD.


  METHOD if_abap_testdouble_arguments~is_importing_param_supplied.
    result = go_arguments->is_importing_param_supplied( name ).
  ENDMETHOD.


  METHOD if_abap_testdouble_arguments~next_parameter.
    go_arguments->next_parameter(
      IMPORTING
        name   = name
        kind   = kind
        ignore = ignore
    ).

    IF gtr_ignored_parameters IS NOT INITIAL AND name IN gtr_ignored_parameters.
      ignore = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD if_abap_testdouble_arguments~reset_iterator.
    go_arguments->reset_iterator( ).
  ENDMETHOD.


  METHOD if_abap_testdouble_arguments~size_of.
    size = go_arguments->size_of( ).
  ENDMETHOD.
ENDCLASS.
