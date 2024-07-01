@AbapCatalog.sqlViewName: '/gicom/org_cds'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Org-Einheiten CDS'
@ClientDependent: true
define view /gicom/org_Unit as select from /gicom/torg_int
{
  key clnt,
  key id,
  typ,
  title
}
union select from /gicom/org_ext
{
  key clnt,
  key id,
  typ,
  title
}
