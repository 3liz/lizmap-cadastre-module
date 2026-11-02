"""Tests of the module on the docker stack, with the fictitious test data: see tests/README.md.

The stack must be running, with the module installed, the test data imported (make import-test-data)
and the rights set (make import-lizmap-acl).
"""

import os
import re

import pytest
import requests

# URL of Lizmap, see LIZMAP_PORT in the Makefile
BASE_URL = os.getenv("LIZMAP_URL", "http://127.0.0.1:9085")

# Project created by make import-test-data
PROJECT = {"repository": "tests", "project": "cadastre_tests", "layer": "parcelles"}

# Parcelles of the fictitious data: a copropriété with several locaux, and a parcelle with 2 locaux
COPROPRIETE = "1320290000A0107"
PARCELLE = "1320290000A1088"

# Layer of the buildings, used for the spatial search
BATI = "Bâti_4f3b3b17_efa5_46ca_8995_479baca18fe7"


def login(session: requests.Session, user: str):
    """Authenticate in Lizmap, the password of the test users is their login"""
    form = session.get(f"{BASE_URL}/admin.php/auth/login")
    form.raise_for_status()
    token = re.search(r'name="__JFORMS_TOKEN__" value="([^"]+)"', form.text)
    assert token, "No token in the login form"
    response = session.post(
        f"{BASE_URL}/admin.php/auth/login/in",
        data={"__JFORMS_TOKEN__": token.group(1), "auth_login": user, "auth_password": user},
    )
    response.raise_for_status()
    # The logout link is only displayed to an authenticated user
    assert "auth/login/out" in session.get(f"{BASE_URL}/index.php").text, f"Login failed for {user}"


@pytest.fixture(scope="session")
def anonymous() -> requests.Session:
    """Session without authentication: search tool only"""
    return requests.Session()


@pytest.fixture(scope="session")
def user() -> requests.Session:
    """The user cadastre, in the group users: owners data without birth data"""
    session = requests.Session()
    login(session, "cadastre")
    return session


@pytest.fixture(scope="session")
def admin() -> requests.Session:
    """The user admin: all the owners data"""
    session = requests.Session()
    login(session, "admin")
    return session
