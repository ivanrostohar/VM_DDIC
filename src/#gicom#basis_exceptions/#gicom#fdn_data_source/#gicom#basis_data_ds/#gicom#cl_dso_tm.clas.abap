class /GICOM/CL_DSO_TM definition
  public
  create public .

public section.

  interfaces /GICOM/IF_DSO_TM .

  aliases EXECUTE_TM
    for /GICOM/IF_DSO_TM~EXECUTE_TM .
  aliases SAVE_TM_DATA
    for /GICOM/IF_DSO_TM~SAVE_TM_DATA .
  aliases SELECT_TM_DATA
    for /GICOM/IF_DSO_TM~SELECT_TM_DATA .

protected section.
private section.
  methods GET_BADI
    returning
      value(RB_DSO_TM) type ref to /GICOM/BADI_DS_TM .
ENDCLASS.



CLASS /GICOM/CL_DSO_TM IMPLEMENTATION.


  METHOD get_badi.
    GET BADI rb_dso_tm.
  ENDMETHOD.


  METHOD /gicom/if_dso_tm~execute_tm.

    TRY.

        DATA(lb_dso) = me->get_badi( ).

        CALL BADI lb_dso->execute_tm
          EXPORTING
            iv_event            = iv_event
            it_groups           = it_groups
            it_source_copy_data = it_source_copy_data
          IMPORTING
            et_target_copy_data = et_target_copy_data.

      CATCH cx_badi.
    ENDTRY.

  ENDMETHOD.


  METHOD /gicom/if_dso_tm~select_tm_data.

    TRY.
        DATA(lb_dso_tm) = get_badi( ).

        CALL BADI lb_dso_tm->select_tm_data
          IMPORTING
            et_tmtg  = et_tmtg
            et_tmtgt = et_tmtgt
            et_tmtr  = et_tmtr
            et_tmss  = et_tmss
            et_tmts  = et_tmts.

      CATCH cx_badi.
    ENDTRY.


  ENDMETHOD.


  METHOD /gicom/if_dso_tm~save_tm_data.

    TRY.
        DATA(lo_dso) = me->get_badi( ).

        CALL BADI lo_dso->save_tm_data
          EXPORTING
            iv_tabname = iv_tabname
            it_insert  = it_insert
            it_update  = it_update
            it_delete  = it_delete.
      CATCH cx_badi.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
