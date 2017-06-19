# LightML.jl


[![Build Status](https://travis-ci.org/memoiry/LightML.jl.svg?branch=master)](https://travis-ci.org/memoiry/LightML.jl)

### Equinetic Branch

LightML can fulfill a longer term need in the Julia and data science community. A "light" machine learning package is suitable for many applications - not everyone needs a super optimized package for working with big data.

In short, I believe LightML should fulfill the following two needs:
1. Providing a robust suite of standard algorithms and functionality for predictive modeling and data processing.
2. Packing the above in structured, readable, and well-documented code to aide (human) learners.

#### Initial Release / Pull Request
* Restructure sections of code base for purposes of extending current capabilities and to make the algorithms more modular.
* Eliminate unnecessary dependencies to keep LightML light. Most of these needs had already been identified by memoiry - PyCall, ForwardDiff, etc.
* Expand the "utilities" section:
    * Feature scaling
    * Binning
    * Plot recipes
* Expand model evaluation:
    * Classification - ROC curves, confusion matrices, every specificity/sensitivity/true-positive-rate type of metric you can think of
    * Similar build out for non classification models
    * Learning curves
* Modularize learning algorithms
    * Parameterized loss (& gradient) function with native implementations
    * Parameterized solver method - again with native implementations

#### Long Term Discussion
The work of the JuliaML organization seems to be a sensible direction for the Julia community. With breadth as the overarching goal of this branch I believe LightML can be included by both a reexport of the utilities and potentially as a backend, if that's the direction they take.

```julia
using Learn
lightml()
```

#### Notes

[TODO](./todo.md)

[New Module Strucutre](./STRUCTURE.md)

[Change Log](./changelog.md)

---

### About
LightML.jl is a collection of reimplementation of general machine learning algorithm in Julia.

The purpose of this project is purely self-educational.

### Why?

This project is targeting people who want to learn internals of ml algorithms or implement them from scratch.

The code is much easier to follow than the optimized libraries and easier to play with.

All algorithms are implemented in Julia.

You should access test function of every implementation for its usage in detail. Every model is actually constructed in a similar manner.

### Installation

```julia
Pkg.clone("https://github.com/memoiry/LightML.jl")
```


### Running Implementations

```julia
using LightML
test_LSC()
```



<p align="center">
    <img src="https://ooo.0o0.ooo/2017/03/25/58d640c2c7a1a.png" width="640">
</p>
<p align="center" style="color:rgb(220,220,220);">
    Figure 1: Smiley, spirals, shapes and cassini Datasets using LSC(large scale spectral clustering)
</p>


### Running Demo

```julia
using LightML
demo()
```

<p align="center">
<img src="https://ooo.0o0.ooo//2017//03//15//58c8cb6e1a1d3.png" width="640"></img>
</p>
<p align="center" style="color:rgb(220,220,220);">
    Figure 2: The Digit Dataset using Demo algorithms
</p>


## Current Implementations

#### Supervised Learning:
- [Adaboost](src/supervised_learning/adaboost.jl)
- [Decision Tree](src/supervised_learning/decisionTree.jl)
- [Gradient Boosting](src/supervised_learning/GradientBoostingTree.jl)
- [Gaussian Discriminant Analysis](src/supervised_learning/gaussianDiscriminantAnalysis.jl)
- [K Nearest Neighbors](src/supervised_learning/kNearestNeighbors.jl)
- [Linear Discriminant Analysis](src/supervised_learning/linearDiscriminantAnalysis.jl)
- [Linear Regression](src/supervised_learning/baseRegression.jl)
- [Logistic Regression](src/supervised_learning/baseRegression.jl)
- [Multilayer Perceptron](src/supervised_learning/neuralNetwork_bp.jl)
- [Naive Bayes](src/supervised_learning/naivdBayes.jl)
- [Ridge Regression](src/supervised_learning/baseRegression.jl)
- [Lasso Regression](src/supervised_learning/baseRegression.jl)
- [Support Vector Machine](src/supervised_learning/support_vector_machine.jl)
- [Hidden Markov Model](src/supervised_learning/hiddenMarkovModel.jl)
- [Label propagation](src/supervised_learning/labelPropagation.jl)
- [Random Forests](src/supervised_learning/randomForests.jl)
- [XGBoost](src/supervised_learning/xgboost.jl)

#### Unsupervised Learning:

- [Gaussian Mixture Model](src/unsupervised_learning/gaussianMixtureModel.jl)
- [K-Means](src/unsupervised_learning/kMeans.jl)
- [Principal Component Analysis](src/unsupervised_learning/principalComponentAnalysis.jl)
- [Spectral Clustering](src/unsupervised_learning/spectralCluster.jl)
- [Large Scale Spectral Clustering](src/unsupervised_learning/largeScaleSpectralClustering.jl)

#### Test Example available

- test_ClassificationTree()
- test_RegressionTree()
- test_label_propagation()
- test_LDA()
- test_naive()
- test_NeuralNetwork()
- test_svm()
- test_kmeans_random()
- test_PCA()
- test_Adaboost()
- test_BoostingTree()
- test_spec_cluster()
- test_LogisticRegression()
- test_LinearRegression()
- test_kneast_regression()
- test_kneast_classification()
- test_LSC()
- test_GaussianMixture() **(Fixing)**
- test_GDA() **(Fixing)**
- test_HMM() **(Fixing)**
- test_xgboost **(Fixing)**

## Contribution

Please examine the [todo list](todo.md) for contribution detials.

Any Pull request is welcome.

## Selected Examples

### LinearRegression

```julia
using LightML
test_LinearRegression()
```

<p align="center">
    <img src="https://ooo.0o0.ooo//2017//03//11//58c2cf6a8726e.png" width="480">
</p>
<p align="center" style="color:rgb(220,220,220);">
    Figure 3: The regression Dataset using LinearRegression
</p>

### Adaboost

```julia
test_Adaboost()
```

<p align="center">
    <img src="https://ooo.0o0.ooo//2017//03//11//58c36970c58a8.png" width="480">
</p>
<p align="center" style="color:rgb(220,220,220);">
    Figure 4: The classification Dataset using Adaboost
</p>



### SVM

```julia
test_svm()
```

<p align="center">
    <img src="https://ooo.0o0.ooo//2017//03//11//58c367760e76a.png" width="480">
</p>
<p align="center" style="color:rgb(220,220,220);">
    Figure 5: The classification Dataset using LinearRegression
</p>

### Classification Tree

```julia
test_ClassificationTree()
```

<p align="center">
    <img src="https://ooo.0o0.ooo//2017//03//11//58c36775113e6.png" width="480">
</p>
<p align="center" style="color:rgb(220,220,220);">
    Figure 6: The digit Dataset using Classification Tree
</p>


### kmeans

```julia
test_kmeans_random()
```

<p align="center">
    <img src="https://ooo.0o0.ooo//2017//02//18//58a8445e2114b.png" width="480">
</p>
<p align="center" style="color:rgb(220,220,220);">
    Figure 7: The blobs Dataset using k-means
</p>

### LDA

```julia
test_LDA()
```

<p align="center">
    <img src="https://ooo.0o0.ooo//2017//03//02//58b82861bade3.png" width="480">
</p>
<p align="center" style="color:rgb(220,220,220);">
    Figure 8: The classification Dataset using LDA
</p>

### PCA

```julia
test_PCA()
```

<p align="center">
    <img src="https://ooo.0o0.ooo//2017//03//11//58c36773da5da.png" width="480">
</p>
<p align="center" style="color:rgb(220,220,220);">
    Figure 9: The Digit Dataset using PCA
</p>
