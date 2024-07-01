CLASS /gicom/cl_util_gos DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    CLASS-METHODS get_instance
      RETURNING VALUE(ro_util_gos) TYPE REF TO /gicom/if_util_gos.

    CLASS-METHODS inject_instance
      IMPORTING io_util_gos TYPE REF TO /gicom/if_util_gos.

    CLASS-METHODS upload_file
      IMPORTING
        !iv_filename     TYPE /gicom/filename
        !iv_filetype     TYPE char4
        !iv_file_descr   TYPE string
        !iv_file_content TYPE xstring
        !iv_encoding_in  TYPE /gicom/encoding
      CHANGING
        !cs_gos_comm     TYPE /gicom/gos_comm_s
      RAISING
        /gicom/cx_internal_error .
    CLASS-METHODS split_path
      IMPORTING
        !iv_path     TYPE string
      EXPORTING
        !ev_path     TYPE string
        !ev_filename TYPE string
        !ev_pserver  TYPE xfeld .
    CLASS-METHODS split_file_extension
      IMPORTING
        !iv_filename_with_ext TYPE string
      EXPORTING
        !ev_filename          TYPE string
        !ev_extension         TYPE string .
    CLASS-METHODS read_file
      IMPORTING
        !is_gos_comm     TYPE /gicom/gos_comm_s
        !iv_encoding_out TYPE /gicom/encoding
      EXPORTING
        !ev_file_content TYPE xstring
      RAISING
        /gicom/cx_internal_error .
    CLASS-METHODS delete_file
      IMPORTING
        !is_gos_comm TYPE /gicom/gos_comm_s
      RAISING
        /gicom/cx_internal_error .
    CLASS-METHODS attach_docs
      IMPORTING
        !iv_mail_header TYPE text50
        !iv_recipients  TYPE string
        !it_docs        TYPE /gicom/email_comm_tt OPTIONAL
        !iv_mail_body   TYPE string
        !iv_doctype     TYPE char1 OPTIONAL
      RAISING
        /gicom/cx_internal_error .
  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA so_instance       TYPE REF TO /gicom/if_util_gos.

    CLASS-METHODS upload_file_sapoffice
      IMPORTING
        !is_gos_comm       TYPE /gicom/gos_comm_s
        !iv_filename       TYPE /gicom/filename
        !iv_filetype       TYPE char4
        !iv_file_descr     TYPE string
        !iv_file_content   TYPE xstring
      EXPORTING
        !ev_archive_doc_id TYPE /gicom/archive_doc_id
      RAISING
        /gicom/cx_internal_error .

    CLASS-METHODS delete_file_sapoffice
      IMPORTING
        !iv_docid TYPE /gicom/archive_doc_id
      RAISING
        /gicom/cx_internal_error .

    CLASS-METHODS read_file_sapoffice
      IMPORTING
        !iv_encoding     TYPE /gicom/encoding
        !iv_docid        TYPE /gicom/archive_doc_id
      EXPORTING
        !ev_file_content TYPE xstring
      RAISING
        /gicom/cx_internal_error .

    CLASS-METHODS upload_file_archivelink
      IMPORTING
        !is_gos_comm       TYPE /gicom/gos_comm_s
        !iv_filename       TYPE /gicom/filename
        !iv_filetype       TYPE char4
        !iv_file_descr     TYPE string
        !iv_file_content   TYPE xstring
      EXPORTING
        !ev_archive_doc_id TYPE /gicom/archive_doc_id
      RAISING
        /gicom/cx_internal_error .

    CLASS-METHODS delete_file_archivelink
      IMPORTING
        !is_gos_comm TYPE /gicom/gos_comm_s
      RAISING
        /gicom/cx_internal_error .

    CLASS-METHODS read_file_archivelink
      IMPORTING
        !iv_docid        TYPE /gicom/archive_doc_id
      EXPORTING
        !ev_file_content TYPE xstring
      RAISING
        /gicom/cx_internal_error .

    CLASS-METHODS split_archive_id_archivelink
      IMPORTING
        !iv_docid         TYPE /gicom/archive_doc_id
      EXPORTING
        !ev_archiv_id     TYPE toa01-archiv_id
        !ev_archiv_doc_id TYPE toa01-arc_doc_id.

    CLASS-METHODS get_doc_type_archivelink
      IMPORTING
        !is_gos_comm      TYPE /gicom/gos_comm_s
        !iv_filetype      TYPE char4
      EXPORTING
        !ev_document_type TYPE saeobjart.


