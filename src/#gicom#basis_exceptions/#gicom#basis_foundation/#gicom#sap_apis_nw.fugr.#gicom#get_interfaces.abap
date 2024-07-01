FUNCTION /GICOM/GET_INTERFACES .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CLASS_NAME) TYPE  SEOCLSNAME
*"  EXPORTING
*"     REFERENCE(ET_INTERFACES) TYPE  SEO_RELKEYS
*"--------------------------------------------------------------------

  SELECT clsname,
         refclsname
    FROM seometarel
    INTO TABLE @et_interfaces
   WHERE clsname = @iv_class_name.

ENDFUNCTION.
