#' @title Gráficos de Diagnóstico
#'
#' @description
#' Fornece gráficos para o diagnóstico de um modelo de regressão linear.
#'
#' @param preditos Valores preditos retornados pela função \code{rl}.
#' @param residuos Resíduos retornados pela função \code{rl}.
#' @param df Banco de dados no formato \code{data.frame} quw contém a variável resposta.
#'
#' @return Uma figura com 6 gráficos: Valores predidos x Valores observados; QQplot dos resíduos; Valores preditos x Resíduos; Histograma dos resíduos; Número da observação x Resíduos; e Boxplot dos resíduos.
#'
#' @examples
#'pred = rl("y", c("x1", "x2", "x3"), dados_simulados)$ValoresPreditos
#'resid = rl("y", c("x1", "x2", "x3"), dados_simulados)$Residuos
#'graficos_diagnostico(pred, resid, dados_simulados)
#'
#'dados_simulados$x2_quadrado = (dados_simulados$x2)^2
#'pred2 = rl("y", c("x1", "x2_quadrado", "x3"), dados_simulados)$ValoresPreditos
#'resid2 = rl("y", c("x1", "x2_quadrado", "x3"), dados_simulados)$Residuos
#'graficos_diagnostico(pred2, resid2, dados_simulados)
#'
#' @import ggplot2
#'
#' @export
graficos_diagnostico = function(preditos, residuos, df){

  if(is.vector(preditos) != TRUE){
    stop("O argumento preditos deve ser um vetor.")
  }

  if(is.vector(residuos) != TRUE){
    stop("O argumento residuos deve ser um vetor.")
  }

  if(is.data.frame(df) != TRUE){
    stop("O argumento novos_dados deve ser um data frame.")
  }

  graf1 = ggplot(data = df, aes(x = preditos, y = y)) +
    geom_point() +
    theme_bw() +
    labs(x = "Valores Preditos", y = "Valores observados")

  graf2 = ggplot(data = df, aes(sample = residuos)) +
    stat_qq(color = "black") +
    stat_qq_line(color = "blue") +
    theme_bw() +
    labs(x = "Quantis teóricos", y = "Quantis amostrais")

  graf3 = ggplot(data = df, aes(x = preditos, y = residuos)) +
    geom_hline(yintercept = 0, color = "blue") +
    geom_point() +
    theme_bw() +
    labs(x = "Valores Preditos", y = "Resíduos")

  graf4 = ggplot(data = df, aes(x = residuos)) +
    geom_histogram(aes(y = after_stat(density)), binwidth = 1, fill = "gray", color = "black") +
    geom_density(color = "blue", linewidth = 1) +
    theme_bw() +
    labs(y = "Densidade", x = "Resíduos")

  graf5 = ggplot(data = df, aes(x = seq_along(y), y = residuos)) +
    geom_hline(yintercept = 0, color = "blue") +
    geom_point() +
    theme_bw() +
    labs(x = "Índice da observação", y = "Resíduos")

  graf6 = ggplot(data = df, aes(y = residuos)) +
    geom_boxplot(fill = "gray", color = "black") +
    theme_minimal() +
    labs(y = "Resíduos") +
    theme(axis.text.x = element_blank())

  graficos = ggpubr::ggarrange(graf1, graf2, graf3, graf4, graf5, graf6,
                               ncol = 2, nrow = 3)

  return(graficos)
}
