actual = ifelse(rand(100) .> .50, 1, 0)
yhat = rand(100)
predicted = ifelse(yhat .> .50, 1, 0)

# +++ Utilities
@test classify(.4) == 0
@test classify(.33, .25) == 1

# +++ Types
stats = ClassificationStatistics(actual, predicted)
confmat = ConfusionMatrix(actual, predicted)
@test typeof(stats) <: ClassificationStatistics
@test typeof(confmat) <: ConfusionMatrix

# +++ Counts
@test true_positives(actual, predicted) == tp(actual, predicted)
@test false_positives(actual, predicted) == fp(actual, predicted)
@test true_negatives(actual, predicted) == tn(actual, predicted)
@test false_negatives(actual, predicted) == fn(actual, predicted)

# +++ ROC Curve
@test length(roccurve(actual, yhat)[1]) == 100
@test length(roccurve(actual, yhat, increment=.001)) == 1000
@test roccurve(actual, yhat)[1][50] == fpr(actual, predicted)
@test roccurve(actual, yhat, charX=f1score)[1][1] == f1score(actual, classify(yhat, 0.))
@test roccurve(actual, yhat, charY=f1score)[2][100] == f1score(actual, classify(yhat, 1.))
@test length(roccurve(actual, yhat, charX=accuracy, charY=f1score)[1]) == 100
@test_throws MethodError roccurve(actual, yhat, charX=accuracy())


# +++ Evaluation functions

# Classification Accuracy
@test typeof(accuracy(actual, predicted)) <: Real

# Classification Error
@test typeof(classification_error(actual, predicted)) <: Real

# F1 Score
@test typeof(f1score(actual, predicted)) <: Real
@test f1score(actual, predicted) == f1score(ppv=stats.ppv, tpr=stats.sensitivity)
@test_throws MethodError f1score(ppv=stats.ppv)

# False Discovery Rate
@test typeof(false_discovery_rate(actual, predicted)) <: Real
@test false_discovery_rate(actual, predicted) == false_discovery_rate(fp=stats.fp, tp=stats.tp)
@test false_discovery_rate(actual, predicted) == fdr(actual, predicted)
@test_throws MethodError false_discovery_rate(fp=stats.fp)

# False Negative Rate

# False Positive Rate

# Informedness

# Markedness

# Matthew's Correlation Coefficient

# Negative Predictive Value

# Positive Predictive Value
@test precision(actual, predicted) == positive_predictive_value(actual, predicted)
@test ppv(actual, predicted) == positive_predictive_value(actual, predicted)
@test_throws MethodError positive_predictive_value(tp=10)
@test_throws MethodError ppv(actual, predicted, tp=10)

# True Negative Rate

# True Positive Rate

# Positive Predictive Value

# Negative Predictive Value
