lizMap.events.on({

    'lizmappopupdisplayed':function(e){

        if(!(typeof cadastreConfig != 'undefined'))
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
            var featureType = cadastreConfig.layer;
            var layerConfig = config.layers[featureType];
            var featureId = featureType + '.' + fid;
            var bt = $(this);

            var getFeatureUrlData = lizMap.getVectorLayerWfsUrl( featureType, null, featureId, 'none' );
            //var getFeatureUrlData = lizMap.getVectorLayerWfsUrl( featureType, '"geo_parcelle" IN (\''+fid+'\')' );
            var format = new OpenLayers.Format.GeoJSON();
            getFeatureUrlData['options']['PROPERTYNAME'] = [cadastreConfig.pk].join(',') + ',comptecommunal';

            $('body').css('cursor', 'wait');
            // Get parcelle feature
            lizMap.addMessage("Les parcelles du propriétaires sont en cours de sélection...",'info',true).attr('id','lizmap-cadastre-message');
            $.get( getFeatureUrlData['url'], getFeatureUrlData['options'], function(data) {
                if( data.features.length != 0) {
                    feat = format.read(data.features[0])[0];

                    // Get all parcelle sharing same comptecommunal
                    var getFeatureUrlData2 = lizMap.getVectorLayerWfsUrl( featureType, '"comptecommunal" IN (\''+feat.attributes.comptecommunal+'\')', null, 'extent' );
                    getFeatureUrlData2['options']['PROPERTYNAME'] = [cadastreConfig.pk].join(',') + ',comptecommunal';

                    $.get( getFeatureUrlData2['url'], getFeatureUrlData2['options'], function(data2) {
                        if( data2.features.length != 0) {
                            config.layers[featureType]['selectedFeatures'] = [];
                            for(var f in data2.features){
                                var feature = data2.features[f];
                                config.layers[featureType]['selectedFeatures'].push( feature.id.split('.')[1] );
                            }
                            var nbparcelles = config.layers[featureType]['selectedFeatures'].length;
                            if( nbparcelles > 0){
                                // Messages
                                $('#lizmap-cadastre-message').remove();
                                var selectHtml = $('button.layerActionExport').parent('div.btn-group:first').html();
                                selectHtml = selectHtml.replace('layerActionExport', 'cadastrelayerActionExport');
                                selectHtml = selectHtml.replace('disabled', '');
                                selectHtml = selectHtml.replace('<i class="icon-download icon-white"></i>', 'Exporter');
                                selectHtml = '<div class="btn-group">'+selectHtml+'</div>';
                                selectHtml+= '';
                                var html = nbparcelles+" parcelles ont été sélectionnées. Vous pouvez les exporter avec le bouton suivant: ";
                                html+= selectHtml;
                                html+= '&nbsp;<button class="btn btn-mini cadastre-unselect">Désélectionner</button>';
                                lizMap.addMessage(html,'info',true).attr('id','lizmap-cadastre-message');

                                var aName = lizMap.getLayerNameByCleanName( lizMap.cleanName(featureType));
                                $('button.cadastrelayerActionExport')
                                .val(aName)
                                .next('ul:first').find('a.btn-export-layer').click(function(){
                                    var eFormat = $(this).text();
                                    if( eFormat == 'GML' )
                                        eFormat = 'GML3';
                                    var eName = $('button.cadastrelayerActionExport').val();
                                    if( !eName ){
                                        $('body').css('cursor', 'auto');
                                    }else{
                                        lizMap.exportVectorLayer( eName, eFormat );
                                        $('#lizmap-cadastre-message').click(); // blur dropdown
                                    }
                                    return false;
                                });
                                $('button.cadastre-unselect').click(function(){
                                    $('#lizmap-cadastre-message').remove();
                                    lizMap.events.triggerEvent(
                                        'layerfeatureunselectall',
                                        { 'featureType': featureType, 'updateDrawing': true}
                                    );
                                    return false;
                                });

                                // Trigger selection
                                lizMap.events.triggerEvent(
                                    "layerSelectionChanged",
                                    {
                                        'featureType': featureType,
                                        'featureIds': config.layers[featureType]['selectedFeatures'],
                                        'updateDrawing': true
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
