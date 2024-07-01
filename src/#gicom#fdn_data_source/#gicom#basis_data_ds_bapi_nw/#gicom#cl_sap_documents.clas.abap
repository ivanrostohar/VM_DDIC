CLASS /gicom/cl_sap_documents DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS so_document_delete_api1
      IMPORTING
        !iv_document_id   TYPE sofolenti1-doc_id
        !iv_unread_delete TYPE sonv-flag OPTIONAL
        !iv_put_in_trash  TYPE sonv-flag DEFAULT 'X'
      RAISING
        /gicom/cx_sap_call_error .
*        FILTER TYPE SOFILTERI1 DEFAULT 'X '
    CLASS-METHODS so_document_read_api1
      IMPORTING
        !iv_document_id   TYPE sofolenti1-doc_id
      EXPORTING
        !es_document_data TYPE sofolenti1
      CHANGING
        !ct_contents_hex  TYPE solix_tab OPTIONAL
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS so_folder_root_id_get
      IMPORTING
        !iv_owner     TYPE soud-usrnam DEFAULT space
        !iv_region    TYPE sofd-folrg DEFAULT 'Q'
      EXPORTING
        !es_folder_id TYPE soodk
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS so_document_insert_api1
      IMPORTING
        !iv_folder_id     TYPE soobjinfi1-object_id
        !is_document_data TYPE sodocchgi1
        !iv_document_type TYPE soodk-objtp
      EXPORTING
        !es_document_info TYPE sofolenti1
      CHANGING
        !ct_object_header TYPE /gicom/solisti1_t OPTIONAL
        !ct_contents_hex  TYPE solix_tab OPTIONAL
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS binary_relation_create
      IMPORTING
        !iv_obj_rolea     TYPE borident
        !iv_obj_roleb     TYPE borident
        !iv_relationtype  TYPE breltyp-reltype
        !iv_fire_events   TYPE xflag DEFAULT 'X'
      EXPORTING
        !es_binrel        TYPE gbinrel
      CHANGING
        !ct_binrel_attrib TYPE /gicom/brelattr_tt OPTIONAL
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS archiv_create_table
      IMPORTING
        !iv_ar_object  TYPE toaom-ar_object
        !iv_del_date   TYPE toa01-del_date OPTIONAL
        !iv_object_id  TYPE sapb-sapobjid
        !iv_sap_object TYPE toaom-sap_object
        !iv_flength    TYPE sapb-length OPTIONAL
        !iv_doc_type   TYPE toadd-doc_type OPTIONAL
        !iv_document   TYPE xstring
        !iv_filename   TYPE toaat-filename OPTIONAL
        !iv_descr      TYPE toaat-descr OPTIONAL
      EXPORTING
        !es_outdoc     TYPE toadt
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS archiv_connection_insert
      IMPORTING
        !iv_archiv_id  TYPE toa01-archiv_id OPTIONAL
        !iv_arc_doc_id TYPE toa01-arc_doc_id
        !iv_ar_object  TYPE toaom-ar_object
        !iv_del_date   TYPE toa01-del_date OPTIONAL
        !iv_object_id  TYPE sapb-sapobjid
        !iv_sap_object TYPE toaom-sap_object
        !iv_doc_type   TYPE toadd-doc_type OPTIONAL
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS archiv_get_connections
      IMPORTING
        !iv_objecttype  TYPE saeanwdid
        !iv_object_id   TYPE saeobjid
      EXPORTING
        !et_connections TYPE toav0_t
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS archiv_metainfo_get
      IMPORTING
        !iv_active_only TYPE /gicom/abap_bool DEFAULT abap_false
        !iv_ar_object   TYPE toaom-ar_object
        !iv_sap_object  TYPE toaom-sap_object
      EXPORTING
        !et_toaom       TYPE /GICOM/TOAOM_TTY
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS archivobject_get_table
      IMPORTING
        !iv_archiv_id  TYPE toa01-archiv_id
        !iv_arc_doc_id TYPE toa01-arc_doc_id
        !iv_doc_type   TYPE toadd-doc_type
      EXPORTING
        !ev_document   TYPE xstring
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS archivobject_delete
      IMPORTING
        !iv_archiv_id     TYPE toa01-archiv_id
        !iv_archiv_doc_id TYPE toa01-arc_doc_id
      RAISING
        /gicom/cx_sap_call_error .
    CLASS-METHODS alink_connection_delete_by_key
      IMPORTING
        !iv_sap_object    TYPE saeanwdid
        !iv_object_id     TYPE saeobjid
        !iv_archiv_id     TYPE saearchivi
        !iv_archiv_doc_id TYPE saeardoid
      RAISING
        /gicom/cx_sap_call_error .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CL_SAP_DOCUMENTS IMPLEMENTATION.


  METHOD alink_connection_delete_by_key.
    cl_alink_connection=>delete_by_key(
        EXPORTING
*          mandt      = SY-MANDT
          sap_object = iv_sap_object
          object_id  = iv_object_id
          archiv_id  = iv_archiv_id
          arc_doc_id = iv_archiv_doc_id
*          tab_name   = space
*        IMPORTING
*          tab_names  =
        EXCEPTIONS
          not_found  = 1
          OTHERS     = 2
      ).
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'cl_alink_connection=>delete_by_key'
          iv_subrc           = sy-subrc.
    ENDIF.
  ENDMETHOD.


  METHOD archivobject_delete.
    CALL FUNCTION 'ARCHIVOBJECT_DELETE'
      EXPORTING
        archiv_doc_id            = iv_archiv_doc_id
        archiv_id                = iv_archiv_id
