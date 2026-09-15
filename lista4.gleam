import gleam/string
import sgleam/check
import gleam/float
import gleam/int

// 13) Projete uma enumeração para representar as direções norte, leste, sul e oeste. Em seguida,

/// Tipo que contém as quatro direções geograficas
pub type Direcao {
  Norte
  Sul
  Leste
  Oeste
}

// a) Projete uma função que indique a direção oposta de uma dada direção.

/// Retorna a direção oposta (180°) da direção inserida pelo usuario
/// as direções são um tipo numerado definido de dados 
pub fn direcao_oposta(direcao: Direcao) -> Direcao {
  case direcao {
    Norte -> Sul
    Sul -> Norte
    Leste -> Oeste
    Oeste -> Leste
  }
}

pub fn direcao_oposta_examples() {
  check.eq(direcao_oposta(Sul), Norte)
  check.eq(direcao_oposta(Oeste), Leste)
  check.eq(direcao_oposta(Norte), Sul)
  check.eq(direcao_oposta(Leste), Oeste)
}

// b) Projete uma função que indique qual é a direção que está a 90 graus no sentido horário de outra
// direção.

/// Retorna a direção a direita da direção inserida pelo usuário, as direções são um tipo numerado definido de dados
pub fn direcao_direita(direcao: Direcao) -> Direcao {
  case direcao {
    Norte -> Leste
    Leste -> Sul
    Sul -> Oeste
    Oeste -> Norte
  }
}

pub fn direcao_direita_examples() {
  check.eq(direcao_direita(Sul), Oeste)
  check.eq(direcao_direita(Oeste), Norte)
  check.eq(direcao_direita(Norte), Leste)
  check.eq(direcao_direita(Leste), Sul)
}

// c) Projete uma função que indique qual é a direção que está a 90 graus no sentido anti-horário de
// outra direção. Use a função do item b para fazer a implementação (não use seleção).

/// Retorna a direção a esquerda da direção inserida pelo usuário, as direções são um tipo numerado definido de dados
pub fn direcao_esquerda(direcao: Direcao) -> Direcao {
  case direcao {
    Norte -> Oeste
    Oeste -> Sul
    Sul -> Leste
    Leste -> Norte
  }
}

pub fn direcao_esquerda_examples() {
  check.eq(direcao_esquerda(Sul), Leste)
  check.eq(direcao_esquerda(Oeste), Sul)
  check.eq(direcao_esquerda(Norte), Oeste)
  check.eq(direcao_esquerda(Leste), Norte)
}

// d) Projete uma função que receba como entrada duas direções e indique quantos graus uma pessoa
// que está virada para a primeira direção precisa virar no sentido horário para virar para a segunda
// direção.

/// Função retorna quantos graus no sentido horario uma pessoa precisará virar para sair da direção A para uma direção B
/// ambas informadas como entrada da função, e as direções sendo do tipo enumerado definido Direcao
pub fn num_graus(dir_a: Direcao, dir_b: Direcao) -> Int {
  case dir_a {
    Sul ->
      case dir_b {
        Sul -> 0
        Norte -> 180
        Leste -> 270
        Oeste -> 90
      }
    Norte ->
      case dir_b {
        Sul -> 180
        Norte -> 0
        Leste -> 90
        Oeste -> 270
      }
    Leste ->
      case dir_b {
        Sul -> 90
        Norte -> 270
        Oeste -> 180
        Leste -> 0
      }
    Oeste ->
      case dir_b {
        Sul -> 270
        Norte -> 90
        Leste -> 180
        Oeste -> 0
      }
  }
}

pub fn num_graus_examples() {
  check.eq(num_graus(Sul, Norte), 180)
  check.eq(num_graus(Leste, Norte), 270)
  check.eq(num_graus(Norte, Oeste), 270)
  check.eq(num_graus(Oeste, Norte), 90)
}

// 14) Projete uma enumeração para representar a situação de um elevador que pode estar parado, subindo
// ou descendo. Em seguida,

