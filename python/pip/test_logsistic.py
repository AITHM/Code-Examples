from logistic_regression import run_logistic_regression_iris
def test_logistic_reg():
    assert run_logistic_regression_iris() > 0.5

