CLASS /gicom/cl_util_code DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS:

      adjust_source_line
        IMPORTING
          iv_line                 TYPE i
          iv_clsname              TYPE seoclsname
          iv_include              TYPE progname
        RETURNING
          VALUE(rv_adjusted_line) TYPE i,

      prevent_rfc_call_once.

  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA:

      sv_prevent_rfc_call TYPE abap_bool VALUE abap_false.

    CLASS-METHODS:

      adjust_source_line_rfc
        IMPORTING
          iv_line                 TYPE i
          iv_clsname              TYPE seoclsname
          iv_include              TYPE progname
        RETURNING
          VALUE(rv_adjusted_line) TYPE i.

ENDCLASS.



CLASS /gicom/cl_util_code IMPLEMENTATION.


  METHOD adjust_source_line.
    DATA:
      lo_clif_source   TYPE REF TO if_oo_clif_source,
      ls_clif_key      TYPE seoclskey,
      lo_pos_converter TYPE REF TO cl_oo_source_pos_converter,
      ls_include_pos   TYPE cl_oo_source_pos_converter=>type_include_position,
      ls_source_pos    TYPE cl_source_scanner=>type_source_position.

    IF sv_prevent_rfc_call = abap_false.
      IF /gicom/cl_system=>is_running_in_consumer( ) OR /gicom/cl_system=>is_running_in_task( ).
        " when running inside an ABAP daemon, we wrap this functionality in a synchronous RFC call
        " this has to be done due to illegal statements such as 'wait' that occur in the SAP coding below
        rv_adjusted_line = /gicom/cl_util_code=>adjust_source_line_rfc(
          iv_line    = iv_line
          iv_clsname = iv_clsname
          iv_include = iv_include
        ).
        RETURN.
      ENDIF.
    ENDIF.

    /gicom/cl_util_code=>sv_prevent_rfc_call = abap_false.

    TRY.
        CLEAR: lo_clif_source, ls_clif_key, ls_source_pos, ls_include_pos.

        ls_clif_key-clsname = iv_clsname.

        lo_clif_source = cl_oo_factory=>create_instance( )->create_clif_source( iv_clsname ).

        lo_pos_converter = cl_oo_source_pos_converter=>create( clif_key  = ls_clif_key
                                                               source    = lo_clif_source ).

        ls_include_pos-include = iv_include.

        ls_include_pos-source_position-column = 1.
        ls_include_pos-source_position-line = iv_line.

        ls_source_pos = lo_pos_converter->get_position_by_include( include_position = ls_include_pos ).

        rv_adjusted_line = ls_source_pos-line.
      CATCH cx_oo_clif_not_exists cx_oo_clif_scan_error cx_oo_clif_component cx_oo_invalid_source_position.

        rv_adjusted_line = iv_line.
    ENDTRY.
  ENDMETHOD.


  METHOD adjust_source_line_rfc.
    CALL FUNCTION '/GICOM/RFC_ADJUST_SOURCE_POS'
      DESTINATION 'NONE'
      EXPORTING
        iv_line          = iv_line
        iv_clsname       = iv_clsname
        iv_include       = iv_include
      IMPORTING
        ev_adjusted_line = rv_adjusted_line.
  ENDMETHOD.


  METHOD prevent_rfc_call_once.
    /gicom/cl_util_code=>sv_prevent_rfc_call = abap_true.
  ENDMETHOD.

ENDCLASS.
