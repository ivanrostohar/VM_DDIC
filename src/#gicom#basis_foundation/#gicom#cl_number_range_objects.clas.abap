CLASS /gicom/cl_number_range_objects DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    CONSTANTS cv_ngr                TYPE /gicom/proc_snro VALUE 'VU10' ##NO_TEXT.
    CONSTANTS cv_ng                 TYPE /gicom/proc_snro VALUE 'VU11' ##NO_TEXT.
    CONSTANTS cv_appt               TYPE /gicom/proc_snro VALUE 'BS30' ##NO_TEXT.
    CONSTANTS cv_trans              TYPE /gicom/proc_snro VALUE 'ZK10' ##NO_TEXT.
    CONSTANTS cv_time_ref           TYPE /gicom/proc_snro VALUE 'BS10' ##NO_TEXT.
    CONSTANTS cv_dimension          TYPE /gicom/proc_snro VALUE 'BS20' ##NO_TEXT.
    CONSTANTS cv_oid_int            TYPE /gicom/proc_snro VALUE 'BS40' ##NO_TEXT.
    CONSTANTS cv_sim_reason         TYPE /gicom/proc_snro VALUE 'ZK20' ##NO_TEXT.
    CONSTANTS cv_sim_fragment       TYPE /gicom/proc_snro VALUE 'ZK21' ##NO_TEXT.
    CONSTANTS cv_calc_head          TYPE /gicom/proc_snro VALUE 'ZK31' ##NO_TEXT.
    CONSTANTS cv_sim_trans          TYPE /gicom/proc_snro VALUE 'ZK22' ##NO_TEXT.
    CONSTANTS cv_partic             TYPE /gicom/proc_snro VALUE 'BS60' ##NO_TEXT.
    CONSTANTS cv_oid_ext            TYPE /gicom/proc_snro VALUE 'BS50' ##NO_TEXT.
    CONSTANTS cv_agreement          TYPE /gicom/proc_snro VALUE 'VD20' ##NO_TEXT.
    CONSTANTS cv_contract           TYPE /gicom/proc_snro VALUE 'VD10' ##NO_TEXT.
    CONSTANTS cv_service_type       TYPE /gicom/proc_snro VALUE 'VD30' ##NO_TEXT.
    CONSTANTS cv_distribution_key   TYPE /gicom/proc_snro VALUE 'VD40' ##NO_TEXT.
    CONSTANTS cv_template           TYPE /gicom/proc_snro VALUE 'BS01' ##NO_TEXT.
    CONSTANTS cv_designer           TYPE /gicom/proc_snro VALUE 'BS02' ##NO_TEXT.
    CONSTANTS cv_text_repo          TYPE /gicom/proc_snro VALUE 'BS03' ##NO_TEXT.
    CONSTANTS cv_view_editor        TYPE /gicom/proc_snro VALUE 'BS04' ##NO_TEXT.
    CONSTANTS cv_cond_group         TYPE /gicom/proc_snro VALUE 'BS80' ##NO_TEXT.
    CONSTANTS cv_usg_profile        TYPE /gicom/proc_snro VALUE 'BS90' ##NO_TEXT.
    CONSTANTS cv_distribution       TYPE /gicom/proc_snro VALUE 'ZK40' ##NO_TEXT.
    CONSTANTS cv_sim_distribution   TYPE /gicom/proc_snro VALUE 'ZK50' ##NO_TEXT.
    CONSTANTS cv_value_add          TYPE /gicom/proc_snro VALUE 'BS05' ##NO_TEXT.
    CONSTANTS cv_value_chain        TYPE /gicom/proc_snro VALUE 'BS06' ##NO_TEXT.
    CONSTANTS cv_qm_analysis        TYPE /gicom/proc_snro VALUE 'BS07' ##NO_TEXT.
    CONSTANTS cv_customizing_grp    TYPE /gicom/proc_snro VALUE 'BS12' ##NO_TEXT.
    CONSTANTS cv_master_data_grp    TYPE /gicom/proc_snro VALUE 'BS13' ##NO_TEXT.
    CONSTANTS cv_settlement         TYPE /gicom/proc_snro VALUE 'VP10' ##NO_TEXT.
    CONSTANTS cv_tuad_run_id        TYPE /gicom/proc_snro VALUE 'VP20' ##NO_TEXT.
    CONSTANTS cv_tuad_head_id       TYPE /gicom/proc_snro VALUE 'VP30' ##NO_TEXT.
    CONSTANTS cv_business_model_id  TYPE /gicom/proc_snro VALUE 'CC01' ##NO_TEXT.
    CONSTANTS cv_price_list_id      TYPE /gicom/proc_snro VALUE 'PL01' ##NO_TEXT.
    CONSTANTS cv_metric_id          TYPE /gicom/proc_snro VALUE 'PM01' ##NO_TEXT.

    CLASS-METHODS:

      class_constructor,

      get_instance
        RETURNING
          VALUE(ro_number_range_help_instance) TYPE REF TO /gicom/if_number_range_objects,

      inject_instance
        IMPORTING
          io_number_range_help_instance TYPE REF TO /gicom/if_number_range_objects,

      get_next_number
        IMPORTING
          !iv_proc_snro   TYPE /gicom/proc_snro
        EXPORTING
          !ev_next_number TYPE any
        RAISING
          /gicom/cx_internal_error,

      get_next_number_and_skip
        IMPORTING
          !iv_proc_snro   TYPE /gicom/proc_snro
          !iv_skip        TYPE i
        EXPORTING
          !ev_next_number TYPE any
        RAISING
          /gicom/cx_internal_error.

  PRIVATE SECTION.
    CONSTANTS gc_rc_interval_not_found      TYPE string VALUE 'interval not found' ##NO_TEXT.
    CONSTANTS gc_rc_number_range_not_intern TYPE string VALUE 'number range not intern' ##NO_TEXT.
    CONSTANTS gc_rc_object_not_found        TYPE string VALUE 'object not found' ##NO_TEXT.
    CONSTANTS gc_rc_quantity_is_0           TYPE string VALUE 'quantity is 0' ##NO_TEXT.
    CONSTANTS gc_rc_quantity_is_not_1       TYPE string VALUE 'quantity is not 1' ##NO_TEXT.
    CONSTANTS gc_rc_interval_overflow       TYPE string VALUE 'interval overflow' ##NO_TEXT.
    CONSTANTS gc_rc_buffer_overflow         TYPE string VALUE 'buffer overflow' ##NO_TEXT.
    CONSTANTS gc_rc_others                  TYPE string VALUE 'others' ##NO_TEXT.

    CLASS-DATA:

      go_instance TYPE REF TO /gicom/if_number_range_objects,

      st_snro     TYPE SORTED TABLE OF /gicom/tpro_snro WITH UNIQUE KEY id.

    CLASS-METHODS:

      get_next_number_internal
        IMPORTING
          iv_proc_snro   TYPE /gicom/proc_snro
          iv_quantity    TYPE nrquan DEFAULT '1'
        EXPORTING
          ev_next_number TYPE any
        RAISING
          /gicom/cx_internal_error,

      apply_conversion_exit
        CHANGING
          cv_next_number TYPE any,

      resolve_sy_subrc
        IMPORTING
          iv_sysubrc          TYPE sy-subrc
        RETURNING
          VALUE(rv_errorcode) TYPE string.

