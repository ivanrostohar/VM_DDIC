FUNCTION /GICOM/TR_INSERT_NEW_COMM .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_KURZTEXT) LIKE  E07T-AS4TEXT
*"     VALUE(IV_TRFUNCTION) LIKE  E070-TRFUNCTION
*"     VALUE(IV_STRKORR) LIKE  E070-STRKORR DEFAULT SPACE
*"     VALUE(IV_CATEGORY) LIKE  E070-KORRDEV DEFAULT SPACE
*"     VALUE(IV_TARSYSTEM) LIKE  E070-TARSYSTEM DEFAULT SPACE
*"     VALUE(IV_CLIENT) LIKE  E070C-CLIENT DEFAULT SPACE
*"     VALUE(IV_TARGET_CLIENT) LIKE  E070C-TARCLIENT DEFAULT SPACE
*"     VALUE(IV_TARDEVCL) LIKE  E070M-TARDEVCL DEFAULT SPACE
*"     VALUE(IV_DEVCLASS) LIKE  E070M-DEVCLASS DEFAULT SPACE
*"     VALUE(IV_TARLAYER) LIKE  E070M-TARLAYER DEFAULT SPACE
*"     VALUE(IV_PROTECT) LIKE  TRPARI-S_LOCKFLAG DEFAULT SPACE
*"     VALUE(IV_SIMULATION) LIKE  TRPARI-W_SIMULAT DEFAULT SPACE
*"  EXPORTING
*"     VALUE(EV_TRKORR) LIKE  E070-TRKORR
*"     VALUE(ES_E070) LIKE  E070 STRUCTURE  E070
*"     VALUE(ES_E07T) LIKE  E07T STRUCTURE  E07T
*"     VALUE(ES_E070C) LIKE  E070C STRUCTURE  E070C
*"     VALUE(ES_E070M) LIKE  E070M STRUCTURE  E070M
*"  EXCEPTIONS
*"      CLIENT_RANGE_FULL
*"      E070L_INSERT_ERROR
*"      E070L_UPDATE_ERROR
*"      E070_INSERT_ERROR
*"      E07T_INSERT_ERROR
*"      E070C_INSERT_ERROR
*"      E070M_INSERT_ERROR
*"      NO_SYSTEMNAME
*"      NO_SYSTEMTYPE
*"      SAP_RANGE_FULL
*"      UNALLOWED_TRFUNCTION
*"      UNALLOWED_USER
*"      ORDER_NOT_FOUND
*"      INVALID_TARGETSYSTEM
*"      INVALID_TARGET_DEVCLASS
*"      INVALID_DEVCLASS
*"      INVALID_TARGET_LAYER
*"      INVALID_STATUS
*"      NOT_AN_ORDER
*"      ORDER_LOCK_FAILED
*"      NO_AUTHORIZATION
*"      WRONG_CLIENT
*"      FILE_ACCESS_ERROR
*"      WRONG_CATEGORY
*"      INTERNAL_ERROR
*"--------------------------------------------------------------------

  CALL FUNCTION 'TR_INSERT_NEW_COMM'
    EXPORTING
      wi_kurztext             = iv_kurztext
      wi_trfunction           = iv_trfunction
      wi_strkorr              = iv_strkorr
      wi_category             = iv_category
      iv_tarsystem            = iv_tarsystem
      wi_client               = iv_client
      wi_target_client        = iv_target_client
      iv_tardevcl             = iv_tardevcl
      iv_devclass             = iv_devclass
      iv_tarlayer             = iv_tarlayer
      wi_protect              = iv_protect
      iv_simulation           = iv_simulation
    IMPORTING
      we_trkorr               = ev_trkorr
      we_e070                 = es_e070
      we_e07t                 = es_e07t
      we_e070c                = es_e070c
      es_e070m                = es_e070m
    EXCEPTIONS
      client_range_full       = 1
      e070l_insert_error      = 2
      e070l_update_error      = 3
      e070_insert_error       = 4
      e07t_insert_error       = 5
      e070c_insert_error      = 6
      e070m_insert_error      = 7
      no_systemname           = 8
      no_systemtype           = 9
      sap_range_full          = 10
      unallowed_trfunction    = 11
      unallowed_user          = 12
      order_not_found         = 13
      invalid_targetsystem    = 14
      invalid_target_devclass = 15
      invalid_devclass        = 16
      invalid_target_layer    = 17
      invalid_status          = 18
      not_an_order            = 19
      order_lock_failed       = 20
      no_authorization        = 21
      wrong_client            = 22
      file_access_error       = 23
      wrong_category          = 24
      internal_error          = 25
      OTHERS                  = 26.
  IF sy-subrc <> 0.

  ENDIF.

ENDFUNCTION.
