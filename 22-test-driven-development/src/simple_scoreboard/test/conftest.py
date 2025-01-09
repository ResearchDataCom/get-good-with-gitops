import os
from random import randint

import boto3
import pytest
from _pytest.assertion import truncate
from moto import mock_aws

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


@pytest.fixture
def dynamodb(_aws_credentials):
    """Mock up a DynamoDB client."""
    with mock_aws():
        yield boto3.resource("dynamodb")


@pytest.fixture
def _mock_scoreboard(dynamodb):
    """Mock up a DynamoDB table and some data."""

    # Create the scoreboard.
    # https://boto3.amazonaws.com/v1/documentation/api/latest/guide/dynamodb.html
    # https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/dynamodb/service-resource/create_table.html
    table = dynamodb.create_table(
        TableName="simple-scoreboard",
        BillingMode="PAY_PER_REQUEST",
        KeySchema=[{"AttributeName": "name", "KeyType": "HASH"}],
        AttributeDefinitions=[{"AttributeName": "name", "AttributeType": "S"}],
    )

    # Generate some data for the scoreboard.
    # https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/dynamodb/table/put_item.html
    names = [
        "Alice",
        "Bill",
        "Eve",
        "Mallory",
    ]
    for name in names:
        table.put_item(Item={"name": name, "score": randint(0, 100)})