ENDCLASS.



CLASS /GICOM/CL_UTIL_GOS IMPLEMENTATION.


  METHOD attach_docs.
    DATA: lt_text255 TYPE TABLE OF so_text255.

    /gicom/cl_sap_conversion=>sotr_serv_string_to_table(
      EXPORTING
        iv_text        = iv_mail_body
        iv_line_length = 255
      CHANGING
        ct_text_tab    = lt_text255
     ).

    TRY.
        DATA(lt_mail_body) = VALUE bcsy_text( FOR lwa_text255 IN lt_text255 ( line = lwa_text255 ) ).

        DATA(lref_send_request) = cl_bcs=>create_persistent( ).
****** Create Document
        DATA(lref_document) = cl_document_bcs=>create_document(
          i_type     = 'RAW'
          i_text     = lt_mail_body
          i_subject  = iv_mail_header
        ).

        "**** Pass the document to send request
        lref_send_request->set_document( lref_document ).


****** Decode PDF data
        LOOP AT it_docs INTO DATA(lwa_docs).

          IF iv_doctype <> 'A'.
            DATA lv_string TYPE string.
            lv_string = lwa_docs-filedata.
            DATA(lv_xstring) = cl_http_utility=>decode_x_base64( lv_string ).
          ELSE.
            lv_xstring = lwa_docs-file_xdata.
          ENDIF.


          DATA lt_binary_content TYPE solix_tab.

          /gicom/cl_sap_conversion=>scms_xstring_to_binary(
            EXPORTING
              iv_buffer          = lv_xstring
            IMPORTING
              ev_output_length   = DATA(lv_output_length)
            CHANGING
              ct_binary_tab      = lt_binary_content
           ).

****** Create Attachment
          " Only set the attachment type when it fits into char3 variable lv_att_type
          " otherwise necessary information will be lost (e.g. XLSX changes to XLS)
          " This results in corrupted files with names like filename.xlsx.xls
          IF strlen( lwa_docs-filetype ) <= 3.
            DATA(lv_att_type) = lwa_docs-filetype.
          ENDIF.

          lref_document->add_attachment(
            i_attachment_type     = |{ lv_att_type }|
            i_attachment_size     = |{ lv_output_length }|
            i_attachment_subject  = |{ lwa_docs-filename }.{ lwa_docs-filetype }| "lv_attrsubject
            i_att_content_hex     = lt_binary_content
          ).

          lref_send_request->set_document( i_document = lref_document ).
        ENDLOOP.

        DATA lt_recipients TYPE TABLE OF adr6-smtp_addr.
        SPLIT iv_recipients AT ',' INTO TABLE lt_recipients.
****** Create Internet Address for Sender
        DATA(lref_sender) = cl_sapuser_bcs=>create( /gicom/cl_system=>get_username(  ) ). "sender is the logged in user
****** Set Sender
        lref_send_request->set_sender( i_sender = lref_sender ).

****** Create Internet Address for Recipient
        LOOP AT lt_recipients INTO DATA(lwa_recipient).
          DATA(lref_recipient) = cl_cam_address_bcs=>create_internet_address(
            i_address_string = lwa_recipient
          ).

****** Add Recipient
          lref_send_request->add_recipient(
            i_recipient  = lref_recipient
            i_express    = abap_true
          ).
        ENDLOOP.


****** Set Send Immediately
        lref_send_request->set_send_immediately( i_send_immediately = abap_true ).

