"! <p class="shorttext synchronized" lang="de">Helper Class for Business Objects</p>
class /GICOM/CL_UTIL_BO definition
  public
  create public .

public section.

  interfaces /GICOM/IF_CONSTANTS_BO .

  aliases CS_BO_CNTR_APLPRS
    for /GICOM/IF_CONSTANTS_BO~CS_BO_CNTR_APLPRS .
  aliases CV_BO_ADDEND
    for /GICOM/IF_CONSTANTS_BO~CV_BO_ADDEND .
  aliases CV_BO_AGRMT
    for /GICOM/IF_CONSTANTS_BO~CV_BO_AGRMT .
  aliases CV_BO_APPT
    for /GICOM/IF_CONSTANTS_BO~CV_BO_APPT .
  aliases CV_BO_BUPA
    for /GICOM/IF_CONSTANTS_BO~CV_BO_BUPA .
  aliases CV_BO_CNTR
    for /GICOM/IF_CONSTANTS_BO~CV_BO_CNTR .
  aliases CV_BO_CNTR_VAR
    for /GICOM/IF_CONSTANTS_BO~CV_BO_CNTR_VAR .
  aliases CV_BO_COCODE
    for /GICOM/IF_CONSTANTS_BO~CV_BO_COCODE .
  aliases CV_BO_CONDITION_TYPE
    for /GICOM/IF_CONSTANTS_BO~CV_BO_CONDITION_TYPE .
  aliases CV_BO_CONTRACT_TYPE
    for /GICOM/IF_CONSTANTS_BO~CV_BO_CONTRACT_TYPE .
  aliases CV_BO_COST_CENTER
    for /GICOM/IF_CONSTANTS_BO~CV_BO_COST_CENTER .
  aliases CV_BO_CUST
    for /GICOM/IF_CONSTANTS_BO~CV_BO_CUST .
  aliases CV_BO_DISTRIBUTION_CHANNEL
    for /GICOM/IF_CONSTANTS_BO~CV_BO_DISTRIBUTION_CHANNEL .
  aliases CV_BO_DIVISION
    for /GICOM/IF_CONSTANTS_BO~CV_BO_DIVISION .
  aliases CV_BO_MATGRP
    for /GICOM/IF_CONSTANTS_BO~CV_BO_MATGRP .
  aliases CV_BO_NEGOTIATION_ROUND_TYPE
    for /GICOM/IF_CONSTANTS_BO~CV_BO_NEGOTIATION_ROUND_TYPE .
  aliases CV_BO_NG
    for /GICOM/IF_CONSTANTS_BO~CV_BO_NG .
  aliases CV_BO_NGR
    for /GICOM/IF_CONSTANTS_BO~CV_BO_NGR .
  aliases CV_BO_PLANT
    for /GICOM/IF_CONSTANTS_BO~CV_BO_PLANT .
  aliases CV_BO_PRODH
    for /GICOM/IF_CONSTANTS_BO~CV_BO_PRODH .
  aliases CV_BO_PURCH_GRP
    for /GICOM/IF_CONSTANTS_BO~CV_BO_PURCH_GRP .
  aliases CV_BO_PURCH_ORG
    for /GICOM/IF_CONSTANTS_BO~CV_BO_PURCH_ORG .
  aliases CV_BO_SALES_ORG
    for /GICOM/IF_CONSTANTS_BO~CV_BO_SALES_ORG .
  aliases CV_BO_SETTLE_DOC
    for /GICOM/IF_CONSTANTS_BO~CV_BO_SETTLE_DOC .
  aliases CV_BO_SETTLE_RUN
    for /GICOM/IF_CONSTANTS_BO~CV_BO_SETTLE_RUN .
  aliases CV_BO_SUPPL
    for /GICOM/IF_CONSTANTS_BO~CV_BO_SUPPL .
  aliases CV_BO_TURNOVER_ADJUSTMENT
    for /GICOM/IF_CONSTANTS_BO~CV_BO_TURNOVER_ADJUSTMENT .
  aliases CV_BO_SIMULATION_AGREEMENT
    for /GICOM/IF_CONSTANTS_BO~CV_BO_SIMULATION_AGREEMENT.

  class-methods CREATE_BO_ID
    importing
      !IV_ID type CLIKE
      !IV_VERSION type CLIKE optional
      !IV_NO type CLIKE optional
    returning
      value(RV_BO_ID) type /GICOM/BO_ID .
  class-methods SPLIT_BO_ID
    importing
      !IV_BO_ID type /GICOM/BO_ID
      !IV_BO_TYP type /GICOM/BO_TYP
    exporting
      !PARAM1 type CLIKE
      !PARAM2 type CLIKE
      !PARAM3 type CLIKE
      !PARAM4 type CLIKE
      !PARAM5 type CLIKE
    raising
      /GICOM/CX_INVALID_ARGUMENTS
      /GICOM/CX_BO_ID_ILLEGAL_LENGTH .
  class-methods CREATE_OBJECT
    importing
      !IV_TYPE type SWO_OBJTYP
      !IV_KEY type SWO_TYPEID optional
    returning
      value(RS_BUSINESS_OBJECT) type OBJ_RECORD .
  class-methods SET_ELEMENT
    importing
      !IV_ELEMENT type ANY
      !IV_FIELD type ANY
    changing
      !CT_CONTAINER type SWCONTTAB .
  class-methods CALL_METHOD
    importing
      !IS_OBJ type OBJ_RECORD
      !IV_VERB type SWO_VERB
    changing
      !CT_CONTAINER type SWCONTTAB .
  class-methods GET_OBJECT_ID
    importing
      !IS_OBJ type OBJ_RECORD
    returning
      value(RV_ID) type SWO_TYPEID .
  class-methods GET_OBJECT_TYPE
    importing
      !IS_OBJ type OBJ_RECORD
    returning
      value(RV_TYPE) type SWO_OBJTYP .
  class-methods GET_DTEL_FOR_BO
    importing
      !IV_BO_TYP type /GICOM/BO_TYP
    returning
      value(RV_DTEL) type ROLLNAME
    raising
      /GICOM/CX_NO_DATA .
  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS /GICOM/CL_UTIL_BO IMPLEMENTATION.


  METHOD call_method.

    swc_call_method     is_obj iv_verb ct_container.

  ENDMETHOD.


  METHOD create_bo_id.

    DATA lv_id TYPE REF TO data.
    CREATE DATA lv_id LIKE iv_id.
    ASSIGN lv_id->* TO FIELD-SYMBOL(<lv_deref>).
    TRY.
        TEST-SEAM convex_remtloc_create_bo_id.
          /gicom/cl_util_ddic=>conv_exit_rem_to_loc(
              EXPORTING
                  iv_input = iv_id
              IMPORTING
                  ev_output = <lv_deref>
          ).
        END-TEST-SEAM.
      CATCH /gicom/cx_conversion_error.
        " We can continue because conv_exit ALPHA throws no exception.
    ENDTRY.

    rv_bo_id = <lv_deref>.

    IF iv_version IS SUPPLIED.
      IF strlen( iv_version ) < 3.
        rv_bo_id = rv_bo_id && '0'.
      ENDIF.

      IF strlen( iv_version ) < 2.
        rv_bo_id = rv_bo_id && '0'.
      ENDIF.

      rv_bo_id = rv_bo_id && iv_version.
    ENDIF.

    IF iv_no IS SUPPLIED.
      IF strlen( iv_no ) < 2.
        rv_bo_id = rv_bo_id && '0'.
      ENDIF.


      rv_bo_id = rv_bo_id && iv_no.
    ENDIF.


  ENDMETHOD.


  METHOD create_object.

    swc_create_object   rs_business_object iv_type iv_key.

  ENDMETHOD.


  METHOD get_dtel_for_bo.

