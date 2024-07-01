CLASS /gicom/cl_dso_repos_eng DEFINITION
  PUBLIC
  CREATE PUBLIC .

PUBLIC SECTION.

  INTERFACES /gicom/if_dso_repos_eng .

  ALIASES class_if_existence_check
    FOR /gicom/if_dso_repos_eng~class_if_existence_check .
  ALIASES create_class
    FOR /gicom/if_dso_repos_eng~create_class .
  ALIASES create_function
    FOR /gicom/if_dso_repos_eng~create_function .
  ALIASES delete_class
    FOR /gicom/if_dso_repos_eng~delete_class .
  ALIASES get_class
    FOR /gicom/if_dso_repos_eng~get_class .
  ALIASES get_class_interfaces
    FOR /gicom/if_dso_repos_eng~get_class_interfaces .
  ALIASES get_includes
    FOR /gicom/if_dso_repos_eng~get_includes .
  ALIASES get_interface
    FOR /gicom/if_dso_repos_eng~get_interface .
  ALIASES get_source_methods
    FOR /gicom/if_dso_repos_eng~get_source_methods .
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CL_DSO_REPOS_ENG IMPLEMENTATION.


  METHOD /gicom/if_dso_repos_eng~get_class_interfaces.

  CHECK iv_class_name IS NOT INITIAL.

  CALL FUNCTION '/GICOM/GET_INTERFACES'
    EXPORTING
      iv_class_name = iv_class_name
    IMPORTING
      et_interfaces = rt_interfaces.

  ENDMETHOD.


METHOD /gicom/if_dso_repos_eng~get_class.

  CHECK iv_classname IS NOT INITIAL.
  " Call FM for Get Class info.

    CALL FUNCTION '/GICOM/SEO_CLASS_READ'
    EXPORTING
      is_clskey                    = VALUE seoclskey( clsname = iv_classname )  " Class
      iv_version                   = seoc_version_inactive    " Version
      iv_master_language           = sy-langu    " Original Language
      iv_modif_language            = sy-langu    " Maintenance Language
      description_bypassing_buffer = abap_false
    IMPORTING
      es_class                     = rs_class.

ENDMETHOD.


METHOD /gicom/if_dso_repos_eng~get_includes.

  cl_oo_classname_service=>get_all_method_includes(
    EXPORTING
      clsname            = iv_class_name
    RECEIVING
      result             = rt_include
    EXCEPTIONS
      class_not_existing = 1
      OTHERS             = 2
  ).

ENDMETHOD.


METHOD /gicom/if_dso_repos_eng~class_if_existence_check.

  CHECK iv_class_name IS NOT INITIAL.

  CALL FUNCTION '/GICOM/SEO_CLIF_EXISTENCE_CHK'
    EXPORTING
      iv_cifkey     = VALUE seoclskey( clsname = iv_class_name )
    EXCEPTIONS
      not_specified = 1
      not_existing  = 2
      OTHERS        = 3.

  IF sy-subrc <> 0.
    rv_not_exists = abap_true.
    RAISE EXCEPTION TYPE /gicom/cx_not_found.
  ENDIF.

ENDMETHOD.


METHOD /gicom/if_dso_repos_eng~get_interface.

  CHECK iv_interface IS NOT INITIAL.
  " Call FM for Get Interface Info.

    CALL FUNCTION '/GICOM/SEO_INTERFACE_READ'
    EXPORTING
      is_intkey                    = VALUE seoclskey( clsname = iv_interface )    " Interface
      iv_version                   = seoc_version_inactive    " Version
      iv_master_language           = sy-langu    " Original Language
      iv_modif_language            = sy-langu    " Maintenance Language
      description_bypassing_buffer = abap_false
    IMPORTING
      es_interface                 = rs_interface.

ENDMETHOD.