****** Send Email
        lref_send_request->send( ).
        COMMIT WORK.

      CATCH
        cx_send_req_bcs
        cx_document_bcs
        cx_address_bcs
        /gicom/cx_sap_call_error INTO DATA(lo_exception).

        RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lo_exception ).

    ENDTRY.
  ENDMETHOD.


  METHOD delete_file.

    CASE is_gos_comm-archive_type.
      WHEN /gicom/if_constants_ddl=>c_archive_type-sap_office.

        /gicom/cl_util_gos=>delete_file_sapoffice( iv_docid = is_gos_comm-archive_doc_id  ).

      WHEN /gicom/if_constants_ddl=>c_archive_type-archive_link.

        /gicom/cl_util_gos=>delete_file_archivelink( is_gos_comm = is_gos_comm ).

    ENDCASE.

  ENDMETHOD.


  METHOD delete_file_archivelink.
    TRY.
        /gicom/cl_util_gos=>split_archive_id_archivelink(
          EXPORTING
            iv_docid         = is_gos_comm-archive_doc_id
          IMPORTING
            ev_archiv_id     = DATA(lv_archiv_id)
            ev_archiv_doc_id = DATA(lv_archiv_doc_id)
        ).

        /gicom/cl_sap_documents=>archivobject_delete(
         EXPORTING
           iv_archiv_id     = lv_archiv_id
           iv_archiv_doc_id = lv_archiv_doc_id
        ).

        /gicom/cl_sap_documents=>alink_connection_delete_by_key(
          EXPORTING
            iv_sap_object    = is_gos_comm-bo_type
            iv_object_id     = CONV #( is_gos_comm-bo_id )
            iv_archiv_id     = lv_archiv_id
            iv_archiv_doc_id = lv_archiv_doc_id
        ).

      CATCH /gicom/cx_sap_call_error INTO DATA(lo_ex).
        RAISE EXCEPTION TYPE /gicom/cx_internal_error EXPORTING previous = lo_ex.
    ENDTRY.
  ENDMETHOD.


  METHOD delete_file_sapoffice.

    TRY.
        /gicom/cl_sap_documents=>so_document_delete_api1( iv_docid ).
      CATCH /gicom/cx_sap_call_error INTO DATA(lo_ex).
        RAISE EXCEPTION TYPE /gicom/cx_internal_error EXPORTING previous = lo_ex.
    ENDTRY.

  ENDMETHOD.


  METHOD get_doc_type_archivelink.

*** Select Archive Link Document Type for File Extension
**********************************************************************
    "ToDo - fitting SAP FuBa?
    SELECT
      ar_object
    FROM
      toaom
    WHERE
      sap_object = @is_gos_comm-bo_type AND
      doc_type   = @iv_filetype AND
      ar_status  = @abap_true
    INTO TABLE
      @DATA(lt_doc_type).

    IF sy-subrc NE 0.
      "Select all (not only active)
      SELECT
        ar_object
      FROM
        toaom
      WHERE
        sap_object = @is_gos_comm-bo_type AND
        doc_type = @iv_filetype
      INTO TABLE
        @lt_doc_type.
    ENDIF.

    SORT lt_doc_type BY ar_object.
    DELETE ADJACENT DUPLICATES FROM lt_doc_type COMPARING ar_object.

    DATA lv_filetype_string TYPE string.
    lv_filetype_string = iv_filetype.

    IF lines( lt_doc_type ) = 0.
      RAISE EXCEPTION TYPE /gicom/cx_alink_no_doc_type EXPORTING iv_file_extension = lv_filetype_string.
    ENDIF.

    IF lines( lt_doc_type ) > 1.
      RAISE EXCEPTION TYPE /gicom/cx_alink_doc_type_amb EXPORTING iv_file_extension = lv_filetype_string.
    ENDIF.

    ev_document_type = lt_doc_type[ 1 ]-ar_object.

  ENDMETHOD.


  METHOD read_file.

*** Read
**********************************************************************
    CASE is_gos_comm-archive_type.
      WHEN /gicom/if_constants_ddl=>c_archive_type-sap_office.
        /gicom/cl_util_gos=>read_file_sapoffice(
          EXPORTING
            iv_encoding     = is_gos_comm-encoding
            iv_docid        = is_gos_comm-archive_doc_id
          IMPORTING
            ev_file_content = DATA(lv_content)
        ).

      WHEN /gicom/if_constants_ddl=>c_archive_type-archive_link.
        /gicom/cl_util_gos=>read_file_archivelink(
          EXPORTING
            iv_docid        = is_gos_comm-archive_doc_id
          IMPORTING
            ev_file_content = lv_content
        ).
    ENDCASE.