**********************************************************************
  "DO NOT CHANGES THIS CODE!!!! IN CASE OF ANY REQUIRED CHANGE, PLEASE CONTACT PJ (or he will contact you after change :D)
**********************************************************************

    "ToDo: Table or BO-Method to get data element
    CASE iv_bo_typ.
      WHEN cv_bo_suppl .
        rv_dtel = 'LIFNR'.
      WHEN cv_bo_cust .
        rv_dtel = 'KUNNR'.
      WHEN cv_bo_bupa .
        rv_dtel = 'BU_PARTNER'.
*      WHEN   cv_bo_addend.
*        rv_dtel = ''.
*      WHEN cv_bo_agrmt .
*        rv_dtel = ''.
*      WHEN cv_bo_appt .
*        rv_dtel = ''.
*      WHEN cv_bo_cnd_typ .
*        rv_dtel = ''.
*      WHEN cv_bo_cntr .
*        rv_dtel = '/GICOM/CONTRACT_ID'.
*      WHEN cv_bo_cntr_typ .
*        rv_dtel = ''.
*      WHEN cv_bo_cntr_var .
*        rv_dtel = ''.
*      WHEN cv_bo_cocode .
*        rv_dtel = ''.
*      WHEN cv_bo_matgrp .
*        rv_dtel = ''.
*      WHEN cv_bo_ng .
*        " rv_dtel = '/GICOM/NG_ID'.
*        rv_dtel = '/GICOM/CHAR13_ALPHA'.
      WHEN cv_bo_ngr .
        rv_dtel = '/GICOM/NGR_ID'.