/// Tipo enumerado que contem os três possíveis estados de um elevador em um determinado instante de tempo
pub type Elevador {
  Parado
  Subindo
  Descendo
}

// a) Sabendo que um elevador está parado e irá atender imediatamente uma solicitação, projete uma
// função que determine, a partir do andar atual e do andar solicitado, qual será a situação do
// elevador imediatamente após receber a solicitação

/// Retorna se o elevador vai subir ou descer de acordo com entradas númericas respectivas
/// ao andar em que o usuário está e o andar em que o elevador se encontra,
/// aqui consideramos que o elevador já está parado, logo não há problema conflito de chamada
pub fn confere_caminho(andar: Int, elevador: Int) -> Elevador {
  case elevador < andar {
    True -> Subindo
    False -> Descendo
  }
}

pub fn confere_caminho_examples() {
  check.eq(confere_caminho(10, 5), Subindo)
  check.eq(confere_caminho(10, 12), Descendo)
  check.eq(confere_caminho(-2, 5), Descendo)
}

// b) Sabendo que um elevador só pode começar a se movimentar se estiver parado, projete uma função
// que verifique se o elevador pode passar de um estado para outro. Faça uma tabela que mostre
// as nove possibilidades de entrada da função e a saída de cada possibilidade. Faça os exemplos a
// partir da tabela. Faça a implementação simplificada a partir da tabela.

// parado   - parado   | + aceita
// parado   - subindo  | + aceita
// parado   - descendo | + aceita
// subindo  - parado   | + aceita
// subindo  - subindo  | - rejeita
// subindo  - descendo | - rejeita
// descendo - parado   | + aceita
// descendo - subindo  | - rejeita
// descendo - descendo | - rejeita

pub fn mudanca_estado(estado_atual: Elevador, estado_desejado: Elevador) -> Bool {
  case estado_atual {
    Parado -> True
    Subindo | Descendo ->
      case estado_desejado {
        Parado -> True
        Subindo | Descendo -> False
      }
  }
}

pub fn mudanca_estado_examples() {
  check.eq(mudanca_estado(Parado, Subindo), True)
  check.eq(mudanca_estado(Parado, Parado), True)
  check.eq(mudanca_estado(Parado, Descendo), True)
  check.eq(mudanca_estado(Subindo, Parado), True)
  check.eq(mudanca_estado(Subindo, Subindo), False)
  check.eq(mudanca_estado(Subindo, Descendo), False)
  check.eq(mudanca_estado(Descendo, Parado), True)
  check.eq(mudanca_estado(Descendo, Subindo), False)
  check.eq(mudanca_estado(Descendo, Descendo), False)
}

// 17) Projete uma união para representar uma figura, que pode ser um retângulo (com largura e altura) ou
// um círculo (com raio). Em seguida,
// a) Projete uma função que determine a área de uma figura. A área de um retângulo é dada por
// largura × altura, e a área de um círculo é dada por 3.14 × raio2.
// b) Projete uma função que verifique se uma figura cabe dentro de outra. Faça uma tabela com as
// quatro possibilidades (retângulo-retângulo, retângulo-círculo, círculo-retângulo, círculo-círculo) e
// identifique as condições necessárias para a primeira figura caber na segunda (um retângulo cabe
// dentro de um círculo se a sua diagonal for menor ou igual ao diâmetro do círculo, o que pode ser
// verificado sem calcular a raiz quadrada: altura2 + largura2 ≤ (2 × raio)2). Faça os exemplos e
// a implementação a partir da tabela.

/// Tipo que define qual o tipo de uma figura geométrica 
pub type Figura {

  /// Caso seja retangulo contem as informações de altura e largura
  Retangulo(largura: Float, altura: Float)

  /// Caso seja um circulo contem o raio do mesmo
  Circulo(raio: Float)
}

