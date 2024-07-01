CLASS /gicom/cl_rfc_helper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS exeption_to_bapiret
      IMPORTING
        !io_exeption     TYPE REF TO cx_root
      RETURNING
        VALUE(et_return) TYPE /gicom/bapiret_tt .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CL_RFC_HELPER IMPLEMENTATION.


  METHOD exeption_to_bapiret.

    DATA lo_err TYPE REF TO cx_root.
    DATA: ls_bapiret TYPE /gicom/bapiret2.
    lo_err = io_exeption.

    DATA(lo_gicomtypedescr) = CAST cl_abap_classdescr( cl_abap_typedescr=>describe_by_name( '/GICOM/CX_ROOT' ) ).
    DATA(lo_rfctypedescr) = CAST cl_abap_classdescr( cl_abap_typedescr=>describe_by_name( '/GICOM/CX_NO_AUTH_RFC' ) ).

    IF lo_rfctypedescr->applies_to( lo_err ).

      IF lo_err->previous IS BOUND.
        lo_err = lo_err->previous.
      ENDIF.

      ls_bapiret-type = 'E'.
      ls_bapiret-message = lo_err->get_text( ).
      ls_bapiret-message_v1 = lo_err->get_longtext( ).

      APPEND ls_bapiret TO et_return.


    ELSE.

      WHILE lo_err IS BOUND.
        ls_bapiret = VALUE /gicom/bapiret2(
          type  = 'E'
          ex_class_name = cl_abap_classdescr=>describe_by_object_ref( p_object_ref = lo_err )->get_relative_name( )
        ).

        IF lo_gicomtypedescr->applies_to( lo_err ) EQ abap_true.

          DATA(ls_message) = /gicom/cl_util_messages=>get_message_from_exception( lo_err ).

          DATA(lo_gicom_err) = CAST /gicom/cx_root( lo_err ).

          ls_bapiret-id         = ls_message-msgid.
          ls_bapiret-number     = ls_message-msgno.
          ls_bapiret-message_v1 = ls_message-msgv1.
          ls_bapiret-message_v2 = ls_message-msgv2.
          ls_bapiret-message_v3 = ls_message-msgv3.
          ls_bapiret-message_v4 = ls_message-msgv4.

          MESSAGE ID ls_bapiret-id
                  TYPE 'E'
                  NUMBER ls_bapiret-number
                  WITH
                    ls_bapiret-message_v1
                    ls_bapiret-message_v2
                    ls_bapiret-message_v3
                    ls_bapiret-message_v4
                  INTO ls_bapiret-message.

        ELSE.

          ls_bapiret-message = lo_err->get_text( ).
          ls_bapiret-message_v1 = lo_err->get_longtext( ).

        ENDIF.

        io_exeption->get_source_position(
          IMPORTING
            program_name = ls_bapiret-abap_program
            include_name = ls_bapiret-include_name
            source_line  = ls_bapiret-source_line
        ).

        APPEND ls_bapiret TO et_return.

        lo_err = lo_err->previous.

      ENDWHILE.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
