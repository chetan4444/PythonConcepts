import math_module
import pytest


@pytest.mark.parametrize(
        ('input', 'output'),
[
    ((2, 5), 7),
    ((-1, 1), 0)
]
)
def test_add(input, output):
    assert math_module.add(*input) == output

@pytest.mark.parametrize(
        ('input', 'output'),
        [
            ((10, 2),5),
            ((15, 3), 5)
        ]
)
def test_division(input, output):
    assert math_module.division(*input) == output

# def test_division_by_zero():
#     try:
#         assert math_module.division(10, 0)
#     except ZeroDivisionError:
#         assert True
#     else:
#         assert False

@pytest.mark.parametrize(
        ('a', 'b'),
          [
              (10, 0),
                (5, 0),
                (0,0)
              ]
                         )
def test_division_by_zero_1(a, b):
    with pytest.raises(ZeroDivisionError):
        math_module.division(a, b)
