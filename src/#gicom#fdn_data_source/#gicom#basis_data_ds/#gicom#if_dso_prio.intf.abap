INTERFACE /gicom/if_dso_prio
  PUBLIC.

  INTERFACES if_badi_interface.


  methods SELECT
    exporting
      !ET_prio type /GICOM/prio_A_TT
      !ET_prio_title type /GICOM/prio_title_tt
      RAISING
        /gicom/cx_internal_error.

ENDINTERFACE.