*** De- / Encode
**********************************************************************
    "how is it stored = how is it requested ?
    IF is_gos_comm-encoding = iv_encoding_out.

      ev_file_content = lv_content.

    ELSE.
      " TODO: replace IFs with something else?? "Comment deprecated - AC M.19600
      IF iv_encoding_out = /gicom/if_constants_ddl=>c_encoding-binary.

      "INS BEGIN AC - M.19600 (support for template designer display)
        IF is_gos_comm-tmpl_type IS INITIAL AND is_gos_comm-tmpid IS NOT INITIAL. "
          " template designer string is stored as xstring, no decoding needed
          ev_file_content = lv_content.
        ELSE.
      "Adobe Forms / SmartForms --> Stored Base64-Encoded --> Decode
      "INS END

          ev_file_content = /gicom/cl_sap_conversion=>decode_base64( lv_content ).
        ENDIF.

      ELSE.

     "INS BEGIN AC - M.19600 (support for template designer display)
        IF is_gos_comm-tmpl_type IS INITIAL AND is_gos_comm-tmpid IS NOT INITIAL.
         " template designer string is stored as xstring, no encoding needed
          ev_file_content = lv_content.
        ELSE.
     "Adobe Forms / SmartForms --> Stored Binary --> encode Base64
     "INS END

          ev_file_content = /gicom/cl_sap_conversion=>encode_base64( iv_decoded = lv_content ).
        ENDIF.

      ENDIF.
    ENDIF.


  ENDMETHOD.


  METHOD read_file_archivelink.
    TRY.
        /gicom/cl_util_gos=>split_archive_id_archivelink(
          EXPORTING
            iv_docid         = iv_docid
          IMPORTING
            ev_archiv_id     = DATA(lv_archiv_id)
            ev_archiv_doc_id = DATA(lv_archiv_doc_id)
        ).

        /gicom/cl_sap_documents=>archivobject_get_table(
           EXPORTING iv_archiv_id = lv_archiv_id
                     iv_arc_doc_id = lv_archiv_doc_id
                     iv_doc_type = '' "not used within the SAP function module
           IMPORTING ev_document   = ev_file_content
        ).

      CATCH /gicom/cx_sap_call_error INTO DATA(lo_ex).
        RAISE EXCEPTION TYPE /gicom/cx_internal_error EXPORTING previous = lo_ex.
    ENDTRY.

  ENDMETHOD.


  METHOD read_file_sapoffice.
    DATA: lt_solix_tab        TYPE solix_tab,
          lv_length           TYPE i,
          ls_doc_data         TYPE sofolenti1.

    TRY.
        /gicom/cl_sap_documents=>so_document_read_api1(
          EXPORTING
            iv_document_id             = iv_docid
          IMPORTING
            es_document_data           = ls_doc_data    "INS AC 07.10.2021 M.21510
          CHANGING
            ct_contents_hex            = lt_solix_tab ).

      CATCH /gicom/cx_sap_call_error INTO DATA(lo_ex).
        RAISE EXCEPTION TYPE /gicom/cx_internal_error EXPORTING previous = lo_ex.
    ENDTRY.

     lv_length = ls_doc_data-doc_size.
     ev_file_content = cl_bcs_convert=>solix_to_xstring( it_solix = lt_solix_tab  "INS AC 07.10.2021 M.21510
                                                         iv_size  = lv_length ).  "INS AC 07.10.2021 M.21510

  ENDMETHOD.


  METHOD split_archive_id_archivelink.
    DATA: lv_length TYPE i.
    lv_length = strlen( iv_docid ) - 2.

    ev_archiv_id = iv_docid(2).
    ev_archiv_doc_id = iv_docid+2(lv_length).

  ENDMETHOD.


  METHOD split_file_extension.

    DATA: lv_len  TYPE i,
          lv_pos  TYPE i,
          lv_char TYPE c.

    FIND '.' IN iv_filename_with_ext.                       "#EC NOTEXT

    IF sy-subrc <> 0.
      ev_filename = iv_filename_with_ext.
      EXIT.
    ELSE.
      lv_len = strlen( iv_filename_with_ext ).

      lv_pos = lv_len - 1.

      lv_char = iv_filename_with_ext+lv_pos(1).

      WHILE lv_char <> '.' AND lv_pos >= 0.

        SUBTRACT 1 FROM lv_pos.
        lv_char = iv_filename_with_ext+lv_pos(1).

      ENDWHILE.

      IF lv_pos = 0.
        CLEAR ev_filename.
        ev_extension = iv_filename_with_ext+1.

      ELSEIF lv_pos > 0.
        SPLIT iv_filename_with_ext+lv_pos AT '.'
              INTO ev_filename ev_extension.
        ev_filename = iv_filename_with_ext(lv_pos).

      ELSE.
        ev_filename = iv_filename_with_ext.
      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD split_path.

    DATA: lv_path   TYPE string,
          lv_cnt    TYPE i,
          lv_len    TYPE i,
          lwa_dummy TYPE string,
          lt_dummy  TYPE STANDARD TABLE OF string.


    CLEAR: ev_path,
           ev_filename.

    SEARCH iv_path FOR '\'.

