"""CSV exports of the parcelles, locaux and owners: rights, content, and SQL injections"""

import csv
import io
import json

import pytest
import requests

from conftest import BASE_URL, BATI, COPROPRIETE, PARCELLE, PROJECT

# Payloads trying to get the rows of all the parcelles, in the list of the parcelles
INJECTIONS = [
    f"{COPROPRIETE}') OR ('1'='1",
    f"{COPROPRIETE}' OR TRUE OR p.parcelle IN ('",
    f"{COPROPRIETE}') OR TRUE --",
]


def export(session: requests.Session, name: str, parcelles: list[str], **params) -> requests.Response:
    """Call an export of the module: locauxProprios or parcellesProprios"""
    return session.get(
        f"{BASE_URL}/index.php/cadastre/service/{name}",
        params={**PROJECT, "parcelles": ",".join(parcelles), **params},
    )


def rows(response: requests.Response) -> list[dict[str, str]]:
    """Rows of a CSV export"""
    assert response.status_code == 200
    assert response.headers["Content-Type"].startswith("text/csv"), response.text[:500]
    return list(csv.DictReader(io.StringIO(response.text)))


@pytest.mark.parametrize("name", ["locauxProprios", "parcellesProprios"])
def test_anonymous(anonymous: requests.Session, name: str):
    """Without rights on the owners, the export is refused"""
    response = export(anonymous, name, [COPROPRIETE])
    assert response.json()["status"] == "error"


def test_locaux(user: requests.Session, admin: requests.Session):
    """One row per local and per owner, the birth data are only given with the full rights"""
    result = rows(export(user, "locauxProprios", [COPROPRIETE, PARCELLE]))
    assert {row["parcelle"] for row in result} == {COPROPRIETE, PARCELLE}
    assert len({row["l_invariant"] for row in result}) == 7
    assert "p_date_naissance" not in result[0]

    # The parameter advanced is ignored without the full rights
    assert "p_date_naissance" not in rows(export(user, "locauxProprios", [COPROPRIETE], advanced="1"))[0]
    assert "p_date_naissance" in rows(export(admin, "locauxProprios", [COPROPRIETE], advanced="1"))[0]
    assert "p_date_naissance" not in rows(export(admin, "locauxProprios", [COPROPRIETE]))[0]


def test_parcelles(user: requests.Session, admin: requests.Session):
    """One row per owner, with the list of its parcelles"""
    result = rows(export(user, "parcellesProprios", [COPROPRIETE, PARCELLE]))
    assert result
    parcelles = {p for row in result for p in row["parcelles"].split(", ")}
    assert parcelles == {COPROPRIETE, PARCELLE}
    assert "date_naissance" not in result[0]
    assert "date_naissance" in rows(export(admin, "parcellesProprios", [COPROPRIETE], advanced="1"))[0]


@pytest.mark.parametrize("name", ["locauxProprios", "parcellesProprios"])
@pytest.mark.parametrize("payload", [*INJECTIONS, "", "1320290000a0107"])
def test_invalid_parcelles(user: requests.Session, name: str, payload: str):
    """Invalid identifiers of parcelles are refused: they cannot change the SQL query"""
    response = export(user, name, [payload])
    assert response.json() == {"status": "error", "message": "Identifiants de parcelles absents ou invalides."}


def spatial_search(selected_ids: str) -> dict[str, str]:
    """Parameter of the export of the owners, with the objects selected in the spatial search"""
    return {
        "additionalData": json.dumps({
            "spatial_layer_id": BATI,
            "spatial_layer_field": "ogc_fid",
            "spatial_layer_buffer": "50",
            "spatial_layer_selected_ids": selected_ids,
        })
    }


def test_parcelles_spatial_search(user: requests.Session):
    """The codes of the selected objects near the parcelles are added to the owners"""
    result = rows(export(user, "parcellesProprios", [COPROPRIETE, PARCELLE], **spatial_search("1,2,3")))
    assert "code_objet" in result[0]
    assert {c for row in result for c in row["code_objet"].split(", ") if c} <= {"1", "2", "3"}


@pytest.mark.parametrize("payload", ["1' OR '1'='1", "1) OR (1=1", "1;DROP TABLE x"])
def test_parcelles_spatial_search_injection(user: requests.Session, payload: str):
    """Invalid identifiers of selected objects are refused: they cannot change the SQL query"""
    response = export(user, "parcellesProprios", [COPROPRIETE], **spatial_search(payload))
    assert response.json() == {"status": "error", "message": "Identifiants des objets sélectionnés invalides."}
