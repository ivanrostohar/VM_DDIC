FUNCTION /gicom/check_client_productive.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXCEPTIONS
*"      CLIENT_IS_PRODUCTIVE
*"----------------------------------------------------------------------


  CALL FUNCTION 'PRGN_CHECK_SYSTEM_PRODUCTIVE'
    EXCEPTIONS
      client_is_productive = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
    RAISE client_is_productive.
  ENDIF.



ENDFUNCTION.
