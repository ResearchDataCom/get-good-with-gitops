import re

import pytest
from moto import mock_aws


@pytest.mark.usefixtures("_mock_scoreboard")
@mock_aws
def test_html_form(socket_disabled):
    from simple_scoreboard import lambda_handler

    response = lambda_handler({}, {})
    assert re.search("(?i)<form[ >]", response["body"])
