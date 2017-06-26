
module LightML


using   Plots,
        DataFrames,
        ForwardDiff,    # Remove this
        Distributions,
        PyCall,         # Remove this
        DataStructures,
        Distances,
        Clustering,

@pyimport sklearn.datasets as dat   # Remove this
pyplot()


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

    # Demos
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


# Include components
include(joinpath("data", "data.jl"))
include(joinpath("model_evaluation", "model_evaluation.jl"))
include(joinpath("objective_functions", "objective_functions.jl"))
include(joinpath("solvers", "solvers.jl"))
include(joinpath("supervised_learning", "supervised_learning.jl"))
include(joinpath("unsupervised_learning", "unsupervised_learning.jl"))
include(joinpath("utils", "utils.jl"))

end
