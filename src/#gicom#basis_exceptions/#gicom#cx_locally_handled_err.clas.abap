"! <p class="shorttext synchronized" lang="en">Special exception class for errors that are handled locally</p>
"!
"! <p><strong>NEVER USE THIS EXCEPTION TO RAISE ERRORS THAT CAN BUBBLE UP TO THE USER!!!</strong></p>
CLASS /gicom/cx_locally_handled_err DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cx_root
  FINAL
  CREATE PUBLIC.

ENDCLASS.



CLASS /GICOM/CX_LOCALLY_HANDLED_ERR IMPLEMENTATION.
ENDCLASS.
