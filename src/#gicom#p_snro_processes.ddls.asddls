@AbapCatalog.sqlViewName: '/GICOM/VSNRO_PRO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Number Range Processes'
define view /GICOM/P_SNRO_PROCESSES
  as select from
  dd07t
{
  key valpos     as process_position,
      domvalue_l as process_key,
      ddtext     as process

}

where
  domname = '/GICOM/PROC_SNRO' and
  as4local = 'A' and
  ddlanguage = $session.system_language