/// Função que determina a área de uma figura dada na entrada
/// a entrada é do tipo "Figura" podendo ser um retangulo ou circulo
/// caso seja um retangulo, sua área é calculada através da multiplicação da altura x largura
/// caso seja um circulo o calculo é feito através de raio^2 * pi (3.14)
pub fn determina_area(fig: Figura) -> Float {
  case fig {
    Retangulo(..) -> fig.altura *. fig.largura
    Circulo(..) -> { fig.raio *. fig.raio } *. 3.14
  }
}

pub fn determina_area_examples() {
  check.eq(determina_area(Retangulo(5.0, 4.0)), 20.0)
  check.eq(determina_area(Circulo(5.0)), 78.5)
}

/// Função verifica se uma figura 'seg_fig' cabe dentro de uma figura 'prim_fig' ambas informadas em entrada
/// para que a função seja válida precisaremos cobrir todos os casos, sendo eles:
/// Retangulo -  Retangulo
/// Retangulo -  Circulo
/// Circulo   -  Circulo
/// Circulo   -  Retangulo
/// 
pub fn fig_cabe_fig(prim_fig: Figura, seg_fig: Figura) -> Bool {
  case prim_fig, seg_fig {
    Retangulo(..), Retangulo(..) ->
      determina_area(seg_fig) <=. determina_area(prim_fig)
    Circulo(..), Circulo(..) ->
      determina_area(seg_fig) <=. determina_area(prim_fig)
    Retangulo(..), Circulo(..) ->
      { { seg_fig.raio *. 2.0 } <=. prim_fig.altura }
      && { { seg_fig.raio *. 2.0 } <=. prim_fig.largura }
    Circulo(..), Retangulo(..) ->
      {
        { seg_fig.altura *. seg_fig.altura }
        +. { seg_fig.largura *. seg_fig.largura }
      }
      <=. { 4.0 *. { prim_fig.raio *. prim_fig.raio } }
  }
}

pub fn fig_cabe_fig_examples() {
  check.eq(fig_cabe_fig(Retangulo(2.0, 4.0), Retangulo(2.0, 3.0)), True)
  check.eq(fig_cabe_fig(Retangulo(2.0, 4.0), Retangulo(3.0, 4.4)), False)
  check.eq(fig_cabe_fig(Circulo(5.0), Circulo(4.0)), True)
  check.eq(fig_cabe_fig(Circulo(4.0), Circulo(5.0)), False)
  check.eq(fig_cabe_fig(Retangulo(4.0, 5.0), Circulo(2.0)), True)
  check.eq(fig_cabe_fig(Retangulo(3.0, 7.0), Circulo(9.0)), False)
  check.eq(fig_cabe_fig(Circulo(5.0), Retangulo(4.0, 5.0)), True)
  check.eq(fig_cabe_fig(Circulo(4.0), Retangulo(6.0, 10.0)), False)
}

// 18) A nota final em uma disciplina é calculada pela média simples de 4 avaliações, que valem de 0 a 10.
// A partir da nota final, os alunos enquadram-se em uma de três situações: aprovado, para notas finais
// maiores ou iguais a 7; reprovado, para notas menores que 4; e exame, para notas maiores ou iguais a
// 4 e menores que 7. Projete uma função que indique a situação de um aluno, dadas as 4 notas de suas
// avaliações.

/// Tipo enumerado que contem as possíbilidades de situações
/// academicas de um aluno
pub type Situacao {
  Aprovado
  Reprovado
  Exame
}

/// Estrutura que contém as notas de quatro avaliações de um determinado aluno
pub type Notas {
  Notas(n1: Float, n2: Float, n3: Float, n4: Float)
}

/// Função que determina se um determinado aluno está aprovado, reprovado ou de exame de acordo
/// com suas quatro notas, as notas são dadas através de um tipo estrutura Notas e a situação do aluno
/// é dada de acordo com a média dessas notas com retorno do tipo enumerado Situação, os possíveis casos são esses:
/// media >= 7 -> Aprovado
/// 4 <= media < 7 -> Exame
/// media < 4 -> Reprovado
pub fn define_situacao(notas: Notas) -> Situacao {
  let media: Float = { notas.n1 +. notas.n2 +. notas.n3 +. notas.n4 } /. 4.0

  case media <. 7.0 {
    True ->
      case media <. 4.0 {
        True -> Reprovado
        False -> Exame
      }
    False -> Aprovado
  }
}

