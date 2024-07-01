FUNCTION /GICOM/DDUT_TEXTTABLE_GET .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_TABNAME) TYPE  TABNAME
*"  EXPORTING
*"     VALUE(EV_TEXTTABLE) TYPE  DD08V-TABNAME
*"     VALUE(EV_CHECKFIELD) TYPE  DD08V-FIELDNAME
*"--------------------------------------------------------------------

  CALL FUNCTION 'DDUT_TEXTTABLE_GET'
    EXPORTING
      tabname    = iv_tabname
    IMPORTING
      texttable  = ev_texttable
      checkfield = ev_checkfield.

ENDFUNCTION.
