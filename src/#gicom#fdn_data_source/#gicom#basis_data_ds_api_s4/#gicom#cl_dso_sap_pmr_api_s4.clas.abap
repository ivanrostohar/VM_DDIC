CLASS /gicom/cl_dso_sap_pmr_api_s4 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_sap_pmr .
    INTERFACES if_badi_interface .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CL_DSO_SAP_PMR_API_S4 IMPLEMENTATION.


  METHOD /gicom/if_dso_sap_pmr~sync_vendor_fund.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_pmr~select_vendor_fund.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_pmr~do_commit.

  ENDMETHOD.


  METHOD /gicom/if_dso_sap_pmr~do_rollback.

  ENDMETHOD.
ENDCLASS.
