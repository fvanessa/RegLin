test_that("predicao funciona", {

  fit_lm = lm(y ~ x1 + x2 + x3, data = dados_simulados)
  fit_rl = rl("y", c("x1", "x2", "x3"), dados_simulados)
  coef_rl = fit_rl$Coeficientes
  dados_novos = data.frame(x1 = c(1, 5), x2 = c(3, 4), x3 = c(2, 2))

  pred_predicao = predicao(coef_rl, dados_novos)
  pred_predic = unname(predict(fit_lm, dados_novos))

  expect_equal(pred_predicao, pred_predic)
})
