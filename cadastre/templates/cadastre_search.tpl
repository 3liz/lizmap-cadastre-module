<h3><span class="title"><span class="icon search"></span>&nbsp;<span class="text">{@cadastre~search.form.title@}</span></span></h3>

<div style="display:none;">
  <form id="form_cadastre_service_autocomplete" method="post" action="{jurl 'cadastre~service:autocomplete'}">
    <input type="text" name="term"></input>
  </form>
</div>
<div id="div_form_cadastre_search" class="menu-content">
{formfull $form, 'cadastre~service:search', array(), 'htmlbootstrap'}
</div>

<!--
<h3><span class="title"><span class="icon result"></span>&nbsp;<span class="text">{@cadastre~search.result.title@}</span></span></h3>
<div id="div_cadastre_results" class="menu-content">
  result
</div>
-->