pub fn define_situacao_examples() {
  check.eq(define_situacao(Notas(4.0, 4.0, 3.0, 2.0)), Reprovado)
  check.eq(define_situacao(Notas(4.0, 4.0, 3.0, 8.0)), Exame)
  check.eq(define_situacao(Notas(7.0, 6.0, 8.0, 8.0)), Aprovado)
}

// 19) O Brasil instituiu, há algum tempo, um sistema de bandeiras tarifárias para sinalizar aos consumidores
// os custos reais da geração de energia. Nesse sistema, a bandeira verde indica condições favoráveis de
// geração, e a tarifa não sofre acréscimo. Já a bandeira amarela indica condições menos favoráveis, e,
// por isso, a tarifa sobre um acréscimo de R$ 0,01874 por quilowatt-hora (kWh) consumido. A bandeira
// vermelha - patamar 1 indica condições mais custosas de geração, e o acréscimo na tarifa é de R$
// 0,03971 por kWh. Por fim, a bandeira vermelha - patamar 2 indica condições ainda mais custosas, e o
// acréscimo é de R$ 0,09492 por kWh. Projete uma função que determine o valor final que o consumidor
// deve pagar, dados o seu consumo em kWh, a tarifa básica do kWh e a bandeira tarifária.

/// Tipo união que contem cada bandeira bandeira mais a tarifa basica de consumo
pub type Bandeira {

  Verde(tarifa: Float)
  Amarelo(tarifa: Float)
  VermelhoP1(tarifa: Float)
  VermelhoP2(tarifa: Float)
}

/// Função que, dado o consumo de energia em kWh de um certo individuo e a bandeira tarifária atual
/// retorna o valor a ser pago por esse individuo, o valor a ser pago é calculado da seguinte maneira:
/// consumo * (tarifa + acrescimo)
/// os valores de tarifa basica e acrescimo são dados de acordo com o tipo estrutura 'Bandeira', a tarifa é variavel
/// de acordo com a entrada e os acrescimos já estão definidos para cada bandeira
pub fn valor_energia(consumo: Float, bandeira: Bandeira) -> Float {
  case bandeira {
    Verde(tarifa: tarifa) -> consumo *. tarifa
    Amarelo(tarifa: tarifa) ->   
     float.to_precision(consumo *. {tarifa +. 0.01874}, 2) 
    VermelhoP1(tarifa: tarifa) ->
     float.to_precision(consumo *. {tarifa +. 0.03971}, 2) 
    VermelhoP2(tarifa: tarifa) ->
     float.to_precision(consumo *. {tarifa +. 0.09492}, 2)
  }
}

pub fn valor_energia_examples(){
  check.eq(valor_energia(100.0, Verde(0.5)), 50.0)
  check.eq(valor_energia(100.0, Amarelo(0.5)), 51.87)
  check.eq(valor_energia(100.0, VermelhoP1(0.5)), 53.97)
  check.eq(valor_energia(100.0, VermelhoP2(0.5)), 59.49)
}


// 20) O desempenho de um time de futebol em um campeonato é medido pelo número de pontos, de vitórias
// e pelo saldo de gols (diferença entre todos os gols marcados e sofridos). Cada vitória vale 3 pontos,
// e cada empate, 1 ponto. Projete uma função que atualize o desempenho de um time com base no
// resultado do seu último jogo (gols marcados e gols sofridos).

/// Tipo estrutura que diz respeito a um time de futebol e seus dados de desempenho durante
/// um campeonato, o desempenho é um valor inteiro respectivo aos pontos que o time obteve até o momento
pub type Time{
  Time(desempenho: Int, gols: Int, sofridos: Int)
}

/// Tipo enumerado que contém as três possibilidades de um jogo de futebol
/// sendo elas vitória, derrota e empate
pub type Resultado{
  Vitoria(gols: Int, sofridos: Int)
  Derrota(gols: Int, sofridos: Int)
  Empate(gols: Int)
}

