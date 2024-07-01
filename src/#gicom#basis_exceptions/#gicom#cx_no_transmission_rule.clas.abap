CLASS /gicom/cx_no_transmission_rule DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_not_found
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

    DATA:
        gv_message              TYPE string.

    CONSTANTS:

      BEGIN OF gc_text,
        msgid TYPE symsgid      VALUE '/GICOM/MSG_CCS_01',
        msgno TYPE symsgno      VALUE '130',
        attr1 TYPE scx_attrname VALUE 'gv_message',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF gc_text .

  METHODS constructor
    IMPORTING
        io_previous             LIKE previous OPTIONAL
        iv_condition_type       TYPE /GICOM/COND_TYPE
        iv_model_agreement_exc  TYPE /GICOM/MODEL_AGREEMENT
        iv_operator_focus_exc   TYPE /GICOM/OPERAT_FOCUS
        iv_process_level_exc    TYPE /GICOM/LVL_PROCESS
        iv_sender_level_exc     TYPE /GICOM/ORGLVL
        iv_receiver_level_exc   TYPE /GICOM/ORGLVL
        iv_art_grp_level_exc    TYPE /GICOM/ORGLVL
        iv_grouping_exc         TYPE /GICOM/GROUPING
        iv_evaluation_group_exc TYPE /GICOM/EVAL_GRP
        iv_sourcing_type_exc    TYPE /GICOM/SOURCING_TYPE.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CX_NO_TRANSMISSION_RULE IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
   super->constructor( previous = io_previous ).

   me->gv_message = |'cond_type '       { iv_condition_type         } | &
                    |' ,model_agrmt '   { iv_model_agreement_exc    } | &
                    |' ,operat_focus '  { iv_operator_focus_exc     } | &
                    |' ,proc_lvl '      { iv_process_level_exc      } | &
                    |' ,sender '        { iv_sender_level_exc       } | &
                    |' ,receiver '      { iv_receiver_level_exc     } | &
                    |' ,art_grp '       { iv_art_grp_level_exc      } | &
                    |' ,grouping '      { iv_grouping_exc           } | &
                    |' ,eval_grp '      { iv_evaluation_group_exc   } | &
                    |' ,type_src '      { iv_sourcing_type_exc      } |.


   me->if_t100_message~t100key = gc_text.

  ENDMETHOD.
ENDCLASS.
