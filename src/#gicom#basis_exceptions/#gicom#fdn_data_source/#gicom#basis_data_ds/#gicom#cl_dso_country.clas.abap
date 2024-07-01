CLASS /gicom/cl_dso_country DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_country.

    ALIASES:
     search FOR /gicom/if_dso_country~search.

ENDCLASS.



CLASS /GICOM/CL_DSO_COUNTRY IMPLEMENTATION.


  METHOD /gicom/if_dso_country~search.

    DATA: lb_dso_country TYPE REF TO /gicom/badi_ds_country.

    GET BADI lb_dso_country.

    CALL BADI lb_dso_country->search
      EXPORTING
        it_countries = it_countries
      RECEIVING
        rt_countries = rt_countries.

  ENDMETHOD.
ENDCLASS.
