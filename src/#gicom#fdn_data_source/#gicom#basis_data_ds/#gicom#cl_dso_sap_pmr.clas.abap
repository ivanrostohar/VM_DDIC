CLASS /gicom/cl_dso_sap_pmr DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES /gicom/if_dso_sap_pmr.
    INTERFACES if_badi_interface .

    ALIASES do_commit
      FOR /gicom/if_dso_sap_pmr~do_commit .
    ALIASES do_rollback
      FOR /gicom/if_dso_sap_pmr~do_rollback .
    ALIASES sync_vendor_fund FOR /gicom/if_dso_sap_pmr~sync_vendor_fund.
    ALIASES select_vendor_fund FOR /gicom/if_dso_sap_pmr~select_vendor_fund.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS get_badi
      RETURNING
        VALUE(rb_dso) TYPE REF TO /gicom/badi_ds_sap_pmr.
ENDCLASS.



CLASS /GICOM/CL_DSO_SAP_PMR IMPLEMENTATION.


  METHOD /gicom/if_dso_sap_pmr~do_commit.

*    DATA(lo_badi) = me->get_badi( ).
*
*    CALL BADI lo_badi->do_commit
*      EXPORTING
*        iv_bapi  = iv_bapi
*        iv_local = iv_local.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_pmr~do_rollback.

*    DATA(lo_badi) = me->get_badi( ).
*
*    CALL BADI lo_badi->do_rollback
*      EXPORTING
*        iv_bapi  = iv_bapi
*        iv_local = iv_local.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_pmr~sync_vendor_fund.

*    DATA(lb_dso) = me->get_badi( ).
*
*    CALL BADI lb_dso->sync_vendor_fund
*      EXPORTING
*        iv_sender                 = iv_sender
*        iv_key_tst                = iv_key_tst
*        iv_src_sys                = iv_src_sys
*        it_pmr_vf_header          = it_pmr_vf_header
*        it_pmr_vf_material        = it_pmr_vf_material
*        it_pmr_vf_location        = it_pmr_vf_location
*        it_pmr_vf_distr_channel   = it_pmr_vf_distr_channel
*        it_pmr_vf_amount          = it_pmr_vf_amount
*        it_pmr_vf_material_amount = it_pmr_vf_material_amount
*      IMPORTING
*        et_message                = et_message.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_pmr~select_vendor_fund.

*    DATA(lb_dso) = me->get_badi( ).
*
*    CALL BADI lb_dso->select_vendor_fund
*      EXPORTING
*        iv_src_sys    = iv_src_sys
*        it_vdr_ofr_id = it_vdr_ofr_id
*      IMPORTING
*        et_vdr_fund   = et_vdr_fund.

  ENDMETHOD.


  METHOD get_badi.

*    GET BADI rb_dso.

  ENDMETHOD.
ENDCLASS.
