import func
import pytest

@pytest.mark.parametrize(
 ('input', 'output'),
 [
     ('abcdaabc', 'abcd'),
     ('abcdaaedv', 'abcd')
 ]       
)
def test(input, output):
    assert func.longest_str(input) == output
    