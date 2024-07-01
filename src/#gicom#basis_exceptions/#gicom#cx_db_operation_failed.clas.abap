CLASS /gicom/cx_db_operation_failed DEFINITION
  PUBLIC
    INHERITING FROM /gicom/cx_internal_error
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          io_previous  TYPE REF TO /gicom/cx_root OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CX_DB_OPERATION_FAILED IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = io_previous ).

  ENDMETHOD.
ENDCLASS.
