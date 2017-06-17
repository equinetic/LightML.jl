
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

#### PR Milestone

- [ ] Eliminate ForwardDiff dependency, this involves linear regression code and should be easy to do.
- [ ] Eliminate PyCall dependency, this involves eliminating the dependency on python scikit-learn's datasets for testing purpose.
- [x] Add ROC statistic calculations to utils
  - 6-6-17: Added many more error calculations as well
- [x] Remove Gadfly in lieu of Plots
- [ ] Provide more API examples in the README
- [x] Add MinMax, UnitLength scaling to utils
  - 6-6-17: Implemented as StandardizeScaler, RescaleScaler, and UnitLengthScaler
- [ ] Use Abstract types
- [x] Define shared function for the ~~tests~~ demos
  - `demo(model::Symbol)` - e.g. `demo(:LinearRegression)`. `demo()` should still do the gigantic demo (untested)
- [x] Consider adding a plotting utilities section
- [ ] Build out tests
  - 6/11/17 - started with the classification eval functions, but I'd like to expand this out to the other components
- [ ] Organize changelog so it's easier to follow
- [x] Decide whether to include synonym functions for true positives, false positives as tp, fp, etc
  - I don't see any immediate downside so I'll add them in. The intent for all of these alias functions is for a smoother API experience...with "true positives" being referenced as "tp" in many of the other functions some people may expect that to be the actual function name. Overall being able to refer to these metrics as one has conceptualized them will make for cleaner, more declarative code - but if conflicts arise this may need to be dialed down in the future.
- [x] Organize classification_eval alphabetically
- [x] Make core classification functions uniform. For example maybe `true_positve_rate` should be the core function with `sensitivity` as an alias. That way all of the documentation call backs will refer to the blander technical names, but those kind of all share a similar structure.
- [x] Determine what the return values should be on error cases for classification evals. For instance, depending on the number of tp and fp in $\frac{tp}{tp+fp}$:
  - 1/0 returns `Inf` - this won't ever actually happen since the numerator terms get added to the denominator
  - 0/0 returns `NaN`
  - ==> I think the default errors are fine
- [x] Determine whether ClassificationStatistics should contain all aliases as is the current implementation. On one hand this may extend the intended convenience and expressive nature of having the aliases in the first place, but on the negative side it does add visual noise to the print out.
  - ==> Will leave them in for now, as long as aliases are the direction I like the clarity
- [x] Maybe create an actual ROCCurve type and call `roccurve` just `roc`. The type could then extend `Plot()` to generate the classic ROC graph.
  - ==> Baseline going
- [x] Convert `test_` prefixes to `demo_`
- [ ] Test plots now that the backend has been swapped out
- [ ] Should things like ClassificationStatistics receive a type ClassificationModel? I'm wondering if some of these functions would be better suited being run on an actual trained model. If this is a change I end up implementing I think all of the vector methods should still be present, that way all of the functionality is still present.
- [ ] Add in inline docs for all of the new classification abilities
- [ ] Improve base regression
  - [ ] Add in gradients
  - [ ] Make intercept optional
  - [ ] Enable batch size
  - [ ] Make loss/grad an optional named parameter, a funciton, that is expected to return (J(θ), J'(θ))
  - [ ] Change naming in type. For example 'parameters' may be better expressed as 'weights' or θ
  - [ ] Use method dispatch to allow an optimized solver to be used (e.g. from Optim.jl)
- [ ] Add binning utility & type
- [ ] Add a pipeline capability
- [ ] Establish a readthedocs


# Long Term
- [ ] Create extension, wrapper, etc for `lab_` styled functions. This will align with the yet to be created REPLab.jl
