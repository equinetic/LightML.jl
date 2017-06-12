
module LightML


using Plots; pyplot()
using DataFrames
using ForwardDiff
using Distributions
using PyCall
using DataStructures
using Distances
using Clustering



@pyimport sklearn.datasets as dat



export
    # Data Generation
    make_cla,
    make_reg,
    make_digits,
    make_blo,
    make_iris,

    # Shared API
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
    # > Types
    ClassificationStatistics,
    ConfusionMatrix,
    ROCCurve,
        roc,

    # > Classification Counts
    true_positives,
        tp,
    false_positives,
        fp,
    true_negatives,
        tn,
    false_negatives,
        fn,

    # > Classification Evaluation
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

    # Education Functions
    demo_LinearRegression,
    demo_LogisticRegression,
    demo_ClassificationTree,
    demo_RegressionTree,
    demo_GDA,
    demo_HMM,
    demo_kneast_regression,
    demo_kneast_classification,
    demo_label_propagation,
    demo_LDA,
    demo_LDA_reduction,
    demo_naive,
    demo_NeuralNetwork,
    demo_svm,
    demo_GaussianMixture,
    demo_kmeans_random,
    demo_kmeans_speed,
    demo_PCA,
    demo_spec_cluster,
    demo_Adaboost,
    demo_BoostingTree,
    demo_randomForest


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
include("utils/plot_utils.jl")
include("utils/scaling.jl")
include("utils/utils.jl")




end