*       SIGN                     = ' '
*       DOC_TYPE                 = ' '
*       COMPID                   = ' '
*       SAP_OBJECT               =
*       AR_OBJECT                =
*       AR_DATE                  =
*       DEL_DATE                 =
*       OBJECT_ID                =
      EXCEPTIONS
        error_archiv             = 1
        error_communicationtable = 2
        error_kernel             = 3
        OTHERS                   = 4.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'ARCHIVOBJECT_DELETE'
          iv_subrc           = sy-subrc.
    ENDIF.

  ENDMETHOD.


  METHOD archivobject_get_table.
    DATA: lv_bin_length TYPE sapb-length,
          lt_bin        TYPE STANDARD TABLE OF tbl1024.

    CALL FUNCTION 'ARCHIVOBJECT_GET_TABLE'
      EXPORTING
        archiv_id                = iv_archiv_id
        document_type            = iv_doc_type
        archiv_doc_id            = iv_arc_doc_id
*       ALL_COMPONENTS           =
*       SIGNATURE                = 'X'
*       COMPID                   = 'data'
      IMPORTING
*       LENGTH                   =
        binlength                = lv_bin_length
      TABLES
*       ARCHIVOBJECT             =
        binarchivobject          = lt_bin
      EXCEPTIONS
        error_archiv             = 1
        error_communicationtable = 2
        error_kernel             = 3
        OTHERS                   = 4.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'ARCHIVOBJECT_GET_TABLE'
          iv_subrc           = sy-subrc.
    ENDIF.

    /gicom/cl_sap_conversion=>scms_binary_to_xstring(
    EXPORTING
        iv_input_length = CONV #( lv_bin_length )
      IMPORTING
       ev_buffer = ev_document
       CHANGING
       ct_binary_tab = lt_bin
        ).

  ENDMETHOD.


  METHOD archiv_connection_insert.

    CALL FUNCTION 'ARCHIV_CONNECTION_INSERT'
      EXPORTING
        archiv_id             = iv_archiv_id
        arc_doc_id            = iv_arc_doc_id
*       AR_DATE               = ' '
        ar_object             = iv_ar_object
        del_date              = iv_del_date
*       MANDANT               = ' '
        object_id             = iv_object_id
        sap_object            = iv_sap_object
        doc_type              = iv_doc_type
*       BARCODE               = ' '
*       FILENAME              = ' '
*       DESCR                 = ' '
*       CREATOR               = ' '
      EXCEPTIONS
        error_connectiontable = 1
        OTHERS                = 2.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'ARCHIV_CONNECTION_INSERT'
          iv_subrc           = sy-subrc.
    ENDIF.


  ENDMETHOD.


  METHOD archiv_create_table.

    CALL FUNCTION 'ARCHIV_CREATE_TABLE'
      EXPORTING
        ar_object                = iv_ar_object
        del_date                 = iv_del_date
        object_id                = iv_object_id
        sap_object               = iv_sap_object
        flength                  = iv_flength
        doc_type                 = iv_doc_type
        document                 = iv_document
*       MANDT                    = SY-MANDT
*       VSCAN_PROFILE            = '/SCMS/KPRO_CREATE'
        filename                 = iv_filename
        descr                    = iv_descr
      IMPORTING
        outdoc                   = es_outdoc
*       TABLES
*       ARCHIVOBJECT             =
*       BINARCHIVOBJECT          =
      EXCEPTIONS
        error_archiv             = 1
        error_communicationtable = 2
        error_connectiontable    = 3
        error_kernel             = 4
        error_parameter          = 5
        error_user_exit          = 6
        error_mandant            = 7
        blocked_by_policy        = 8
        OTHERS                   = 9.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'ARCHIV_CREATE_TABLE'
          iv_subrc           = sy-subrc.
    ENDIF.

  ENDMETHOD.


  METHOD archiv_get_connections.

    CALL FUNCTION 'ARCHIV_GET_CONNECTIONS'
      EXPORTING
        objecttype    = iv_objecttype
        object_id     = iv_object_id