*      WHEN cv_bo_ngr_typ .
*        rv_dtel = ''.
*      WHEN cv_bo_plant .
*        rv_dtel = ''.
*      WHEN cv_bo_purch_org .
*        rv_dtel = ''.
*      WHEN cv_bo_sales_org .
*        rv_dtel = ''.
      WHEN OTHERS.
        RAISE EXCEPTION TYPE /gicom/cx_no_data.
    ENDCASE.


  ENDMETHOD.


  METHOD get_object_id.

    swc_get_object_key  is_obj rv_id.

  ENDMETHOD.


  METHOD get_object_type.

    swc_get_object_type is_obj rv_type.

  ENDMETHOD.


  METHOD set_element.

    swc_set_element     ct_container iv_element iv_field.

  ENDMETHOD.


  METHOD split_bo_id.

    DATA: lv_bo_id     TYPE /gicom/bo_id,
          lv_id        TYPE string,
          lv_id_length TYPE string,
          lv_bo_string TYPE string,
          lv_bo_typ    TYPE /gicom/bo_typ.


    CASE iv_bo_typ.
      WHEN /gicom/cl_util_bo=>cv_bo_ngr.
*        IF strlen( iv_bo_id ) < 1.
*          RAISE EXCEPTION TYPE /gicom/cx_bo_id_illegal_length
*            EXPORTING
*              iv_bo_id  = lv_bo_id
*              iv_bo_typ = /gicom/cl_util_bo=>cv_bo_ng.
*        ENDIF.
        param1 = iv_bo_id.
        TRY.
            TEST-SEAM convex_remtloc_ngr.
              /gicom/cl_util_ddic=>conv_exit_rem_to_loc( EXPORTING iv_input   = param1
                                                         IMPORTING ev_output  = param1 ).
            END-TEST-SEAM.
          CATCH /gicom/cx_conversion_error.
            " We can continue because conv_exit ALPHA throws no exception.
        ENDTRY.
      WHEN /gicom/cl_util_bo=>cv_bo_ng. "We now: last three characters are the version, rest ist NG-ID
****************************************************
* Remove leading zeros
****************************************************
        TRY.
            TEST-SEAM convex_loctrem_ng.
              /gicom/cl_util_ddic=>conv_exit_loc_to_rem(
                 EXPORTING
                   iv_input  = iv_bo_id
                 IMPORTING
                   ev_output = lv_bo_id
               ).
            END-TEST-SEAM.
          CATCH /gicom/cx_conversion_error.
            " We can continue because conv_exit ALPHA throws no exception.
        ENDTRY.
        lv_bo_string = lv_bo_id.

****************************************************
* Determine the length of the BO-ID
****************************************************
        DATA(lv_bo_id_length) = strlen( lv_bo_string ).

        IF lv_bo_id_length < 4.
          RAISE EXCEPTION TYPE /gicom/cx_bo_id_illegal_length
            EXPORTING
              iv_bo_id  = lv_bo_id
              iv_bo_typ = /gicom/cl_util_bo=>cv_bo_ng.
        ENDIF.

****************************************************
* Determine the length of the ID
****************************************************
        lv_id_length = lv_bo_id_length - '3' .

        param1 = lv_bo_string+0(lv_id_length).
        TRY.
            TEST-SEAM convex_remtloc_ng.
              /gicom/cl_util_ddic=>conv_exit_rem_to_loc( EXPORTING iv_input   = param1
                                                         IMPORTING ev_output  = param1 ).
            END-TEST-SEAM.
          CATCH /gicom/cx_conversion_error.
            " We can continue because conv_exit ALPHA throws no exception.
        ENDTRY.

        param2 = lv_bo_id+lv_id_length(3).

      WHEN /gicom/cl_util_bo=>cv_bo_cntr_var. "We now: last three characters are the version, rest ist Cntr-ID
****************************************************
* Remove leading zeros
****************************************************
        TRY.
            TEST-SEAM convex_loctrem_cntr_var.
              /gicom/cl_util_ddic=>conv_exit_loc_to_rem(
                       EXPORTING
                         iv_input  = iv_bo_id
                       IMPORTING
                         ev_output = lv_bo_id
                     ).
            END-TEST-SEAM.
          CATCH /gicom/cx_conversion_error.
            " We can continue because conv_exit ALPHA throws no exception.
        ENDTRY.
        lv_bo_string = lv_bo_id.

