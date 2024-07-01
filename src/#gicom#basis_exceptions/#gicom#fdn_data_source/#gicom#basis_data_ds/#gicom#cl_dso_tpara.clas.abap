CLASS /gicom/cl_dso_tpara DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_tpara .
    INTERFACES if_badi_interface .

    ALIASES select_cust
      FOR /gicom/if_dso_tpara~select_cust .
    ALIASES select_cust_for_para
      FOR /gicom/if_dso_tpara~select_cust_for_para .

    METHODS select_tpara
      IMPORTING
        itr_keys        TYPE /gicom/key_para_rtt
      RETURNING
        VALUE(rt_tpara) TYPE /gicom/tpara_a_tt.

  PRIVATE SECTION.

ENDCLASS.



CLASS /GICOM/CL_DSO_TPARA IMPLEMENTATION.


  METHOD /gicom/if_dso_tpara~select_cust_for_para.
    SELECT SINGLE para,
                  value
                  FROM /gicom/tpara
                  INTO CORRESPONDING FIELDS OF @rs_tpara
                  WHERE para = @iv_para.
  ENDMETHOD.


  METHOD select_tpara.
    SELECT
      para,
      value

    FROM
      /gicom/tpara

    WHERE
      para IN @itr_keys

    INTO
      TABLE @rt_tpara.
  ENDMETHOD.


  METHOD /gicom/if_dso_tpara~select_cust.
    SELECT
          para,
          value
          FROM /gicom/tpara
          INTO CORRESPONDING FIELDS OF TABLE @rt_tpara.
  ENDMETHOD.
ENDCLASS.
