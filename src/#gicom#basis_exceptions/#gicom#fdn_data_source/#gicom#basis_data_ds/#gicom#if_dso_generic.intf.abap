INTERFACE /gicom/if_dso_generic
  PUBLIC.

  INTERFACES:
    if_badi_interface.

  METHODS:
    select
      IMPORTING
        iv_table           TYPE tabname
        iv_where           TYPE string OPTIONAL
        it_for_all_entries TYPE ANY TABLE OPTIONAL
      CHANGING
        ct_result          TYPE ANY TABLE
      RAISING
        /gicom/cx_root_ds,

    select_with_selopts
      IMPORTING
        iv_table           TYPE tabname
        it_selopts         TYPE ddshselops OPTIONAL
        it_for_all_entries TYPE ANY TABLE OPTIONAL
      CHANGING
        ct_result          TYPE ANY TABLE
      RAISING
        /gicom/cx_root_ds,

    select_single
      IMPORTING
        iv_table  TYPE tabname
        iv_where  TYPE string OPTIONAL
      CHANGING
        cs_result TYPE any
      RAISING
        /gicom/cx_root_ds,

    select_single_with_selopts
      IMPORTING
        iv_table   TYPE tabname
        it_selopts TYPE ddshselops OPTIONAL
      CHANGING
        cs_result  TYPE any
      RAISING
        /gicom/cx_root_ds,

    insert
      IMPORTING
        iv_table             TYPE tabname
        it_lines             TYPE ANY TABLE
        iv_accept_duplicates TYPE abap_bool DEFAULT abap_false
      RAISING
        /gicom/cx_root_ds,

    update
      IMPORTING
        iv_table TYPE tabname
        it_lines TYPE ANY TABLE
      RAISING
        /gicom/cx_root_ds,

    delete
      IMPORTING
        iv_table TYPE tabname
        iv_where TYPE string
      RAISING
        /gicom/cx_root_ds.

ENDINTERFACE.
