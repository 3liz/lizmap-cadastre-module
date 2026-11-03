/* global cadastreConfig */
/*eslint no-unused-vars: ["error", { "argsIgnorePattern": "^_" }]*/

/**
 * Check if Lizmap uses Bootstrap 5 (Lizmap 3.10 and above) or Bootstrap 2 (before).
 *
 * Bootstrap 5 is loaded as a script which defines the global object bootstrap.
 *
 * @returns {boolean} True for Bootstrap 5
 */
function cadastreIsBootstrap5() {
    return typeof window.bootstrap !== 'undefined' && typeof window.bootstrap.Tab !== 'undefined';
}

/**
 * Adapt tabs written for Bootstrap 2 to Bootstrap 5, with the flat style of the forms of Lizmap.
 *
 * With Bootstrap 2 (before Lizmap 3.10), nothing is changed. With Bootstrap 5, the links of the tabs
 * get the class nav-link and the attribute data-bs-toggle, the active tab is marked on its link,
 * and the container gets the class cadastre-bs5 used by the CSS of the flat style.
 *
 * @param {jQuery} container The element containing the ul.nav-tabs and the div.tab-pane
 */
function cadastreAdaptTabs(container) {
    if (!cadastreIsBootstrap5()) {
        return;
    }
    container.addClass('cadastre-bs5');
    container.find('ul.nav-tabs > li').each(function () {
        var item = $(this);
        var link = item.children('a');
        item.addClass('nav-item');
        link.addClass('nav-link').attr('data-bs-toggle', 'tab').removeAttr('data-toggle');
        if (item.hasClass('active')) {
            link.addClass('active');
            item.removeClass('active');
        }
    });
}

/**
 * Show a tab, with Bootstrap 5 or Bootstrap 2.
 *
 * @param {jQuery} link The link of the tab
 */
function cadastreShowTab(link) {
    if (link.length == 0) {
        return;
    }
    if (cadastreIsBootstrap5()) {
        window.bootstrap.Tab.getOrCreateInstance(link[0]).show();
    } else {
        link.tab('show');
    }
}

/**
 * Get the target of the active tab, with Bootstrap 5 (active link) or Bootstrap 2 (active item).
 *
 * @param {jQuery} container The element containing the ul.nav-tabs
 *
 * @returns {string} The href of the link of the active tab, like #tab1
 */
function cadastreActiveTab(container) {
    var link = container.find('ul.nav-tabs a.nav-link.active');
    if (link.length == 0) {
        link = container.find('ul.nav-tabs > li.active > a');
    }
    return link.attr('href');
}

/** Id of the search form of the panel, see the form cadastre~search */
const CADASTRE_FORM_ID = 'jforms_cadastre_search';

/** Id of the message of the module displayed by Lizmap: a new message replaces the previous one */
const CADASTRE_MESSAGE_ID = 'lizmap-cadastre-message';

/**
 * Get a field of the search form.
 *
 * @param {string} name Name of the control of the form, like commune
 *
 * @returns {HTMLElement|null} The field, null if the form does not have it (some need the MAJIC data)
 */
function cadastreField(name) {
    return document.getElementById(CADASTRE_FORM_ID + '_' + name);
}

/**
 * Get the value of a field of the search form.
 *
 * @param {string} name Name of the control of the form
 *
 * @returns {string} The value, an empty string if the field does not exist
 */
function cadastreValue(name) {
    const field = cadastreField(name);
    return field ? field.value : '';
}

/**
 * Set the value of a field of the search form.
 *
 * The change event is a native event: it also triggers the listeners bound with jQuery, like those of jForms
 * which fill the dependent lists.
 *
 * @param {string}  name    Name of the control of the form
 * @param {string}  value   The new value
 * @param {boolean} trigger True to trigger the change event
 */
function cadastreSetValue(name, value, trigger) {
    const field = cadastreField(name);
    if (!field) {
        return;
    }
    field.value = value;
    if (trigger) {
        field.dispatchEvent(new Event('change', { bubbles: true }));
    }
}

/**
 * Send a request, like jQuery did: parameters encoded as a form, header X-Requested-With.
 *
 * @param {string} url        URL of the request
 * @param {object} parameters Parameters of the request, a null or undefined value is sent empty
 * @param {object} options    method: GET or POST (default); type: json (default) or text
 *
 * @returns {Promise} The JSON or the text of the response, rejected if the request fails
 */
function cadastreFetch(url, parameters, options) {
    const method = (options && options.method) || 'POST';
    const type = (options && options.type) || 'json';
    const params = new URLSearchParams();
    for (const [key, value] of Object.entries(parameters || {})) {
        params.append(key, (value === null || value === undefined) ? '' : value);
    }
    const init = { method: method, headers: { 'X-Requested-With': 'XMLHttpRequest' } };
    if (method === 'GET') {
        url += (url.includes('?') ? '&' : '?') + params.toString();
    } else {
        init.body = params;
    }
    return fetch(url, init).then(function (response) {
        if (!response.ok) {
            throw new Error('HTTP ' + response.status + ' ' + url);
        }
        return type === 'text' ? response.text() : response.json();
    });
}

/**
 * Remove the message of the module.
 */
