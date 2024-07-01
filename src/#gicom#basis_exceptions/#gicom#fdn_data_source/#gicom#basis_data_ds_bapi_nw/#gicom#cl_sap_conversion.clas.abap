CLASS /gicom/cl_sap_conversion DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CONSTANTS gv_utf8 TYPE abap_encod VALUE '4110'.

    CLASS-METHODS convert_date_to_external
      IMPORTING
        !iv_date_internal TYPE syst_datum OPTIONAL
      EXPORTING
        !ev_date_external TYPE any   ##ADT_PARAMETER_UNTYPED
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS scp_replace_strange_chars
      IMPORTING
        !iv_intext        TYPE any   ##ADT_PARAMETER_UNTYPED
        !iv_intext_lg     TYPE i DEFAULT 0
        !iv_inter_cp      TYPE tcp00-cpcodepage DEFAULT '0000'
        !iv_inter_base_cp TYPE tcp00-cpcodepage DEFAULT '0000'
        !iv_in_cp         TYPE tcp00-cpcodepage DEFAULT '0000'
        !iv_replacement   TYPE any DEFAULT 46   ##ADT_PARAMETER_UNTYPED
      EXPORTING
        !ev_outtext       TYPE any   ##ADT_PARAMETER_UNTYPED
        !ev_outused       TYPE any   ##ADT_PARAMETER_UNTYPED
        !ev_outoverflow   TYPE any   ##ADT_PARAMETER_UNTYPED
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS sotr_serv_string_to_table
      IMPORTING
        !iv_text                TYPE string
        !iv_flag_no_line_breaks TYPE as4flag DEFAULT 'X'
        !iv_line_length         TYPE i OPTIONAL
        !iv_langu               TYPE sylangu DEFAULT sy-langu
      CHANGING
        !ct_text_tab            TYPE STANDARD TABLE  ##ADT_PARAMETER_UNTYPED.
    CLASS-METHODS scms_xstring_to_binary
      IMPORTING
        !iv_buffer          TYPE xstring
        !iv_append_to_table TYPE c DEFAULT space
      EXPORTING
        !ev_output_length   TYPE i
      CHANGING
        !ct_binary_tab      TYPE STANDARD TABLE  ##ADT_PARAMETER_UNTYPED
      RAISING
        /gicom/cx_sap_call_error.
    CLASS-METHODS scms_binary_to_xstring
      IMPORTING
        !iv_input_length TYPE i
      EXPORTING
        !ev_buffer       TYPE xstring
      CHANGING
        !ct_binary_tab   TYPE STANDARD TABLE  ##ADT_PARAMETER_UNTYPED
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS swa_string_from_table
      IMPORTING
        !it_character_table      TYPE table
        !iv_number_of_characters TYPE i OPTIONAL
        !iv_line_size            TYPE i OPTIONAL
        !iv_keep_trailing_spaces TYPE xfeld DEFAULT space
        !iv_check_table_type     TYPE xfeld DEFAULT space
      EXPORTING
        !ev_character_string     TYPE string
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS ecatt_conv_xstring_to_string
      IMPORTING
        !iv_xstring  TYPE etxml_line_str
        !iv_encoding TYPE abap_encod DEFAULT 'UTF-8'
      EXPORTING
        !ev_string   TYPE string .
    CLASS-METHODS conversion_exit_var_output
      IMPORTING
        !iv_input       TYPE any   ##ADT_PARAMETER_UNTYPED
        !iv_conv_exit   TYPE convexit DEFAULT 'ALPHA'
      EXPORTING
        !ev_output    TYPE any  ##ADT_PARAMETER_UNTYPED
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS conversion_exit_var_input
      IMPORTING
        !iv_input       TYPE any   ##ADT_PARAMETER_UNTYPED
        !iv_conv_exit   TYPE convexit DEFAULT 'ALPHA'
        !iv_language    TYPE sy-langu OPTIONAL
      EXPORTING
        !ev_output    TYPE any  ##ADT_PARAMETER_UNTYPED
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS encode_base64
      IMPORTING
        !iv_decoded       TYPE xstring
      RETURNING
        VALUE(rv_encoded) TYPE xstring.
    CLASS-METHODS decode_base64
      IMPORTING
        !iv_encoded       TYPE xstring
      RETURNING
        VALUE(rv_decoded) TYPE xstring.
    CLASS-METHODS xstring_to_string
      IMPORTING
        iv_xstring       TYPE xstring
        iv_encoding      TYPE abap_encod DEFAULT gv_utf8
      RETURNING
        VALUE(rv_string) TYPE string
      RAISING
        /gicom/cx_conversion_error.
    CLASS-METHODS string_to_xstring
      IMPORTING
        iv_string         TYPE string
        iv_encoding       TYPE abap_encod DEFAULT gv_utf8
      RETURNING
        VALUE(rv_xstring) TYPE xstring
      RAISING
        /gicom/cx_conversion_error.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CL_SAP_CONVERSION IMPLEMENTATION.


  METHOD conversion_exit_var_input.

    DATA(lv_funcname) = 'CONVERSION_EXIT_' && iv_conv_exit && '_INPUT'.

    IF iv_language IS NOT INITIAL.

      CALL FUNCTION lv_funcname
        EXPORTING
          input    = iv_input
          language = iv_language
        IMPORTING
          output = ev_output
        EXCEPTIONS
          OTHERS = 1.

    ELSE.

       CALL FUNCTION lv_funcname
        EXPORTING
          input    = iv_input
        IMPORTING
          output = ev_output
        EXCEPTIONS
          OTHERS = 1.

     ENDIF.


    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = lv_funcname
          iv_subrc           = sy-subrc.
    ENDIF.

  ENDMETHOD.


  METHOD conversion_exit_var_output.

    DATA(lv_funcname) = 'CONVERSION_EXIT_' && iv_conv_exit && '_OUTPUT'.

    CALL FUNCTION lv_funcname
      EXPORTING
        input  = iv_input
      IMPORTING
        output = ev_output
      EXCEPTIONS
        OTHERS = 1.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = lv_funcname
          iv_subrc           = sy-subrc.
    ENDIF.

  ENDMETHOD.


  METHOD convert_date_to_external.
    DATA(lv_date_internal) = /gicom/cl_system=>get_date( iv_date_internal ).
    CALL FUNCTION 'CONVERT_DATE_TO_EXTERNAL'
      EXPORTING
        date_internal            = lv_date_internal
      IMPORTING
        date_external            = ev_date_external
      EXCEPTIONS
        date_internal_is_invalid = 1.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'CONVERT_DATE_TO_EXTERNAL'
          iv_subrc           = sy-subrc.
    ENDIF.
  ENDMETHOD.


  METHOD decode_base64.
    " MOD MR M.19600 - replaced cl_abap_conv_codepage=>create_in as it is not supported by NW <= 7.52
    DATA(lv_string) = /gicom/cl_sap_conversion=>xstring_to_string(
      EXPORTING
        iv_xstring  = iv_encoded
        iv_encoding = gv_utf8
    ).

    rv_decoded = cl_http_utility=>decode_x_base64(
      EXPORTING
        encoded = lv_string
    ).
  ENDMETHOD.


  METHOD ecatt_conv_xstring_to_string.
    CALL FUNCTION 'ECATT_CONV_XSTRING_TO_STRING'
      EXPORTING
        im_xstring  = iv_xstring
        im_encoding = iv_encoding
      IMPORTING
        ex_string   = ev_string.
  ENDMETHOD.


  METHOD encode_base64.
    DATA(lv_base64) = cl_http_utility=>encode_x_base64(
      EXPORTING
        unencoded = iv_decoded
    ).

    " MOD MR M.19600 - replaced cl_abap_conv_codepage=>create_out as it is not supported by NW <= 7.52
    rv_encoded = /gicom/cl_sap_conversion=>string_to_xstring(
      EXPORTING
        iv_string = lv_base64
    ).
  ENDMETHOD.


  METHOD scms_binary_to_xstring.

    CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
      EXPORTING
        input_length = iv_input_length
