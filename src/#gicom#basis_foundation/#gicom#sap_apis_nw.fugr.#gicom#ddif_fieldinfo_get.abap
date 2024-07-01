FUNCTION /gicom/ddif_fieldinfo_get.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_TABNAME) TYPE  DDOBJNAME
*"     VALUE(IV_FIELDNAME) TYPE  DFIES-FIELDNAME DEFAULT ' '
*"     VALUE(IV_LANGU) TYPE  SY-LANGU DEFAULT SY-LANGU
*"     VALUE(IV_LFIELDNAME) TYPE  DFIES-LFIELDNAME DEFAULT ' '
*"     VALUE(IV_ALL_TYPES) TYPE  DDBOOL_D DEFAULT ' '
*"     VALUE(IV_GROUP_NAMES) TYPE  DDBOOL_D DEFAULT ' '
*"     VALUE(IV_UCLEN) TYPE  /GICOM/UNICODELG OPTIONAL
*"     VALUE(IV_DO_NOT_WRITE) TYPE  DDBOOL_D DEFAULT ' '
*"  EXPORTING
*"     VALUE(ES_X030L_WA) TYPE  X030L
*"     VALUE(EV_DDOBJTYPE) TYPE  DD02V-TABCLASS
*"     VALUE(ES_DFIES_WA) TYPE  DFIES
*"     VALUE(ET_LINES_DESCR) TYPE  DDTYPELIST
*"  TABLES
*"      DFIES_TAB STRUCTURE  DFIES OPTIONAL
*"      FIXED_VALUES TYPE  DDFIXVALUES OPTIONAL
*"  EXCEPTIONS
*"      NOT_FOUND
*"      INTERNAL_ERROR
*"----------------------------------------------------------------------

  CALL FUNCTION 'DDIF_FIELDINFO_GET'
    EXPORTING
      tabname        = iv_tabname
      fieldname      = iv_fieldname
      langu          = iv_langu
      lfieldname     = iv_lfieldname
      all_types      = iv_all_types
      group_names    = iv_group_names
      uclen          = iv_uclen
      do_not_write   = iv_do_not_write
    IMPORTING
      x030l_wa       = es_x030l_wa
      ddobjtype      = ev_ddobjtype
      dfies_wa       = es_dfies_wa
      lines_descr    = et_lines_descr
    TABLES
      dfies_tab      = dfies_tab
      fixed_values   = fixed_values
    EXCEPTIONS
      not_found      = 1
      internal_error = 2
      OTHERS         = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
