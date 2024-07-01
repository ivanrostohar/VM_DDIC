*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

    TYPES: BEGIN OF tt_gicom_description,
             results TYPE TABLE OF /gicom/a_productdescription WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_gicom_description.

    TYPES: BEGIN OF ts_gicom_material.
        INCLUDE TYPE /gicom/a_product.
    TYPES: to_description TYPE tt_gicom_description,
           END OF ts_gicom_material.

    TYPES: tt_gicom_material TYPE STANDARD TABLE OF ts_gicom_material WITH NON-UNIQUE DEFAULT KEY.
