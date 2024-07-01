CLASS lcl_facade DEFINITION.

  PUBLIC SECTION.

  INTERFACES /gicom/if_util_gos.

ENDCLASS.

CLASS lcl_facade IMPLEMENTATION.

  METHOD /gicom/if_util_gos~delete_file.

    /gicom/cl_util_gos=>delete_file( is_gos_comm = is_gos_comm ).

  ENDMETHOD.

ENDCLASS.
