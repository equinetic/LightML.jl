
module LightML


#using Gadfly
using Plots
using DataFrames
using ForwardDiff
using Distributions
using PyCall
using PyPlot
using DataStructures
using Distances
using Clustering



@pyimport sklearn.datasets as dat



export

    test_LinearRegression,
    test_LogisticRegression,

    test_ClassificationTree,
    test_RegressionTree,

    test_GDA,
    test_HMM,

    test_kneast_regression,
    test_kneast_classification,


    test_label_propagation,

    test_LDA,
    test_LDA_reduction,

    test_naive,

    test_NeuralNetwork,

    test_svm,

    test_GaussianMixture,

    test_kmeans_random,
    test_kmeans_speed,

    test_PCA,

    test_spec_cluster,

    test_Adaboost,
    test_BoostingTree,
    test_randomForest,

    make_cla,
    make_reg,
    make_digits,
    make_blo,
    make_iris,

    train!,
    predict,

    # src/supervised_learning
    RegressionTree,
    ClassificationTree,
    randomForest,
    Adaboost,
    LinearRegression,
    LogisticRegression,
    GDA,
    BoostingTree,
    KnnRegression,
    KnnClassifier,
    label_propagation,
    show_example,
    LDA,
    plot_in_2d,
    NaiveBayes,
    NeuralNetwork,
    svm,

    # src/unsupervised_learning
    GaussianMixture,
    Kmeans,
    PCA,
    transform,
    spec_clustering,

    # src/utils/scaling.jl
    FeatureScaler,
      StandardizeScaler,
        standardize,
      RescaleScaler,
        rescale,
      UnitLengthScaler,
        unitlength,

    # src/utils/classification_eval.jl
    ## Types
    ClassificationStatistics,
    ConfusionMatrix,

    ## Classification Counts
    true_positives,
        tp,
    false_positives,
        fp,
    true_negatives,
        tn,
    false_negatives,
        fn,

    ## ROC Curve
    ROCCurve,
    roc,

    ## Classification Evaluation
    accuracy,
    classification_error,
    f1score,
    false_discovery_rate,
        fdr,
    false_negative_rate,
        fnr,
    false_positive_rate,
        fallout,
        fpr,
    informedness,
    markedness,
    matthews_corrcoef,
        mcc,
    negative_predictive_value,
        npv,
    positive_predictive_value,
        ppv,
        precision,
    true_negative_rate,
        spc,
        specificity,
        tnr,
    true_positive_rate,
        recall,
        sensitivity,
        tpr,

#typealias Features Union{String, Real}


#Supervised_learning

include("supervised_learning/baseRegression.jl")
include("supervised_learning/decisionTree.jl")
include("supervised_learning/gaussianDiscriminantAnalysis.jl")
include("supervised_learning/hiddenMarkovModel.jl")
include("supervised_learning/kNearestNeighbors.jl")
include("supervised_learning/labelPropagation.jl")
include("supervised_learning/linearDiscriminantAnalysis.jl")
include("supervised_learning/naivdBayes.jl")
include("supervised_learning/neuralNetwork_bp.jl")
include("supervised_learning/support_vector_machine.jl")
include("supervised_learning/adaboost.jl")
include("supervised_learning/randomForests.jl")
include("supervised_learning/xgboost.jl")
include("supervised_learning/GradientBoostingTree.jl")


#Unsupervised_learning

include("unsupervised_learning/gaussianMixtureModel.jl")
include("unsupervised_learning/kMeans.jl")
include("unsupervised_learning/principalComponentAnalysis.jl")
include("unsupervised_learning/spectralCluster.jl")
include("unsupervised_learning/largeScaleSpectralClustering.jl")

#Utils
include("utils/classification_eval.jl")
include("utils/demo.jl")
include("utils/eval.jl")
include("utils/partitioning.jl")
include("utils/scaling.jl")
include("utils/utils.jl")




end
