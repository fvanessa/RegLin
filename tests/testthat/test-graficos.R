test_that("graficos funciona", {
  fit = rl("y", c("x1", "x2", "x3"), dados_simulados)
  grafico = graficos_diagnostico(fit$ValoresPreditos, fit$Residuos, dados_simulados)
  expect_s3_class(grafico, "ggplot")
})
