import pytest

@pytest.fixture
def some_data():
    return 'data'

def test_validate_json(some_data):
    assert(some_data == 'data')

