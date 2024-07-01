INTERFACE /gicom/if_const_record_status
    PUBLIC.

  CONSTANTS:
    cv_activity_internal_only   TYPE /gicom/activity_allowed VALUE 0,
    cv_activity_display_allowed TYPE /gicom/activity_allowed VALUE 1,
    cv_activity_change_allowed  TYPE /gicom/activity_allowed VALUE 2,
    cv_activity_create_allowed  TYPE /gicom/activity_allowed VALUE 3,

    cv_activity_undefined       TYPE /gicom/activity_allowed VALUE 9,

    " Special convenience thingy
    cv_activity_all             TYPE /gicom/activity_allowed VALUE 3.

ENDINTERFACE.
