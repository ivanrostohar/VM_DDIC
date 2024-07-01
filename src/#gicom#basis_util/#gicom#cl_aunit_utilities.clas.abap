CLASS /gicom/cl_aunit_utilities DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS:

      is_unit_test_active
        RETURNING
          VALUE(rv_active) TYPE /gicom/abap_bool,

      assert_not_in_unit_test
        IMPORTING
          iv_message TYPE string DEFAULT `Forbidden code reached`.

ENDCLASS.



CLASS /gicom/cl_aunit_utilities IMPLEMENTATION.

  METHOD is_unit_test_active.
    rv_active = xsdbool( sy-cprog CS 'RS_AUNIT_SBOX' ).
  ENDMETHOD.


  METHOD assert_not_in_unit_test.
    " If we are not in a unit test we can safely exit
    IF NOT /gicom/cl_aunit_utilities=>is_unit_test_active( ).
      RETURN.
    ENDIF.

    " Otherwise we have to do some ugly stuff:
    " We have to dynamically call the assertion as the ABAP compiler does not
    " want us to call this in non-testing code. However, if we mark this code
    " as "FOR TESTING", we cannot call it in production code.
    CALL METHOD ('CL_ABAP_UNIT_ASSERT')=>('FAIL')
      EXPORTING
        msg = iv_message.
  ENDMETHOD.

ENDCLASS.
