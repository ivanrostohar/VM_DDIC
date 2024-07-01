INTERFACE /gicom/if_constants_ddic
  PUBLIC.

  CONSTANTS: BEGIN OF c_domain,

               lvl_process TYPE ddobjname VALUE '/GICOM/LVL_PROCESS',
               status_ngr  TYPE ddobjname VALUE '/GICOM/STATUS_NGR',
               status_ng   TYPE ddobjname VALUE '/GICOM/STATUS_NG',
               status_appt type ddobjname VALUE '/GICOM/STATUS_APPT',
               type_borel  type ddobjname VALUE '/GICOM/TYPE_REL',
             END OF c_domain.

ENDINTERFACE.