ENDCLASS.



CLASS /gicom/cl_number_range_objects IMPLEMENTATION.


  METHOD class_constructor.
    SELECT * FROM /gicom/tpro_snro INTO TABLE @st_snro.
  ENDMETHOD.


  METHOD get_next_number.
    /gicom/cl_number_range_objects=>get_next_number_internal(
      EXPORTING
        iv_proc_snro   = iv_proc_snro
        iv_quantity    = '1'
      IMPORTING
        ev_next_number = ev_next_number
    ).
  ENDMETHOD.


  METHOD get_next_number_internal.
    ASSIGN st_snro[ KEY primary_key id = iv_proc_snro ] TO FIELD-SYMBOL(<ls_snro>).

    IF <ls_snro> IS NOT ASSIGNED.
      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_FOUNDAT'
        TYPE 'E'
        NUMBER 032
        WITH iv_proc_snro.

    ENDIF.

    DATA lv_retcode TYPE inri-returncode.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = <ls_snro>-intervall
        object                  = <ls_snro>-nr_object
        quantity                = iv_quantity
*       subobject               = iv_compcode
*       toyear                  = iv_year
        ignore_buffer           = ' '
      IMPORTING
        number                  = ev_next_number
*       QUANTITY                =
        returncode              = lv_retcode
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.

    DATA(lv_errorcode) = /gicom/cl_number_range_objects=>resolve_sy_subrc( sy-subrc ).

    IF lv_errorcode <> '' OR lv_retcode <> ' '.
      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_FOUNDAT'
        TYPE 'E'
        NUMBER 008
        WITH
        <ls_snro>-nr_object
        lv_errorcode.

    ENDIF.

    /gicom/cl_number_range_objects=>apply_conversion_exit( CHANGING cv_next_number = ev_next_number ).
  ENDMETHOD.


  METHOD resolve_sy_subrc.

    CASE iv_sysubrc.
      WHEN 1.
        rv_errorcode = gc_rc_interval_not_found.
      WHEN 2.
        rv_errorcode = gc_rc_number_range_not_intern.
      WHEN 3.
        rv_errorcode = gc_rc_object_not_found.
      WHEN 4.
        rv_errorcode = gc_rc_quantity_is_0.
      WHEN 5.
        rv_errorcode = gc_rc_quantity_is_not_1.
      WHEN 6.
        rv_errorcode = gc_rc_interval_overflow.
      WHEN 7.
        rv_errorcode = gc_rc_buffer_overflow.
      WHEN 8.
        rv_errorcode = gc_rc_others.
    ENDCASE.

  ENDMETHOD.


  METHOD get_instance.
    IF go_instance IS NOT BOUND.
      go_instance = NEW lcl_facade( ).
    ENDIF.
    ro_number_range_help_instance = go_instance.
  ENDMETHOD.


  METHOD inject_instance.
    go_instance = io_number_range_help_instance.
  ENDMETHOD.


  METHOD apply_conversion_exit.
    TRY.
        IF /gicom/cl_util_ddic=>has_conversion_exit_alpha( /gicom/cl_util_ddic=>get_type_name( cv_next_number ) ) = abap_true.
          TRY.
              /gicom/cl_util_ddic=>conv_exit_rem_to_loc(
                EXPORTING
                  iv_input  = cv_next_number
                IMPORTING
                  ev_output = cv_next_number
              ).
            CATCH /gicom/cx_conversion_error.
              " We can continue because conv_exit ALPHA throws no exception.
          ENDTRY.
        ENDIF.

      CATCH /gicom/cx_internal_error.
        " No conversion #
    ENDTRY.
  ENDMETHOD.


  METHOD get_next_number_and_skip.
    /gicom/cl_number_range_objects=>get_next_number_internal(
      EXPORTING
        iv_proc_snro   = iv_proc_snro
        iv_quantity    = CONV #( iv_skip )
      IMPORTING
        ev_next_number = ev_next_number
    ).
  ENDMETHOD.
ENDCLASS.