/// atualiza a pontuação de desempenho de um time de acordo com o resultado de seu ultimo jogo
/// as pontuações são dadas da seguinte maneira:
/// - Vitoria -> 3 pontos somados ao desempenho
/// - Empate -> 1 ponto somado ao desempenho
/// - Derrota -> nenhum ponto é somado ao desempenho
/// Os valores de gols marcados e gols sofridos também é alterado
pub fn atualiza_desempenho(time: Time, jogo: Resultado) -> Time{
  case jogo{
    Vitoria(gols: g, sofridos: s) -> Time(time.desempenho + 3, time.gols + g, time.sofridos + s)
    Derrota(gols: g, sofridos: s) -> Time(time.desempenho + 0, time.gols + g, time.sofridos + s)
    Empate(gols: g) -> Time(time.desempenho + 1, time.gols + g, time.sofridos + g)
  } 
}

pub fn atualiza_desempenho_examples(){
  check.eq(atualiza_desempenho(Time(30, 10, 5), Vitoria(6, 3)), Time(33, 16, 8))
  check.eq(atualiza_desempenho(Time(14, 8, 3), Empate(2)), Time(15, 10, 5))
  check.eq(atualiza_desempenho(Time(20, 10, 15), Derrota(2, 7)), Time(20, 12, 22))
}


// 21) Em um determinado programa, é necessário exibir para o usuário o tempo de duração de uma operação.
// Esse tempo está disponível em segundos, mas exibir essa informação em segundos pode não ser prático
// para o usuário — afinal, ter uma noção clara do que 14.678 segundos representam é difícil!
// a) Projete uma função que converta uma quantidade de segundos para o valor equivalente em horas,
// minutos e segundos.
// b) Projete uma função que converta uma quantidade de horas, minutos e segundos em uma string
// amigável para o usuário. A string não deve conter informações de tempo com valor zero (por
// exemplo, não deve exibir “0 minutos”).


/// Tipo de dado relacionado à uma quantidade de tempo formatada em horas minutos e segundos
pub type Tempo{
  Tempo(hora: Int, minuto: Int, segundo: Int)
}

/// Recebe como parametro um valor inteiro relacionado ao tempo de execução de uma tarefa em segundos, e, de acordo com esse tempo
/// retorna suas respectivas informações formatadas dentro de um tipo "Tempo" com horas minutos e segundos
pub fn formata_tempo(execucao: Int) -> Tempo{
  let horas: Int = execucao / 360
  let minuts: Int = {execucao % 360} / 60
  let sec: Int = {execucao % 360} % 60
  Tempo(horas, minuts, sec)
}

pub fn formata_tempo_examples(){
  check.eq(formata_tempo(50), Tempo(0, 0, 50))
  check.eq(formata_tempo(60), Tempo(0, 1, 0))
  check.eq(formata_tempo(360), Tempo(1, 0, 0))
  check.eq(formata_tempo(379), Tempo(1, 0, 19))
  check.eq(formata_tempo(425), Tempo(1, 1, 5))
}

/// Transforma os valores contidos no tipo de dado 'Tempo' em uma String amigável ao usuário, ou seja,
/// uma string formatada em horário padrão h:m:s, 
/// caso os valores obtidos em qualquer um dos campos seja igual a zero então esse campo será omitido
pub fn tempo_string(execucao: Tempo) -> String{
  let ini: String = "Tempo de Execução: "
  let horas: String = int.to_string(execucao.hora) <> " hora(s)"
  let min: String = int.to_string(execucao.minuto) <> " minuto(s)"
  let sec: String = int.to_string(execucao.segundo) <> " segundo(s)."

  case execucao.hora > 0, execucao.minuto > 0, execucao.segundo > 0{
    True, True, True -> ini <> horas <> ", " <> min <> ", " <> sec
    True, True, False -> ini <> horas <> ", " <> min <> "."
    True, False, True -> ini <> horas <> ", " <> sec
    True, False, False -> ini <> horas <> "."

    False, True, True -> ini <> min <> ", " <> sec
    False, True, False -> ini <> min <> "."
    False, False, True -> ini <> sec
    False, False, False -> ini <> "N/A"

  } 

}

