INTERFACE /gicom/if_dso_country
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS search
    IMPORTING
      !it_countries       TYPE /gicom/country_code_tt
    RETURNING
      VALUE(rt_countries) TYPE /gicom/country_tt
    RAISING
      /gicom/cx_root_ds.
ENDINTERFACE.
