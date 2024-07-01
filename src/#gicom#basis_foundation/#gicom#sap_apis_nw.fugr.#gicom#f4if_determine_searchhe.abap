FUNCTION /GICOM/F4IF_DETERMINE_SEARCHHE .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_TABNAME) TYPE  DFIES-TABNAME
*"     VALUE(IV_FIELDNAME) TYPE  DFIES-FIELDNAME
*"     REFERENCE(IV_SELECTION_SCREEN) TYPE  DDBOOL_D DEFAULT SPACE
*"  EXPORTING
*"     VALUE(ES_SHLP) TYPE  SHLP_DESCR
*"  EXCEPTIONS
*"      FIELD_NOT_FOUND
*"      NO_HELP_FOR_FIELD
*"      INCONSISTENT_HELP
*"--------------------------------------------------------------------

  CALL FUNCTION 'F4IF_DETERMINE_SEARCHHELP'
    EXPORTING
      tabname           = iv_tabname
      fieldname         = iv_fieldname
      selection_screen  = iv_selection_screen
    IMPORTING
      shlp              = es_shlp
    EXCEPTIONS
      field_not_found   = 1
      no_help_for_field = 2
      inconsistent_help = 3
      OTHERS            = 4.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