pub fn tempo_string_examples(){
  check.eq(tempo_string(Tempo(5, 2, 30)), "Tempo de Execução: 5 hora(s), 2 minuto(s), 30 segundo(s).")
  check.eq(tempo_string(Tempo(5, 2, 0)), "Tempo de Execução: 5 hora(s), 2 minuto(s).")
  check.eq(tempo_string(Tempo(5, 0, 30)), "Tempo de Execução: 5 hora(s), 30 segundo(s).")
  check.eq(tempo_string(Tempo(5, 0, 0)), "Tempo de Execução: 5 hora(s).")
  check.eq(tempo_string(Tempo(0, 2, 30)), "Tempo de Execução: 2 minuto(s), 30 segundo(s).")
  check.eq(tempo_string(Tempo(0, 2, 0)), "Tempo de Execução: 2 minuto(s).")
  check.eq(tempo_string(Tempo(0, 0, 30)), "Tempo de Execução: 30 segundo(s).")
  check.eq(tempo_string(Tempo(0, 0, 0)), "Tempo de Execução: N/A")
}

// 22) Considere um jogo em que o personagem está em um tabuleiro (semelhante a um tabuleiro de xadrez).
// As linhas e colunas do tabuleiro são numeradas de 1 a 10; dessa forma, é possível representar a posição
// (casa) do personagem pelo número da linha e da coluna em que ele se encontra. O personagem fica
// virado para uma das quatro direções: norte, sul, leste ou oeste. O jogador pode avançar seu personagem
// qualquer número de casas na direção em que ele está virado, mas, claro, sem sair do tabuleiro. Projete
// uma função que indique, a partir das informações do personagem, qual é o número máximo de casas
// que ele pode avançar na direção em que está virado.


/// Tipo de dado que representa a posição de um jogador em um tabuleiro
/// a posição contém a direção em que ele está virado e as coordenadas do tabuleiro
/// o tabuleiro tem tamanho de 10x10
/// os pontos são 'a' e 'b' e se portam da mesma maneira que uma matriz com a sendo as linhas e b as colunas
/// a direção em que está virado é do tipo enumerado 'Direcao'
pub type Pos{
  Pos(a: Int, b: Int, direcao: Direcao)
}

/// Função que determina quantas casas um personagem pode andar em um tabuleiro
/// esse tabuleiro tem tamanho 10x10, como entrada teremos o tipo de dado 'Pos' que representa a posição do personagem
/// levaremos em consideração o ponto em que ele está e em qual direção está virado, deste modo, saberemos dizer quantas casas
/// ele ainda pode caminhar sem que ultrapasse o limite do tabuleiro
pub fn qtde_casas(pos: Pos) -> Int{
  case pos.direcao{
    Norte -> pos.a - 1
    Sul -> 10 - pos.a
    Leste -> 10 - pos.b
    Oeste -> pos.b - 1
  }
}

pub fn qtde_casas_examples(){
  check.eq(qtde_casas(Pos(5, 6, Norte)), 4)
  check.eq(qtde_casas(Pos(5, 8, Leste)), 2)
  check.eq(qtde_casas(Pos(2, 4, Sul)), 8)
  check.eq(qtde_casas(Pos(9, 9, Oeste)), 8)
  check.eq(qtde_casas(Pos(1, 1, Oeste)), 0)

}

// 23) Segundo a Wikipédia, um pixel é o menor elemento de um dispositivo de exibição (como um monitor,
// por exemplo) ao qual é possível atribuir uma cor. Nos monitores atuais, os pixels são organizados em
// linhas e colunas para formar a imagem exibida. Cada pixel pode ser referenciado por uma coordenada,
// que corresponde ao número da linha e da coluna em que ele aparece. Por exemplo, em um monitor
// de 1080 linhas por 1920 colunas, o pixel no canto superior esquerdo está na posição (0, 0), enquanto
// o pixel no canto inferior direito está na posição (1079, 1919).
// Em um ambiente gráfico com janelas, quando o usuário clica com o mouse, é necessário identificar em
// qual janela o clique ocorreu.
// a) Projete uma função que receba como parâmetros as informações sobre uma janela e um clique do
// mouse e determine se o clique ocorreu sobre a janela.


