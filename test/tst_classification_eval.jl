actual = ifelse(rand(100) .> .50, 1, 0)
yhat = rand(100)
predicted = ifelse(yhat .> .50, 1, 0)

@test classify(.4) == 0
@test classify(.33, .25) == 1

stats = ClassificationStatistics(actual, predicted)
confmat = ConfusionMatrix(actual, predicted)


@test typeof(stats) <: ClassificationStatistics
@test typeof(confmat) <: ConfusionMatrix

# Positive Predictive Value
@test precision(actual, predicted) == positive_predictive_value(actual, predicted)
@test ppv(actual, predicted) == positive_predictive_value(actual, predicted)
@test_throws MethodError positive_predictive_value(tp=10)
@test_throws MethodError ppv(actual, predicted, tp=10)

# Negative Predictive Value

# Sensitivity

# Specificity
