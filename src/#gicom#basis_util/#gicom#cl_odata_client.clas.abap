class /GICOM/CL_ODATA_CLIENT definition
  public
  create public .

public section.

  methods EXECUTE
    importing
      !IV_RFC_OBJECT type /GICOM/RFC_OBJECT_ID
      !IV_ENTITY_SET type STRING
      !IV_ENTITY_ID type STRING optional
      !IT_SELOPT type DDSHSELOPS optional
      !IT_EXPAND_CLAUSES type STRING_TABLE optional
      !IV_SERVICE_NAME type STRING optional
    exporting
      !E_RESULT type ANY .
  PROTECTED SECTION.
private section.

  methods GET_HTTP_CLIENT
    importing
      !IV_RFC_OBJECT type /GICOM/RFC_OBJECT_ID
    returning
      value(RO_HTTP_CLIENT) type ref to IF_HTTP_CLIENT .
  methods SET_REQUEST_URI
    importing
      !IO_HTTP_CLIENT type ref to IF_HTTP_CLIENT
      !IV_SERVICE_NAME type STRING optional
      !IV_ENTITY_SET type STRING
      !IV_ENTITY_ID type STRING optional
      !IT_SELOPT type DDSHSELOPS optional
      !IT_EXPAND_CLAUSES type STRING_TABLE optional
      !IV_RFC_OBJECT type /GICOM/RFC_OBJECT_ID .
  methods PARSE_JSON
    importing
      !IV_SINGLE_ENTITY type /gicom/abap_bool default abap_false
      !IV_RESPONSE type STRING
    exporting
      value(E_RESULT) type ANY .
ENDCLASS.



CLASS /GICOM/CL_ODATA_CLIENT IMPLEMENTATION.


  METHOD execute.


    DATA(lo_http_client) = me->get_http_client( iv_rfc_object = iv_rfc_object  ).

    me->set_request_uri(
        EXPORTING
          io_http_client      = lo_http_client
          iv_rfc_object       = iv_rfc_object
          iv_service_name     = iv_service_name
          iv_entity_set       = iv_entity_set
          iv_entity_id        = iv_entity_id
          it_selopt           = it_selopt
          it_expand_clauses   = it_expand_clauses
      ).

    CALL METHOD lo_http_client->send
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        http_invalid_timeout       = 4
        OTHERS                     = 5.

    IF sy-subrc = 0.
      CALL METHOD lo_http_client->receive
        EXCEPTIONS
          http_communication_failure = 1
          http_invalid_state         = 2
          http_processing_failed     = 3
          OTHERS                     = 5.
    ENDIF.

    IF sy-subrc <> 0.
      "ToDo: error handling
    ENDIF.


    DATA(lv_response) = lo_http_client->response->get_cdata( ).

    me->parse_json(
      EXPORTING
        iv_single_entity    = COND #( WHEN iv_entity_id IS INITIAL THEN abap_false ELSE abap_true )
        iv_response = lv_response
      IMPORTING
        e_result    = e_result
    ).


  ENDMETHOD.


  METHOD get_http_client.


    DATA(lo_rfc) = /gicom/cl_rfc_manager=>get_instance( ).
    DATA(lv_dest) = lo_rfc->get_destination(
          EXPORTING
            iv_rfc_object  = iv_rfc_object
            iv_rfc_type    = /gicom/cl_rfc_manager=>cv_rfc_type_http
        ).
    IF lv_dest IS INITIAL.
      "ToDo: Error handling
    ENDIF.


