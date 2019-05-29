
function selectParcelles(getFeatureUrlData, addToSelection){
    $('body').css('cursor', 'wait');

    $.post( getFeatureUrlData['url'], getFeatureUrlData['options'], function(data2) {
        if( data2.features.length != 0) {
            var nbParcellesModify = 0;
            for(var f in data2.features){
                var feature = data2.features[f];
                
                var parcelleId = feature.id.split('.')[1];

                if(addToSelection){
                    // Don't add existing parcelle
                    if(lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'].indexOf(parcelleId) === -1){
                        lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'].push(parcelleId);
                        nbParcellesModify++;
                    }
                }else{
                    var index = lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'].indexOf(parcelleId);
                    if (index > -1) {
                      lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'].splice(index, 1);
                      nbParcellesModify++;
                    }
                }
            }

            if( nbParcellesModify > 0){
                // Messages
                $('#lizmap-cadastre-message').remove();
                
                var html = '';
                if(addToSelection){
                    if(nbParcellesModify == 1){
                        html = "1 parcelle a été sélectionnée.";
                    }else{
                        html = nbParcellesModify+" parcelles ont été sélectionnées.";
                    }
                }else{
                    if(nbParcellesModify == 1){
                        html = "1 parcelle a été désélectionnée.";
                    }else{
                        html = nbParcellesModify+" parcelles ont été désélectionnées.";
                    }
                }

                lizMap.addMessage(html,'info',true).attr('id','lizmap-cadastre-message');
                // Open selection mini-dock
                $('#mapmenu li.selectiontool:not(.active) a').click();

                // Trigger selection
                // Dot no trigger updateDrawing to avoid too big url
                // Get layer
                var cleanName = lizMap.cleanName(cadastreConfig.layer);
                var layer = lizMap.map.getLayersByName( cleanName )[0];
                var updateDrawing = true;
                if( layer && lizMap.config.layers[cadastreConfig.layer]
                    && 'EXP_FILTER' in getFeatureUrlData['options']
                    && getFeatureUrlData['options']['EXP_FILTER'].startsWith('"comptecommunal"')

                ){
                    var selectionParam = cadastreConfig.layer + ': ' + getFeatureUrlData['options']['EXP_FILTER'];
                    //lizMap.config.layers[cadastreConfig.layer]['request_params']['filter'] = selectionParam;
                    //layer.params['FILTER'] = selectionParam;
                    //layer.redraw(true);
                    //updateDrawing = false;
                }else{
                    console.log('pas de filtre par comptecommunal');
                }

                lizMap.events.triggerEvent(
                    "layerSelectionChanged",
                    {
                        'featureType': cadastreConfig.layer,
                        'featureIds': lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'],
                        'updateDrawing': updateDrawing
                    }
                );
            }else{
                $('#lizmap-cadastre-message').remove();
                lizMap.addMessage("Aucune parcelle n'a été sélectionnée",'error',true).attr('id','lizmap-cadastre-message');
            }

            $('body').css('cursor', 'auto');
            window.setTimeout(function(){$('#lizmap-cadastre-message').hide('slow')},1500);
            return false;
        }else{
            $('#lizmap-cadastre-message').remove();
            lizMap.addMessage("Aucune parcelle n'a été sélectionnée",'error',true).attr('id','lizmap-cadastre-message');
            $('body').css('cursor', 'auto');
            window.setTimeout(function(){$('#lizmap-cadastre-message').hide('slow')},1500);
            return false;
        }

    }).fail(function(){
        $('#lizmap-cadastre-message').remove();
        lizMap.addMessage("Aucune parcelle n'a été sélectionnée",'error',true).attr('id','lizmap-cadastre-message');
        $('body').css('cursor', 'auto');
        window.setTimeout(function(){$('#lizmap-cadastre-message').hide('slow')},1500);
        return false;
    });
}