****************************************************
* Determine the length of the BO-ID
****************************************************
        lv_bo_id_length = strlen( lv_bo_string ).

        IF lv_bo_id_length < 4.
          RAISE EXCEPTION TYPE /gicom/cx_bo_id_illegal_length
            EXPORTING
              iv_bo_id  = lv_bo_id
              iv_bo_typ = /gicom/cl_util_bo=>cv_bo_ng.
        ENDIF.

****************************************************
* Determine the length of the ID
****************************************************
        lv_id_length = lv_bo_id_length - '3' .

        param1 = lv_bo_string+0(lv_id_length).
        TRY.
            TEST-SEAM convex_remtloc_cntr_var.
              /gicom/cl_util_ddic=>conv_exit_rem_to_loc( EXPORTING iv_input   = param1
                                                         IMPORTING ev_output  = param1 ).
            END-TEST-SEAM.
          CATCH /gicom/cx_conversion_error.
            " We can continue because conv_exit ALPHA throws no exception.
        ENDTRY.
        param2 = lv_bo_id+lv_id_length(3).


      WHEN /gicom/cl_util_bo=>cv_bo_addend.

****************************************************
* Remove leading zeros
****************************************************
        TRY.
            TEST-SEAM convex_loctrem_addend.
              /gicom/cl_util_ddic=>conv_exit_loc_to_rem(
                       EXPORTING
                         iv_input  = iv_bo_id
                       IMPORTING
                         ev_output = lv_bo_id
                     ).
            END-TEST-SEAM.
          CATCH /gicom/cx_conversion_error.

        ENDTRY.
        lv_bo_string = lv_bo_id.

****************************************************
* Determine the length of the BO-ID
****************************************************
        lv_bo_id_length = strlen( lv_bo_string ).

        IF lv_bo_id_length < 6.
          RAISE EXCEPTION TYPE /gicom/cx_bo_id_illegal_length
            EXPORTING
              iv_bo_id  = lv_bo_id
              iv_bo_typ = /gicom/cl_util_bo=>cv_bo_ng.
        ENDIF.

****************************************************
* Determine the length of the ID
****************************************************
        lv_id_length = lv_bo_id_length - '5' .

        param1 = lv_bo_string+0(lv_id_length).
        TRY.
            TEST-SEAM convex_remtloc_addend.
              /gicom/cl_util_ddic=>conv_exit_rem_to_loc( EXPORTING iv_input   = param1
                                                         IMPORTING ev_output  = param1 ).
            END-TEST-SEAM.
          CATCH /gicom/cx_conversion_error.
            " We can continue because conv_exit ALPHA throws no exception.
        ENDTRY.
        param2 = lv_bo_id+lv_id_length(3).

        lv_id_length = lv_id_length + '3'.

        param3 = lv_bo_id+lv_id_length(2).

      WHEN /gicom/cl_util_bo=>cv_bo_agrmt.
****************************************************
* Remove leading zeros
****************************************************
        TEST-SEAM convex_loctrem_agrmt.
          /gicom/cl_util_ddic=>conv_exit_loc_to_rem(
                   EXPORTING
                     iv_input  = iv_bo_id
                   IMPORTING
                     ev_output = lv_bo_id
                 ).
        END-TEST-SEAM.


        IF strlen( lv_bo_id ) < 1.
          RAISE EXCEPTION TYPE /gicom/cx_bo_id_illegal_length
            EXPORTING
              iv_bo_id  = lv_bo_id
              iv_bo_typ = /gicom/cl_util_bo=>cv_bo_ng.
        ENDIF.

        lv_bo_string = lv_bo_id.

        param1 = lv_bo_string.
        TRY.
            TEST-SEAM convex_remtloc_agrmt.
              /gicom/cl_util_ddic=>conv_exit_rem_to_loc( EXPORTING iv_input   = param1
                                                         IMPORTING ev_output  = param1 ).
            END-TEST-SEAM.
          CATCH /gicom/cx_conversion_error.
            " We can continue because conv_exit ALPHA throws no exception.
        ENDTRY.

      WHEN /gicom/cl_util_bo=>cv_bo_simulation_agreement.

        IF strlen( iv_bo_id ) = 20.

          param1 = iv_bo_id(10).
          param2 = iv_bo_id+10(10).

        ELSE.
          RAISE EXCEPTION NEW /gicom/cx_bo_id_illegal_length(
            iv_bo_id  = lv_bo_id
            iv_bo_typ = /gicom/cl_util_bo=>cv_bo_simulation_agreement
           ).
        ENDIF.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE /gicom/cx_invalid_arguments
          MESSAGE ID '/GICOM/VU_MESSAGES'
          TYPE 'E'
          NUMBER 061.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