/// Tipo de dado respectivo a uma coordenada com pontos x e y inteiros
pub type Ponto{
  Ponto(x: Int, y: Int)
}

/// Tipo de dado que contém as informações de uma janela, as informações contidas são a altura e largura dela
/// e o ponto (x, y) em que ela se inicia na tela 
pub type Janela{
  Janela(altura: Int, largura: Int, inicio: Ponto)
}

/// Dado um click em um determinado ponto de um monitor, confere e retorna se o click foi feito dentro de uma janela ou não
/// o click são as coordenadas de x e y do monitor e a janela é representada pelo tipo janela, com seu tamanho e coordenada de inicio
/// caso o click seja feito no intervalo da janela retorna True, do contrário retorna False
pub fn ocorre_click(wnd: Janela, click: Ponto) -> Bool{
  let lim_sup_x: Int = wnd.altura + wnd.inicio.x
  let lim_sup_y: Int = wnd.largura + wnd.inicio.y

  case {click.x >= wnd.inicio.x && click.x <= lim_sup_x} && {click.y >= wnd.inicio.y && click.y <= lim_sup_y}{
    True -> True
    False -> False
  }
}

pub fn ocorre_click_examples(){
  check.eq(ocorre_click(Janela(500, 1000, Ponto(0, 0)), Ponto(100, 200)), True)
  check.eq(ocorre_click(Janela(500, 1000, Ponto(400, 600)), Ponto(100, 200)), False)
  check.eq(ocorre_click(Janela(500, 1000, Ponto(0, 300)), Ponto(100, 200)), False)
  check.eq(ocorre_click(Janela(500, 1000, Ponto(200, 0)), Ponto(100, 200)), False)

}

// b) (Desafio) Projete uma função que verifique se os espaços de duas janelas se sobrepõem.


// 24) Considere um jogo em que o personagem está em um tabuleiro (semelhante a um tabuleiro de xadrez).
// As linhas e colunas do tabuleiro são numeradas de 1 a 10; dessa forma, é possível representar a posição
// (casa) do personagem pelo número da linha e da coluna em que ele se encontra. O personagem fica
// virado para uma das quatro direções: norte, sul, leste ou oeste. O jogador controla o personagem por
// meio de um dos seguintes comandos: virar à esquerda e virar à direita, que mudam a direção para a
// qual o personagem está virado, e avançar n casas, que o faz avançar até n casas na direção em que ele
// está virado.
// Projete uma função que receba como entrada o personagem do jogo e um comando e gere como saída
// o novo estado do personagem.
// Por exemplo, ao executar o comando para virar à direita, estando o personagem na posição (1, 5) e
// virado para o norte, a função deve gerar como resultado o personagem na posição (1, 5) e virado para
// o leste.
// Se o comando for para avançar duas casas, estando o personagem na posição (7, 5) e virado para o
// oeste, a função deve gerar como resultado o personagem na posição (7, 3) e virado para o oeste.

/// Tipo enumerado de controles do personagem do tabuleiro
pub type Ctrl{
  MovEsq
  MovDir
  Avancar(n: Int)
}

