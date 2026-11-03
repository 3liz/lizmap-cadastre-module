"""CSV exports of the parcelles, locaux and owners: rights, content, and SQL injections"""

import csv
import io
import json

import pytest
import requests

from conftest import BASE_URL, BATI, COPROPRIETE, PARCELLE, PROJECT

# Columns of the exports, the same with the QGIS plugin (request GetExport) or with the SQL of the module
LOCAUX_COLUMNS = [
    "parcelle", "l_batiment", "l_numero_entree", "l_niveau_etage", "l_numero_local", "l_invariant",
    "l_identifiant", "l_numero_voirie", "l_adresse", "l10_compte_proprietaire", "l10_type_local",
    "l10_type_local_lib", "l10_nature_local", "l10_nature_local_lib", "l10_nature_construction_particuliere",
    "l10_nature_construction_particuliere_lib", "l10_annee_construction", "l10_nombre_niveaux",
    "l10_nature_occupation", "l10_nature_occupation_lib", "p_ordre", "p_numero", "p_nom", "p_adresse",
    "p_date_naissance", "p_lieu_naissance", "p_code_droit", "p_code_droit_lib", "p_code_demembrement",
    "p_code_demembrement_lib",
]
PARCELLES_COLUMNS = [
    "commune", "code_proprietaire", "qualite", "nom", "prenom", "denomination", "adresse",
    "complement_adresse", "code_postal", "ville", "adresse_complete", "date_naissance", "lieu_naissance",
    "parcelles",
]

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


def masked(result: list[dict[str, str]], prefix: str = "") -> bool:
    """True if the birth data of all the rows are masked, like in the fiche parcellaire"""
    return all(
        (row[f"{prefix}date_naissance"], row[f"{prefix}lieu_naissance"]) == ("XX/XX/XXXX", "XXX") for row in result
    )


def test_locaux(user: requests.Session, admin: requests.Session):
    """One row per local and per owner, the birth data are masked for a third party, the default"""
    result = rows(export(user, "locauxProprios", [COPROPRIETE, PARCELLE]))
    assert list(result[0]) == LOCAUX_COLUMNS
    assert {row["parcelle"] for row in result} == {COPROPRIETE, PARCELLE}
    assert len({row["l_invariant"] for row in result}) == 7
    assert masked(result, "p_")

    # Without right on the sensitive data, the export is always the one for a third party
    assert masked(rows(export(user, "locauxProprios", [COPROPRIETE], tiers="0")), "p_")
    result = rows(export(admin, "locauxProprios", [COPROPRIETE], tiers="0"))
    assert list(result[0]) == LOCAUX_COLUMNS
    assert not any(row["p_date_naissance"] == "XX/XX/XXXX" for row in result)
    assert masked(rows(export(admin, "locauxProprios", [COPROPRIETE])), "p_")


def test_export_partial_rights(agent: requests.Session, admin: requests.Session):
    """With one right on the sensitive data, its data are exported, unless the export is for a third party"""
    result = rows(export(agent, "locauxProprios", [COPROPRIETE], tiers="0"))
    assert not any(row["p_date_naissance"] == "XX/XX/XXXX" for row in result)
    assert masked(rows(export(agent, "locauxProprios", [COPROPRIETE], tiers="1")), "p_")
    assert masked(rows(export(admin, "locauxProprios", [COPROPRIETE], tiers="1")), "p_")


def test_parcelles(user: requests.Session, admin: requests.Session):
    """One row per owner, with the list of its parcelles"""
    result = rows(export(user, "parcellesProprios", [COPROPRIETE, PARCELLE]))
    assert result
    assert list(result[0]) == PARCELLES_COLUMNS
    parcelles = {p for row in result for p in row["parcelles"].split(", ")}
    assert parcelles == {COPROPRIETE, PARCELLE}
    assert masked(result)
    result = rows(export(admin, "parcellesProprios", [COPROPRIETE], tiers="0"))
    assert not any(row["date_naissance"] == "XX/XX/XXXX" for row in result)


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


# Maximum number of parcelles of an export, see cadastreExtraInfos::MAX_EXPORT_PARCELLES
MAX_EXPORT_PARCELLES = 20000


@pytest.mark.parametrize("name", ["locauxProprios", "parcellesProprios"])
def test_max_parcelles(user: requests.Session, name: str):
    """Too big exports are refused, the list of the parcelles is sent with POST like the JavaScript does"""
    parcelles = [COPROPRIETE] + [f"1320290000Z{i:04d}" for i in range(MAX_EXPORT_PARCELLES)]
    response = user.post(
        f"{BASE_URL}/index.php/cadastre/service/{name}", data={**PROJECT, "parcelles": ",".join(parcelles)}
    )
    assert response.json() == {
        "status": "error", "message": f"L'export est limité à {MAX_EXPORT_PARCELLES} parcelles."
    }

    # At the limit, the export is done: only the existing parcelles are exported
    response = user.post(
        f"{BASE_URL}/index.php/cadastre/service/{name}",
        data={**PROJECT, "parcelles": ",".join(parcelles[:MAX_EXPORT_PARCELLES])},
    )
    assert rows(response)