*    cl_http_client=>create_by_url(
*      EXPORTING
*        url                = lv_url
    cl_http_client=>create_by_destination(
      EXPORTING
        destination              = lv_dest
      IMPORTING
        client                   = ro_http_client
      EXCEPTIONS
        argument_not_found       = 1
        destination_not_found    = 2
        destination_no_authority = 3
        plugin_not_active        = 4
        internal_error           = 5
        OTHERS                   = 6
    ).
    IF sy-subrc <> 0.
      "ToDo: error handling
    ENDIF.


    "setting request method
    ro_http_client->request->set_method('GET').

    "adding headers
    ro_http_client->request->set_header_field( name = 'Content-Type' value = 'application/json' ).
    ro_http_client->request->set_header_field( name = 'Accept' value = 'application/json' ).


  ENDMETHOD.


  METHOD parse_json.

    TYPES:
      BEGIN OF ts_odata_response_entity_set,
        BEGIN OF d,
          results TYPE REF TO data,
        END OF d,
      END OF ts_odata_response_entity_set,
      BEGIN OF ts_odata_response_entity,
        d TYPE REF TO data,
      END OF ts_odata_response_entity.


    DATA: lr_odata_response TYPE REF TO data.
    FIELD-SYMBOLS: <ls_odata_response> TYPE any,
                   <d>                 TYPE any,
                   <results>           TYPE any.

    IF iv_single_entity EQ abap_false.
      CREATE DATA lr_odata_response TYPE ts_odata_response_entity_set.
      ASSIGN lr_odata_response->* TO <ls_odata_response>.
      ASSIGN COMPONENT 'D' OF STRUCTURE <ls_odata_response> TO <d>.
      ASSIGN COMPONENT 'RESULTS' OF STRUCTURE <d> TO <results>.
      CREATE DATA <results> LIKE e_result.
    ELSE.
      CREATE DATA lr_odata_response TYPE ts_odata_response_entity.
      ASSIGN lr_odata_response->* TO <ls_odata_response>.
      ASSIGN COMPONENT 'D' OF STRUCTURE <ls_odata_response> TO <d>.
      CREATE DATA <d> LIKE e_result.
    ENDIF.



    /ui2/cl_json=>deserialize(
      EXPORTING
        json             = iv_response                 " JSON string
*      jsonx            =                  " JSON XString
        pretty_name      = /ui2/cl_json=>pretty_mode-camel_case                 " Pretty Print property names
*      assoc_arrays     =                  " Deserialize associative array as tables with unique keys
*      assoc_arrays_opt =                  " Optimize rendering of name value maps
*      name_mappings    =                  " ABAP<->JSON Name Mapping Table
      CHANGING
        data             = <ls_odata_response>                 " Data to serialize
    ).


    IF iv_single_entity EQ abap_false.
      ASSIGN <results>->* TO FIELD-SYMBOL(<fs_results_entity_set>).
      e_result = CORRESPONDING #( <fs_results_entity_set> ).
    ELSE.
      ASSIGN <d>->* TO FIELD-SYMBOL(<fs_results_entity>).
      e_result = CORRESPONDING #( <fs_results_entity> ).
    ENDIF.




  ENDMETHOD.


  METHOD set_request_uri.

    DATA: lv_uri          TYPE string,
          lv_service_name TYPE string.


    "*** Determine API service name
    "**********************************************************************
    IF iv_service_name IS NOT INITIAL.
      lv_service_name = iv_service_name.
    ELSE.
      lv_service_name = /gicom/cl_rfc_manager=>get_instance( )->get_service_name( iv_rfc_object ).
    ENDIF.


    "*** Create base URI (e.g. /sap/opu/odata/sap + /API_BUSINESS_PARTNER + /A_BusinessPartner
    "**********************************************************************
    lv_uri = /gicom/cl_odata_client_factory=>cv_path_odata_sap && `/` && lv_service_name && `/` && iv_entity_set.


    "*** Append entity id (if single entity is requested)
    "**********************************************************************
    IF iv_entity_id IS NOT INITIAL.
      lv_uri = lv_uri && `('` && iv_entity_id && `')`.
    ENDIF.


    "*** Add selopts/filters
    "**********************************************************************
    IF it_selopt IS NOT INITIAL.
      lv_uri = lv_uri && `?`.
      lv_uri = lv_uri && `$filter=`.

      RAISE EXCEPTION TYPE /gicom/cx_not_implemented.
*      DATA(lv_where) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
*        EXPORTING
*          it_selopt            =  it_selopt
**          iv_statement         = '1'
*      ).

    ENDIF.


    "*** Add expand clauses
    "**********************************************************************
    IF it_expand_clauses IS NOT INITIAL.
      IF it_selopt IS INITIAL.
        lv_uri = lv_uri && `?`.
      ELSE.
        lv_uri = lv_uri && `&`.
      ENDIF.
      lv_uri = lv_uri && `$expand=`.
      lv_uri = lv_uri && concat_lines_of( table = it_expand_clauses sep = ',' ).

    ENDIF.



    "*** Set URI in request
    "**********************************************************************
    CALL METHOD cl_http_utility=>set_request_uri
      EXPORTING
        request = io_http_client->request
        uri     = lv_uri.


  ENDMETHOD.
ENDCLASS.