/// De acordo com a posiçao de um personagem em um tabuleiro, e suas coordenadas, retorna seu novo estado após algum controle de ação, caso a 
/// ação seja inválida, retorna uma String de erro.
/// as ações de mudar de posição alteram a direção em que o personagem está virado, e a ação de avançar altera as coordenadas em que o personagem está
/// a mudança de coordenada com a movimentação é diferente de acordo com a direção em que ele está virado
/// por exemplo:
/// virado para o norte -> reduz o número de 'a' na coordenada (está subindo)
/// virado para o sul -> aumenta o número de 'a' na coordenada (está descendo)
/// virado para leste -> aumenta o número de 'b' na coordenada (está indo para a direita do tabuleiro)
/// virado para oeste -> reduz o número de 'b' na coordenada (está indo para a esquerda do tabuleiro)
/// a função também não deve permitir que o jogador se mova além do limite do tabuleiro, ou seja,
/// caso ele queira andar um número de casas maior que o tamanho do tabuleiro, ou então dado sua posição e a quantidade que ele deseja andar
/// a coordenada ultrapasse o tamanho do tabuleiro ele não será permitido executar a ação
/// por exemplo:
/// pos (0,0) avancar(11) -> não permite, tabuleiro 10x10 e avança alem do limite
/// pos (5, 2) - direcao Sul - avancar(6) -> não permite, vai ultrapassar o limite de tamanho do tabuleiro
pub fn acao(pos: Pos, acao: Ctrl) -> Result(Pos, String){
  case acao{
    MovEsq -> Ok(Pos(pos.a, pos.b, direcao_esquerda(pos.direcao)))
    MovDir -> Ok(Pos(pos.a, pos.b, direcao_direita(pos.direcao)))
    Avancar(n) -> case {qtde_casas(pos) >= n}, pos.direcao{
      True, Norte -> Ok(Pos({pos.a - n}, pos.b, pos.direcao))
      True, Sul -> Ok(Pos({pos.a + n}, pos.b, pos.direcao))
      True, Leste -> Ok(Pos(pos.a, {pos.b + n}, pos.direcao))
      True, Oeste -> Ok(Pos(pos.a, {pos.b - n}, pos.direcao))
      False, _ -> Error("Erro! A quantidade de casas a serem avançadas ultrapassa o limite do tabuleiro.")
    }
  }
}

pub fn acao_examples(){

  check.eq(acao(Pos(2, 2, Oeste), MovEsq), Ok(Pos(2, 2, Sul)))
  check.eq(acao(Pos(2, 2, Sul), MovEsq), Ok(Pos(2, 2, Leste)))
  check.eq(acao(Pos(2, 2, Leste), MovEsq), Ok(Pos(2, 2, Norte)))
  check.eq(acao(Pos(2, 2, Norte), MovEsq), Ok(Pos(2, 2, Oeste)))


  check.eq(acao(Pos(2, 2, Oeste), MovDir), Ok(Pos(2, 2, Norte)))
  check.eq(acao(Pos(2, 2, Norte), MovDir), Ok(Pos(2, 2, Leste)))
  check.eq(acao(Pos(2, 2, Leste), MovDir), Ok(Pos(2, 2, Sul)))
  check.eq(acao(Pos(2, 2, Sul), MovDir), Ok(Pos(2, 2, Oeste)))


  check.eq(acao(Pos(2, 2, Norte), Avancar(1)), Ok(Pos(1, 2, Norte)))
  check.eq(acao(Pos(2, 2, Sul), Avancar(1)), Ok(Pos(3, 2, Sul)))
  check.eq(acao(Pos(2, 2, Leste), Avancar(4)), Ok(Pos(2, 6, Leste)))
  check.eq(acao(Pos(2, 2, Oeste), Avancar(1)), Ok(Pos(2, 1, Oeste)))


  check.eq(acao(Pos(2, 2, Norte), Avancar(3)), Error("Erro! A quantidade de casas a serem avançadas ultrapassa o limite do tabuleiro."))
  check.eq(acao(Pos(8, 2, Sul), Avancar(3)), Error("Erro! A quantidade de casas a serem avançadas ultrapassa o limite do tabuleiro."))
  check.eq(acao(Pos(2, 8, Leste), Avancar(3)), Error("Erro! A quantidade de casas a serem avançadas ultrapassa o limite do tabuleiro."))
  check.eq(acao(Pos(2, 2, Oeste), Avancar(3)), Error("Erro! A quantidade de casas a serem avançadas ultrapassa o limite do tabuleiro."))
}