<h3><span class="title"><span class="icon search"></span>&nbsp;<span class="text">{@cadastre~search.form.title@}</span></span></h3>

<div style="display:none;">
  <form id="form_cadastre_service_autocomplete" method="post" action="{jurl 'cadastre~service:autocomplete'}">
    <input type="text" name="term"></input>
  </form>
</div>

<div id="div_form_cadastre_search" class="menu-content">
{form $form, 'cadastre~service:search', array(), 'htmlbootstrap'}

  {formcontrols array('grp_lieu')}
     <p> {ctrl_label} {ctrl_control} </p>
  {/formcontrols}

  {ifacl2 "cadastre.acces.donnees.proprio"}
  {formcontrols array('grp_prop')}
     <p> {ctrl_label} {ctrl_control} </p>
  {/formcontrols}
  {/ifacl2}

  {formcontrols array('grp_result_parcelle_lieu')}
     <p> {ctrl_label} {ctrl_control} </p>
  {/formcontrols}

  {formcontrols array('grp_result_parcelle_prop')}
     <p> {ctrl_label} {ctrl_control} </p>
  {/formcontrols}

  <div style="text-align:center;">
    {ctrl_control 'zoom'}
    {formsubmits}{formsubmit}{/formsubmits}
    {ctrl_control 'emptyselect'}
  </div>
  <div>{formreset}</div>

{/form}

</div>

<!--
<h3><span class="title"><span class="icon result"></span>&nbsp;<span class="text">{@cadastre~search.result.title@}</span></span></h3>
<div id="div_cadastre_results" class="menu-content">
  result
</div>
-->
