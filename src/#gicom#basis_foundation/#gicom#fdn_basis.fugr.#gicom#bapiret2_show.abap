FUNCTION /GICOM/BAPIRET2_SHOW.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  TABLES
*"      I_BAPIRET2_TAB STRUCTURE  BAPIRET2
*"----------------------------------------------------------------------

* Local data -----------------------------------------------------------

  DATA: L_LINES TYPE I.

* Function body --------------------------------------------------------

* check the number of messages
  DESCRIBE TABLE I_BAPIRET2_TAB LINES L_LINES.

* if we have only one message, we don't show a screen
  IF L_LINES <= 1.
    LOOP AT I_BAPIRET2_TAB.
      MESSAGE ID     I_BAPIRET2_TAB-ID
              TYPE   I_BAPIRET2_TAB-TYPE
              NUMBER I_BAPIRET2_TAB-NUMBER
              WITH   I_BAPIRET2_TAB-MESSAGE_V1
                     I_BAPIRET2_TAB-MESSAGE_V2
                     I_BAPIRET2_TAB-MESSAGE_V3
                     I_BAPIRET2_TAB-MESSAGE_V4.
    ENDLOOP.
  ELSE.

* we have more than one message, we show them on a screen
    CALL FUNCTION 'MESSAGES_INITIALIZE'.
    LOOP AT I_BAPIRET2_TAB.
      CALL FUNCTION 'MESSAGE_STORE'
           EXPORTING
                ARBGB                   = I_BAPIRET2_TAB-ID
                MSGTY                   = I_BAPIRET2_TAB-TYPE
                MSGV1                   = I_BAPIRET2_TAB-MESSAGE_V1
                MSGV2                   = I_BAPIRET2_TAB-MESSAGE_V2
                MSGV3                   = I_BAPIRET2_TAB-MESSAGE_V3
                MSGV4                   = I_BAPIRET2_TAB-MESSAGE_V4
                TXTNR                   = I_BAPIRET2_TAB-NUMBER
           EXCEPTIONS
                MESSAGE_TYPE_NOT_VALID  = 1
                NOT_ACTIVE              = 2
                OTHERS                  = 3.
      IF SY-SUBRC <> 0.
*       nothing to do
      ENDIF.
    ENDLOOP.

    CALL FUNCTION 'MESSAGES_STOP'
         EXCEPTIONS
              A_MESSAGE = 1
              E_MESSAGE = 2
              I_MESSAGE = 3
              W_MESSAGE = 4
              OTHERS    = 5.

    IF SY-SUBRC <> 0.
*     nothing to do
    ENDIF.


    CALL FUNCTION 'MESSAGES_SHOW'
         EXCEPTIONS
              INCONSISTENT_RANGE    = 1
              NO_MESSAGES           = 2
              OTHERS                = 3.
    IF SY-SUBRC <> 0.
*     nothing to do
    ENDIF.
  ENDIF.




ENDFUNCTION.
