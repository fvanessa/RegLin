#' @title Regressão Linear
#'
#' @description
#' Fornece os coeficientes, os valores preditos e os resíduos de uma regressão linear.
#'
#' @param y Variável resposta da classe \code{character}
#' @param X Vetor de \code{character} com as variáveis explicativas (todas as variáveis explicativas devem ser numéricas)
#' @param df Banco de dados no formato \code{data.frame}
#'
#' @return Uma lista contendo um vetor com os coeficientes, um vetor com os valores preditos e um vetor com os resíduos do modelo ajustado.
#'
#' @examples
#'rl("y", c("x1", "x2", "x3"), dados_simulados)
#'
#'dados_simulados$x2_quadrado = (dados_simulados$x2)^2
#'rl("y", c("x1", "x2_quadrado", "x3"), dados_simulados)
#'
#' @importFrom dplyr select
#'
#' @export
rl = function(y, X, df){

  if(class(y) != "character"){
    stop("O argumento y deve ser uma string.")
  }

  if(is.vector(X) != TRUE){
    stop("O argumento X deve ser um vetor de strings.")
  }

  if(class(X) != "character"){
    stop("O argumento X deve ser um vetor de strings.")
  }

  if(is.data.frame(df) != TRUE){
    stop("O argumento df deve ser um data frame.")
  }

  var_necessarias = c(y, X)
  var_faltando = setdiff(var_necessarias, names(df))
  if (length(var_faltando) > 0) {
    stop("Alguma(s) variável(is) especificada(s) não foi(ram) encontrada(s) no banco de dados.")
  }

  Y = select(df, all_of(y))
  X = select(df, all_of(X))
  Y = as.matrix(Y)
  X = as.matrix(X)
  n = nrow(df)
  Intercepto = rep(1, n)
  X_matriz = cbind(Intercepto, X)
  X_transposto = t(X_matriz)
  X_transposto_X = X_transposto %*% X_matriz
  X_transposto_X_inverso = solve(X_transposto_X)
  beta_chapeu = X_transposto_X_inverso %*% X_transposto %*% Y
  beta_chapeu = as.matrix(beta_chapeu)

  Y_chapeu = X_matriz %*% beta_chapeu
  Y_chapeu = as.matrix(Y_chapeu)

  residuos = Y - Y_chapeu

  return(list(Coeficientes = as.vector(beta_chapeu),
              ValoresPreditos = as.vector(Y_chapeu),
              Residuos = as.vector(residuos)))
}
