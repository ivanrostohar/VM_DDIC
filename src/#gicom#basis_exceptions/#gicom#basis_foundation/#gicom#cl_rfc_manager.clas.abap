CLASS /gicom/cl_rfc_manager DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    CONSTANTS cv_paymterm TYPE /gicom/rfc_object_id VALUE '320' ##NO_TEXT.
    CONSTANTS cv_general TYPE /gicom/rfc_object_id VALUE '001' ##NO_TEXT.
    CONSTANTS cv_businesspartner TYPE /gicom/rfc_object_id VALUE '10' ##NO_TEXT.
    CONSTANTS cv_contracts TYPE /gicom/rfc_object_id VALUE '20' ##NO_TEXT.
    CONSTANTS cv_conditions TYPE /gicom/rfc_object_id VALUE '30' ##NO_TEXT.
    CONSTANTS cv_negotiation TYPE /gicom/rfc_object_id VALUE '40' ##NO_TEXT.
    CONSTANTS cv_negotiation_round TYPE /gicom/rfc_object_id VALUE '50' ##NO_TEXT.
    CONSTANTS cv_org_units TYPE /gicom/rfc_object_id VALUE '70' ##NO_TEXT.
    CONSTANTS cv_dynamic_appendix TYPE /gicom/rfc_object_id VALUE '60' ##NO_TEXT.
    CONSTANTS cv_contract_types TYPE /gicom/rfc_object_id VALUE '80' ##NO_TEXT.
    CONSTANTS cv_condition_title TYPE /gicom/rfc_object_id VALUE '210' ##NO_TEXT.
    CONSTANTS cv_condition_types TYPE /gicom/rfc_object_id VALUE '90' ##NO_TEXT.
    CONSTANTS cv_price_procedure TYPE /gicom/rfc_object_id VALUE '100' ##NO_TEXT.
    CONSTANTS cv_material TYPE /gicom/rfc_object_id VALUE '110' ##NO_TEXT.
    CONSTANTS cv_grouping TYPE /gicom/rfc_object_id VALUE '120' ##NO_TEXT.
    CONSTANTS cv_sourcing_type TYPE /gicom/rfc_object_id VALUE '130' ##NO_TEXT.
    CONSTANTS cv_uom TYPE /gicom/rfc_object_id VALUE '140' ##NO_TEXT.
    CONSTANTS cv_currency TYPE /gicom/rfc_object_id VALUE '150' ##NO_TEXT.
    CONSTANTS cv_country TYPE /gicom/rfc_object_id VALUE '160' ##NO_TEXT.
    CONSTANTS cv_service_type TYPE /gicom/rfc_object_id VALUE '170' ##NO_TEXT.
    CONSTANTS cv_company_code TYPE /gicom/rfc_object_id VALUE '180' ##NO_TEXT.
    CONSTANTS cv_ccs TYPE /gicom/rfc_object_id VALUE '190' ##NO_TEXT.
    CONSTANTS cv_pmr TYPE /gicom/rfc_object_id VALUE '340' ##NO_TEXT.
    CONSTANTS cv_tax TYPE /gicom/rfc_object_id VALUE '200' ##NO_TEXT.
    CONSTANTS cv_addendum TYPE /gicom/rfc_object_id VALUE '220' ##NO_TEXT.
    CONSTANTS cv_sales_org TYPE /gicom/rfc_object_id VALUE '230' ##NO_TEXT.
    CONSTANTS cv_purch_org TYPE /gicom/rfc_object_id VALUE '240' ##NO_TEXT.
    CONSTANTS cv_purch_grp TYPE /gicom/rfc_object_id VALUE '250' ##NO_TEXT.
    CONSTANTS cv_cost_center TYPE /gicom/rfc_object_id VALUE '260' ##NO_TEXT.
    CONSTANTS cv_distr_channel TYPE /gicom/rfc_object_id VALUE '270' ##NO_TEXT.
    CONSTANTS cv_division TYPE /gicom/rfc_object_id VALUE '280' ##NO_TEXT.
    CONSTANTS cv_mat_grp TYPE /gicom/rfc_object_id VALUE '290' ##NO_TEXT.
    CONSTANTS cv_plant TYPE /gicom/rfc_object_id VALUE '300' ##NO_TEXT.
    CONSTANTS cv_prod_hier TYPE /gicom/rfc_object_id VALUE '310' ##NO_TEXT.
    CONSTANTS cv_tr_engine TYPE /gicom/rfc_object_id VALUE '311' ##NO_TEXT.
    CONSTANTS cv_ddic_engine TYPE /gicom/rfc_object_id VALUE '312' ##NO_TEXT.
    CONSTANTS cv_repos_engine TYPE /gicom/rfc_object_id VALUE '313' ##NO_TEXT.
    CONSTANTS cv_transfer_manager TYPE /gicom/rfc_object_id VALUE '314' ##NO_TEXT.
    CONSTANTS cv_user_roles TYPE /gicom/rfc_object_id VALUE '315' ##NO_TEXT.
    CONSTANTS cv_file TYPE /gicom/rfc_object_id VALUE '316' ##NO_TEXT.
    CONSTANTS cv_sap_basis TYPE /gicom/rfc_object_id VALUE '330' ##NO_TEXT.
    CONSTANTS cv_pfc TYPE /gicom/rfc_object_id VALUE '350' ##NO_TEXT.
    CONSTANTS cv_apm TYPE /gicom/rfc_object_id VALUE '360' ##NO_TEXT.
    CONSTANTS cv_rfc_type_http TYPE /gicom/rfctype VALUE 'G' ##NO_TEXT.
    CONSTANTS cv_rfc_type_abap TYPE /gicom/rfctype VALUE '3' ##NO_TEXT.

    CLASS-METHODS get_instance
      RETURNING
        VALUE(ro_instance) TYPE REF TO /gicom/cl_rfc_manager .
    METHODS get_destination
      IMPORTING
        !iv_rfc_object        TYPE /gicom/rfc_object_id
        !iv_rfc_type          TYPE /gicom/rfctype DEFAULT '3'
      RETURNING
        VALUE(rv_destination) TYPE /gicom/rfcdest .
    METHODS handle_rfc_exception
      IMPORTING
        !it_return TYPE /gicom/bapiret_tt
        !iv_msg    TYPE /gicom/rfc_msg
        !iv_subrc  TYPE sy-subrc
      RAISING
        /gicom/cx_rfc_error
        /gicom/cx_unresolved_message .
    METHODS get_service_name
      IMPORTING
        !iv_rfc_object         TYPE /gicom/rfc_object_id
      RETURNING
        VALUE(rv_service_name) TYPE string .
  PROTECTED SECTION.

  PRIVATE SECTION.

    CLASS-DATA so_instance TYPE REF TO /gicom/cl_rfc_manager .
