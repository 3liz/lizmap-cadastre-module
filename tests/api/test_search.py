"""Search panel: search of the parcelles by voie, with the codes of voie of the table voie"""

import json
import re

import requests

from conftest import BASE_URL, PROJECT

# Voie of the copropriété, CHEM DE LA COOPERATIVE: code of the table voie, built from the file TOPO
# without ccovoi ("00000"). The parcelles have the code with ccovoi (132029015001500)
VOIE = "132029000001500"

# Parcelle of the copropriété, on this voie
COPROPRIETE = "1320290000A0107"


def search(session: requests.Session, action: str, **params: str) -> requests.Response:
    """Call a search service of the module: autocomplete or extent"""
    return session.get(
        f"{BASE_URL}/index.php/cadastre/service/{action}",
        params={**PROJECT, **params},
    )


def test_autocomplete_voie(user: requests.Session):
    """The address search gives the code of the voie from the table voie"""
    data = search(user, "autocomplete", field="voie", term="COOP").json()
    assert [item["code"] for item in data] == [VOIE]


def test_extent_voie(user: requests.Session):
    """The extent of a voie is the one of its parcelles, despite the different codes of voie"""
    data = search(user, "extent", field="voie", value=VOIE).json()
    assert len(data) == 1
    geometry = json.loads(data[0]["geom"])
    assert geometry["type"] == "Polygon"


def test_parcelles_voie(user: requests.Session):
    """The list of parcelles of a voie, filled by jForms, contains the parcelles of the voie"""
    page = user.get(
        f"{BASE_URL}/index.php/view/map",
        params={"repository": PROJECT["repository"], "project": PROJECT["project"]},
    ).text
    # Hidden fields of the search form, criteria of the list of parcelles
    layer_id = re.search(r'id="jforms_cadastre_search_parcelleLayerId"[^>]*value="([^"]*)"', page)
    assert layer_id, "No layer of the parcelles in the search form"
    response = user.post(
        f"{BASE_URL}/index.php/jelix/forms/getdata",
        data={
            "__form": "cadastre~search",
            "__formid": "0",
            "__JFORMS_TOKEN__": "",
            "__ref": "geo_parcelle_lieu",
            "repository": PROJECT["repository"],
            "project": PROJECT["project"],
            "parcelleLayerId": layer_id.group(1),
            "section": "",
            "voie": VOIE,
        },
        # jForms only answers to the requests of its JavaScript
        headers={"X-Requested-With": "XMLHttpRequest"},
    )
    values = [item["value"] for item in response.json()]
    assert COPROPRIETE in values


def test_wfs_layers(user: requests.Session):
    """The layers used by the search panel are published in WFS, like the documentation asks:
    the zoom on a commune, a section or a parcelle uses a WFS request"""
    capabilities = user.get(
        f"{BASE_URL}/index.php/lizmap/service",
        params={**PROJECT, "SERVICE": "WFS", "VERSION": "1.0.0", "REQUEST": "GetCapabilities"},
    ).text
    names = re.findall(r"<Name>([^<]+)</Name>", capabilities)
    for layer in ("communes", "parcelles", "sections"):
        assert layer in names


def test_owners_not_published(user: requests.Session):
    """The owners of the parcelles are not published by QGIS Server: only the module gives them, with its rights"""
    params = {**PROJECT, "SERVICE": "WFS", "VERSION": "1.0.0"}
    description = user.get(
        f"{BASE_URL}/index.php/lizmap/service",
        params={**params, "REQUEST": "DescribeFeatureType", "TYPENAME": PROJECT["layer"]},
    ).text
    assert 'name="geo_parcelle"' in description
    assert "proprietaire" not in description

    features = user.get(
        f"{BASE_URL}/index.php/lizmap/service",
        params={**params, "REQUEST": "GetFeature", "TYPENAME": PROJECT["layer"], "OUTPUTFORMAT": "GeoJSON",
                "MAXFEATURES": "1"},
    ).json()["features"]
    assert features and "proprietaire" not in features[0]["properties"]
