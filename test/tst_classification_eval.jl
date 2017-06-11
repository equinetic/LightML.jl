actual = [0, 1, 1, 0, 1, 0, 1]
yhat = [.55, .5, .80, .13, .51, .99, .65]
predicted = [1, 0, 1, 0, 1, 1, 1]

# +++ Utilities
@test classify(.4) == 0
@test classify(.33, .25) == 1
@test classify.(yhat) == predicted

# +++ Types
stats = ClassificationStatistics(actual, predicted)
confmat = ConfusionMatrix(actual, predicted)
@test typeof(stats) <: ClassificationStatistics
@test typeof(confmat) <: ConfusionMatrix
@test confmat.tp == 3
@test confmat.fp == 2
@test confmat.tn == 1
@test confmat.fn == 1
print(confmat)

# +++ Counts
@test true_positives(actual, predicted) == tp(actual, predicted)
@test false_positives(actual, predicted) == fp(actual, predicted)
@test true_negatives(actual, predicted) == tn(actual, predicted)
@test false_negatives(actual, predicted) == fn(actual, predicted)

# +++ ROC Curve
@test length(roc(actual, yhat)[1]) == 101
@test length(roc(actual, yhat, increment=.001)[1]) == 1001
@test roc(actual, yhat)[1][51] == fpr(actual, predicted)
@test roc(actual, yhat, charX=f1score)[1][1] == f1score(actual, classify(yhat, 0.))
#@test roc(actual, yhat, charY=f1score)[2][101] == f1score(actual, classify(yhat, 1.))
#@test length(roc(actual, yhat, charX=accuracy, charY=f1score)[1]) == 100
# - figure out Inf and NaN cases before implementing above tests
@test_throws MethodError roc(actual, yhat, charX=accuracy())


# +++ Evaluation functions
#=
Eval functions with integer keyword arguments will
throw method errors when all kwargs have not been
provided. Functions with float kwargs will produce
NaNs.
=#

# Classification Accuracy
@test typeof(accuracy(actual, predicted)) <: Real

# Classification Error
@test typeof(classification_error(actual, predicted)) <: Real

# F1 Score
@test typeof(f1score(actual, predicted)) <: Real
@test f1score(actual, predicted) == f1score(ppv=stats.ppv, tpr=stats.sensitivity)
@test isnan(f1score(ppv=stats.ppv))

# False Discovery Rate
@test typeof(false_discovery_rate(actual, predicted)) <: Real
@test false_discovery_rate(actual, predicted) == false_discovery_rate(fp=stats.fp, tp=stats.tp)
@test false_discovery_rate(actual, predicted) == fdr(actual, predicted)
@test_throws MethodError false_discovery_rate(fp=stats.fp)
@test_throws MethodError false_discovery_rate(actual, predicted, fp=stats.fp)

# False Negative Rate
@test typeof(false_negative_rate(actual, predicted)) <: Real
@test false_negative_rate(actual, predicted) == false_negative_rate(fn=stats.fn, tp=stats.tp)
@test false_negative_rate(actual, predicted) == fnr(actual, predicted)
@test_throws MethodError false_negative_rate(fn=stats.fn)
@test_throws MethodError false_negative_rate(actual, predicted, fn=stats.fn)

# False Positive Rate
@test typeof(false_positive_rate(actual, predicted)) <: Real
@test false_positive_rate(actual, predicted) == false_positive_rate(fp=stats.fp, tn=stats.tn)
@test false_positive_rate(actual, predicted) == fpr(actual, predicted)
@test_throws MethodError false_positive_rate(fp=stats.fp)
@test_throws MethodError false_positive_rate(actual, predicted, fp=stats.fp)

# Informedness
@test typeof(informedness(actual, predicted)) <: Real
@test informedness(actual, predicted) == informedness(tpr=stats.tpr, spc=stats.specificity)
@test isnan(informedness(tpr=stats.tpr))
@test_throws MethodError informedness(actual, predicted, fp=stats.fp)

# Markedness
@test typeof(markedness(actual, predicted)) <: Real
@test markedness(actual, predicted) == markedness(ppv=stats.ppv, npv=stats.npv)
@test isnan(markedness(ppv=stats.ppv))
@test_throws MethodError markedness(actual, predicted, ppv=stats.ppv)

# Matthew's Correlation Coefficient
@test typeof(matthews_corrcoef(actual, predicted)) <: Real
@test matthews_corrcoef(actual, predicted) == matthews_corrcoef(tp=stats.tp,tn=stats.tn,fp=stats.fp,fn=stats.fn)
@test matthews_corrcoef(actual, predicted) == mcc(actual, predicted)
@test_throws MethodError matthews_corrcoef(tp=stats.tp)
@test_throws MethodError matthews_corrcoef(actual, predicted, tp=stats.tp)

# Negative Predictive Value
@test typeof(negative_predictive_value(actual, predicted)) <: Real
@test negative_predictive_value(actual, predicted) == npv(actual, predicted)
@test npv(actual, predicted) == npv(tn=stats.tn,fn=stats.fn)
@test_throws MethodError npv(tn=stats.tn)
@test_throws MethodError npv(actual, predicted, tn=stats.tn)

# Positive Predictive Value
@test precision(actual, predicted) == positive_predictive_value(actual, predicted)
@test ppv(actual, predicted) == positive_predictive_value(actual, predicted)
@test ppv(actual, predicted) == precision(actual, predicted)
@test ppv(actual, predicted) == ppv(tp=stats.tp, fp=stats.fp)
@test_throws MethodError positive_predictive_value(tp=stats.tp)
@test_throws MethodError ppv(actual, predicted, tp=stats.tp)

# True Negative Rate
@test true_negative_rate(actual, predicted) == tnr(actual, predicted)
@test tnr(actual, predicted) == spc(actual, predicted)
@test tnr(actual, predicted) == specificity(actual, predicted)
@test tnr(actual, predicted) == tnr(tn=stats.tn, fp=stats.fp)
@test_throws MethodError tnr(tp=stats.tp)
@test_throws MethodError tnr(actual, predicted, tn=stats.tn)

# True Positive Rate
@test true_positive_rate(actual, predicted) == tpr(actual, predicted)
@test tpr(actual, predicted) == recall(actual, predicted)
@test tpr(actual, predicted) == sensitivity(actual, predicted)
@test tpr(actual, predicted) == tpr(tp=stats.tp, fn=stats.fn)
@test_throws MethodError tpr(tp=stats.tp)
@test_throws MethodError tpr(actual, predicted, tp=stats.tp)
