INTERFACE /gicom/if_constants_custapps
  PUBLIC .


  CONSTANTS:
    BEGIN OF gc_appl_names,
      layout_designer TYPE /gicom/appl_name VALUE 'LAYOUTDESIGNER',
      view_editor     TYPE /gicom/appl_name VALUE 'VIEWEDITOR',
      spro_config     TYPE /gicom/appl_name VALUE 'SPROCONFIG',
    END OF gc_appl_names.

ENDINTERFACE.