*       FIRST_LINE   = 0
*       LAST_LINE    = 0
      IMPORTING
        buffer       = ev_buffer
      TABLES
        binary_tab   = ct_binary_tab
      EXCEPTIONS
        failed       = 1
        OTHERS       = 2.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'SCMS_BINARY_TO_XSTRING'
          iv_subrc           = sy-subrc.
    ENDIF.

  ENDMETHOD.


  METHOD scms_xstring_to_binary.

    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        buffer          = iv_buffer
        append_to_table = iv_append_to_table
      IMPORTING
        output_length   = ev_output_length
      TABLES
        binary_tab      = ct_binary_tab.

*    IF sy-subrc <> 0.
*      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
*        iv_function_module = 'SCMS_XSTRING_TO_BINARY'
*        iv_subrc           = sy-subrc
*      ).
*    ENDIF.

  ENDMETHOD.


  METHOD scp_replace_strange_chars.
    CALL FUNCTION 'SCP_REPLACE_STRANGE_CHARS'
      EXPORTING
        intext            = iv_intext
        intext_lg         = iv_intext_lg
        inter_cp          = iv_inter_cp
        inter_base_cp     = iv_inter_base_cp
        in_cp             = iv_in_cp
        replacement       = iv_replacement
      IMPORTING
        outtext           = ev_outtext
        outused           = ev_outused
        outoverflow       = ev_outoverflow
      EXCEPTIONS
        invalid_codepage  = 1
        codepage_mismatch = 2
        internal_error    = 3
        cannot_convert    = 4
        fields_not_type_c = 5.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'SCP_REPLACE_STRANGE_CHARS'
          iv_subrc           = sy-subrc.
    ENDIF.
  ENDMETHOD.


  METHOD sotr_serv_string_to_table.

    CALL FUNCTION 'SOTR_SERV_STRING_TO_TABLE'
      EXPORTING
        text        = iv_text
