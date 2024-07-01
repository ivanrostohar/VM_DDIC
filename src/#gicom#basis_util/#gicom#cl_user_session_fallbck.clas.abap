CLASS /gicom/cl_user_session_fallbck DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface.
    INTERFACES /gicom/if_user_session.
    ALIASES get_user_session FOR /gicom/if_user_session~get_user_session.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CL_USER_SESSION_FALLBCK IMPLEMENTATION.


  METHOD get_user_session.

  ENDMETHOD.
ENDCLASS.