function selectParcelleByProprietaire(geo_parcelle, addToSelection){

    var feat = null;
    //var featureId = cadastreConfig.layer + '.' + fid;

    //var getFeatureUrlData = lizMap.getVectorLayerWfsUrl( cadastreConfig.layer, null, featureId, 'none' );
    var getFeatureUrlData = lizMap.getVectorLayerWfsUrl( cadastreConfig.layer, '"geo_parcelle" IN (\''+geo_parcelle+'\')', null, 'none' );
    getFeatureUrlData['options']['PROPERTYNAME'] = [cadastreConfig.pk].join(',') + ',comptecommunal';

    // Get parcelle feature
    $.post( getFeatureUrlData['url'], getFeatureUrlData['options'], function(data) {
        if( data.features.length != 0) {
            var format = new OpenLayers.Format.GeoJSON();
            feat = format.read(data.features[0])[0];

            // Get all parcelle sharing same comptecommunal
            var getFeatureUrlData2 = lizMap.getVectorLayerWfsUrl(
                cadastreConfig.layer,
                '"comptecommunal" IN ( \''+feat.attributes.comptecommunal+'\' )',
                null,
                'none'
            );
            getFeatureUrlData2['options']['PROPERTYNAME'] = [cadastreConfig.pk].join(',') + ',comptecommunal';
            selectParcelles(getFeatureUrlData2, addToSelection);

            return false;
        }
        $('body').css('cursor', 'auto');
    }).fail(function(){
        $('#lizmap-cadastre-message').remove();
        lizMap.addMessage("Aucune parcelle n'a été sélectionnée",'error',true).attr('id','lizmap-cadastre-message');
        $('body').css('cursor', 'auto');
        return false;
    });

    return false;
};

