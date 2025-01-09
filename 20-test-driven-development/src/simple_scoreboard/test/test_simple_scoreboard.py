import re

from simple_scoreboard import lambda_handler


def test_html_form():
    response = lambda_handler({}, {})
    assert re.search("(?i)<form[ >]", response["body"])