*       flag_no_line_breaks = iv_flag_no_line_breaks
        line_length = iv_line_length
*       langu       = iv_langu
      TABLES
        text_tab    = ct_text_tab.

  ENDMETHOD.


  METHOD swa_string_from_table.
    CALL FUNCTION 'SWA_STRING_FROM_TABLE'
      EXPORTING
        character_table            = it_character_table
        number_of_characters       = iv_number_of_characters
        line_size                  = iv_line_size
        keep_trailing_spaces       = iv_keep_trailing_spaces
        check_table_type           = iv_check_table_type
      IMPORTING
        character_string           = ev_character_string
      EXCEPTIONS
        no_flat_charlike_structure = 1.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'SWA_STRING_FROM_TABLE'
          iv_subrc           = sy-subrc.
    ENDIF.
  ENDMETHOD.


  METHOD xstring_to_string.
    DATA lv_cp TYPE cpcodepage.
    lv_cp = iv_encoding.

    TRY.
        rv_string = cl_bcs_convert=>xstring_to_string(
          EXPORTING
            iv_xstr = iv_xstring
            iv_cp   = lv_cp
        ).
      CATCH cx_bcs INTO DATA(lx_bcs).
        RAISE EXCEPTION TYPE /gicom/cx_conversion_error EXPORTING previous = lx_bcs .
    ENDTRY.
  ENDMETHOD.


  METHOD string_to_xstring.
    TRY.
        rv_xstring = cl_bcs_convert=>string_to_xstring(
          EXPORTING
            iv_string   = iv_string
            iv_codepage = iv_encoding
        ).
      CATCH cx_bcs INTO DATA(lx_bcs).
        RAISE EXCEPTION TYPE /gicom/cx_conversion_error EXPORTING previous = lx_bcs .
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
