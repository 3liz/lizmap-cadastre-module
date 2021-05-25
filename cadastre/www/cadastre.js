/* global cadastreConfig */
/*eslint no-unused-vars: ["error", { "argsIgnorePattern": "^_" }]*/

function selectParcelles(getFeatureUrlData, addToSelection) {
    if (!(typeof cadastreConfig != 'undefined'))
        return;

    if (!cadastreConfig.url)
        return;

    if (!cadastreConfig.layer)
        return;

    $('body').css('cursor', 'wait');

    $.post(getFeatureUrlData['url'], getFeatureUrlData['options'], function (data2) {
        if (data2.features.length != 0) {
            var nbParcellesModify = 0;
            for (var f in data2.features) {
                var feature = data2.features[f];

                var parcelleId = feature.id.split('.')[1];

                if (addToSelection) {
                    // Don't add existing parcelle
                    if (lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'].indexOf(parcelleId) === -1) {
                        lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'].push(parcelleId);
                        nbParcellesModify++;
                    }
                } else {
                    var index = lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'].indexOf(parcelleId);
                    if (index > -1) {
                        lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'].splice(index, 1);
                        nbParcellesModify++;
                    }
                }
            }

            if (nbParcellesModify > 0) {
                // Messages
                $('#lizmap-cadastre-message').remove();

                var html = '';
                if (addToSelection) {
                    if (nbParcellesModify == 1) {
                        html = "1 parcelle a été sélectionnée.";
                    } else {
                        html = nbParcellesModify + " parcelles ont été sélectionnées.";
                    }
                } else {
                    if (nbParcellesModify == 1) {
                        html = "1 parcelle a été désélectionnée.";
                    } else {
                        html = nbParcellesModify + " parcelles ont été désélectionnées.";
                    }
                }

                lizMap.addMessage(html, 'info', true).attr('id', 'lizmap-cadastre-message');
                // Open selection mini-dock
                $('#mapmenu li.selectiontool:not(.active) a').click();

                // Trigger selection
                lizMap.events.triggerEvent(
                    "layerSelectionChanged",
                    {
                        'featureType': cadastreConfig.layer,
                        'featureIds': lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'],
                        'updateDrawing': true
                    }
                );
            } else {
                $('#lizmap-cadastre-message').remove();
                lizMap.addMessage("Aucune parcelle n'a été sélectionnée", 'error', true).attr('id', 'lizmap-cadastre-message');
            }

            $('body').css('cursor', 'auto');
            window.setTimeout(function () { $('#lizmap-cadastre-message').hide('slow') }, 1500);
            return false;
        } else {
            $('#lizmap-cadastre-message').remove();
            lizMap.addMessage("Aucune parcelle n'a été sélectionnée", 'error', true).attr('id', 'lizmap-cadastre-message');
            $('body').css('cursor', 'auto');
            window.setTimeout(function () { $('#lizmap-cadastre-message').hide('slow') }, 1500);
            return false;
        }

    }, 'json').fail(function () {
        $('#lizmap-cadastre-message').remove();
        lizMap.addMessage("Aucune parcelle n'a été sélectionnée", 'error', true).attr('id', 'lizmap-cadastre-message');
        $('body').css('cursor', 'auto');
        window.setTimeout(function () { $('#lizmap-cadastre-message').hide('slow') }, 1500);
        return false;
    });
}