lizMap.events.on({

    'uicreated': function(e){
        var cadastreCrs = 'EPSG:2154';
        if ( 'qgisServerVersion' in lizMap.config.options && lizMap.config.options.qgisServerVersion != '2.14' )
            cadastreCrs = 'EPSG:4326';

        function initCadastreForm() {
            var formId = $('#div_form_cadastre_search form').attr('id');
            $('#'+formId+'_commune').val('');
            $('#'+formId+'_adresse').val('');
            $('#'+formId+'_voie').val('');
            $('#'+formId+'_geo_parcelle_lieu').val('');
            $('#'+formId+'_commune_prop').val('');
            $('#'+formId+'_proprietaire').val('');
            $('#'+formId+'_comptecommunal').val('');
            $('#'+formId+'_geo_parcelle_prop').val('');

            // Autocomplete adresse
            $('#'+formId+'_adresse').autocomplete({
                minLength:3,
                delay: 500,
                autoFocus: true,
                source:function( request, response ) {
                    request.field = 'voie';
                    request.commune = $('#'+formId+'_commune').val();
                    request.limit = 100;
                    $.getJSON($('#form_cadastre_service_autocomplete').attr('action'),
                        request, function( data, status, xhr ) {
                            response( data );
                        }
                    );
                },
                open: function( e, ui ) {
                },
                focus: function( e, ui ) {
                },
                close: function( e, ui ) {
                },
                change: function( e, ui ) {
                    $('#'+formId+'_section').val( '' );
                    if ( $(this).val().length < $(this).autocomplete('option','minLength') ){
                        $(this).val('').change();
                        $('#'+formId+'_voie').val('').change();
                    }
                },
                search: function( e, ui ) {
                    //$('#'+formId+'_section').val( '' ).change();
                    //$('#'+formId+'_voie').val('').change();
                },
                select: function( e, ui ) {
                    $(this).val( $('<a>').html(ui.item.label).text() );
                    $('#'+formId+'_section').val( '' );
                    $('#'+formId+'_voie').val( ui.item.code ).change();

                    return false;
                }
            }).autocomplete( "widget" ).css("z-index","1050");

            // Autocomplete proprietaire
            $('#'+formId+'_proprietaire').autocomplete({
                minLength:3,
                autoFocus: true,
                source:function( request, response ) {
                    request.field = 'prop';
                    request.commune = $('#'+formId+'_commune_prop').val();
                    request.limit = 100;
                    $.getJSON($('#form_cadastre_service_autocomplete').attr('action'),
                        request, function( data, status, xhr ) {
                            response( data );
                        }
                    );
                },
                open: function( e, ui ) {
                },
                focus: function( e, ui ) {
                },
                close: function( e, ui ) {
                },
                change: function( e, ui ) {
                    if ( $(this).val().length < $(this).autocomplete('option','minLength') ){
                        $(this).val('').change();
                        $('#'+formId+'_comptecommunal').val('').change();
                    }
                },
                search: function( e, ui ) {
                },
                select: function( e, ui ) {
                    $(this).val( $('<a>').html(ui.item.label).text() );
                    $('#'+formId+'_comptecommunal').val( ui.item.code ).change();

                    return false;
                }
            }).autocomplete( "widget" ).css("z-index","1050");


            $('#'+formId+'_commune').change(function(){
                $('#'+formId+'_geo_parcelle_lieu').val( '' );
            });
            $('#'+formId+'_section').change(function(){
                $('#'+formId+'_adresse').val( '' );
                $('#'+formId+'_voie').val( '' );
                $('#'+formId+'_geo_parcelle_lieu').val( '' );
            });
            $('#'+formId+'_adresse').change(function(){
                $('#'+formId+'_section').val( '' );
            });

            $('#'+formId+'_commune_prop').change(function(){
                $('#'+formId+'_proprietaire').val( '' );
                $('#'+formId+'_geo_parcelle_prop').val( '' );

            });

            // Manage submit
            $('#'+formId).submit(function(){
                return false;
            });

            // Click on zoom button
            $('#'+formId+'_zoom')
            .attr( "title", "Mode zoom" )
            .addClass( "btn" )
            .html( "<i class='icon-zoom-in'></i>" )
            .click(function(){
                $(this).toggleClass('active');
                return false;
            });

            $('#'+formId+'_select')
            .attr( "title", "Ajouter à la sélection" )
            .addClass( "btn" )
            .html( "<i class='icon-plus'></i>" );

            $('#'+formId+'_unselect')
            .attr( "title", "Supprimer de la sélection" )
            .addClass( "btn disabled" )
            .html( "<i class='icon-minus'></i>" );

            // Zoom on features if mode is active
            $('#'+formId+'_geo_parcelle_lieu, #'+formId+'_geo_parcelle_prop').change(function(){
                if($('#'+formId+'_zoom').hasClass('active')){
                    zoomToCadastreFeature();
                }
            });

            // Handle click on select and unselect buttons
            $('#'+formId+'_select, #'+formId+'_unselect').click(function(){
                var fieldname = null; var filter = null;

                if($('#div_form_cadastre_search ul li:first').hasClass('active')){
                    var section = $('#'+formId+'_section').val();
                    fieldname = '#'+formId+'_geo_parcelle_lieu';
                    if($(fieldname + ' option').size() > 1 && ( section || $('#'+formId+'_voie').val() ) ) {
                        if(section){
                            // Select one parcelle
                            if($(fieldname).val()){
                                filter = '"geo_parcelle" IN (\'' + $(fieldname).val() + '\')';
                            }else{ // Select all parcelles on section
                                var section = $('#'+formId+'_section').val();
                                filter = '"geo_section" IN (\'' + section + '\')';
                            }
                        }
                        if($('#'+formId+'_voie').val()){
                            if($(fieldname).val() == ''){
                                fids =  $.map( $(fieldname + ' option'), function( o ){return "'" + o.value + "'";}).join(',');
                            }else{
                                fids = "'" + $(fieldname).val() + "'";
                            }
                            filter = '"geo_parcelle" IN (' + fids + ')';
                        }
                    }
                }
                else{
                    fieldname = '#'+formId+'_geo_parcelle_prop';
                    if( $('#jforms_cadastre_search_geo_parcelle_prop option').size() > 1 && $('#'+formId+'_comptecommunal').val() ){
                        if($(fieldname).val() == ''){
                            fids =  "'" + $('#'+formId+'_comptecommunal').val().split(",").join("' , '") + "'";
                            filter = '"comptecommunal" IN ( ' + fids + ' )';
                        }else{
                            fids = "'" + $(fieldname).val() + "'";
                            filter = '"geo_parcelle" IN ( ' + fids + ' )';
                        }
                    }
                }

                if(filter){
                    var getFeatureUrlData = lizMap.getVectorLayerWfsUrl(
                        cadastreConfig.layer,
                        filter,
                        null,
                        'none'
                    );
                    // Add or remove from selection
                    var addToSelection = (this.id === "jforms_cadastre_search_select");
                    selectParcelles(getFeatureUrlData, addToSelection);

                }
                return false;
            });
            // Click on export button
            $('#'+formId+'_export').click(function(){
                var etype = $('#jforms_cadastre_search_exported_item').val();
                //exportSelectedItems(etype);
                return false;
            });
            // Reinit search form
            $('#'+formId+'_reinit').click(function(){
                reinitCadastreForm();
                return false;
            });

            // Empty selection
            $('#'+formId+'_emptyselect')
                .attr( "title", "Nouvelle sélection" )
                .addClass( "btn" )
                .html( "<i class='icon-refresh'></i>" )
                .click(function(){
                    // $('#'+formId+'_unselect').addClass('disabled');
                    lizMap.events.triggerEvent(
                        'layerfeatureunselectall',
                        { 'featureType': cadastreConfig.layer, 'updateDrawing': true}
                    );
                    return false;
            });

            // Observe modification on parcelle select to display option count
            // TODO : refactoring to avoid duplicate code
            MutationObserver = window.MutationObserver || window.WebKitMutationObserver;

            var geo_parcelle_lieu_observer = new MutationObserver(function() {
                var formId = $('#div_form_cadastre_search form').attr('id');
                var countParcelle = $('#'+formId+'_geo_parcelle_lieu option').length - 1;
                var firstOption = $('#'+formId+'_geo_parcelle_lieu option:first');

                if($('#'+formId+'_section').val() != '' ||  $('#'+formId+'_adresse').val() != ''){
                    if(countParcelle > 0){
                        if(countParcelle == 1){
                            firstOption.text("1 parcelle trouvée");
                        }else{
                            firstOption.text(countParcelle+" parcelles trouvées");
                        }
                        // Zoom on features if mode is active
                        if($('#'+formId+'_zoom').hasClass('active')){
                            zoomToCadastreFeature();
                        }
                    }else{
                        firstOption.text("-- Choisir --");
                    }
                }
            });

            var geo_parcelle_prop_observer = new MutationObserver(function() {
                var formId = $('#div_form_cadastre_search form').attr('id');
                var countParcelle = $('#'+formId+'_geo_parcelle_prop option').length - 1;
                var firstOption = $('#'+formId+'_geo_parcelle_prop option:first');

                if(countParcelle > 0){
                    if(countParcelle == 1){
                        firstOption.text("1 parcelle trouvée");
                    }else{
                        firstOption.text(countParcelle+" parcelles trouvées");
                    }
                    // Zoom on features if mode is active
                    if($('#'+formId+'_zoom').hasClass('active')){
                        zoomToCadastreFeature();
                    }
                }else{
                    firstOption.text("-- Choisir --");
                }
            });

            var geo_parcelle_lieu =  document.getElementById(formId+'_geo_parcelle_lieu');
            var geo_parcelle_prop =  document.getElementById(formId+'_geo_parcelle_prop');

            if(geo_parcelle_lieu){
                geo_parcelle_lieu_observer.observe(geo_parcelle_lieu, {childList:true});
            }
            if(geo_parcelle_prop){
                geo_parcelle_prop_observer.observe(geo_parcelle_prop, {childList:true});
            }
        }

        function zoomToCadastreFeature(){
            var formId = $('#div_form_cadastre_search form').attr('id');

            var layername = null; var fieldname = null; var fieldval = null;

            if($('#div_form_cadastre_search ul li:first').hasClass('active')){
                if( $('#'+formId+'_commune').val() ){
                    layername = 'Communes'; fieldname = 'geo_commune'; fieldval = $('#'+formId+'_commune').val();
                }
                if( $('#'+formId+'_section').val() ){
                    layername = 'Sections'; fieldname = 'geo_section'; fieldval = $('#'+formId+'_section').val();
                }
                if( $('#'+formId+'_voie').val() && !$('#'+formId+'_geo_parcelle_lieu').val()){
                    layername = 'Voies'; fieldname = 'voie'; fieldval = $('#'+formId+'_voie').val();
                }
                if( $('#'+formId+'_geo_parcelle_lieu').val() ){
                    layername = 'Parcelles'; fieldname = 'geo_parcelle'; fieldval = $('#'+formId+'_geo_parcelle_lieu').val();
                }
            }else{
                if( $('#'+formId+'_commune_prop').val() ){
                    layername = 'Communes'; fieldname = 'geo_commune'; fieldval = $('#'+formId+'_commune_prop').val();
                }
                if( $('#'+formId+'_geo_parcelle_prop').val() ){
                    layername = 'Parcelles'; fieldname = 'geo_parcelle'; fieldval = $('#'+formId+'_geo_parcelle_prop').val();
                }
                if( $('#'+formId+'_comptecommunal').val() && !$('#'+formId+'_geo_parcelle_prop').val()){
                    layername = 'Proprietaire'; fieldname = 'prop'; fieldval = $('#'+formId+'_comptecommunal').val();
                }
            }

            if(!layername || !fieldname || !fieldval){
                return false;
            }

            var format = new OpenLayers.Format.GeoJSON();

            if(fieldname == 'voie' || fieldname == 'prop'){
                var url = $('#form_cadastre_service_autocomplete').attr('action').replace('autocomplete','extent');
                var options = {field: fieldname, value: fieldval};
                $.getJSON(
                    url,
                    options,
                    function( data, status, xhr ) {
                        if(data && data.length == 1){
                            feat = format.read(data[0]['geom'])[0];
                            var proj = new OpenLayers.Projection('EPSG:4326');
                            feat.geometry.transform(proj, lizMap.map.getProjection());
                            lizMap.map.zoomToExtent(feat.geometry.getBounds());
                        }
                    }
                );
            }else{
                var filter = '"' + fieldname + '" = ' + "'" + fieldval +"'";
                var getFeatureUrlData = lizMap.getVectorLayerWfsUrl( layername, filter, null, 'extent' );
                getFeatureUrlData['options']['PROPERTYNAME'] = 'ogc_fid,geometry';
                // Get data
                $.post( getFeatureUrlData['url'], getFeatureUrlData['options'], function(data) {
                  if( data.features.length != 0) {
                    feat = format.read(data.features[0])[0];
                    var proj = new OpenLayers.Projection(cadastreCrs);
                    feat.geometry.transform(proj, lizMap.map.getProjection());
                    lizMap.map.zoomToExtent(feat.geometry.getBounds());
                  }
                });
            }
        }

        function reinitCadastreForm(){
            var formId = $('#div_form_cadastre_search form').attr('id');
            $('#div_form_cadastre_search form select option').prop('selected', function() {
                return this.defaultSelected;
            });

            $('#'+formId+'_geo_parcelle_lieu option:not(:first)').remove();
            $('#'+formId+'_geo_parcelle_lieu option:first').text('-- Choisir --');
            $('#'+formId+'_geo_parcelle_prop option:not(:first)').remove();

            $('#'+formId+'_commune').val( '' ).change();
            $('#'+formId+'_commune_prop').val( '' ).change();
            $('#'+formId+'_section').val( '' ).change();
            $('#'+formId+'_adresse').val( '' ).change();
            $('#'+formId+'_voie').val( '' ).change();
            $('#'+formId+'_proprietaire').val( '' ).change();

        }

        function manageCadastreSubmit(){
            //console.log('submit form -> manageCadastreSubmit');
            return false;
        }

        initCadastreForm();
    },

    'lizmappopupdisplayed':function(e){

        if(!(typeof cadastreConfig != 'undefined'))
            return;

        if(!cadastreConfig.url)
            return;

        var popup = e.popup;
        var config = lizMap.config;

        var cadastreLayer = cadastreConfig.layer;
        var cleanName = lizMap.cleanName(cadastreLayer);

        if( !config.layers[cadastreLayer]['selectedFeatures'] )
            config.layers[cadastreLayer]['selectedFeatures'] = [];

        var cadastreLink = OpenLayers.Util.urlAppend(cadastreConfig.url
          ,OpenLayers.Util.getParameterString(lizUrls.params)
        )


        // Add action buttons if needed
        $('div.lizmapPopupContent input.lizmap-popup-layer-feature-id').each(function(){

            var self = $(this);
            var val = self.val();
            var eHtml = '';
            var fid = val.split('.').pop();
            var layerId = val.replace( '.' + fid, '' );

            // Add Cadastre buttons
            var getLayerConfig = lizMap.getLayerConfigById( layerId );
            if( getLayerConfig ) {
                var layerConfig = getLayerConfig[1];
                var layerName = getLayerConfig[0];

                if (layerName == cadastreConfig.layer ){

                    // Get geo_parcelle from WFS request and build export URL
                    var getFeatureUrlData = lizMap.getVectorLayerWfsUrl(
                        cadastreConfig.layer,
                        null,
                        cadastreConfig.layer + '.' + fid,
                        'none'
                    );
                    $.post( getFeatureUrlData['url'], getFeatureUrlData['options'], function(data) {

                        var link = '';
                        link+= cadastreLink;
                        link+= '&layer=' + cadastreConfig.layer;
                        var format = new OpenLayers.Format.GeoJSON();
                        getFeatureUrlData['options']['PROPERTYNAME'] = [cadastreConfig.pk].join(',');

                        if( data.features.length != 0) {
                            feat = format.read(data.features[0])[0];
                            link+= '&parcelle=' + feat.attributes[cadastreConfig.pk];

                            // Add buttons
                            eHtml = ''
                            eHtml+= '<a href="';
                            eHtml+= link + '&type=parcelle';
                            eHtml+= '" class="btn btn-mini cadastre-export-parcelle parcelle" target="_blank" title="Relevé parcellaire"><i class="icon-file"></i>&nbsp;</a>';

                            eHtml+= '<a href="';
                            eHtml+= link + '&type=proprietaire';
                            eHtml+= '" class="btn btn-mini cadastre-export-parcelle proprietaire" target="_blank" title="Relevé de propriété"><i class="icon-book"></i>&nbsp;</a>';

                            if( 'attributeLayers' in config && cadastreLayer in config.attributeLayers){
                                eHtml+= '<button class="btn btn-mini cadastre-select-parcelle-proprietaire" target="_blank" value="';
                                eHtml+= fid;
                                eHtml+= '" title="Sélectionner les parcelles du propriétaire"';
                                eHtml+= ' onclick="selectParcelleByProprietaire(\''+feat.attributes[cadastreConfig.pk]+'\', true)">';
                                eHtml+= '<i class="icon-user"></i><i class="icon-plus"></i>&nbsp;</button>';

                                eHtml+= '<button class="btn btn-mini cadastre-unselect-parcelle-proprietaire" target="_blank" value="';
                                eHtml+= fid;
                                eHtml+= '" title="Retirer les parcelles du propriétaire"';
                                eHtml+= ' onclick="selectParcelleByProprietaire(\''+feat.attributes[cadastreConfig.pk]+'\', false)">';
                                eHtml+= '<i class="icon-user"></i><i class="icon-minus"></i>&nbsp;</button>';

                            }

                            var popupButtonBar = self.next('span.popupButtonBar');
                            if ( popupButtonBar.length != 0 ) {
                                popupButtonBar.append(eHtml);
                            } else {
                                eHtml = '<span class="popupButtonBar">' + eHtml + '</span></br>';
                                self.after(eHtml);
                            }
                        }
                        $('body').css('cursor', 'auto');
                        return false;
                    }).fail(function(){
                        $('body').css('cursor', 'auto');
                        $('#lizmap-cadastre-message').remove();
                        return false;
                    });
                }
            }
        });
    },
    'layerSelectionChanged':function(e){
        // Enable/disable remove from selection button
        var formId = $('#div_form_cadastre_search form').attr('id');
        if(e.featureIds.length > 0){
            $('#'+formId+'_unselect')
            .removeClass('disabled')
            .prop('disabled', false);
        }else{
            $('#'+formId+'_unselect')
            .addClass('disabled')
            .prop('disabled', true);
        }
    }
});
