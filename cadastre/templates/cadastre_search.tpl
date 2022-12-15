<h3><span class="title"><span class="icon search"></span>&nbsp;<span class="text">{@cadastre~search.form.title@}</span></span></h3>

<div style="display:none;">
  <form id="form_cadastre_service_autocomplete" method="post" action="{jurl 'cadastre~service:autocomplete'}">
    <input type="text" name="term"></input>
  </form>
</div>

<div id="div_form_cadastre_search" class="menu-content">
  <ul class="nav nav-tabs" style="margin-bottom: 5px;">
    <li class="active"><a href="#tab1" data-toggle="tab">{@cadastre~search.group.search.lieu@}</a></li>
    {if $has_majic === '1'}
    <li><a href="#tab2" data-toggle="tab">{@cadastre~search.group.search.proprietaire@}</a></li>
    {/if}
  </ul>

  {form $form, 'cadastre~service:search', array(), 'htmlbootstrap'}

    <div class="tab-content">
      <div class="tab-pane active" id="tab1">
        {formcontrols array('commune','section','adresse','voie')}
          <p> {ctrl_label}&nbsp;&nbsp;{ctrl_control} </p>
        {/formcontrols}

        {formcontrols array('grp_result_parcelle_lieu')}
           <p> {ctrl_label} {ctrl_control} </p>
        {/formcontrols}
      </div>
      {if $has_majic === '1'}
      <div class="tab-pane" id="tab2">
        {formcontrols array('commune_prop','proprietaire','comptecommunal','compte')}
          <p> {ctrl_label}&nbsp;&nbsp;{ctrl_control} </p>
        {/formcontrols}

        {formcontrols array('grp_result_parcelle_prop')}
           <p> {ctrl_label} {ctrl_control} </p>
        {/formcontrols}
      </div>
      {/if}

    </div>

    <div style="text-align:center;margin-bottom: 5px;">
      {ctrl_control 'zoom'}
      <div class="btn-group">
        {ctrl_control 'newselect'}
        {ctrl_control 'addselect'}
        {ctrl_control 'unselect'}
      </div>
      {ctrl_control 'emptyselect'}
    </div>
    <div>{formreset}</div>

  {/form}
  {if $has_majic === '1'}
  <div>
    <h4>Données de la sélection</h4>
    <p><a id="cadastre-export-locaux-proprios" class="btn" href="{jurl 'cadastre~service:locauxProprios'}">Locaux et propriétaires <i class="icon-download-alt"></i></a></p>
  </div>
  {/if}


</div>
