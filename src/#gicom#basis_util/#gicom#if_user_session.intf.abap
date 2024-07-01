INTERFACE /gicom/if_user_session
    PUBLIC .

  INTERFACES if_badi_interface .

  METHODS get_user_session
    RETURNING
      VALUE(rs_user_session) TYPE /gicom/user_date_s
    RAISING
      /gicom/cx_internal_error.

ENDINTERFACE.
