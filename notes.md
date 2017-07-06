# Notes

* Regularization, gradient descent
  - Since some algorithms won't be regularizing the intercept/bias I think it'd be easier to have reg terms handled separately. So a `loss()` and `gradient()` will return an unregularized vector, which will then be adjusted for `l1_reg()` and `l1_reg_grad()`, respectively.