ENDCLASS.



CLASS /GICOM/CL_RFC_MANAGER IMPLEMENTATION.


  METHOD get_destination.

    CLEAR rv_destination.

    "Get logical System
    DATA: lv_logsys TYPE logsys.

    CALL FUNCTION 'OWN_LOGICAL_SYSTEM_GET'
      IMPORTING
        own_logical_system             = lv_logsys
      EXCEPTIONS
        own_logical_system_not_defined = 1
        OTHERS                         = 2.
    IF sy-subrc <> 0.
      "Ok
    ENDIF.


    "Get RFC destination
    SELECT SINGLE
      rfc_dest
    FROM
      /gicom/trfc_mngr
    INTO
      rv_destination
    WHERE rfc_obj_id = iv_rfc_object
      AND rfc_type   = iv_rfc_type
      AND logsys     = lv_logsys.
    IF sy-subrc NE 0.
      "Fallback
      SELECT SINGLE
        rfc_dest
      FROM
        /gicom/trfc_mngr
      INTO
        rv_destination
      WHERE rfc_obj_id = iv_rfc_object
        AND rfc_type   = iv_rfc_type
        AND logsys EQ '' OR logsys IS NULL.

    ENDIF.


  ENDMETHOD.


  METHOD get_instance.
    IF /gicom/cl_rfc_manager=>so_instance IS NOT BOUND.
      /gicom/cl_rfc_manager=>so_instance = NEW /gicom/cl_rfc_manager( ).
    ENDIF.

    ro_instance = /gicom/cl_rfc_manager=>so_instance.
  ENDMETHOD.


  METHOD get_service_name.

    CLEAR rv_service_name.


    SELECT SINGLE
      service_name
    FROM
      /gicom/trfc_obj
    INTO
      rv_service_name
    WHERE id = iv_rfc_object.



  ENDMETHOD.


  METHOD handle_rfc_exception.
