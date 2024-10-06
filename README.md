
# RegLin

O objetivo deste pacote é trabalhar com modelos de regressão linear
através de funções que permitem que o usuário obtenha os seguintes
elementos:

- Coeficientes $\hat{\beta}$;
- Resíduos;
- Valores preditos dentro do conjunto de dados;
- Valores preditos para novos valores; e
- Gráficos.

A função `rl` presente no pacote permite obter os três primeiros; a
função `predicao`, o quarto e a função `graficos_diagnostico` o último.

O pacote também contém um conjunto de dados, `dados_simulados`, que
foram simulados para testar tais funções.

## Instalação

Para instalar este pacote diretamente do GitHub, você precisará ter o
pacote `devtools` instalado no R e executar o seguinte comando:

``` r
devtools::install_github(repo = "fvanessa/RegLin")
```

## Exemplos de uso

Para usar o pacote, carregue-o da seguinte forma:

``` r
library(RegLin)
```

Para utilizar a função `rl` forneça adequadamente os três argumentos
exigidos, `y`, `X` e `df`, como representado abaixo:

``` r
rl(y = "y", X = c("x1", "x2", "x3"), df = dados_simulados)
```

Para utilizar a função `predicao` use dois argumentos,
`coeficientes_estimados` (coeficientes calculados a partir dos dados
simulados) e `novos_dados` (novos valores de x para os quais desejamos
prever a variável y), como a seguir:

``` r
coef = rl("y", c("x1", "x2", "x3"), dados_simulados)$Coeficientes
df_novo = data.frame(x1 = c(1, 5), x2 = c(3, 4), x3 = c(2, 2))
predicao(coeficientes_estimados = coef, novos_dados = df_novo)
```

Para utilizar a função `graficos_diagnostico`, são necessários três
argumentos, `preditos`, `residuos` e `df`, como no exemplo abaixo:

``` r
pred = rl("y", c("x1", "x2", "x3"), dados_simulados)$ValoresPreditos
resid = rl("y", c("x1", "x2", "x3"), dados_simulados)$Residuos
graficos_diagnostico(pred, resid, dados_simulados)
```

O pacote inclui o dataset `dados_simulados` para você testar as funções
com facilidade. Estes dados contêm 5 variáveis independentes.
$x1,..,x5$, e uma variável dependente, $y$, simulando um cenário
clássico de regressão linear.

``` r
head(dados_simulados)
```
