"""Map page of a cadastre project: configuration of the module and search dock, added by the listeners"""

import json
import re

import pytest
import requests

from conftest import BASE_URL, PROJECT


def map_page(session: requests.Session) -> str:
    """HTML of the map page of the test project"""
    response = session.get(
        f"{BASE_URL}/index.php/view/map",
        params={"repository": PROJECT["repository"], "project": PROJECT["project"]},
        allow_redirects=False,
    )
    # Lizmap redirects to the home page when the map cannot be displayed
    assert response.status_code == 200, response.headers.get("Location")
    return response.text


def cadastre_config(html: str) -> dict:
    """Configuration of the module given to the JavaScript, see cadastre.listener.php"""
    match = re.search(r"var cadastreConfig = (\{.*?\})\s*;?\s*[<\n]", html)
    assert match, "No configuration of the module in the map page"
    return json.loads(match.group(1))


# Rights given to the JavaScript, see cadastreRights::forJavaScript()
RIGHTS = [
    "owners", "birth", "revenue", "exoneration", "releveParcellaire", "relevePropriete", "popupTabs", "exportSensitive",
]


@pytest.mark.parametrize(
    "session, rights",
    [
        ("anonymous", []),
        ("user", ["owners"]),
        ("agent", ["owners", "birth", "releveParcellaire", "popupTabs", "exportSensitive"]),
        ("admin", RIGHTS),
    ],
)
def test_map(request: pytest.FixtureRequest, session: str, rights: list[str]):
    """The search tool is given to everybody, the owners to users, all the rights to admin"""
    html = map_page(request.getfixturevalue(session))
    config = cadastre_config(html)
    assert config["layer"] == PROJECT["layer"]
    assert config["pk"] == "geo_parcelle"
    assert config["rights"] == {name: name in rights for name in RIGHTS}
    # Search dock, see cadastreDockable.listener.php
    assert "jforms_cadastre_search" in html
    # The box "Exporter pour un tiers", unchecked and enabled, only with a right on the sensitive data
    box = re.search(r'<input type="checkbox" id="cadastre-export-tiers"([^>]*)>', html)
    assert (box is not None) is ("exportSensitive" in rights)
    if box:
        assert "checked" not in box.group(1) and "disabled" not in box.group(1)
