@AbapCatalog.sqlViewName: '/GICOM/VCNDGRPFD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View of condition groups'
define view /GICOM/P_COND_GROUP_FDN as select from /gicom/tcngp as cond_grp 
  // titles
  left outer join /gicom/tcngpt as cond_grp_txt on
    cond_grp_txt.id = cond_grp.id and
    cond_grp_txt.langu = $session.system_language

  left outer join /gicom/tcngpt as cond_grp_txt_eng on
    cond_grp_txt_eng.id     = cond_grp.id and
    cond_grp_txt_eng.langu  = 'E'

{

  key cond_grp.id,
  cond_grp.process,
  cond_grp.schema_id,
  cond_grp.abbrev,
  coalesce( cond_grp_txt.title, cond_grp_txt_eng.title ) as title,
  cond_grp.x_auto_generated,
  cond_grp.level_group,
  cond_grp.created_by,
  cond_grp.created_on,
  cond_grp.last_changed_by,
  cond_grp.last_changed_on

}
  