* if \ in path, file is on the presentationserver but if in Batch-Mode
* the file can't be on a presentationserver
    IF sy-subrc = 0 AND sy-batch <> abap_true.
      ev_pserver = abap_true.
    ENDIF.

* Change \ with /
    lv_path = iv_path.
    TRANSLATE lv_path USING '\/'.

* Split the whole path at /
    SPLIT lv_path AT '/' INTO TABLE lt_dummy.

* get the filename from the last line of table
    DESCRIBE TABLE lt_dummy LINES lv_cnt.
    READ TABLE lt_dummy INDEX lv_cnt INTO lwa_dummy.
    ev_filename = lwa_dummy.

* get only the path
    lv_len = strlen( iv_path ) - strlen( ev_filename ).
    IF lv_len > 0.
      ev_path = iv_path(lv_len).
    ENDIF.


  ENDMETHOD.


  METHOD upload_file.

*** De- / Encode
**********************************************************************
    IF cs_gos_comm-encoding = iv_encoding_in.

      DATA(lv_content) = iv_file_content.

    ELSE.

      IF iv_encoding_in = /gicom/if_constants_ddl=>c_encoding-binary.

        "INS BEGIN AC - M.19600 (support for template designer display)
        IF cs_gos_comm-tmpl_type IS INITIAL AND cs_gos_comm-tmpid IS NOT INITIAL.
         " If template designer --> just store the converted xstring of the html string
          lv_content = iv_file_content.
        ELSE.
        "otherwise encode binary to base64
        "INS END

          lv_content = /gicom/cl_sap_conversion=>encode_base64( iv_decoded = iv_file_content ).
        ENDIF.

      ELSE.

        "INS BEGIN AC - M.19600 (support for template designer display)
        IF cs_gos_comm-tmpl_type IS INITIAL AND cs_gos_comm-tmpid IS NOT INITIAL.
         "If template designer --> just store the converted xstring of the html string
          lv_content = iv_file_content.
        ELSE.
         "otherwise decode base64 to binary
         "INS END

          lv_content = /gicom/cl_sap_conversion=>decode_base64( iv_file_content ).
        ENDIF.

      ENDIF.

    ENDIF.


*** Store in archive (and get id)
**********************************************************************

