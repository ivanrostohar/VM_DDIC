INTERFACE /gicom/if_dso_currency
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select
    IMPORTING
      !it_currencies       TYPE /gicom/currency_tty OPTIONAL
    RETURNING
      VALUE(rt_currencies) TYPE /gicom/currency_st_tty
    RAISING
      /gicom/cx_root_ds .

  METHODS get_exchange_rate
    IMPORTING
      !iv_from_currency TYPE /gicom/currency
      !iv_to_currency   TYPE /gicom/currency
      !iv_date          TYPE /gicom/date DEFAULT sy-datum
    EXPORTING
      !ev_exchange_rate TYPE /gicom/currency_factor
      !ev_from_factor   TYPE /gicom/currency_factor
      !ev_to_factor     TYPE /gicom/currency_factor
    RAISING
      /gicom/cx_root_ds .

  METHODS select_for_mandt
    IMPORTING
      !iv_mandt          TYPE mandt DEFAULT sy-mandt
    RETURNING
      VALUE(rv_currency) TYPE /gicom/currency
    RAISING
      /gicom/cx_root_ds .

   METHODS insert_currencies
    IMPORTING
      it_currencies TYPE  /gicom/_curr_a_tt
      iv_commit TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_currencies
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_currencies
    IMPORTING
       it_selopt           TYPE ddshselops OPTIONAL
    RETURNING
      VALUE(rt_currencies) TYPE /gicom/_curr_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.



ENDINTERFACE.
