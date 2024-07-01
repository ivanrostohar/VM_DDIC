INTERFACE /gicom/if_const_settl_period
  PUBLIC .


  CONSTANTS gc_monthly          TYPE /gicom/settling_period VALUE 'M'   ##NO_TEXT.
  CONSTANTS gc_quarterly        TYPE /gicom/settling_period VALUE 'Q'   ##NO_TEXT.
  CONSTANTS gc_tertiary         TYPE /gicom/settling_period VALUE 'T'   ##NO_TEXT.
  CONSTANTS gc_half_yearly      TYPE /gicom/settling_period VALUE 'H'   ##NO_TEXT.
  CONSTANTS gc_yearly           TYPE /gicom/settling_period VALUE 'J'   ##NO_TEXT.
  CONSTANTS gc_undetermined     TYPE /gicom/settling_period VALUE 'U'   ##NO_TEXT.
  CONSTANTS gc_target_date      TYPE /gicom/settling_period VALUE 'Z'   ##NO_TEXT.
  CONSTANTS gc_weekly           TYPE /gicom/settling_period VALUE 'W'   ##NO_TEXT.
  CONSTANTS gc_end_of_agreement TYPE /gicom/settling_period VALUE 'V'   ##NO_TEXT.
  CONSTANTS gc_end_of_contract  TYPE /gicom/settling_period VALUE 'E'   ##NO_TEXT.
  CONSTANTS gc_monthly_3        TYPE /gicom/settling_period VALUE 'M3'  ##NO_TEXT.
  CONSTANTS gc_monthly_4        TYPE /gicom/settling_period VALUE 'M4'  ##NO_TEXT.
  CONSTANTS gc_monthly_6        TYPE /gicom/settling_period VALUE 'M6'  ##NO_TEXT.
  CONSTANTS gc_monthly_12       TYPE /gicom/settling_period VALUE 'M12' ##NO_TEXT.
ENDINTERFACE.