*    cs_gos_comm-archive_type = /gicom/if_constants_ddl~c_archive_type-sap_office.

    CASE cs_gos_comm-archive_type.
      WHEN /gicom/if_constants_ddl=>c_archive_type-sap_office.
        /gicom/cl_util_gos=>upload_file_sapoffice(
          EXPORTING
            is_gos_comm       = cs_gos_comm
            iv_filename       = iv_filename
            iv_filetype       = iv_filetype
            iv_file_descr     = iv_file_descr
            iv_file_content   = lv_content
          IMPORTING
            ev_archive_doc_id = cs_gos_comm-archive_doc_id
        ).

      WHEN /gicom/if_constants_ddl=>c_archive_type-archive_link.
        /gicom/cl_util_gos=>upload_file_archivelink(
          EXPORTING
            is_gos_comm       = cs_gos_comm
            iv_filename       = iv_filename
            iv_filetype       = iv_filetype
            iv_file_descr     = iv_file_descr
            iv_file_content   = lv_content
          IMPORTING
            ev_archive_doc_id = cs_gos_comm-archive_doc_id
        ).

    ENDCASE.
  ENDMETHOD.


  METHOD upload_file_archivelink.

    TRY.
        /gicom/cl_util_gos=>get_doc_type_archivelink(
          EXPORTING
            is_gos_comm      = is_gos_comm
            iv_filetype      = iv_filetype
          IMPORTING
            ev_document_type = DATA(lv_doc_type)
        ).

        /gicom/cl_sap_documents=>archiv_create_table(
          EXPORTING
            iv_ar_object  = lv_doc_type
*            iv_del_date   =
            iv_object_id  = CONV #( is_gos_comm-bo_id )
            iv_sap_object = is_gos_comm-bo_type
*            iv_flength    =
*            iv_doc_type   =
            iv_document   = iv_file_content
            iv_filename   = CONV #( iv_filename )
            iv_descr      = CONV #( iv_file_descr )
          IMPORTING
            es_outdoc     = DATA(ls_outdoc)
        ).

        ev_archive_doc_id = ls_outdoc-contrep_id && ls_outdoc-arc_doc_id.

      CATCH /gicom/cx_sap_call_error INTO DATA(lo_ex).
        RAISE EXCEPTION TYPE /gicom/cx_internal_error EXPORTING previous = lo_ex.
    ENDTRY.

  ENDMETHOD.


  METHOD upload_file_sapoffice.
    DATA: ls_folderid   TYPE soodk,
          lv_folder_id  TYPE so_obj_id,
          ls_docdata    TYPE sodocchgi1,
          ls_object     TYPE borident,
          ls_attachment TYPE borident.

    DATA: lv_extension TYPE soodk-objtp.
    DATA: lwa_objhdr  TYPE  solisti1,
          lwa_objcont TYPE solisti1,
          lwa_hexcont TYPE solix,
          lt_objhdr   TYPE TABLE OF solisti1,
          lt_objcont  TYPE TABLE OF solisti1,
          lt_hexcont  TYPE TABLE OF solix.

    "Defaulting
    DATA: lv_doc_type TYPE so_obj_tp VALUE 'EXT'.

****************************
* Get the folder id
****************************
    TRY.
        /gicom/cl_sap_documents=>so_folder_root_id_get(
          EXPORTING
            iv_region                = 'B'
          IMPORTING
            es_folder_id             = ls_folderid
        ).

      CATCH /gicom/cx_sap_call_error INTO DATA(lo_ex).
        RAISE EXCEPTION TYPE /gicom/cx_internal_error EXPORTING previous = lo_ex.

    ENDTRY.

    ls_docdata-obj_name = 'MESSAGE'.
    ls_docdata-obj_descr = iv_filename.
    ls_docdata-obj_langu = sy-langu.
    ls_docdata-doc_size = xstrlen( iv_file_content ).   "MOD FG 20210602 M.20808

    CONCATENATE '&SO_FILENAME=' iv_filename INTO lwa_objhdr-line.
    APPEND lwa_objhdr TO lt_objhdr.
    CONCATENATE '&SO_FORMAT=' 'BIN' INTO lwa_objhdr-line.
    APPEND lwa_objhdr TO lt_objhdr.

    lt_hexcont = cl_bcs_convert=>xstring_to_solix( iv_xstring = iv_file_content ).
    lv_folder_id = ls_folderid-objtp && ls_folderid-objyr && ls_folderid-objno.

    TRY.
        /gicom/cl_sap_documents=>so_document_insert_api1(
          EXPORTING
            iv_folder_id                  = lv_folder_id
            is_document_data              = ls_docdata
            iv_document_type              = lv_doc_type
          IMPORTING
            es_document_info              = DATA(ls_document_info)
          CHANGING
            ct_object_header              = lt_objhdr
            ct_contents_hex               = lt_hexcont
        ).

        ev_archive_doc_id = ls_document_info-doc_id.

      CATCH /gicom/cx_sap_call_error INTO DATA(lo_ex2).
        RAISE EXCEPTION TYPE /gicom/cx_internal_error EXPORTING previous = lo_ex2.
    ENDTRY.

  ENDMETHOD.


  METHOD get_instance.
    IF so_instance IS NOT BOUND.
      so_instance = NEW lcl_facade( ).
    ENDIF.
    ro_util_gos = so_instance.
  ENDMETHOD.


  METHOD inject_instance.
    so_instance = io_util_gos.
  ENDMETHOD.
ENDCLASS.