// Disable line for eslint because this function is used in html
// eslint-disable-next-line no-unused-vars
function selectParcelleByProprietaire(geo_parcelle, addToSelection) {
    if (!(typeof cadastreConfig != 'undefined'))
        return;

    if (!cadastreConfig.url)
        return;

    if (!cadastreConfig.layer)
        return;

    var feat = null;
    //var featureId = cadastreConfig.layer + '.' + fid;

    //var getFeatureUrlData = lizMap.getVectorLayerWfsUrl( cadastreConfig.layer, null, featureId, 'none' );
    var getFeatureUrlData = lizMap.getVectorLayerWfsUrl(cadastreConfig.layer, '"geo_parcelle" IN (\'' + geo_parcelle + '\')', null, 'none');
    getFeatureUrlData['options']['PROPERTYNAME'] = [cadastreConfig.pk].join(',') + ',comptecommunal';

    // Get parcelle feature
    $.post(getFeatureUrlData['url'], getFeatureUrlData['options'], function (data) {
        if (data.features.length != 0) {
            var format = new OpenLayers.Format.GeoJSON();
            feat = format.read(data.features[0])[0];

            // Get all parcelle sharing same comptecommunal
            var getFeatureUrlData2 = lizMap.getVectorLayerWfsUrl(
                cadastreConfig.layer,
                '"comptecommunal" IN ( \'' + feat.attributes.comptecommunal + '\' )',
                null,
                'none'
            );
            getFeatureUrlData2['options']['PROPERTYNAME'] = [cadastreConfig.pk].join(',') + ',comptecommunal';
            selectParcelles(getFeatureUrlData2, addToSelection);

            return false;
        }
        $('body').css('cursor', 'auto');
    }, 'json').fail(function () {
        $('#lizmap-cadastre-message').remove();
        lizMap.addMessage("Aucune parcelle n'a été sélectionnée", 'error', true).attr('id', 'lizmap-cadastre-message');
        $('body').css('cursor', 'auto');
        return false;
    });

    return false;
}

