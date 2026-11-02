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


@pytest.mark.parametrize("session, advanced", [("anonymous", False), ("user", False), ("admin", True)])
def test_map(request: pytest.FixtureRequest, session: str, advanced: bool):
    """The search tool is given to everybody, the full owners data only to admin"""
    html = map_page(request.getfixturevalue(session))
    config = cadastre_config(html)
    assert config["layer"] == PROJECT["layer"]
    assert config["pk"] == "geo_parcelle"
    assert config["advanced"] is advanced
    # Search dock, see cadastreDockable.listener.php
    assert "jforms_cadastre_search" in html
