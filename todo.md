
## Todo List


#### Fix Some Problems

There are implementation not working as expected, so further debug is needed.

- [ ] [Gaussian Mixture Model](src/unsupervised_learning/gaussianMixtureModel.jl)
- [ ] [Hidden Markov Model](src/supervised_learning/hiddenMarkovModel.jl)
- [ ] [Gaussian Discriminant Analysis](src/supervised_learning/gaussianDiscriminantAnalysis.jl)
- [ ] [XGBoost](src/supervised_learning/xgboost.jl)


#### New Algorithm


- [ ] Boltzmann machine and DBN
- [ ] Apriori
- [ ] DBSCAN
- [ ] FP-Growth
- [ ] Partitioning Around Medoids


Feel free to use the [frame.jl](src/utils/frame.jl) to develop your version of ML algorithm.

#### Miscellaneous

- [ ] Eliminate ForwardDiff dependency, this involves linear regression code and should be easy to do.
- [ ] Eliminate PyCall dependency, this involves eliminating the dependency on python scikit-learn's datasets for testing purpose.
- [ ] Add ROC statistic calculations to utils
- [ ] Remove Gadfly in lieu of Plots
- [ ] Provide more API examples in the README
- [ ] Add MinMax, UnitLength scaling to utils
- [ ] Use Abstract types
