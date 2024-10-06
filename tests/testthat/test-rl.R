test_that("rl funciona", {
  fit_rl = rl("y", c("x1","x2","x3","x4","x5"), dados_simulados)
  fit_lm = lm(y ~ x1 + x2 + x3 + x4 + x5, data = dados_simulados)

  coef_rl = fit_rl$Coeficientes
  coef_lm = summary(fit_lm)$coefficients[1:6]

  pred_rl = fit_rl$ValoresPreditos
  pred_lm = unname(fitted.values(fit_lm))

  resid_rl = fit_rl$Residuos
  resid_lm = unname(residuals(fit_lm))

  dados_simulados$x6 = rep(2,1000)
  dados_simulados$x7 = (dados_simulados$x1)*2

  expect_equal(coef_rl, coef_lm)
  expect_equal(pred_rl, pred_lm)
  expect_equal(resid_rl, resid_lm)
  expect_error(rl("y", c("x1","x2","x3","x4","x5", "x6"), dados_simulados))
  expect_error(rl("y", c("x1","x2","x3","x4","x5", "x7"), dados_simulados))
})
