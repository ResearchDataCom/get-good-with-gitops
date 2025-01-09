import os

import pytest
from _pytest.assertion import truncate

# Increase the long string truncation limit when running pytest in
# verbose mode; cf. https://stackoverflow.com/a/60321834.
truncate.DEFAULT_MAX_LINES = 999999
truncate.DEFAULT_MAX_CHARS = 999999


@pytest.fixture
def _aws_credentials():
    """Avoid mutating real AWS infrastructure."""
    os.environ["AWS_ACCESS_KEY_ID"] = "testing"
    os.environ["AWS_DEFAULT_REGION"] = "antarctica"
    os.environ["AWS_SECRET_ACCESS_KEY"] = "testing"
    os.environ["AWS_SECURITY_TOKEN"] = "testing"
    os.environ["AWS_SESSION_TOKEN"] = "testing"
    os.environ["MOTO_ALLOW_NONEXISTENT_REGION"] = "True"