METHOD /gicom/if_dso_repos_eng~get_source_methods.

 " Get includes for this class

   DATA(lt_include) = me->get_includes( iv_class_name ).

  IF NOT lt_include IS INITIAL.

  " Get Source Code of all the methods

      LOOP AT lt_include ASSIGNING FIELD-SYMBOL(<lwa_include>).

      APPEND INITIAL LINE TO rt_source ASSIGNING FIELD-SYMBOL(<lwa_source>).

      IF <lwa_source> IS ASSIGNED.

       " Fill in the details of method into final table

        <lwa_source>-clsname = <lwa_include>-cpdkey-clsname.
        <lwa_source>-cpdname = <lwa_include>-cpdkey-cpdname.
        <lwa_source>-incname = <lwa_include>-incname.

        " truncate the interface name & fill out only the component name into method name
         IF <lwa_include>-cpdkey-cpdname CA '~'.
          SPLIT <lwa_include>-cpdkey-cpdname AT '~' INTO DATA(lv_temp) <lwa_source>-method.
        ENDIF.

        " Get source code of the method
                CALL FUNCTION '/GICOM/SEO_METHOD_GET_SOURCE'
          EXPORTING
            is_mtdkey                     = <lwa_include>-cpdkey
          IMPORTING
            ev_source                     = <lwa_source>-source
          EXCEPTIONS
            _internal_method_not_existing = 1
            _internal_class_not_existing  = 2
            version_not_existing          = 3
            inactive_new                  = 4
            inactive_deleted              = 5
            OTHERS                        = 6.
        IF sy-subrc <> 0.
          CLEAR <lwa_source>-source.
        ENDIF.

      ENDIF.

      UNASSIGN <lwa_source>.

    ENDLOOP.

  ENDIF.
ENDMETHOD.


METHOD /gicom/if_dso_repos_eng~delete_class.

  DATA(lv_clskey) = VALUE seoclskey( clsname = iv_class ).

    " validate TR
  IF ev_trkorr IS NOT INITIAL.
    lcl_local_helper=>validate_tr(
      EXPORTING
        iv_class    = iv_class
        iv_trkorr   = ev_trkorr
    ).
  ENDIF.

  CALL FUNCTION '/GICOM/SEO_CLASS_DELET_COMPLET'
    EXPORTING
      iv_clskey          = lv_clskey
      iv_authority_check = abap_false
      iv_suppress_dialog = abap_true
    CHANGING
      cv_corrnr          = ev_trkorr
    EXCEPTIONS
      not_existing       = 1
      is_interface       = 2
      db_error           = 3
      no_access          = 4
      other              = 5
      OTHERS             = 6.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
ENDMETHOD.


METHOD /gicom/if_dso_repos_eng~create_function.

CHECK iv_funcname IS NOT INITIAL AND iv_func_pool IS NOT INITIAL.

" Call FM for Put Function module into FG  (Create and Activate)
CALL FUNCTION '/GICOM/RS_FUNCTIONMODULE_INSRT'
    EXPORTING
      iv_funcname             = iv_funcname         " Function Module Name
      iv_function_pool        = iv_func_pool        " Function Group
      iv_short_text           = iv_short_text
      iv_corrnum              = cv_trkorr         " Correction Number
      iv_authority_check      = abap_false
      iv_save_active          = abap_true
      iv_new_source           = it_source         " source code
    IMPORTING
      ev_function_include     = rv_fun_include
      ev_corrnum_e            = cv_trkorr
    TABLES
      import_parameter        = ct_imp_params    " Import Parameters
      export_parameter        = ct_exp_params    " Export Parameters
      tables_parameter        = ct_tab_params    " Table Parameters
      changing_parameter      = ct_cha_params
      exception_list          = ct_exc_list      " List of exceptions
      parameter_docu          = ct_par_docu
    EXCEPTIONS
      double_task             = 1
      error_message           = 2
      function_already_exists = 3
      invalid_function_pool   = 4
      invalid_name            = 5
      too_many_functions      = 6
      no_modify_permission    = 7
      no_show_permission      = 8
      enqueue_system_failure  = 9
      canceled_in_corr        = 10
      OTHERS                  = 11.
  IF sy-subrc <> 0.
