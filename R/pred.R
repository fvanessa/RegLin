#' @title Predições para modelos de regressão linear
#'
#' @description
#' Fornece predições para novos valores das variáveis explicativas usadas para ajustar um modelo de regressão linear.
#'
#' @param coeficientes_estimados Um vetor com os coeficientes estimados pela função \code{rl}.
#' @param novos_dados Banco de dados no formato \code{data.frame} com os novos valores para realizar as predições.
#'
#' @return Um \code{data.frame} com as predições para os novos valores.
#'
#' @examples
#'coef = rl("y", c("x1", "x2", "x3"), dados_simulados)$Coeficientes
#'df_novo = data.frame(x1 = c(1, 5), x2 = c(3, 4), x3 = c(2, 2))
#'predicao(coef, df_novo)
#'
#' @export
predicao = function(coeficientes_estimados, novos_dados){

  if(is.vector(coeficientes_estimados) != TRUE){
    stop("O argumento coeficientes_estimados deve ser um vetor.")
  }

  if(is.data.frame(novos_dados) != TRUE){
    stop("O argumento novos_dados deve ser um data frame.")
  }

  predicoes = apply(novos_dados, 1, function(linha) {
    coeficientes_estimados[1] + sum(linha * coeficientes_estimados[-1])
  })
  return(predicoes)
}
