CLASS /gicom/cl_dso_efim_exe DEFINITION
  PUBLIC
  CREATE PUBLIC .

PUBLIC SECTION.

  INTERFACES /gicom/if_dso_efim_exe .

  ALIASES execute_tm
    FOR /gicom/if_dso_efim_exe~execute_tm .

PROTECTED SECTION.
PRIVATE SECTION.

ENDCLASS.



CLASS /GICOM/CL_DSO_EFIM_EXE IMPLEMENTATION.


METHOD /gicom/if_dso_efim_exe~execute_tm.

  "Commented out because it is in obsolete package

*  LOOP AT it_groups ASSIGNING FIELD-SYMBOL(<lwa_group>).
*
*    cl_wlf_transfer_manager=>transfer(
*      EXPORTING
*        i_transfer_event    = iv_event
*        i_transfer_group    = <lwa_group>
*        it_source_copy_data = it_source_copy_data
*     CHANGING
*        ct_target_copy_data = et_target_copy_data
*    ).
*
*  ENDLOOP.

ENDMETHOD.
ENDCLASS.