* Implement suitable error handling here
    CLEAR rv_fun_include.
  ENDIF.

ENDMETHOD.


METHOD /gicom/if_dso_repos_eng~create_class.

  DATA: ls_inheritance   TYPE vseoextend,
        lt_imptngs       TYPE seor_implementings_r,
        lt_method_source TYPE seo_method_source_table,
        lt_aliases       TYPE seoo_aliases_r.

  DATA: ls_imptngs LIKE LINE OF lt_imptngs.

  CHECK  is_class IS NOT INITIAL.

  DATA(ls_class) = is_class.

  " Adding Some Basic Information for Class
  ls_class-clsccincl = abap_true. "Flags new include structure for local types
  ls_class-fixpt = abap_true. "Fixed point arithmetic flag

  ls_class-langu = sy-langu.
  ls_class-author = /gicom/cl_system=>get_username( ).
  ls_class-createdon = /gicom/cl_system=>get_date( ).

  IF iv_superclass IS NOT INITIAL.

   " Adding Interface's Info. for class,
   LOOP AT it_interface ASSIGNING FIELD-SYMBOL(<ls_inteface>).
    " Get Interface Information

     ls_imptngs = CORRESPONDING #( get_interface( iv_interface = <ls_inteface>-clsname ) ).

      "Fill empty implementation for all the methods from interfaces
      lcl_local_helper=>prepare_method_sources(
        EXPORTING
          iv_interface     = <ls_inteface>-clsname
          iv_class         = is_class-clsname
        IMPORTING
          et_method_source = lt_method_source
          et_aliases       = lt_aliases
      ).

      IF ls_imptngs-clsname IS NOT INITIAL.
        ls_imptngs-refclsname = ls_imptngs-clsname.    " Reference name (Interface)
        ls_imptngs-clsname = ls_class-clsname.         " Current Class name

        APPEND ls_imptngs TO lt_imptngs.
        CLEAR: ls_imptngs.
      ENDIF.

    ENDLOOP.

  ENDIF.

  " validate TR
  IF ev_trkorr IS NOT INITIAL.
    lcl_local_helper=>validate_tr(
      EXPORTING
        iv_class    = is_class-clsname
        iv_devclass = iv_devclass
        iv_trkorr   = ev_trkorr
    ).
  ENDIF.

  CALL FUNCTION '/GICOM/SEO_CLASS_CREATE_COMPLT'
    EXPORTING
      iv_corrnr                      = ev_trkorr              " Correction Number
      iv_devclass                    = iv_devclass            " Package
      iv_version                     = seoc_version_active    " Active/Inactive
      iv_authority_check             = abap_false
      it_method_sources              = lt_method_source       " Table of Methodsources
      iv_suppress_corr               = abap_false
      iv_suppress_dialog             = abap_true
      generate_method_impls_wo_frame = abap_true  " X -> METHOD_SOURCES have to contain METHOD and ENDMETHOD sta
    IMPORTING
      ev_korrnr                      = ev_trkorr              " Request/Task
      ev_class                       = ev_class
    CHANGING
      cs_class                       = ls_class
      cs_inheritance                 = ls_inheritance
      ct_implementings               = lt_imptngs
      ct_aliases                     = lt_aliases
    EXCEPTIONS
      existing                       = 1
      is_interface                   = 2
      db_error                       = 3
      component_error                = 4
      no_access                      = 5
      other                          = 6
      OTHERS                         = 7.
  IF sy-subrc EQ 0.
    IF ev_class IS INITIAL.
      rv_subrc = 4.
    ENDIF.
  ELSE.
* Implement suitable error handling here
    rv_subrc = sy-subrc.
  ENDIF.
ENDMETHOD.
ENDCLASS.