function cadastreRemoveMessage() {
    const message = document.getElementById(CADASTRE_MESSAGE_ID);
    if (message) {
        message.remove();
    }
}

/**
 * Hide the message of the module after a delay, with a fade.
 *
 * @param {number} delay Delay in milliseconds
 */
function cadastreHideMessage(delay) {
    window.setTimeout(function () {
        const message = document.getElementById(CADASTRE_MESSAGE_ID);
        if (message) {
            message.style.transition = 'opacity 0.6s';
            message.style.opacity = '0';
            window.setTimeout(function () { message.remove(); }, 600);
        }
    }, delay);
}

/**
 * Display the waiting cursor during a request, or the normal cursor.
 *
 * @param {boolean} wait True to display the waiting cursor
 */
function cadastreWaitCursor(wait) {
    document.body.style.cursor = wait ? 'wait' : 'auto';
}

function selectParcelles(getFeatureUrlData, addToSelection) {
    if (!(typeof cadastreConfig != 'undefined'))
        return;

    if (!cadastreConfig.url)
        return;

    if (!cadastreConfig.layer)
        return;

    cadastreWaitCursor(true);

    cadastreFetch(getFeatureUrlData['url'], getFeatureUrlData['options']).then(function (data2) {
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

        // Messages
        cadastreRemoveMessage();
        if (nbParcellesModify > 0) {
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

            lizMap.addMessage(html, 'info', true).attr('id', CADASTRE_MESSAGE_ID);
            // Open selection mini-dock: jQuery, to trigger the handler of Lizmap without following the link
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
            lizMap.addMessage("Aucune parcelle n'a été sélectionnée", 'error', true).attr('id', CADASTRE_MESSAGE_ID);
        }
    }).catch(function () {
        cadastreRemoveMessage();
        lizMap.addMessage("Aucune parcelle n'a été sélectionnée", 'error', true).attr('id', CADASTRE_MESSAGE_ID);
    }).finally(function () {
        cadastreWaitCursor(false);
        cadastreHideMessage(1500);
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
    cadastreFetch(getFeatureUrlData['url'], getFeatureUrlData['options']).then(function (data) {
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
        }
    }).catch(function () {
        cadastreRemoveMessage();
        lizMap.addMessage("Aucune parcelle n'a été sélectionnée", 'error', true).attr('id', CADASTRE_MESSAGE_ID);
        cadastreWaitCursor(false);
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

        var cadastreCrs = 'EPSG:4326';
        const searchContainer = document.getElementById('div_form_cadastre_search');
        if (!searchContainer) {
            return;
        }
        // URL of the autocompletion, and of the extent of a voie or an owner
        const autocompleteUrl = document.getElementById('form_cadastre_service_autocomplete').getAttribute('action');

        // Tabs of the search panel: Bootstrap 5 and flat style of Lizmap 3.10 and above
        cadastreAdaptTabs($(searchContainer));
        // Description of the displayed tab, above the tabs
        const help = document.getElementById('cadastre-search-help');
        searchContainer.querySelectorAll('ul.nav-tabs a').forEach(function (link) {
            link.addEventListener('click', function () {
                help.textContent = link.dataset.help || '';
            });
        });
        if (cadastreIsBootstrap5()) {
            // Small button to reset the search form, like the other buttons of the panel
            searchContainer.querySelectorAll('button.jforms-ctrl-reset').forEach(function (button) {
                button.classList.add('btn-sm');
            });
            // The labels are above the fields (see cadastre.css): the spaces between them are removed
            searchContainer.querySelectorAll('.tab-pane > p').forEach(function (paragraph) {
                Array.from(paragraph.childNodes).forEach(function (node) {
                    if (node.nodeType === Node.TEXT_NODE) {
                        node.remove();
                    }
                });
            });
        }

        /**
         * Update the first option of a list of parcelles with the number of parcelles found, after jForms
         * filled it, and zoom on them if the zoom mode is active.
         *
         * @param {string} name Name of the list in the form
         */
        function updateParcelleCount(name) {
            const select = cadastreField(name);
            // The list of the tab Lieu is only updated after a search by section or by address
            if (name == 'geo_parcelle_lieu' && cadastreValue('section') == '' && cadastreValue('adresse') == '') {
                return;
            }
            const countParcelle = select.options.length - 1;
            const firstOption = select.options[0];
            if (!firstOption) {
                return;
            }
            if (countParcelle > 0) {
                if (countParcelle == 1) {
                    firstOption.text = "1 parcelle trouvée";
                } else {
                    firstOption.text = countParcelle + " parcelles trouvées";
                }
                // Zoom on features if mode is active
                if (zoomModeActive()) {
                    zoomToCadastreFeature();
                }
            } else {
                firstOption.text = "-- Choisir --";
            }
        }

        /**
         * Check if the zoom mode of the search panel is active.
         *
         * @returns {boolean} True if the map zooms on the chosen element
         */
        function zoomModeActive() {
            const button = cadastreField('zoom');
            return button !== null && button.classList.contains('active');
        }

        /**
         * Get the parcelles of a list for the filter of a WFS request: the chosen one, or all the parcelles
         * of the list if none is chosen.
         *
         * @param {string} name Name of the list in the form
         *
         * @returns {string} The quoted ids of the parcelles, separated by commas
         */
        function quotedParcelles(name) {
            const select = cadastreField(name);
            if (select.value != '') {
                return "'" + select.value + "'";
            }
            return Array.from(select.options).map(function (o) { return "'" + o.value + "'"; }).join(',');
        }

        function initCadastreForm() {
            var formId = CADASTRE_FORM_ID;
            [
                'commune', 'adresse', 'voie', 'geo_parcelle_lieu',
                'commune_prop', 'proprietaire', 'comptecommunal', 'compte', 'geo_parcelle_prop',
                'spatial_layer_id', 'spatial_layer_selected_ids', 'spatial_layer_field', 'geo_parcelle_spatial'
            ].forEach(function (name) {
                cadastreSetValue(name, '', false);
            });
            cadastreSetValue('spatial_layer_buffer', 0, false);

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
                    cadastreFetch(autocompleteUrl, request, { method: 'GET' }).then(response).catch(function () {
                        response([]);
                    });
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
                    cadastreFetch(autocompleteUrl, request, { method: 'GET' }).then(response).catch(function () {
                        response([]);
                    });
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
                        $('#' + formId + '_compte').val('').change();
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

            // Autocomplete compte
            $('#' + formId + '_compte').autocomplete({
                minLength: 3,
                autoFocus: true,
                source: function (request, response) {
                    request.field = 'comp';
                    request.commune = $('#' + formId + '_commune_prop').val();
                    request.comptecommunal = $('#' + formId + '_comptecommunal').val();
                    request.limit = 100;
                    request.layer = cadastreConfig.layer;
                    request.repository = lizUrls.params.repository;
                    request.project = lizUrls.params.project;
                    cadastreFetch(autocompleteUrl, request).then(response).catch(function () {
                        response([]);
                    });
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
                        $('#' + formId + '_comptecommunal').change();
                    }
                },
                search: function () {
                },
                select: function (_e, ui) {
                    $(this).val($('<a>').html(ui.item.label).text()).change();
                    //$('#' + formId + '_comptecommunal').val(ui.item.code).change();

                    return false;
                }
            }).autocomplete("widget").css("z-index", "1050");


            // The change listeners are bound with jQuery: the autocompletion triggers jQuery events,
            // which do not reach the native listeners
            $('#' + formId + '_commune').change(function () {
                cadastreSetValue('section', '', false);
                cadastreSetValue('adresse', '', false);
                cadastreSetValue('voie', '', false);
                cadastreField('geo_parcelle_lieu').innerHTML = '<option value selected="selected">-- Choisir --</option>';
                if (zoomModeActive()) {
                    zoomToCadastreFeature();
                }
            });
            $('#' + formId + '_section').change(function () {
                cadastreSetValue('geo_parcelle_lieu', '', false);
                window.setTimeout(function() {
                    cadastreSetValue('adresse', '', false);
                    cadastreSetValue('voie', '', true);
                }, 500);
            });
            $('#' + formId + '_adresse').change(function () {
                cadastreSetValue('section', '', false);
            });

            $('#' + formId + '_commune_prop').change(function () {
                cadastreSetValue('proprietaire', '', false);
                cadastreSetValue('comptecommunal', '', false);
                cadastreSetValue('compte', '', false);
                cadastreField('geo_parcelle_prop').innerHTML = '<option value selected="selected">-- Choisir --</option>';
                if (zoomModeActive()) {
                    zoomToCadastreFeature();
                }

            });

            // Change on spatial layer combobox
            $('#' + formId + '_spatial_layer_id').change(function () {
                const layerId = this.value;
                let selectedIds = '-9999999';
                if (layerId) {
                    const getLayerConfig = lizMap.getLayerConfigById(layerId);
                    const layerConfig = getLayerConfig[1];
                    if ('selectedFeatures' in layerConfig && layerConfig.selectedFeatures && layerConfig.selectedFeatures.length) {
                        selectedIds = layerConfig.selectedFeatures.join();
                    }
                }
                cadastreSetValue('spatial_layer_selected_ids', selectedIds, true);
            });

            // Manage submit
            document.getElementById(formId).addEventListener('submit', function (event) {
                event.preventDefault();
            });

            /**
             * Set up a button of the toolbar of the search panel: title, class and icon.
             *
             * @param {string} name  Name of the button in the form
             * @param {string} title Title of the button
             * @param {string} icon  Class of the icon
             *
             * @returns {HTMLElement} The button
             */
            function setupButton(name, title, icon) {
                const button = cadastreField(name);
                button.title = title;
                button.classList.add('btn');
                button.innerHTML = "<i class='" + icon + "'></i>";
                return button;
            }

            // Click on zoom button
            const zoomButton = setupButton('zoom', 'Mode zoom', 'icon-zoom-in');
            zoomButton.classList.add('active');
            zoomButton.addEventListener('click', function (event) {
                event.preventDefault();
                if (zoomButton.classList.toggle('active')) {
                    zoomToCadastreFeature();
                }
            });

            setupButton('newselect', 'Nouvelle sélection', 'icon-refresh');
            setupButton('addselect', 'Ajouter à la sélection', 'icon-plus');
            setupButton('unselect', 'Supprimer de la sélection', 'icon-minus').classList.add('disabled');

            // Zoom on features if mode is active
            $('#' + formId + '_geo_parcelle_lieu, #' + formId + '_geo_parcelle_prop, #' + formId + '_geo_parcelle_spatial').change(function () {
                if (zoomModeActive()) {
                    zoomToCadastreFeature();
                }
            });

            // Handle click on select and unselect buttons
            ['newselect', 'addselect', 'unselect'].forEach(function (name) {
                cadastreField(name).addEventListener('click', function (event) {
                    event.preventDefault();
                    selectFromForm(this.id);
                });
            });

            /**
             * Change the selection with the parcelles of the active tab of the search panel.
             *
             * @param {string} buttonId Id of the clicked button: new selection, add or remove
             */
            function selectFromForm(buttonId) {
                var filter = null; var fids = null;
                var activeTab = cadastreActiveTab($(searchContainer));

                // Lieu tab is active
                if (activeTab == '#tab1') {
                    var section = cadastreValue('section');
                    var parcelle = cadastreValue('geo_parcelle_lieu');
                    if (cadastreField('geo_parcelle_lieu').options.length > 1 && (section || cadastreValue('voie'))) {
                        if (section) {
                            if (parcelle) {
                                // Select one parcelle
                                filter = '"geo_parcelle" IN (\'' + parcelle + '\')';
                            } else {
                                // Select all parcelles on section with section value
                                filter = '"geo_section" IN (\'' + section + '\')';
                            }
                        }
                        if (cadastreValue('voie')) {
                            filter = '"geo_parcelle" IN (' + quotedParcelles('geo_parcelle_lieu') + ')';
                        }
                    }
                }
                // Prop tab is active
                else if (activeTab == '#tab2') {
                    if (cadastreField('geo_parcelle_prop').options.length > 1) {
                        if (cadastreValue('geo_parcelle_prop') == '') {
                            var comptecommunal = cadastreValue('comptecommunal');
                            var compte = cadastreValue('compte');
                            if (compte !== '') {
                                comptecommunal = cadastreValue('commune_prop') + compte;
                            }
                            fids = "'" + comptecommunal.split(",").join("' , '") + "'";
                            filter = '"comptecommunal" IN ( ' + fids + ' )';
                        } else {
                            fids = "'" + cadastreValue('geo_parcelle_prop') + "'";
                            filter = '"geo_parcelle" IN ( ' + fids + ' )';
                        }
                    }
                }
                // Spatial tab is active
                else if (activeTab == '#tab3') {
                    if (cadastreField('geo_parcelle_spatial').options.length > 1) {
                        filter = '"geo_parcelle" IN (' + quotedParcelles('geo_parcelle_spatial') + ')';
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
                    if (buttonId === formId + "_newselect") {
                        lizMap.config.layers[cadastreConfig.layer]['selectedFeatures'] = [];
                    }
                    // Add or remove from selection
                    var addToSelection = (buttonId !== formId + "_unselect");
                    selectParcelles(getFeatureUrlData, addToSelection);
                }
            }

            // Reinit search form
            cadastreField('reinit').addEventListener('click', function (event) {
                event.preventDefault();
                reinitCadastreForm();
            });

            // Empty selection
            setupButton('emptyselect', 'Désélectionner', 'icon-star-empty').addEventListener('click', function (event) {
                event.preventDefault();
                lizMap.events.triggerEvent(
                    'layerfeatureunselectall',
                    { 'featureType': cadastreConfig.layer, 'updateDrawing': true }
                );
            });

            // Observe the lists of parcelles, filled by jForms, to display the number of parcelles found
            ['geo_parcelle_lieu', 'geo_parcelle_prop', 'geo_parcelle_spatial'].forEach(function (name) {
                const select = cadastreField(name);
                if (select) {
                    new MutationObserver(function () {
                        updateParcelleCount(name);
                    }).observe(select, { childList: true });
                }
            });
        }

        function zoomToCadastreFeature() {
            var layername = null; var fieldname = null; var fieldval = null;
            var activeTab = cadastreActiveTab($(searchContainer));

            if (activeTab == '#tab1') {
                // TAB 1 : lieu
                if (cadastreValue('commune')) {
                    layername = 'Communes'; fieldname = 'geo_commune'; fieldval = cadastreValue('commune');
                }
                if (cadastreValue('section')) {
                    layername = 'Sections'; fieldname = 'geo_section'; fieldval = cadastreValue('section');
                }
                if (cadastreValue('voie') && !cadastreValue('geo_parcelle_lieu')) {
                    layername = 'Voies'; fieldname = 'voie'; fieldval = cadastreValue('voie');
                }
                if (cadastreValue('geo_parcelle_lieu')) {
                    layername = 'Parcelles'; fieldname = 'geo_parcelle'; fieldval = cadastreValue('geo_parcelle_lieu');
                }
            } else if (activeTab == '#tab2') {
                // TAB 2 : prop
                if (cadastreValue('commune_prop')) {
                    layername = 'Communes'; fieldname = 'geo_commune'; fieldval = cadastreValue('commune_prop');
                }
                if (cadastreValue('geo_parcelle_prop')) {
                    layername = 'Parcelles'; fieldname = 'geo_parcelle'; fieldval = cadastreValue('geo_parcelle_prop');
                } else {
                    if (cadastreValue('compte')) {
                        layername = 'Parcelles'; fieldname = 'comp';
                        fieldval = cadastreValue('commune_prop') + cadastreValue('compte');
                    }
                    else if (cadastreValue('comptecommunal')) {
                        layername = 'Proprietaire'; fieldname = 'prop'; fieldval = cadastreValue('comptecommunal');
                    }
                }
            } else if (activeTab == '#tab3') {
                // TAB 3 : spatial
                if (cadastreValue('geo_parcelle_spatial')) {
                    layername = 'Parcelles'; fieldname = 'geo_parcelle'; fieldval = cadastreValue('geo_parcelle_spatial');
                }
            }

            if (!layername || !fieldname || !fieldval) {
                return false;
            }

            var format = new OpenLayers.Format.GeoJSON();

            if (fieldname == 'voie' || fieldname == 'prop' || fieldname == 'comp') {
                var url = autocompleteUrl.replace('autocomplete', 'extent');
                var options = {
                    field: fieldname,
                    value: fieldval,
                    layer: cadastreConfig.layer,
                    repository: lizUrls.params.repository,
                    project: lizUrls.params.project
                };
                cadastreFetch(url, options, { method: 'GET' }).then(function (data) {
                    if (data && data.length == 1) {
                        var feat = format.read(data[0]['geom'])[0];
                        var proj = new OpenLayers.Projection('EPSG:4326');
                        feat.geometry.transform(proj, lizMap.map.getProjection());
                        lizMap.map.zoomToExtent(feat.geometry.getBounds());
                    }
                }).catch(function (error) {
                    console.log(error);
                });
            } else {
                if (layername == 'Parcelles') {
                    if ('parcelle' in cadastreConfig) {
                        var parcelleConfig = cadastreConfig.parcelle;
                        if (parcelleConfig.shortName !== '') {
                            layername = parcelleConfig.shortName;
                        } else {
                            layername = parcelleConfig.name;
                        }
                    } else if (layername != cadastreConfig.layer) {
                        layername = cadastreConfig.layer;
                    }
                } else if (layername == 'Sections' && ('section' in cadastreConfig)) {
                    var sectionConfig = cadastreConfig.section;
                    if (sectionConfig.shortName !== '') {
                        layername = sectionConfig.shortName;
                    } else {
                        layername = sectionConfig.name;
                    }
                } else if (layername == 'Communes' && ('commune' in cadastreConfig)) {
                    var communeConfig = cadastreConfig.commune;
                    if (communeConfig.shortName !== '') {
                        layername = communeConfig.shortName;
                    } else {
                        layername = communeConfig.name;
                    }
                }
                var filter = '"' + fieldname + '" = ' + "'" + fieldval + "'";
                var getFeatureUrlData = lizMap.getVectorLayerWfsUrl(layername, filter, null, 'extent');
                getFeatureUrlData['options']['PROPERTYNAME'] = 'ogc_fid,geometry';
                // Get data
                cadastreFetch(getFeatureUrlData['url'], getFeatureUrlData['options']).then(function (data) {
                    if (data.features.length != 0) {
                        var feat = format.read(data.features[0])[0];
                        var proj = new OpenLayers.Projection(cadastreCrs);
                        feat.geometry.transform(proj, lizMap.map.getProjection());
                        lizMap.map.zoomToExtent(feat.geometry.getBounds());
                    }
                }).catch(function (error) {
                    console.log(error);
                });
            }
        }

        function reinitCadastreForm() {
            searchContainer.querySelectorAll('form select option').forEach(function (option) {
                option.selected = option.defaultSelected;
            });

            // Keep only the first option of the lists of parcelles
            ['geo_parcelle_lieu', 'geo_parcelle_prop', 'geo_parcelle_spatial'].forEach(function (name) {
                const select = cadastreField(name);
                if (!select) {
                    return;
                }
                while (select.options.length > 1) {
                    select.remove(1);
                }
                if (name != 'geo_parcelle_prop' && select.options.length) {
                    select.options[0].text = '-- Choisir --';
                }
            });

            ['commune', 'commune_prop', 'section', 'adresse', 'voie', 'proprietaire'].forEach(function (name) {
                cadastreSetValue(name, '', true);
            });

            ['spatial_layer_id', 'spatial_layer_selected_ids', 'spatial_layer_field', 'geo_parcelle_spatial'].forEach(function (name) {
                cadastreSetValue(name, '', false);
            });
            cadastreSetValue('spatial_layer_buffer', 0, false);
        }

        // function manageCadastreSubmit() {
        //     //console.log('submit form -> manageCadastreSubmit');
        //     return false;
        // }

        // copy from lizmap

        /**
         * Téléchargement d'un fichier en JS
         *
         * @param {string} url URL of the file
         * @param {objet}  parameters Parameters
         */
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
            var params = new URLSearchParams();
            for (var key in parameters) {
                // Like jQuery.param: a null or undefined value is sent empty
                params.append(key, (parameters[key] === null || parameters[key] === undefined) ? '' : parameters[key]);
            }
            xhr.send(params.toString());
        }


        /**
         * Déclenche le téléchargement des données parcelles sélectionnées.
         *
         * En fonction du bouton, le fichier CSV récupéré contient
         * soit les parcelles et leurs propriétaires,
         * soit les locaux des parcelles et leurs propriétaires.
         *
         * Cette information est contenue dans href
         *
         * @param {string} href             URL de téléchargement des données
         * @param {string} additionalData  Données additionnelles, par exemple sur les paramètres du formulaire
         *
         */
        function getSelectedParcellesData(href, additionalData) {
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
                lizMap.addMessage('Aucune parcelle sélectionnée', 'error', true).attr('id', CADASTRE_MESSAGE_ID);
                window.setTimeout(cadastreRemoveMessage, 5000);
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

            cadastreFetch(getFeatureUrlData['url'], getFeatureUrlData['options']).then(function (data) {
                var parcellePks = data.features.map(function (feat) {
                    return feat.properties[cadastreConfig.pk];
                });
                var parameters = {
                    parcelles: parcellePks.join(),
                    layer: cadastreConfig.layer,
                    repository: lizUrls.params.repository,
                    project: lizUrls.params.project,
                    additionalData: additionalData
                };
                // Export for a third party, without sensitive data, unless the box is unchecked.
                // The server checks the rights again
                var forThirdParty = document.getElementById('cadastre-export-tiers');
                parameters['tiers'] = (forThirdParty && !forThirdParty.checked) ? '0' : '1';
                downloadFile(href, parameters);
            }).catch(function (error) {
                console.log(error);
            });
        }

        // Événement sur clic des boutons de téléchagement du publipostage sur les locaux
        // des parcelles sélectionnées
        const exportLocaux = document.getElementById('cadastre-export-locaux-proprios');
        if (exportLocaux) {
            exportLocaux.addEventListener('click', function (event) {
                event.preventDefault();
                try {
                    getSelectedParcellesData(exportLocaux.getAttribute('href'));
                } catch (e) {
                    console.log(e);
                }
            });
        }

        /**
         * Get a JSON representation of the "Recherche spatial" form tab
         *
         * @returns {string} JSON of the spatial form parameters
         */
        function getSpatialFormData() {
            const form = document.getElementById('jforms_cadastre_search');
            let intersectionDataJson = null;
            // Check if the spatial search tab is active
            const spatialTabActive = (cadastreActiveTab($(searchContainer)) == '#tab3');
            if (form
                // Visible tab must be "Recherche spatiale"
                && spatialTabActive
                && true
            ) {
                const data = Object.fromEntries(new FormData(form));
                const intersectionData = {};
                const keptKeys = ['spatial_layer_id', 'spatial_layer_field', 'spatial_layer_buffer', 'spatial_layer_selected_ids'];
                for (const key in data) {
                    if (keptKeys.includes(key)) {
                        intersectionData[key] = data[key];
                    }
                }
                intersectionDataJson = JSON.stringify(intersectionData);
            }

            return intersectionDataJson
        }

        // Événement sur clic des boutons de téléchagement du publipostage sur les parcelles sélectionnées
        // Si la case est cochée, on doit aussi envoyer les données du formulaire spatial
        // pour permettre une jointure avec la couche choisie et ses objets sélectionnés
        const exportParcelles = document.getElementById('cadastre-export-parcelles-proprios');
        if (exportParcelles) {
            exportParcelles.addEventListener('click', function (event) {
                event.preventDefault();
                try {
                    const intersectionDataJson = getSpatialFormData();
                    getSelectedParcellesData(exportParcelles.getAttribute('href'), intersectionDataJson);
                } catch (e) {
                    console.log(e);
                }
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

        // The buttons and the tabs need the access to the owners, then each one has its right
        var rights = cadastreConfig.rights || {};
        if (!rights.owners)
            return;

        var hasMajic = cadastreField('has_majic');
        if (hasMajic && hasMajic.value != '1') {
            return;
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

        // Parse parcelle HTML given by the cadastre QGIS Server plugin
        // Add create HTML with bootstrap tabs
        function parseParcelleHtmlFromPlugin(data_object, pkey) {
            var html_object = $('<div class="cadastre-popup-tab-container"></div>');
            var navTabs = $('<ul class="nav nav-tabs"></ul>');
            var tabContent = $('<div class="tab-content cadastre"></div>');
            var idTab = '';
            var tabPanes = [];
            var tabPane = null;

            // Look inside the given HTML and move content to separate tabs
            // Parcelle, Propriétaires, Subdivisions fiscales
            // Locaux, Locaux; informations détaillées
            var firstTab = '';
            for (var c=0, clen=data_object.length; c <clen; c++) {
                var child = data_object[c];
                if (child.localName == 'h2') {
                    if (tabPane !== null && tabPane.children().length == 0) {
                        tabPane.append('<p class="cadastre-no-data">Pas de données</p>');
                    }
                    idTab = child.innerText.toLowerCase().replace(/\W+/g, '')+'-'+pkey;
                    tabPane = $('<div id="'+idTab+'" class="tab-pane"></div>');
                    var tab = '<li><a href="#'+idTab+'" data-toggle="tab">'+child.innerText+'</a></li>';
                    navTabs.append(tab);
                    tabPanes.push(tabPane);
                    if (c == 0) {
                        firstTab = idTab;
                    }
                } else {
                    tabPane.append(child);
                }
            }

            // Add message if not data for a given tab content
            if (tabPane !== null && tabPane.children().length == 0) {
                tabPane.append('<p class="cadastre-no-data">Pas de données</p>');
            }

            // Add content to the popup
            tabContent.append(tabPanes);
            html_object.append(navTabs)
            html_object.append(tabContent)
            // Bootstrap 5 and flat style of Lizmap 3.10 and above
            cadastreAdaptTabs(html_object);

            return [html_object, firstTab];
        }

        /**
         * Style sheet of the print of the detailed information of a parcelle: same look as the tabs
         * of the popup and as the fiche parcellaire in QGIS, see fiche_parcelle.css in the plugin.
         *
         * It is written in the print window, an external style sheet could be loaded after the print.
         */
        var CADASTRE_PRINT_CSS = [
            'body { font-family: "Lucida Grande", "Segoe UI", Arial, sans-serif; font-size: 12px; color: #333; }',
            'h1 { font-size: 18px; color: #43718c; margin: 0 0 8px 0; }',
            'h2 { font-size: 16px; color: #43718c; margin: 16px 0 6px 0; line-height: 1.5;'
                + ' border-bottom: 2px solid #43718c; }',
            'h3 { font-size: 14px; color: #43718c; margin: 10px 0 4px 0; line-height: 1.5; }',
            'h4 { font-size: 13px; color: #505050; margin: 8px 0 4px 0; }',
            'h2, h3, h4 { page-break-after: avoid; break-after: avoid; }',
            'table { border-collapse: collapse; border: 1px solid #BBB; width: 100%; margin: 0 0 6px 0; }',
            'th, td { border: 1px solid #BBB; padding: 3px 5px; text-align: left; vertical-align: top; }',
            'th { color: #43718c; font-weight: bold; }',
            'tr { page-break-inside: avoid; break-inside: avoid; }',
            // A light grey on one row out of two, printed even if the browser does not print the backgrounds
            'tr:nth-child(even) { background: #F5F5F5; -webkit-print-color-adjust: exact; print-color-adjust: exact; }',
            'tr:nth-child(odd) { background: #FFF; }'
        ].join('\n');

        /**
         * Print the detailed information of a parcelle in a new window, with the style of the fiche parcellaire.
         *
         * The window is opened during the click, otherwise the browser would block it. The fiche is written
         * in it when it is received, then printed.
         *
         * @param {string} url URL of the fiche of the parcelle
         */
        function printParcelleHtml(url) {
            var print_window = window.open('', 'PRINT', 'height=400,width=600');
            if (!print_window) {
                return;
            }
            print_window.document.write('<html><head><title>' + document.title + '</title>');
            print_window.document.write('<style>' + CADASTRE_PRINT_CSS + '</style>');
            print_window.document.write('</head><body><h1>' + document.title + '</h1>');
            print_window.document.write('<p id="cadastre-print-wait">Chargement…</p></body></html>');
            print_window.document.close();

            cadastreFetch(url, {type: 'fiche'}, { type: 'text' }).then(function (data) {
                var body = print_window.document.body;
                body.removeChild(print_window.document.getElementById('cadastre-print-wait'));
                body.insertAdjacentHTML('beforeend', data);
                print_window.focus();
                print_window.print();
                print_window.close();
            }).catch(function () {
                print_window.close();
            });
        }

        /**
         * Build the HTML of the button of a relevé in the toolbar of the popup.
         *
         * With at least one right on the sensitive data, the button opens a dropdown menu to choose the relevé
         * with the sensitive data allowed by the rights, or for a third party without them. It uses the dropdown
         * of Bootstrap 5 (Lizmap 3.10 and above) or of Bootstrap 2 (before). Without right on the sensitive data,
         * the button opens the relevé for a third party. The server checks the rights again.
         *
         * @param {string} link   URL of the relevés of the parcelle
         * @param {string} type   Type of relevé: parcelle or proprietaire
         * @param {string} title  Title of the button
         * @param {string} icon   Class of the icon of the button
         * @param {object} rights Rights of the user, see cadastreRights::forJavaScript()
         *
         * @returns {string} The HTML of the button
         */
        function releveButtonHtml(link, type, title, icon, rights) {
            var href = link + '&type=' + type;
            var buttonClass = 'btn btn-mini btn-sm cadastre-export-parcelle ' + type;
            if (!rights.exportSensitive) {
                return '<a href="' + href + '&tiers=1" class="' + buttonClass + '" target="_blank" title="' + title + '">'
                    + '<i class="' + icon + '"></i>&nbsp;</a>';
            }

            var bootstrap5 = cadastreIsBootstrap5();
            // Static display: the dropdown of Bootstrap 5 does not need Popper
            var toggle = bootstrap5 ? 'data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false"' : 'data-toggle="dropdown"';
            // Bootstrap 5 adds the caret itself
            var caret = bootstrap5 ? '' : ' <span class="caret"></span>';
            var itemClass = bootstrap5 ? ' class="dropdown-item"' : '';

            var html = '<div class="btn-group cadastre-releve">';
            html += '<a href="#" class="' + buttonClass + ' dropdown-toggle" ' + toggle + ' title="' + title + '">';
            html += '<i class="' + icon + '"></i>' + caret + '</a>';
            html += '<ul class="dropdown-menu">';
            html += '<li><a' + itemClass + ' href="' + href + '&tiers=0" target="_blank">Avec les données que je peux voir</a></li>';
            html += '<li><a' + itemClass + ' href="' + href + '&tiers=1" target="_blank">Pour un tiers (sans données sensibles)</a></li>';
            html += '</ul></div>';

            return html;
        }

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
                    cadastreFetch(getFeatureUrlData['url'], getFeatureUrlData['options']).then(function (data) {

                        var link = '';
                        link += cadastreLink;
                        link += '&layer=' + cadastreConfig.layer;
                        var format = new OpenLayers.Format.GeoJSON();
                        getFeatureUrlData['options']['PROPERTYNAME'] = [cadastreConfig.pk].join(',');

                        if (data.features.length != 0) {
                            var feat = format.read(data.features[0])[0];
                            link += '&parcelle=' + feat.attributes[cadastreConfig.pk];

                            // Add buttons, according to the rights of the user
                            eHtml = ''
                            if (rights.releveParcellaire) {
                                // Export parcelle to PDF
                                eHtml += releveButtonHtml(link, 'parcelle', 'Relevé parcellaire', 'icon-file', rights);
                            }
                            if (rights.relevePropriete) {
                                // Export propriétaire to PDF
                                eHtml += releveButtonHtml(link, 'proprietaire', 'Relevé de propriété', 'icon-book', rights);
                            }
                            if (rights.popupTabs) {
                                // Print Parcelle info HTML detail
                                eHtml += '<button class="btn btn-mini btn-sm cadastre-export-parcelle print" title="Imprimer le détail">';
                                eHtml += '<i class="icon-print"></i>&nbsp;</button>';
                            }

                            if ('attributeLayers' in config && cadastreLayer in config.attributeLayers) {
                                eHtml += '<button class="btn btn-mini btn-sm cadastre-select-parcelle-proprietaire" target="_blank" value="';
                                eHtml += fid;
                                eHtml += '" title="Sélectionner les parcelles du propriétaire"';
                                eHtml += ' onclick="selectParcelleByProprietaire(\'' + feat.attributes[cadastreConfig.pk] + '\', true)">';
                                eHtml += '<i class="icon-user"></i><i class="icon-plus"></i>&nbsp;</button>';

                                eHtml += '<button class="btn btn-mini btn-sm cadastre-unselect-parcelle-proprietaire" target="_blank" value="';
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
                                popupButtonBar = self.next('span.popupButtonBar');
                            }


                            // Print button of this popup only: the popup can display several parcelles
                            popupButtonBar.find('button.cadastre-export-parcelle.print').click(function() {
                                printParcelleHtml(link);
                            });

                            // Get Extra content: the tabs of the detailed information, with their right
                            if (rights.popupTabs) {
                                cadastreFetch(link, {type: 'fiche'}, { type: 'text' }).then(function (data) {
                                    var data_object = $(data);
                                    if (data_object[0].localName == 'h2') {
                                        // Create empty container for the main div, the tab li and content
                                        var html_parsing_result = parseParcelleHtmlFromPlugin(
                                            data_object,
                                            feat.attributes[cadastreConfig.pk]
                                        );
                                        var contentContainer = html_parsing_result[0];
                                        var firstTab = html_parsing_result[1];
                                        self.parent().append(contentContainer);

                                        // Activate first tab
                                        cadastreShowTab(self.parent().find('.nav-tabs a[href="#' + firstTab + '"]'));
                                    } else {
                                        self.parent().append(data_object);
                                    }
                                }).catch(function () {
                                    console.log('fail cadastre fiche');
                                });
                            }
                        }
                        cadastreWaitCursor(false);
                    }).catch(function () {
                        cadastreWaitCursor(false);
                        cadastreRemoveMessage();
                    });
                }
            }
        }


        // Add action buttons and parcelle detail if needed
        $('div.lizmapPopupContent input.lizmap-popup-layer-feature-id').each(function () {
            addCadastreToolsInfos($(this));
        });
    },
    'layerSelectionChanged': function (e) {
        if (!document.getElementById(CADASTRE_FORM_ID))
            return;

        // Enable/disable remove from selection button
        var unselect = cadastreField('unselect');
        var empty = (e.featureIds.length == 0);
        unselect.classList.toggle('disabled', empty);
        unselect.disabled = empty;

        // Change the value of selected Id in the spatial search hidden input
        // Only if the layer corresponds
        const chosenLayerId = cadastreValue('spatial_layer_id');
        const layerId = lizMap.config.layers[e.featureType].id;
        if (chosenLayerId == layerId) {
            const selectedIds =  (e.featureIds.length) ? e.featureIds : [-999999];
            cadastreSetValue('spatial_layer_selected_ids', selectedIds.join(), true);
        }
    }
});
