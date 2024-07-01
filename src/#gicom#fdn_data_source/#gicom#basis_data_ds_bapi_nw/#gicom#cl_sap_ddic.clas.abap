CLASS /gicom/cl_sap_ddic DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS:
      dd_domvalues_get
        IMPORTING
          iv_domname       TYPE dd07l-domname
          iv_text          TYPE ddrefstruc-bool DEFAULT space
          iv_langu         TYPE dd07t-ddlanguage DEFAULT space
          iv_bypass_buffer TYPE ddrefstruc-bool DEFAULT space
        EXPORTING
          ev_rc            TYPE sy-subrc
        CHANGING
          ct_dd07v_tab     TYPE dd07v_tab
        RAISING
          /gicom/cx_sap_call_error,

      ddif_doma_get
        IMPORTING
          iv_name      TYPE ddobjname
          iv_state     TYPE ddobjstate DEFAULT 'A'
          iv_langu     TYPE sy-langu DEFAULT ' '
        EXPORTING
          ev_gotstate  TYPE ddgotstate
          ev_dd01v_wa  TYPE dd01v
        CHANGING
          ct_dd07v_tab TYPE dd07v_tab OPTIONAL
        RAISING
          /gicom/cx_sap_call_error,

      ddif_dtel_get
        IMPORTING
          iv_name      TYPE ddobjname
          iv_state     TYPE ddobjstate DEFAULT 'A'
          iv_langu     TYPE sy-langu DEFAULT ' '
        EXPORTING
          ev_gotstate  TYPE ddgotstate
          es_dd04v_wa  TYPE dd04v
          eS_tpara_wa  TYPE tpara
        RAISING
          /gicom/cx_sap_call_error,

      ddif_fieldinfo_get
        IMPORTING
          iv_tabname      TYPE ddobjname
          iv_fieldname    TYPE dfies-fieldname DEFAULT ' '
          iv_langu        TYPE sy-langu DEFAULT sy-langu
          iv_lfieldname   TYPE dfies-lfieldname DEFAULT ' '
          iv_all_types    TYPE ddbool_d DEFAULT ' '
          iv_group_names  TYPE ddbool_d DEFAULT ' '
          iv_uclen        TYPE /gicom/unicodelg OPTIONAL
          iv_do_not_write TYPE ddbool_d DEFAULT ' '
        EXPORTING
          es_x030l_wa     TYPE x030l
          et_ddobjtype    TYPE dd02v-tabclass
          es_dfies_wa     TYPE dfies
          et_lines_descr  TYPE ddtypelist
        CHANGING
          cs_dfies_tab    TYPE /gicom/dfies_tt OPTIONAL
          ct_fixed_values TYPE ddfixvalues OPTIONAL
        RAISING
          /gicom/cx_sap_call_error,

      ddif_nametab_get
        IMPORTING
          iv_tabname     TYPE ddobjname
          iv_all_types   TYPE ddbool_d DEFAULT ' '
          iv_lfieldname  TYPE dfies-lfieldname DEFAULT ' '
          iv_group_names TYPE ddbool_d DEFAULT ' '
          iv_uclen       TYPE /gicom/unicodelg OPTIONAL
          iv_status      TYPE as4local DEFAULT 'A'
        EXPORTING
          es_x030l_wa    TYPE x030l
          es_dtelinfo_wa TYPE dtelinfo
          es_ttypinfo_wa TYPE ttypinfo
          ev_ddobjtype   TYPE dd02v-tabclass
          es_dfies_wa    TYPE dfies
          et_lines_descr TYPE ddtypelist
        CHANGING
          ct_dfies_tab   TYPE /gicom/dfies_tt OPTIONAL
        RAISING
          /gicom/cx_sap_call_error,

      ddut_texttable_get
        IMPORTING
          iv_tabname    TYPE tabname
        EXPORTING
          ev_texttable  TYPE dd08v-tabname
          ev_checkfield TYPE dd08v-fieldname,

      ddut_domvalue_text_get
        IMPORTING
          iv_name       TYPE ddobjname
          iv_value      TYPE dd07v-domvalue_l
          iv_langu      TYPE sy-langu DEFAULT sy-langu
          iv_texts_only TYPE ddbool_d DEFAULT ' '
        EXPORTING
          es_dd07v_wa   TYPE dd07v
        RAISING
          /gicom/cx_sap_call_error.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CL_SAP_DDIC IMPLEMENTATION.


  METHOD ddif_doma_get.

    CALL FUNCTION 'DDIF_DOMA_GET'
      EXPORTING
        name          = iv_name
        state         = iv_state
        langu         = iv_langu
      IMPORTING
        gotstate      = ev_gotstate
        dd01v_wa      = ev_dd01v_wa
      TABLES
        dd07v_tab     = ct_dd07v_tab
      EXCEPTIONS
        illegal_input = 1.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'DDIF_DOMA_GET'
        iv_subrc           = sy-subrc
      ).
    ENDIF.

  ENDMETHOD.


  METHOD ddif_dtel_get.

    CALL FUNCTION 'DDIF_DTEL_GET'
      EXPORTING
        name          = iv_name
        state         = iv_state
        langu         = iv_langu
      IMPORTING
        gotstate      = ev_gotstate
        dd04v_wa      = es_dd04v_wa
        tpara_wa      = es_tpara_wa
      EXCEPTIONS
        illegal_input = 1
      .
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'DDIF_DOMA_GET'
        iv_subrc           = sy-subrc
      ).
    ENDIF.

  ENDMETHOD.


  METHOD ddif_fieldinfo_get.

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
        ddobjtype      = et_ddobjtype
        dfies_wa       = es_dfies_wa
        lines_descr    = et_lines_descr
      TABLES
        dfies_tab      = cs_dfies_tab
        fixed_values   = ct_fixed_values
      EXCEPTIONS
        not_found      = 1
        internal_error = 2.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'DDIF_FIELDINFO_GET'
        iv_subrc           = sy-subrc
      ).
    ENDIF.

  ENDMETHOD.


  METHOD ddif_nametab_get.
    CALL FUNCTION 'DDIF_NAMETAB_GET'
      EXPORTING
        tabname     = iv_tabname
        all_types   = iv_all_types
        lfieldname  = iv_lfieldname
        group_names = iv_group_names
        uclen       = iv_uclen
        status      = iv_status
      IMPORTING
        x030l_wa    = es_x030l_wa
        dtelinfo_wa = es_dtelinfo_wa
        ttypinfo_wa = es_ttypinfo_wa
        ddobjtype   = ev_ddobjtype
        dfies_wa    = es_dfies_wa
        lines_descr = et_lines_descr
      TABLES
        dfies_tab   = ct_dfies_tab
      EXCEPTIONS
        not_found   = 1.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'DDIF_NAMETAB_GET'
        iv_subrc           = sy-subrc
      ).
    ENDIF.

  ENDMETHOD.


  METHOD ddut_domvalue_text_get.

    CALL FUNCTION 'DDUT_DOMVALUE_TEXT_GET'
      EXPORTING
        name          = iv_name
        value         = iv_value
        langu         = iv_langu
        texts_only    = iv_texts_only
      IMPORTING
        dd07v_wa      = es_dd07v_wa
      EXCEPTIONS
        not_found     = 1
        illegal_input = 2.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'DDUT_DOMVALUE_TEXT_GET'
        iv_subrc           = sy-subrc
      ).
    ENDIF.

  ENDMETHOD.


  METHOD ddut_texttable_get.

    CALL FUNCTION 'DDUT_TEXTTABLE_GET'
      EXPORTING
        tabname    = iv_tabname
      IMPORTING
        texttable  = ev_texttable
        checkfield = ev_checkfield.

  ENDMETHOD.


  METHOD dd_domvalues_get.

    CALL FUNCTION 'DD_DOMVALUES_GET'
      EXPORTING
        domname        = iv_domname
        text           = iv_text
        langu          = iv_langu
        bypass_buffer  = iv_bypass_buffer
      IMPORTING
        rc             = ev_rc
      TABLES
        dd07v_tab      = ct_dd07v_tab
      EXCEPTIONS
        wrong_textflag = 1.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'DD_DOMVALUES_GET'
        iv_subrc           = sy-subrc
      ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