lizMap.events.on({

    'uicreated': function () {
        if (!(typeof cadastreConfig != 'undefined'))
            return;

        if (!cadastreConfig.url)
            return;

        if (!cadastreConfig.layer)
            return;

        var cadastreCrs = 'EPSG:2154';
        if ('qgisServerVersion' in lizMap.config.options && lizMap.config.options.qgisServerVersion != '2.14')
            cadastreCrs = 'EPSG:4326';

        function initCadastreForm() {
            var formId = $('#div_form_cadastre_search form').attr('id');
            $('#' + formId + '_commune').val('');
            $('#' + formId + '_adresse').val('');
            $('#' + formId + '_voie').val('');
            $('#' + formId + '_geo_parcelle_lieu').val('');
            $('#' + formId + '_commune_prop').val('');
            $('#' + formId + '_proprietaire').val('');
            $('#' + formId + '_comptecommunal').val('');
            $('#' + formId + '_geo_parcelle_prop').val('');

            // Autocomplete adresse
            $('#' + formId + '_adresse').autocomplete({
                minLength: 3,
                delay: 500,
                autoFocus: true,
                source: function (request, response) {
                    request.field = 'voie';
                    request.commune = $('#' + formId + '_commune').val();
                    request.limit = 100;
                    request.layer = cadastreConfig.layer;
                    request.repository = lizUrls.params.repository;
                    request.project = lizUrls.params.project;
                    $.getJSON($('#form_cadastre_service_autocomplete').attr('action'),
                        request, function (data) {
                            response(data);
                        }
                    );
                },
                open: function () {
                },
                focus: function () {
                },
                close: function () {
                },
                change: function () {
                    $('#' + formId + '_section').val('');
                    if ($(this).val().length < $(this).autocomplete('option', 'minLength')) {
                        $(this).val('').change();
                        $('#' + formId + '_voie').val('').change();
                    }
                },
                search: function () {
                    //$('#'+formId+'_section').val( '' ).change();
                    //$('#'+formId+'_voie').val('').change();
                },
                select: function (_e, ui) {
                    $(this).val($('<a>').html(ui.item.label).text());
                    $('#' + formId + '_section').val('');
                    $('#' + formId + '_voie').val(ui.item.code).change();

                    return false;
                }
            }).autocomplete("widget").css("z-index", "1050");

            // Autocomplete proprietaire
            $('#' + formId + '_proprietaire').autocomplete({
                minLength: 3,
                autoFocus: true,
                source: function (request, response) {
                    request.field = 'prop';
                    request.commune = $('#' + formId + '_commune_prop').val();
                    request.limit = 100;
                    request.layer = cadastreConfig.layer;
                    request.repository = lizUrls.params.repository;
                    request.project = lizUrls.params.project;
                    $.getJSON($('#form_cadastre_service_autocomplete').attr('action'),
                        request, function (data) {
                            response(data);
                        }
                    );
                },
                open: function () {
                },
                focus: function () {
                },
                close: function () {
                },
                change: function () {
                    if ($(this).val().length < $(this).autocomplete('option', 'minLength')) {
                        $(this).val('').change();
                        $('#' + formId + '_comptecommunal').val('').change();
                    }
                },
                search: function () {
                },
                select: function (_e, ui) {
                    $(this).val($('<a>').html(ui.item.label).text());
                    $('#' + formId + '_comptecommunal').val(ui.item.code).change();

                    return false;
                }
            }).autocomplete("widget").css("z-index", "1050");


            $('#' + formId + '_commune').change(function () {
                $('#' + formId + '_geo_parcelle_lieu').val('');
            });
            $('#' + formId + '_section').change(function () {
                $('#' + formId + '_adresse').val('');
                $('#' + formId + '_voie').val('');
                $('#' + formId + '_geo_parcelle_lieu').val('');
            });
            $('#' + formId + '_adresse').change(function () {
                $('#' + formId + '_section').val('');
            });

            $('#' + formId + '_commune_prop').change(function () {
                $('#' + formId + '_proprietaire').val('');
                $('#' + formId + '_geo_parcelle_prop').val('');

            });

            // Manage submit
            $('#' + formId).submit(function () {
                return false;
            });

            // Click on zoom button
            $('#' + formId + '_zoom')
                .attr("title", "Mode zoom")
                .addClass("btn")
                .html("<i class='icon-zoom-in'></i>")
                .click(function () {
                    $(this).toggleClass('active');
                    if ($(this).hasClass('active')) {
                        zoomToCadastreFeature();
                    }
                    return false;
                });

            $('#' + formId + '_newselect')
                .attr("title", "Nouvelle sélection")
                .addClass("btn")
                .html("<i class='icon-refresh'></i>");

            $('#' + formId + '_addselect')
                .attr("title", "Ajouter à la sélection")
                .addClass("btn")
                .html("<i class='icon-plus'></i>");

            $('#' + formId + '_unselect')
                .attr("title", "Supprimer de la sélection")
                .addClass("btn disabled")
                .html("<i class='icon-minus'></i>");

            // Zoom on features if mode is active
            $('#' + formId + '_geo_parcelle_lieu, #' + formId + '_geo_parcelle_prop').change(function () {
                if ($('#' + formId + '_zoom').hasClass('active')) {
                    zoomToCadastreFeature();
                }
            });

            // Handle click on select and unselect buttons
            $('#' + formId + '_newselect, #' + formId + '_addselect, #' + formId + '_unselect').click(function () {
                var fieldname = null; var filter = null; var fids = null;

                if ($('#div_form_cadastre_search ul li:first').hasClass('active')) {
                    var section = $('#' + formId + '_section').val();
                    fieldname = '#' + formId + '_geo_parcelle_lieu';
                    if ($(fieldname + ' option').size() > 1 && (section || $('#' + formId + '_voie').val())) {
                        if (section) {
                            if ($(fieldname).val()) {
                                // Select one parcelle
                                filter = '"geo_parcelle" IN (\'' + $(fieldname).val() + '\')';
                            } else {
                                // Select all parcelles on section with section value
                                filter = '"geo_section" IN (\'' + section + '\')';
                            }
                        }
                        if ($('#' + formId + '_voie').val()) {
                            if ($(fieldname).val() == '') {
                                fids = $.map($(fieldname + ' option'), function (o) { return "'" + o.value + "'"; }).join(',');
                            } else {
                                fids = "'" + $(fieldname).val() + "'";
                            }
                            filter = '"geo_parcelle" IN (' + fids + ')';
                        }
                    }
                }
                else {
                    fieldname = '#' + formId + '_geo_parcelle_prop';
                    if ($('#jforms_cadastre_search_geo_parcelle_prop option').size() > 1 && $('#' + formId + '_comptecommunal').val()) {
                        if ($(fieldname).val() == '') {
                            fids = "'" + $('#' + formId + '_comptecommunal').val().split(",").join("' , '") + "'";
                            filter = '"comptecommunal" IN ( ' + fids + ' )';
                        } else {
                            fids = "'" + $(fieldname).val() + "'";
                            filter = '"geo_parcelle" IN ( ' + fids + ' )';
                        }
                    }
                }

                if (filter) {
                    var getFeatureUrlData = lizMap.getVectorLayerWfsUrl(
                        cadastreConfig.layer,
                        filter,
                        null,
                        'none'
                    );
                    // Clear selection
                    if (this.id === "jforms_cadastre_search_newselect") {
                        lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'] = [];
                    }
                    // Add or remove from selection
                    var addToSelection = (this.id !== "jforms_cadastre_search_unselect");
                    selectParcelles(getFeatureUrlData, addToSelection);

                }
                return false;
            });
            // Click on export button
            $('#' + formId + '_export').click(function () {
                //var etype = $('#jforms_cadastre_search_exported_item').val();
                //exportSelectedItems(etype);
                return false;
            });
            // Reinit search form
            $('#' + formId + '_reinit').click(function () {
                reinitCadastreForm();
                return false;
            });

            // Empty selection
            $('#' + formId + '_emptyselect')
                .attr("title", "Désélectionner")
                .addClass("btn")
                .html("<i class='icon-star-empty'></i>")
                .click(function () {
                    // $('#'+formId+'_unselect').addClass('disabled');
                    lizMap.events.triggerEvent(
                        'layerfeatureunselectall',
                        { 'featureType': cadastreConfig.layer, 'updateDrawing': true }
                    );
                    return false;
                });

            // Observe modification on parcelle select to display option count
            // TODO : refactoring to avoid duplicate code
            MutationObserver = window.MutationObserver || window.WebKitMutationObserver;

            var geo_parcelle_lieu_observer = new MutationObserver(function () {
                var formId = $('#div_form_cadastre_search form').attr('id');
                var countParcelle = $('#' + formId + '_geo_parcelle_lieu option').length - 1;
                var firstOption = $('#' + formId + '_geo_parcelle_lieu option:first');

                if ($('#' + formId + '_section').val() != '' || $('#' + formId + '_adresse').val() != '') {
                    if (countParcelle > 0) {
                        if (countParcelle == 1) {
                            firstOption.text("1 parcelle trouvée");
                        } else {
                            firstOption.text(countParcelle + " parcelles trouvées");
                        }
                        // Zoom on features if mode is active
                        if ($('#' + formId + '_zoom').hasClass('active')) {
                            zoomToCadastreFeature();
                        }
                    } else {
                        firstOption.text("-- Choisir --");
                    }
                }
            });

            var geo_parcelle_prop_observer = new MutationObserver(function () {
                var formId = $('#div_form_cadastre_search form').attr('id');
                var countParcelle = $('#' + formId + '_geo_parcelle_prop option').length - 1;
                var firstOption = $('#' + formId + '_geo_parcelle_prop option:first');

                if (countParcelle > 0) {
                    if (countParcelle == 1) {
                        firstOption.text("1 parcelle trouvée");
                    } else {
                        firstOption.text(countParcelle + " parcelles trouvées");
                    }
                    // Zoom on features if mode is active
                    if ($('#' + formId + '_zoom').hasClass('active')) {
                        zoomToCadastreFeature();
                    }
                } else {
                    firstOption.text("-- Choisir --");
                }
            });

            var geo_parcelle_lieu = document.getElementById(formId + '_geo_parcelle_lieu');
            var geo_parcelle_prop = document.getElementById(formId + '_geo_parcelle_prop');

            if (geo_parcelle_lieu) {
                geo_parcelle_lieu_observer.observe(geo_parcelle_lieu, { childList: true });
            }
            if (geo_parcelle_prop) {
                geo_parcelle_prop_observer.observe(geo_parcelle_prop, { childList: true });
            }
        }

        function zoomToCadastreFeature() {
            var formId = $('#div_form_cadastre_search form').attr('id');

            var layername = null; var fieldname = null; var fieldval = null;

            if ($('#div_form_cadastre_search ul li:first').hasClass('active')) {
                if ($('#' + formId + '_commune').val()) {
                    layername = 'Communes'; fieldname = 'geo_commune'; fieldval = $('#' + formId + '_commune').val();
                }
                if ($('#' + formId + '_section').val()) {
                    layername = 'Sections'; fieldname = 'geo_section'; fieldval = $('#' + formId + '_section').val();
                }
                if ($('#' + formId + '_voie').val() && !$('#' + formId + '_geo_parcelle_lieu').val()) {
                    layername = 'Voies'; fieldname = 'voie'; fieldval = $('#' + formId + '_voie').val();
                }
                if ($('#' + formId + '_geo_parcelle_lieu').val()) {
                    layername = 'Parcelles'; fieldname = 'geo_parcelle'; fieldval = $('#' + formId + '_geo_parcelle_lieu').val();
                }
            } else {
                if ($('#' + formId + '_commune_prop').val()) {
                    layername = 'Communes'; fieldname = 'geo_commune'; fieldval = $('#' + formId + '_commune_prop').val();
                }
                if ($('#' + formId + '_geo_parcelle_prop').val()) {
                    layername = 'Parcelles'; fieldname = 'geo_parcelle'; fieldval = $('#' + formId + '_geo_parcelle_prop').val();
                }
                if ($('#' + formId + '_comptecommunal').val() && !$('#' + formId + '_geo_parcelle_prop').val()) {
                    layername = 'Proprietaire'; fieldname = 'prop'; fieldval = $('#' + formId + '_comptecommunal').val();
                }
            }

            if (!layername || !fieldname || !fieldval) {
                return false;
            }

            var format = new OpenLayers.Format.GeoJSON();

            if (fieldname == 'voie' || fieldname == 'prop') {
                var url = $('#form_cadastre_service_autocomplete').attr('action').replace('autocomplete', 'extent');
                var options = {
                    field: fieldname,
                    value: fieldval,
                    layer: cadastreConfig.layer,
                    repository: lizUrls.params.repository,
                    project: lizUrls.params.project
                };
                $.getJSON(
                    url,
                    options,
                    function (data) {
                        if (data && data.length == 1) {
                            var feat = format.read(data[0]['geom'])[0];
                            var proj = new OpenLayers.Projection('EPSG:4326');
                            feat.geometry.transform(proj, lizMap.map.getProjection());
                            lizMap.map.zoomToExtent(feat.geometry.getBounds());
                        }
                    }
                );
            } else {
                if (layername == 'Parcelles' && layername != cadastreConfig.layer) {
                    layername = cadastreConfig.layer;
                }
                var filter = '"' + fieldname + '" = ' + "'" + fieldval + "'";
                var getFeatureUrlData = lizMap.getVectorLayerWfsUrl(layername, filter, null, 'extent');
                getFeatureUrlData['options']['PROPERTYNAME'] = 'ogc_fid,geometry';
                // Get data
                $.post(getFeatureUrlData['url'], getFeatureUrlData['options'], function (data) {
                    if (data.features.length != 0) {
                        var feat = format.read(data.features[0])[0];
                        var proj = new OpenLayers.Projection(cadastreCrs);
                        feat.geometry.transform(proj, lizMap.map.getProjection());
                        lizMap.map.zoomToExtent(feat.geometry.getBounds());
                    }
                }, 'json');
            }
        }

        function reinitCadastreForm() {
            var formId = $('#div_form_cadastre_search form').attr('id');
            $('#div_form_cadastre_search form select option').prop('selected', function () {
                return this.defaultSelected;
            });

            $('#' + formId + '_geo_parcelle_lieu option:not(:first)').remove();
            $('#' + formId + '_geo_parcelle_lieu option:first').text('-- Choisir --');
            $('#' + formId + '_geo_parcelle_prop option:not(:first)').remove();

            $('#' + formId + '_commune').val('').change();
            $('#' + formId + '_commune_prop').val('').change();
            $('#' + formId + '_section').val('').change();
            $('#' + formId + '_adresse').val('').change();
            $('#' + formId + '_voie').val('').change();
            $('#' + formId + '_proprietaire').val('').change();

        }

        // function manageCadastreSubmit() {
        //     //console.log('submit form -> manageCadastreSubmit');
        //     return false;
        // }

        // copy from lizmap
        function downloadFile(url, parameters) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', url, true);
            xhr.responseType = 'arraybuffer';
            xhr.onload = function () {
                if (this.status === 200) {
                    var filename = "";
                    var disposition = xhr.getResponseHeader('Content-Disposition');
                    if (disposition && disposition.indexOf('attachment') !== -1) {
                        var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                        var matches = filenameRegex.exec(disposition);
                        if (matches != null && matches[1]) filename = matches[1].replace(/['"]/g, '');
                    }
                    var type = xhr.getResponseHeader('Content-Type');

                    var blob = typeof File === 'function'
                        ? new File([this.response], filename, { type: type })
                        : new Blob([this.response], { type: type });
                    if (typeof window.navigator.msSaveBlob !== 'undefined') {
                        // IE workaround for "HTML7007: One or more blob URLs were revoked by closing the blob for which they were created. These URLs will no longer resolve as the data backing the URL has been freed."
                        window.navigator.msSaveBlob(blob, filename);
                    } else {
                        var URL = window.URL || window.webkitURL;
                        var downloadUrl = URL.createObjectURL(blob);

                        if (filename) {
                            // use HTML5 a[download] attribute to specify filename
                            var a = document.createElement("a");
                            // safari doesn't support this yet
                            if (typeof a.download === 'undefined') {
                                window.location = downloadUrl;
                            } else {
                                a.href = downloadUrl;
                                a.download = filename;
                                document.body.appendChild(a);
                                a.click();
                            }
                        } else {
                            window.location = downloadUrl;
                        }

                        setTimeout(function () { URL.revokeObjectURL(downloadUrl); }, 100); // cleanup
                    }
                }
            };
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhr.send($.param(parameters));
        }
        function getLocauxAndProprioInfos() {
            if (!(typeof cadastreConfig != 'undefined'))
                return;

            if (!cadastreConfig.url)
                return;

            if (!cadastreConfig.layer)
                return;

            var cadastreLayer = cadastreConfig.layer;
            var cadastreLayerConfig = lizMap.config.layers[cadastreLayer];
            // var cleanName = lizMap.cleanName(cadastreLayer);

            if (!cadastreLayerConfig['selectedFeatures'])
                cadastreLayerConfig['selectedFeatures'] = [];

            var selectedParcelles = cadastreLayerConfig['selectedFeatures'];
            if (selectedParcelles.length == 0) {
                lizMap.addMessage('Aucune parcelle sélectionée', 'error', true).attr('id', 'lizmap-cadastre-message');
                window.setTimeout(function () {
                    var $CadastreMessage = $('#lizmap-cadastre-message');
                    if ($CadastreMessage.length != 0) {
                        $CadastreMessage.remove();
                    }
                }, 5000);
                return;
            }

            var typeName = cadastreLayer.split(' ').join('_');
            if ('typename' in cadastreLayerConfig) {
                typeName = cadastreLayerConfig.typename;
            } else if ('shortname' in cadastreLayerConfig) {
                typeName = cadastreLayerConfig.shortname;
            }

            // copy and adapt from getVectorLayerSelectionFeatureIdsString
            var featureids = '';
            var fids = [];
            for (var id in selectedParcelles) {
                fids.push(typeName + '.' + selectedParcelles[id]);
            }
            if (fids.length) {
                featureids = fids.join();
            }

            var getFeatureUrlData = lizMap.getVectorLayerWfsUrl(cadastreLayer, null, featureids, 'none');
            // Set export format
            getFeatureUrlData['options']['PROPERTYNAME'] = [cadastreConfig.pk].join(',');

            $.post(getFeatureUrlData['url'], getFeatureUrlData['options'], function (data) {
                var parcellePks = $.map(data.features, function (feat) {
                    return feat.properties[cadastreConfig.pk];
                });
                downloadFile(
                    $('#cadastre-export-locaux-proprios').attr('href'),
                    {
                        parcelles: parcellePks.join(),
                        layer: cadastreConfig.layer,
                        repository: lizUrls.params.repository,
                        project: lizUrls.params.project
                    }
                );
            });
        }
        if ($('#cadastre-export-locaux-proprios').length != 0) {
            $('#cadastre-export-locaux-proprios').click(function () {
                try {
                    getLocauxAndProprioInfos();
                } catch (e) {
                    console.log(e);
                }
                return false;
            });
        }

        initCadastreForm();
    },

    'lizmappopupdisplayed': function () {

        if (!(typeof cadastreConfig != 'undefined'))
            return;

        if (!cadastreConfig.url)
            return;

        if (!cadastreConfig.layer)
            return;

        if ($('#jforms_cadastre_search_has_majic').length) {
            var has_majic = $('#jforms_cadastre_search_has_majic').val();
            if (has_majic == '0') {
                return;
            }
        }

        // var popup = e.popup;
        var config = lizMap.config;

        var cadastreLayer = cadastreConfig.layer;
        // var cleanName = lizMap.cleanName(cadastreLayer);

        if (!config.layers[cadastreLayer]['selectedFeatures'])
            config.layers[cadastreLayer]['selectedFeatures'] = [];

        var cadastreLink = OpenLayers.Util.urlAppend(cadastreConfig.url
            , OpenLayers.Util.getParameterString(lizUrls.params)
        )

        function addCadastreToolsInfos(self) {
            var val = self.val();
            var eHtml = '';
            var fid = val.split('.').pop();
            var layerId = val.replace('.' + fid, '');

            // Add Cadastre buttons
            var getLayerConfig = lizMap.getLayerConfigById(layerId);
            if (getLayerConfig) {
                // var layerConfig = getLayerConfig[1];
                var layerName = getLayerConfig[0];

                if (layerName == cadastreConfig.layer) {

                    // Get geo_parcelle from WFS request and build export URL
                    var getFeatureUrlData = lizMap.getVectorLayerWfsUrl(
                        cadastreConfig.layer,
                        null,
                        cadastreConfig.layer + '.' + fid,
                        'none'
                    );
                    $.post(getFeatureUrlData['url'], getFeatureUrlData['options'], function (data) {

                        var link = '';
                        link += cadastreLink;
                        link += '&layer=' + cadastreConfig.layer;
                        var format = new OpenLayers.Format.GeoJSON();
                        getFeatureUrlData['options']['PROPERTYNAME'] = [cadastreConfig.pk].join(',');

                        if (data.features.length != 0) {
                            var feat = format.read(data.features[0])[0];
                            link += '&parcelle=' + feat.attributes[cadastreConfig.pk];

                            // Add buttons
                            eHtml = ''
                            eHtml += '<a href="';
                            eHtml += link + '&type=parcelle';
                            eHtml += '" class="btn btn-mini cadastre-export-parcelle parcelle" target="_blank" title="Relevé parcellaire"><i class="icon-file"></i>&nbsp;</a>';

                            eHtml += '<a href="';
                            eHtml += link + '&type=proprietaire';
                            eHtml += '" class="btn btn-mini cadastre-export-parcelle proprietaire" target="_blank" title="Relevé de propriété"><i class="icon-book"></i>&nbsp;</a>';

                            if ('attributeLayers' in config && cadastreLayer in config.attributeLayers) {
                                eHtml += '<button class="btn btn-mini cadastre-select-parcelle-proprietaire" target="_blank" value="';
                                eHtml += fid;
                                eHtml += '" title="Sélectionner les parcelles du propriétaire"';
                                eHtml += ' onclick="selectParcelleByProprietaire(\'' + feat.attributes[cadastreConfig.pk] + '\', true)">';
                                eHtml += '<i class="icon-user"></i><i class="icon-plus"></i>&nbsp;</button>';

                                eHtml += '<button class="btn btn-mini cadastre-unselect-parcelle-proprietaire" target="_blank" value="';
                                eHtml += fid;
                                eHtml += '" title="Retirer les parcelles du propriétaire"';
                                eHtml += ' onclick="selectParcelleByProprietaire(\'' + feat.attributes[cadastreConfig.pk] + '\', false)">';
                                eHtml += '<i class="icon-user"></i><i class="icon-minus"></i>&nbsp;</button>';

                            }

                            var popupButtonBar = self.next('span.popupButtonBar');
                            if (popupButtonBar.length != 0) {
                                popupButtonBar.append(eHtml);
                            } else {
                                eHtml = '<span class="popupButtonBar">' + eHtml + '</span></br>';
                                self.after(eHtml);
                            }

                            // Get Extra content
                            $.post(link, {type:'fiche'}, function (data) {
                                var d = $(data);
                                if (d[0].localName == 'h2') {
                                    var navTabs = $('<ul class="nav nav-tabs"></ul>');
                                    var tabContent = $('<div class="tab-content cadastre"></div>');
                                    var idTab = '';
                                    var tabPanes = [];
                                    var tabPane = null;
                                    for (var c=0, clen=d.length; c <clen; c++) {
                                        var child = d[c];
                                        if (child.localName == 'h2') {
                                            if (tabPane !== null && tabPane.children().length == 0) {
                                                tabPane.append('<p class="cadastre-no-data">Pas de données</p>');
                                            }
                                            idTab = child.innerText.toLowerCase().replace(/\W+/g, '')+'-'+feat.attributes[cadastreConfig.pk];
                                            tabPane = $('<div id="'+idTab+'" class="tab-pane"></div>');
                                            var tab = '<li><a href="#'+idTab+'" data-toggle="tab">'+child.innerText+'</a></li>';
                                            navTabs.append(tab);
                                            tabPanes.push(tabPane);
                                        } else {
                                            tabPane.append(child);
                                        }
                                    }
                                    if (tabPane !== null && tabPane.children().length == 0) {
                                        tabPane.append('<p class="cadastre-no-data">Pas de données</p>');
                                    }
                                    tabContent.append(tabPanes);
                                    self.parent().append(navTabs);
                                    self.parent().append(tabContent);
                                } else {
                                    self.parent().append(d);
                                }
                            }).fail(function () {
                                console.log('fail cadastre fiche');
                            });
                        }
                        $('body').css('cursor', 'auto');
                        return false;
                    }, 'json').fail(function () {
                        $('body').css('cursor', 'auto');
                        $('#lizmap-cadastre-message').remove();
                        return false;
                    });
                }
            }
        }


        // Add action buttons if needed
        $('div.lizmapPopupContent input.lizmap-popup-layer-feature-id').each(function () {
            addCadastreToolsInfos($(this));
        });
    },
    'layerSelectionChanged': function (e) {
        if ($('#div_form_cadastre_search form').length == 0)
            return;
        // Enable/disable remove from selection button
        var formId = $('#div_form_cadastre_search form').attr('id');
        if (e.featureIds.length > 0) {
            $('#' + formId + '_unselect')
                .removeClass('disabled')
                .prop('disabled', false);
        } else {
            $('#' + formId + '_unselect')
                .addClass('disabled')
                .prop('disabled', true);
        }
    }
});
