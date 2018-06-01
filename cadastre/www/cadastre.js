function selectParcelles(getFeatureUrlData){
    $('body').css('cursor', 'wait');

    $.get( getFeatureUrlData['url'], getFeatureUrlData['options'], function(data2) {
        if( data2.features.length != 0) {
            lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'] = [];
            for(var f in data2.features){
                var feature = data2.features[f];
                lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'].push( feature.id.split('.')[1] );
            }
            var nbparcelles = lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'].length;
            if( nbparcelles > 0){
                // Messages
                $('#lizmap-cadastre-message').remove();
                var html = nbparcelles+" parcelles ont été sélectionnées.";
                html+= '&nbsp;<button class="btn btn-mini cadastre-unselect">Désélectionner</button>';
                lizMap.addMessage(html,'info',true).attr('id','lizmap-cadastre-message');
                // Open selection mini-dock
                $('#mapmenu li.selectiontool:not(.active) a').click();

                $('button.cadastre-unselect').click(function(){
                    $('#lizmap-cadastre-message').remove();
                    lizMap.events.triggerEvent(
                        'layerfeatureunselectall',
                        { 'featureType': cadastreConfig.layer, 'updateDrawing': true}
                    );
                    return false;
                });

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
console.log('FILTRE COMPTE COMMUNAL');
                    var selectionParam = cadastreConfig.layer + ': ' + getFeatureUrlData['options']['EXP_FILTER'];
                    //lizMap.config.layers[cadastreConfig.layer]['request_params']['filter'] = selectionParam;
                    //layer.params['FILTER'] = selectionParam;
                    //layer.redraw(true);
                    //updateDrawing = false;
                }else{
console.log('TRUC CLASSIQUE');
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
            return false;
        }else{
            $('#lizmap-cadastre-message').remove();
            lizMap.addMessage("Aucune parcelle n'a été sélectionnée",'error',true).attr('id','lizmap-cadastre-message');
            $('body').css('cursor', 'auto');
            return false;
        }

    }).fail(function(){
        $('#lizmap-cadastre-message').remove();
        lizMap.addMessage("Aucune parcelle n'a été sélectionnée",'error',true).attr('id','lizmap-cadastre-message');
        $('body').css('cursor', 'auto');
        return false;
    });

}

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
                    //console.log('select adresse');
                    $(this).val( $('<a>').html(ui.item.label).text() );
                    $('#'+formId+'_section').val( '' );
                    $('#'+formId+'_voie').val( ui.item.code ).change();
                    $('#'+formId+'_proprietaire').val( '' );
                    $('#'+formId+'_comptecommunal').val( '' );
                    $('#'+formId+'_geo_parcelle_prop').val( '' );
                    zoomToCadastreFeature();

                    return false;
                }
            }).autocomplete( "widget" ).css("z-index","1050");

            // Autocomplete proprietaire
            $('#'+formId+'_proprietaire').autocomplete({
                minLength:3,
                autoFocus: true,
                source:function( request, response ) {
                    request.field = 'prop';
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
                    //console.log('select');
                    $('#'+formId+'_section').val( '' );
                    $('#'+formId+'_adresse').val( '' );
                    $('#'+formId+'_voie').val( '' );
                    $('#'+formId+'_geo_parcelle_lieu').val( '' );
                    $(this).val( $('<a>').html(ui.item.label).text() );
                    $('#'+formId+'_comptecommunal').val( ui.item.code ).change();
                    zoomToCadastreFeature();
                    return false;
                }
            }).autocomplete( "widget" ).css("z-index","1050");



            $('#'+formId+'_commune').change(function(){
                //console.log('changed commune');
                $('#'+formId+'_adresse').val( '' );
                $('#'+formId+'_voie').val( '' );
                $('#'+formId+'_geo_parcelle_lieu').val( '' );
                $('#'+formId+'_proprietaire').val( '' );
                $('#'+formId+'_comptecommunal').val( '' );
                $('#'+formId+'_geo_parcelle_prop').val( '' );
            });
            $('#'+formId+'_section').change(function(){
                //console.log('changed section')
                $('#'+formId+'_adresse').val( '' );
                $('#'+formId+'_voie').val( '' );
                $('#'+formId+'_geo_parcelle_lieu').val( '' );
                $('#'+formId+'_proprietaire').val( '' );
                $('#'+formId+'_comptecommunal').val( '' );
                $('#'+formId+'_geo_parcelle_prop').val( '' );
            });
            $('#'+formId+'_adresse').change(function(){
                //console.log('changed adresse')
                $('#'+formId+'_section').val( '' );
                $('#'+formId+'_proprietaire').val( '' );
                $('#'+formId+'_comptecommunal').val( '' );
                $('#'+formId+'_geo_parcelle_prop').val( '' );
            });
            $('#'+formId+'_geo_parcelle_lieu').change(function(){
                //console.log('changed adresse')
                $('#'+formId+'_proprietaire').val( '' );
                $('#'+formId+'_comptecommunal').val( '' );
                $('#'+formId+'_geo_parcelle_prop').val( '' );
            });
            $('#'+formId+'_proprietaire').change(function(){
                //console.log('changed proprio')
                $('#'+formId+'_section').val( '' );
                $('#'+formId+'_adresse').val( '' );
                $('#'+formId+'_voie').val( '' );
                $('#'+formId+'_geo_parcelle_lieu').val( '' );
            });
            $('#'+formId+'_geo_parcelle_prop').change(function(){
                //console.log('changed adresse')
                $('#'+formId+'_section').val( '' );
                $('#'+formId+'_adresse').val( '' );
                $('#'+formId+'_voie').val( '' );
                $('#'+formId+'_geo_parcelle_lieu').val( '' );
            });



            // Manage submit
            $('#'+formId).submit(function(){
                return false;
            });
            // Click on zoom button
            $('#'+formId+'_zoom').click(function(){
                //console.log('zoom');
                zoomToCadastreFeature();
                return false;
            });

            // Click on select button
            $('#'+formId+'_select').click(function(){
                var fieldname = null; var filter = null;
                fieldname = '#'+formId+'_geo_parcelle_lieu';
                if($(fieldname + ' option').size() > 1 && ( $('#'+formId+'_section').val() || $('#'+formId+'_voie').val() ) ) {
                    if($('#'+formId+'_section').val() && $(fieldname).val()){
                        filter = '"geo_parcelle" IN (\'' + $(fieldname).val() + '\')';
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
                if(filter){
                    var getFeatureUrlData = lizMap.getVectorLayerWfsUrl(
                        cadastreConfig.layer,
                        filter,
                        null,
                        'none'
                    );
                    selectParcelles(getFeatureUrlData)
                }
                return false;
            });
            // Click on select button
            $('#'+formId+'_select').click(function(){
                //manageCadastreSubmit();
                //console.log('select');
                return false;
            });
            // Reinit search form
            $('#'+formId+'_reinit').click(function(){
                reinitCadastreForm();
                return false;
            });
        }

        function zoomToCadastreFeature(){
            var formId = $('#div_form_cadastre_search form').attr('id');

            var layername = null; var fieldname = null; var fieldval = null;
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
            if( $('#'+formId+'_geo_parcelle_prop').val() ){
                layername = 'Parcelles'; fieldname = 'geo_parcelle'; fieldval = $('#'+formId+'_geo_parcelle_prop').val();
            }
            if( $('#'+formId+'_comptecommunal').val() && !$('#'+formId+'_geo_parcelle_prop').val()){
                layername = 'Proprietaire'; fieldname = 'prop'; fieldval = $('#'+formId+'_comptecommunal').val();
            }
            if(!layername || !fieldname || !fieldval)
                return false;

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
                $.get( getFeatureUrlData['url'], getFeatureUrlData['options'], function(data) {
                  if( data.features.length != 0) {
                    feat = format.read(data.features[0])[0];
                    var proj = new OpenLayers.Projection(cadastreCrs);
                    feat.geometry.transform(proj, lizMap.map.getProjection());
                    lizMap.map.zoomToExtent(feat.geometry.getBounds());
                    //console.log(feat.geometry.getBounds())
                  }
                })
            }
        }

        function reinitCadastreForm(){
            var formId = $('#div_form_cadastre_search form').attr('id');
            $('#div_form_cadastre_search form select option').prop('selected', function() {
                return this.defaultSelected;
            });
            $('#'+formId+'_commune').val( '' ).change();
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

                    var fval = fid;
                    eHtml = '<button class="btn btn-mini cadastre-export-parcelle parcelle" target="_blank" value="';
                    eHtml+= fval;
                    eHtml+= '" title="Relevé parcellaire"><i class="icon-file"></i>&nbsp;</button>';

                    eHtml+= '<button class="btn btn-mini cadastre-export-parcelle proprietaire" target="_blank" value="';
                    eHtml+= fval;
                    eHtml+= '" title="Relevé de propriété"><i class="icon-book"></i>&nbsp;</button>';

                    if( 'attributeLayers' in config && cadastreLayer in config.attributeLayers){
                        eHtml+= '<button class="btn btn-mini cadastre-select-parcelle-proprietaire" target="_blank" value="';
                        eHtml+= fval;
                        eHtml+= '" title="Sélectionner les parcelles du propriétaire"><i class="icon-user"></i>&nbsp;</button>';
                    }

                    var popupButtonBar = self.next('span.popupButtonBar');
                    if ( popupButtonBar.length != 0 ) {
                        popupButtonBar.append(eHtml);
                    } else {
                        eHtml = '<span class="popupButtonBar">' + eHtml + '</span></br>';
                        self.after(eHtml);
                    }
                }

            }

        });


        $('button.cadastre-export-parcelle').click(function(){

            var feat = null;
            var fid = $(this).val();
            var featureType = cadastreConfig.layer;
            var layerConfig = config.layers[featureType];
            var featureId = featureType + '.' + fid;
            var bt = $(this);

            var link = '';
            link+= cadastreLink;
            link+= '&layer=' + featureType;
            var etype = 'parcelle';
            if( bt.hasClass('proprietaire') )
                etype = 'proprietaire';
            link+= '&type=' + etype;

            if( bt.prev('a.cadastre-select-parcelle-proprietaire:first').length == 0){
                bt.before('<a class="cadastre-select-parcelle-proprietaire" href="" target="_blank"/>')
            }
            var a = bt.prev('a.cadastre-select-parcelle-proprietaire:first')
            if( a.attr('href') != '' ){
                a[0].click();
                return false;
            }
            lizMap.addMessage('Export en cours...','info',true).attr('id','lizmap-cadastre-message');
            var getFeatureUrlData = lizMap.getVectorLayerWfsUrl( featureType, null, featureId, 'none' );
            var format = new OpenLayers.Format.GeoJSON();
            getFeatureUrlData['options']['PROPERTYNAME'] = [cadastreConfig.pk].join(',');
            $('body').css('cursor', 'wait');
            $.get( getFeatureUrlData['url'], getFeatureUrlData['options'], function(data) {
                if( data.features.length != 0) {
                    feat = format.read(data.features[0])[0];
                    link+= '&parcelle=' + feat.attributes[cadastreConfig.pk];
                    a.attr('href', link)
                    a[0].click();
                    $('body').css('cursor', 'auto');
                }
                $('body').css('cursor', 'auto');
                $('#lizmap-cadastre-message').remove();
                return false;
            }).fail(function(){
                $('body').css('cursor', 'auto');
                $('#lizmap-cadastre-message').remove();
                return false;
            });
            $('body').css('cursor', 'auto');
            return false;
        });

        $('button.cadastre-select-parcelle-proprietaire').click(function(){

            var feat = null;
            var fid = $(this).val();
            var featureId = cadastreConfig.layer + '.' + fid;
            var bt = $(this);

            var getFeatureUrlData = lizMap.getVectorLayerWfsUrl( cadastreConfig.layer, null, featureId, 'none' );
            //var getFeatureUrlData = lizMap.getVectorLayerWfsUrl( cadastreConfig.layer, '"geo_parcelle" IN (\''+fid+'\')' );
            getFeatureUrlData['options']['PROPERTYNAME'] = [cadastreConfig.pk].join(',') + ',comptecommunal';

            // Get parcelle feature
            $.get( getFeatureUrlData['url'], getFeatureUrlData['options'], function(data) {
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
                    selectParcelles(getFeatureUrlData2);

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
        });

    }

});
