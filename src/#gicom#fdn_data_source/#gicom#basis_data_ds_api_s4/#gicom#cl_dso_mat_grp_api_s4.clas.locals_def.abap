*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

    TYPES: BEGIN OF tt_gicom_productgrouptext,
             results TYPE TABLE OF /gicom/a_productgrouptext WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_gicom_productgrouptext.

    TYPES: BEGIN OF ts_gicom_productgroup.
        INCLUDE TYPE /gicom/a_productgroup.
    TYPES: to_description TYPE tt_gicom_productgrouptext, "ToDo : check field name to_description
           END OF ts_gicom_productgroup.

    TYPES: tt_gicom_productgroup TYPE STANDARD TABLE OF ts_gicom_productgroup WITH NON-UNIQUE DEFAULT KEY.