**
**  Author: Patrick Böhm  - gicom GmbH
**  Date:   16.01.2017
**  Mantis: 12030
**
**  Description:
**    Raise exceptions for RFC-Module
**
***********************************************************************************************************
*** 0. Declarations
***********************************************************************************************************

    DATA ls_gicom_bapiret TYPE /gicom/bapiret2.

***********************************************************************************************************
*** 1. Check and raise exception
***********************************************************************************************************
    IF iv_subrc <> 0.

      IF iv_subrc <> 1003.
        RAISE EXCEPTION TYPE /gicom/cx_rfc_error
          MESSAGE ID '/GICOM/MSG_FOUNDAT'
          TYPE 'E'
          NUMBER 019
          WITH iv_msg.
      ELSE.
        RAISE EXCEPTION TYPE /gicom/cx_rfc_error
          MESSAGE ID '/GICOM/MSG_FOUNDAT'
          TYPE 'E'
          NUMBER 008.
      ENDIF.

    ELSEIF it_return IS NOT INITIAL.

      FIELD-SYMBOLS: <ls_> LIKE LINE OF it_return.
      LOOP AT it_return ASSIGNING <ls_> WHERE ex_class_name IS NOT INITIAL.

        DATA(lv_name) = <ls_>-ex_class_name.
*
        DATA lo_ex TYPE REF TO cx_root.
        CREATE OBJECT lo_ex TYPE (lv_name).

        IF lo_ex IS INSTANCE OF /gicom/cx_root.
          DATA(lo_gicom_ex) = CAST /gicom/cx_root( lo_ex ).

          lo_gicom_ex->set_params(
            EXPORTING
              iv_msg_class = <ls_>-id
              iv_msg_num   = <ls_>-number
              iv_msg_type  = 'E'
              iv_msg_par1  = <ls_>-message_v1
              iv_msg_par2  = <ls_>-message_v2
              iv_msg_par3  = <ls_>-message_v3
              iv_msg_par4  = <ls_>-message_v4
          ).

          lo_gicom_ex->set_external_source_pos(
            iv_external_include_name = <ls_>-include_name
            iv_external_program_name = <ls_>-abap_program
            iv_external_source_line = <ls_>-source_line
          ).
        ENDIF.

        " Wrap the exception in an RFC error so that we do not declare CX_STATIC_CHECK in our interface
        RAISE EXCEPTION TYPE /gicom/cx_rfc_error
          EXPORTING
            previous = lo_ex.

      ENDLOOP.

      "When we checked table for exceptions, we have to check for errors without exception.
      READ TABLE it_return WITH KEY bo_type = 'E' ASSIGNING FIELD-SYMBOL(<ls_return>).
      IF <ls_return> IS ASSIGNED.
        IF <ls_return>-id IS NOT INITIAL AND <ls_return>-number IS NOT INITIAL.
          RAISE EXCEPTION TYPE /gicom/cx_unresolved_message
            MESSAGE ID <ls_return>-id
            TYPE 'E'
            NUMBER <ls_return>-number.
        ELSE.
          RAISE EXCEPTION TYPE /gicom/cx_unresolved_message.
        ENDIF.
      ENDIF.


    ENDIF.

  ENDMETHOD.
ENDCLASS.
