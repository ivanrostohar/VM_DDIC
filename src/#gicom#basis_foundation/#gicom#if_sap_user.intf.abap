interface /GICOM/IF_SAP_USER
  public .
  METHODS:
    bapi_user_get_detail
      IMPORTING
        iv_username       TYPE bapibname-bapibname
        iv_cache_results  TYPE flag_x DEFAULT 'X'
      EXPORTING
        es_logondata      TYPE bapilogond
        es_defaults       TYPE bapidefaul
        es_address        TYPE bapiaddr3
      CHANGING
        ct_return         TYPE    bapiret2_t OPTIONAL
        ct_addsmtp        TYPE    bapiadsmtp_t OPTIONAL,

    bapi_user_existence_check
      IMPORTING
        iv_username TYPE bapibname-bapibname
      EXPORTING
        es_return   TYPE bapiret2.

endinterface.
