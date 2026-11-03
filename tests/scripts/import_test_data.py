"""Import the fictitious test data of the QGIS plugin cadastre, and create the Lizmap project using them.

Run in the qgis-tools service with `make import-test-data`: the plugin is mounted in /srv/plugin.

* The EDIGEO and MAJIC data of the commune 13029 (Cornillon-Confoux) come from the tests of the plugin.
  The MAJIC data are FICTITIOUS: owners, births, addresses and values are invented.
* They are imported in the schema cadastre_tests, with the import of the plugin itself.
* The project cadastre_tests.qgs is a copy of cadastre_caen.qgs, using this schema and the extent of the data.
"""

import json
import shutil
import sys
import tempfile

from pathlib import Path

from qgis.core import (
    Qgis,
    QgsApplication,
    QgsProject,
    QgsProviderRegistry,
    QgsRectangle,
    QgsReferencedRectangle,
)

# Name of the QGIS connection, and of the PostgreSQL service used by the Lizmap projects
CONNECTION = "lizmap-cadastre"
# Schema of the test data
SCHEMA = "cadastre_tests"
# Data of the tests of the plugin
FIXTURES = Path("/srv/plugin/tests/fixtures")
INSEE = "13029"
# Lizmap project used as model, and the project created
PROJECTS = Path("/srv/projects/tests")
MODEL = "cadastre_caen"
PROJECT = "cadastre_tests"
# Filter by login of the layer of the parcelles: the field of parcelle_info giving the group which can see
# a parcelle ("all" for everybody), and a parcelle only visible by the group agents. The group users is not
# used: with Lizmap 3.10, it is the default group of the new users, the user agent is also in it
LOGIN_FILTER_FIELD = "groupe"
LOGIN_FILTER_PARCELLE = "1320290000A0037"
LOGIN_FILTER_GROUP = "agents"

# Layers published in WFS, needed by the module: see the documentation of the configuration of the module
WFS_LAYERS = ("communes", "parcelles", "sections")
# Fields of the parcelles with the owners, not published in WMS and WFS: like the plugin cadastre does
# when it loads the layers, only the module gives them, according to the rights of the user
OWNER_FIELDS = ("proprietaire", "proprietaire_info")
# Metadata of the Lizmap configuration accepted by all the versions of Lizmap Web Client supported by the module
LIZMAP_METADATA = {
    "lizmap_plugin_version_str": "4.5.0",
    "lizmap_plugin_version": 40500,
    "lizmap_web_client_target_version": 30800,
}


def import_data():
    """Import the EDIGEO and MAJIC test data of the plugin in the schema SCHEMA, replacing it"""
    # Imported here, the plugin needs a QgsApplication
    from cadastre.cadastre_database import CadastreDatabase
    from cadastre.cadastre_import import ImportOptions, cadastreImport
    from cadastre.definitions import MAXIMUM_YEAR
    from cadastre.feedback import CadastreFeedback

    metadata = QgsProviderRegistry.instance().providerMetadata("postgres")
    metadata.saveConnection(metadata.createConnection(f"service='{CONNECTION}'", {}), CONNECTION)
    connection = metadata.findConnection(CONNECTION)
    connection.executeSql(f"DROP SCHEMA IF EXISTS {SCHEMA} CASCADE")
    connection.createSchema(SCHEMA)

    # The plugin is mounted read only: the data are copied in a temporary directory
    with tempfile.TemporaryDirectory() as tmp:
        majic = shutil.copytree(FIXTURES / "majic" / INSEE, Path(tmp) / "majic")
        edigeo = shutil.copytree(FIXTURES / "edigeo" / INSEE, Path(tmp) / "edigeo")
        options = ImportOptions(
            database=CadastreDatabase.from_connection("postgis", CONNECTION, SCHEMA),
            data_version=str(MAXIMUM_YEAR),
            data_year=str(MAXIMUM_YEAR),
            lot="1",
            departement="13",
            direction="2",
            majic_source_dir=str(majic),
            edigeo_source_dir=str(edigeo),
            edigeo_source_proj="EPSG:2154",
            edigeo_target_proj="EPSG:2154",
        )
        if not cadastreImport(options, CadastreFeedback()).run():
            sys.exit("The import of the test data failed")

    # Field of the filter by login of the parcelles
    connection.executeSql(
        f"ALTER TABLE {SCHEMA}.parcelle_info ADD COLUMN {LOGIN_FILTER_FIELD} text NOT NULL DEFAULT 'all'"
    )
    connection.executeSql(
        f"UPDATE {SCHEMA}.parcelle_info SET {LOGIN_FILTER_FIELD} = '{LOGIN_FILTER_GROUP}' "
        f"WHERE geo_parcelle = '{LOGIN_FILTER_PARCELLE}'"
    )
    print(f"Test data imported in the schema {SCHEMA}")


