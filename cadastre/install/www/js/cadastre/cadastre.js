lizMap.events.on({

    'lizmappopupdisplayed':function(e){

        if(!(typeof cadastreConfig != 'undefined'))
            return;

        var popup = e.popup;
        var config = lizMap.config;

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

            // Select button
            var getLayerConfig = lizMap.getLayerConfigById( layerId );
            if( getLayerConfig ) {
                var layerConfig = getLayerConfig[1];
                var layerName = getLayerConfig[0];

                if (layerName == cadastreConfig.layer ){
                    eHtml = '<button class="btn btn-mini cadastre-export-parcelle parcelle" target="_blank" value="';
                    eHtml+= fid;
                    eHtml+= '" title="Relevé parcellaire"><i class="icon-file"></i>&nbsp;</button>';
                    eHtml+= '<button class="btn btn-mini cadastre-export-parcelle proprietaire" target="_blank" value="';
                    eHtml+= fid;
                    eHtml+= '" title="Relevé de propriété"><i class="icon-book"></i>&nbsp;</button>';

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

            if( bt.prev('a.cadastre-export-parcelle:first').length == 0){
                bt.before('<a class="cadastre-export-parcelle" href="" target="_blank"/>')
            }
            var a = bt.prev('a.cadastre-export-parcelle:first')
            if( a.attr('href') != '' ){
                a[0].click();
                return false;
            }

            // Use already retrieved feature
            if( 'features' in layerConfig && layerConfig['features'] && fid in layerConfig['features'] ){
                feat = layerConfig['features'][fid];
                link+= '&parcelle=' + feat.properties[cadastreConfig.pk];
                a.attr('href', link);
                a[0].click();
                return false;
            }
            // Or get the feature via WFS in needed
            else{
                var getFeatureUrlData = lizMap.getVectorLayerWfsUrl( featureType, null, featureId );
                var format = new OpenLayers.Format.GeoJSON();
                getFeatureUrlData['options']['PROPERTYNAME'] = [cadastreConfig.pk].join(',');
                $.get( getFeatureUrlData['url'], getFeatureUrlData['options'], function(data) {
                    if( data.features.length != 0) {
                        feat = format.read(data.features[0])[0];
                        link+= '&parcelle=' + feat.attributes[cadastreConfig.pk];
                        a.attr('href', link)
                        a[0].click();
                        return false;
                    }

                }).fail(function(){
                    return false;
                });

            }

            return false;
        });

    }

});