*       CLIENT        =
*       ARCHIV_ID     =
*       ARC_DOC_ID    =
*       DOCUMENTTYPE  =
*       FROM_AR_DATE  =
*       UNTIL_AR_DATE = /gicom/cl_system=>get_date( )
*       DOCUMENTCLASS =
*       DEL_DATE      =
*       LIMITED       =
*       LIMIT         =
*   IMPORTING
*       COUNT         =
*       REDUCEDBYLIMIT           =
*       REDUCEDBYAUTHORITY       =
      TABLES
        connections   = et_connections
*       PARAMETER     =
*       FILE_ATTRIBUTES          =
      EXCEPTIONS
        nothing_found = 1
        OTHERS        = 2.
    IF sy-subrc <> 0 AND NOT ( sy-subrc = 1 ).
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'ARCHIV_GET_CONNECTIONS'
          iv_subrc           = sy-subrc.
    ENDIF.


  ENDMETHOD.


  METHOD archiv_metainfo_get.

    CALL FUNCTION 'ARCHIV_METAINFO_GET'
      EXPORTING
        active_flag           = iv_active_only
        ar_object             = iv_ar_object
        sap_object            = iv_sap_object
      TABLES
        toaom_fkt             = et_toaom
      EXCEPTIONS
        error_connectiontable = 1
        error_parameter       = 2
        OTHERS                = 3.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'ARCHIV_METAINFO_GET'
          iv_subrc           = sy-subrc.
    ENDIF.

  ENDMETHOD.


  METHOD binary_relation_create.

    CALL FUNCTION 'BINARY_RELATION_CREATE'
      EXPORTING
        obj_rolea      = iv_obj_rolea
        obj_roleb      = iv_obj_roleb
        relationtype   = iv_relationtype
        fire_events    = iv_fire_events
      IMPORTING
        binrel         = es_binrel
      TABLES
        binrel_attrib  = ct_binrel_attrib
      EXCEPTIONS
        no_model       = 1
        internal_error = 2
        unknown        = 3
        OTHERS         = 4.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'BINARY_RELATION_CREATE'
          iv_subrc           = sy-subrc.
    ENDIF.

  ENDMETHOD.


  METHOD so_document_delete_api1.

    CALL FUNCTION 'SO_DOCUMENT_DELETE_API1'
      EXPORTING
        document_id                = iv_document_id
        unread_delete              = iv_unread_delete
        put_in_trash               = iv_put_in_trash
      EXCEPTIONS
        document_not_exist         = 1
        operation_no_authorization = 2
        parameter_error            = 3
        x_error                    = 4
        enqueue_error              = 5.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'SO_DOCUMENT_DELETE_API1'
          iv_subrc           = sy-subrc.
    ENDIF.

  ENDMETHOD.


  METHOD so_document_insert_api1.
    CALL FUNCTION 'SO_DOCUMENT_INSERT_API1'
      EXPORTING
        folder_id                  = iv_folder_id
        document_data              = is_document_data
        document_type              = iv_document_type
      IMPORTING
        document_info              = es_document_info
      TABLES
        object_header              = ct_object_header
        contents_hex               = ct_contents_hex
      EXCEPTIONS
        folder_not_exist           = 1
        document_type_not_exist    = 2
        operation_no_authorization = 3
        parameter_error            = 4
        x_error                    = 5
        enqueue_error              = 6.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'SO_DOCUMENT_INSERT_API1'
          iv_subrc           = sy-subrc.
    ENDIF.

  ENDMETHOD.


  METHOD so_document_read_api1.

    CALL FUNCTION 'SO_DOCUMENT_READ_API1'
      EXPORTING
        document_id                = iv_document_id
      IMPORTING
        document_data              = es_document_data
      TABLES
        contents_hex               = ct_contents_hex
      EXCEPTIONS
        document_id_not_exist      = 1
        operation_no_authorization = 2
        x_error                    = 3.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'SO_DOCUMENT_READ_API1'
          iv_subrc           = sy-subrc.
    ENDIF.

  ENDMETHOD.


  METHOD so_folder_root_id_get.

    CALL FUNCTION 'SO_FOLDER_ROOT_ID_GET'
      EXPORTING
        owner                 = iv_owner
        region                = iv_region
      IMPORTING
        folder_id             = es_folder_id
      EXCEPTIONS
        owner_not_exist       = 1
        x_error               = 2
        communication_failure = 3
        system_failure        = 4
        OTHERS                = 999.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_sap_call_error
        EXPORTING
          iv_function_module = 'SO_FOLDER_ROOT_ID_GET'
          iv_subrc           = sy-subrc.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