def create_project():
    """Create the Lizmap project PROJECT from MODEL, with the schema and the extent of the test data"""
    qgs = (PROJECTS / f"{MODEL}.qgs").read_text()
    path = PROJECTS / f"{PROJECT}.qgs"
    path.write_text(qgs.replace(f'"{MODEL}".', f'"{SCHEMA}".'))

    project = QgsProject.instance()
    if not project.read(str(path)):
        sys.exit(f"Unable to read the project {path}")
    extents = {}
    full = QgsRectangle()
    for layer in project.mapLayers().values():
        if not layer.isValid():
            sys.exit(f"The layer {layer.name()} is not valid: {layer.source()}")
        layer.updateExtents()
        extents[layer.id()] = layer.extent()
        full.combineExtentWith(layer.extent())
    project.viewSettings().setDefaultViewExtent(QgsReferencedRectangle(full, project.crs()))
    bbox = [full.xMinimum(), full.yMinimum(), full.xMaximum(), full.yMaximum()]
    project.writeEntry("WMSExtent", "/", [str(round(v)) for v in bbox])
    # The model does not publish the communes in WFS: the zoom on a commune of the search panel would fail
    wfs_ids = [layer.id() for layer in project.mapLayers().values() if layer.name() in WFS_LAYERS]
    project.writeEntry("WFSLayers", "/", wfs_ids)
    for layer_id in wfs_ids:
        project.writeEntry("WFSLayersPrecision", "/" + layer_id, 8)
    for layer in project.mapLayersByName("parcelles"):
        for name in OWNER_FIELDS:
            index = layer.fields().indexOf(name)
            if index >= 0:
                layer.setFieldConfigurationFlag(index, Qgis.FieldConfigurationFlag.HideFromWms, True)
                layer.setFieldConfigurationFlag(index, Qgis.FieldConfigurationFlag.HideFromWfs, True)
    project.write()

    # Lizmap configuration: the extents of the project and of the layers
    config = json.loads((PROJECTS / f"{MODEL}.qgs.cfg").read_text())
    # Versions of the Lizmap plugin and target version of Lizmap Web Client: those of the model are refused
    # by Lizmap Web Client 3.8 and above, which then does not display the map
    config["metadata"].update(LIZMAP_METADATA)
    config["options"]["bbox"] = [str(round(v)) for v in bbox]
    config["options"]["initialExtent"] = bbox
    # Filter by login of the parcelles: only the users of the group agents see LOGIN_FILTER_PARCELLE
    parcelles = project.mapLayersByName("parcelles")[0]
    config["loginFilteredLayers"] = {
        "parcelles": {
            "layerId": parcelles.id(),
            "filterAttribute": LOGIN_FILTER_FIELD,
            "filterPrivate": "False",
            "order": 0,
        }
    }
    for layer in config["layers"].values():
        extent = extents.get(layer.get("id"))
        if extent is not None:
            layer["extent"] = [extent.xMinimum(), extent.yMinimum(), extent.xMaximum(), extent.yMaximum()]
    (PROJECTS / f"{PROJECT}.qgs.cfg").write_text(json.dumps(config, indent=4, ensure_ascii=False))
    print(f"Lizmap project {path} created")


if __name__ == "__main__":
    app = QgsApplication([], False)
    app.initQgis()
    import_data()
    create_project()
    app.exitQgis()
