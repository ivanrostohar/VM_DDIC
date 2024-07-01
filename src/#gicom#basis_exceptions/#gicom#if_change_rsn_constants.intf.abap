interface /GICOM/IF_CHANGE_RSN_CONSTANTS
  public .
  CONSTANTS cv_reason_continuation TYPE /gicom/change_reason VALUE 'CONT' ##NO_TEXT.
  CONSTANTS cv_reason_renegotiation TYPE /gicom/change_reason VALUE 'RENG' ##NO_TEXT.
  CONSTANTS cv_reason_deny TYPE /gicom/change_reason VALUE 'DENY' ##NO_TEXT.
  CONSTANTS cv_reason_correction TYPE /gicom/change_reason VALUE 'CORR' ##NO_TEXT.
  CONSTANTS cv_reason_initial TYPE /gicom/change_reason VALUE '' ##NO_TEXT.
endinterface.
