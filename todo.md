
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
- [x] Add ROC statistic calculations to utils
  - 6-6-17: Added many more error calculations as well
- [ ] Remove Gadfly in lieu of Plots
- [ ] Provide more API examples in the README
- [x] Add MinMax, UnitLength scaling to utils
  - 6-6-17: Implemented as StandardizeScaler, RescaleScaler, and UnitLengthScaler
- [ ] Use Abstract types
- [ ] Define shared function for the tests
- [ ] Consider adding a plotting utilities section
- [ ] Build out tests
- [ ] Organize changelog so it's easier to follow
- [x] Decide whether to include synonym functions for true positives, false positives as tp, fp, etc
  - I don't see any immediate downside so I'll add them in. The intent for all of these alias functions is for a smoother API experience...with "true positives" being referenced as "tp" in many of the other functions some people may expect that to be the actual function name. Overall being able to refer to these metrics as one has conceptualized them will make for cleaner, more declarative code - but if conflicts arise this may need to be dialed down in the future.
- [ ] Organize classification_eval alphabetically
- [ ] Make core classification functions uniform. For example maybe `true_positve_rate` should be the core function with `sensitivity` as an alias. That way all of the documentation call backs will refer to the blander technical names, but those kind of all share a similar structure.
