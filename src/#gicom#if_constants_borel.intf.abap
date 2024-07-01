INTERFACE /gicom/if_constants_borel
  PUBLIC .
  CONSTANTS: BEGIN OF cs_type,
               budget TYPE /gicom/type_rel VALUE '40',
               hedge  TYPE /gicom/type_rel VALUE '50',
               exclusive_agreement  TYPE /gicom/type_rel VALUE '60',
               sim_agr_origin_of_ad_agr TYPE /gicom/type_rel VALUE '70',
             END OF cs_type.


ENDINTERFACE.
