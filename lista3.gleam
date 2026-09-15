// 1) Quais são as etapas do processo de projeto de funções?
// Análise, Definição, Especificação, Implementação, Verificação e Revisão

//2) Qual é o propósito da análise?
// Abstrair o problema a ser resolvido, resumir o mesmo e especificar pontos
// que ficaram ímplicitos

// 3) Qual é o propósito da definição dos tipos de dados?
// Listar definir os dados abstraídos da análise e seus tipos, para que sejam usados
// de maneira correta durante a implementação do código

// 4) Quais são as partes que compõem a especificação de uma função?
// Assinatura da função, definição da função e exemplos

// 5) Qual é a principal propriedade que uma especificação deve ter para ser considerada adequada?
// Exemplos corretos e adequados 

// 6) O que é a assinatura de uma função?
// É o nome que a função recebe, suas entradas e tipos,
// saídas e tipos, ex: funcao(entrada: int) -> Int{}

// 7) Qual é o objetivo inicial dos exemplos no projeto de uma função? E os demais objetivos?
// 

// 13) Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.

/// Produz True se uma pessoa com *idade* é isento da
/// tarifa de transporte público, isto é, tem 
/// 18 anos ou menos ou 65 ou mais. Produz False caso contrário.
import gleam/int
import gleam/list
import gleam/string
import sgleam/check
import gleam/float

pub fn isento_tarifa(idade: Int) -> Bool {
  case idade <= 18 {
    True -> True
    False ->
      case idade >= 65 {
        True -> True
        False -> False
      }
  }
}

pub fn isento_tarifa_examples() {
  check.eq(isento_tarifa(17), True)
  check.eq(isento_tarifa(18), True)
  check.eq(isento_tarifa(50), False)
  check.eq(isento_tarifa(65), True)
  check.eq(isento_tarifa(70), True)
}

// Comparando a especificação com os exemplos, na verdade a isenção ocorre
// quando o cidadão tem 18 ou menos, '<=' e não '<'

// 14) Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.

//Função auxiliar >>

/// Transforma um número qualquer para sua versão absoluta (positiva)
pub fn abs(x: Int) -> Int {
  case x >= 0 {
    True -> x
    False -> -x
  }
}

/// Conta a quantidade de dígitos de *n*.
/// Se *n* é 0, então devolve zero.
/// Se *n* é menor que zero, então devolve a quantidade
/// de dígitos do valor absoluto de *n*.
pub fn quantidade_digitos(n: Int) -> Int {
  case n == 0 {
    True -> 0
    False ->
      case n > 0 {
        True -> string.length(int.to_string(n))
        False -> string.length(int.to_string(abs(n)))
      }
  }
}

pub fn quantidade_digitos_examples() {
  check.eq(quantidade_digitos(123), 3)
  check.eq(quantidade_digitos(0), 0)
  check.eq(quantidade_digitos(-1519), 4)
}

// No exercicio um dos exemplos estava dando errado, de acordo com a especificação, quando temos entrada 0
// o retorno também deve ser 0, entre mudar no exemplo e na especificação achei melhor mudar no exemplo 

//15) Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.

/// Produz True se uma pessoa com *idade* é supercentenária,
/// isto é, tem mais de 110 anos, produz False caso contrário.
pub fn supercentenario(idade: Int) -> Bool {
  case idade > 110 {
    True -> True
    False -> False
  }
}

pub fn supercentenario_examples() {
  check.eq(supercentenario(101), False)
  check.eq(supercentenario(110), False)
  check.eq(supercentenario(112), True)
}

// 16) Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.

// VERSÃO SIMPLES UTILIZANDO FERRAMENTAS DO GLEAM

/// Transforma a string *data* que está no formato "dia/mes/ano"
/// para o formato "ano/mes/dia".
///
/// Requer que o dia e o mês tenham dois dígitos e que
/// o ano tenha quatro dígitos
pub fn dma_para_amd_simples(data: String) -> String {
  string.join(list.reverse(string.split(data, "/")), "/")
}

pub fn dma_para_amd_simples_examples() {
  check.eq(dma_para_amd_simples("19/07/2023"), "2023/07/19")
  check.eq(dma_para_amd_simples("01/01/1980"), "1980/01/01")
  check.eq(dma_para_amd_simples("02/02/2002"), "2002/02/02")
}

// VERSÃO TRABALHOSA

// -------------- Funções auxiliares --------------

/// Pega os dois primeiros caracteres (dia) da string data no formato "dia/mes/ano"
pub fn dia_from_dma(data: String) -> String {
  string.slice(data, 0, 2)
}

pub fn dia_from_dma_examples() {
  check.eq(dia_from_dma("26/09/2007"), "26")
  check.eq(dia_from_dma("27/11/2007"), "27")
  check.eq(dia_from_dma("11/01/2007"), "11")
}

/// Pega os quatro ultimos caracteres (ano) da string data no formato "dia/mes/ano"
pub fn ano_from_dma(data: String) -> String {
  string.slice(data, 6, 4)
}

pub fn ano_from_dma_examples() {
  check.eq(ano_from_dma("06/08/1971"), "1971")
  check.eq(ano_from_dma("26/06/1997"), "1997")
  check.eq(ano_from_dma("19/11/1982"), "1982")
}

// --------------------------------------------------

/// Transforma a string *data* que está no formato "dia/mes/ano"
/// para o formato "ano/mes/dia".
///
/// Requer que o dia e o mês tenham dois dígitos e que
/// o ano tenha quatro dígitos
pub fn dma_para_amd(data: String) -> String {
  ano_from_dma(data) <> string.slice(data, 2, 4) <> dia_from_dma(data)
}

pub fn dma_para_amd_examples() {
  check.eq(dma_para_amd("19/07/2023"), "2023/07/19")
  check.eq(dma_para_amd("01/01/1980"), "1980/01/01")
  check.eq(dma_para_amd("02/02/2002"), "2002/02/02")
}

// 17) Escreva a especificação para a seguinte implementação de função. Avalie se a sua especificação está
// boa, verificando se ela sozinha é suficiente para um desenvolvedor fazer uma implementação da função.

/// Soma o valor de entrada à "porcentagem" por cento do próprio valor 
pub fn aumenta(valor: Float, porcentagem: Float) -> Float {
  valor *. { 1.0 +. porcentagem /. 100.0 }
}

pub fn aumenta_example() {
  check.eq(aumenta(10.0, 10.0), 11.0)
  check.eq(aumenta(100.0, 67.0), 167.0)
  check.eq(aumenta(52.0, 15.0), 59.8)
}

// 18) Escreva a especificação para a seguinte implementação de função. Avalie se a sua especificação está
// boa, verificando se ela sozinha é suficiente para um desenvolvedor fazer uma implementação da função.

/// Verifica o tamanho de um nome, caso o nome tenha 4 ou menos caracteres (<= 4), retorna "curto"
/// caso tenha entre 5 e 10 caracteres (4< qtde <= 10) retorna "médio" 
/// e caso tenha mais que 10 caracteres (10<) retorna "longo"
pub fn tamanho_nome(nome: String) -> String {
  case string.length(nome) <= 4 {
    True -> "curto"
    False ->
      case string.length(nome) <= 10 {
        True -> "médio"
        False -> "longo"
      }
  }
}

pub fn tamanho_nome_examples() {
  check.eq(tamanho_nome("cinco"), "médio")
  check.eq(tamanho_nome("palindromo"), "médio")
  check.eq(tamanho_nome("palindromos"), "longo")
}

// 19) Projete uma função que adicione um ponto final a uma frase se ela não acabar com um.

/// Confere se o ultimo caractere de uma string não vazia é um ponto final, caso seja, retorna a string,
/// do contrário, adiciona um ponto final ao final da string, e retorna a string com um ponto final
pub fn add_ponto(palavra: String) -> String {
  case
    string.slice(
      palavra,
      {
        string.length(palavra)
        -1
      },
      1,
    )
    == "."
  {
    True -> palavra
    False -> palavra <> "."
  }
}

pub fn add_ponto_examples() {
  check.eq(add_ponto("teste"), "teste.")
  check.eq(add_ponto("teste2."), "teste2.")
  check.eq(add_ponto(" "), " .")
}

// 20) Projete uma função que determine se uma palavra tem um traço ("-") no meio, como por exemplo,
// "lero-lero". Não use nenhum condicional na implementação.

/// Confere se uma String não vazia contém um caractere "-" no meio, caso contenha, retorna True
/// do contrário retorna False
pub fn tem_hifen(palavra: String) -> Bool {
  string.slice(palavra, { string.length(palavra) / 2 }, 1) == "-"
}

pub fn tem_hifen_examples() {
  check.eq(tem_hifen("teste-teste"), True)
  check.eq(tem_hifen("sim"), False)
  check.eq(tem_hifen("a-b"), True)
}

// 21) Projete uma função que encontre o máximo entre três números dados

/// Faz a comparação entre três números inteiros dados como entrada e retorna o maior entre eles
pub fn maior_tres(x: Int, y: Int, z: Int) -> Int {
  case x > y && x > z {
    True -> x
    False ->
      case y > x && y > z {
        True -> y
        False -> z
      }
  }
}

pub fn maior_tres_example() {
  check.eq(maior_tres(1, 2, 3), 3)
  check.eq(maior_tres(5, 29, 0), 29)
  check.eq(maior_tres(1, 1, 1), 1)
  check.eq(maior_tres(509, 2, 1), 509)
}

// 22) Projete uma função que receba como parâmetro uma string e um número natural n e substitua os
// primeiros n caracteres da string por n letras x.

/// Pega uma string de entrada qualquer e transforma seus n primeiros caracteres em 'x'
/// 'n' também é um valor natural dado como parametro na função
pub fn troca_caracter_x(palavra: String, n: Int) -> String {
  string.repeat("x", times: n) <> string.slice(palavra, n, 90)
}

pub fn troca_caracter_x_examples() {
  check.eq(troca_caracter_x("Teste", 3), "xxxte")
  check.eq(troca_caracter_x("Palavra", 10), "xxxxxxxxxx")
  check.eq(troca_caracter_x("oi", 1), "xi")
}

// 23) Você está fazendo um programa e precisa verificar se um texto digitado pelo usuário está de acordo
// com algumas regras. A regra “sem espaços extras” requer que o texto não comece e não termine com
// espaços. Projete uma função que verifique se um texto qualquer está de acordo com a regra “sem
// espaços extras”.

/// Confere se uma string começa com espaço " ", caso sim, remove os espaços
/// do contrário apenas retorna a string normalmente
pub fn sem_espaco_ini(palavra: String) -> String {
  case string.slice(palavra, 0, 1) == " " {
    True -> string.slice(palavra, 1, string.length(palavra))
    False -> palavra
  }
}

pub fn sem_espaco_ini_examples() {
  check.eq(sem_espaco_ini(" Teste"), "Teste")
  check.eq(sem_espaco_ini("segundo"), "segundo")
  check.eq(sem_espaco_ini(" terceiro "), "terceiro ")
}

/// Confere se uma string termina com espaço " ", caso termine, remove o espaço extra, do contrario
/// retorna ela normalmente
pub fn sem_espaco_extra(palavra: String) -> String {
  case string.slice(sem_espaco_ini(palavra), -1, 1) == " " {
    True ->
      string.slice(sem_espaco_ini(palavra), 0, {
        string.length(sem_espaco_ini(palavra)) - 1
      })
    False -> sem_espaco_ini(palavra)
  }
}

pub fn sem_espaco_extra_examples() {
  check.eq(sem_espaco_extra(" Teste"), "Teste")
  check.eq(sem_espaco_extra("segundo "), "segundo")
  check.eq(sem_espaco_extra(" terceiro "), "terceiro")
}

// 24) Cada cidadão de um país, cuja moeda chama-se dinheiro, tem que pagar imposto sobre a sua renda.
// Cidadãos que recebem até 1000 dinheiros pagam 5% de imposto. Cidadãos que recebem entre 1000 e
// 5000 dinheiros pagam 5% de imposto sobre 1000 dinheiros e 10% sobre o que passar de 1000. Cidadãos
// que recebem mais de 5000 dinheiros pagam 5% de imposto sobre 1000 dinheiros, 10% de imposto sobre
// 4000 dinheiros e 20% sobre o que passar de 5000. Projete uma função que calcule o imposto que um
// cidadão deve pagar dada a sua renda.

/// Calcula o valor do imposto a respeito do salario em dinheiros de um cidadão 
/// para salarios até 1000.0, o imposto é de 5%
/// para 1000.0 < salario <= 5000.0, o imposto é de 5% sobre 1000.0 + 10% sobre o excedente de 1000.0
/// para 5000 < salario, o imposto é de 5% sobre 1000.0 + 10% sobre 4000.0 + 20% sobre o excedente de 5000.0
pub fn calcula_imposto(salario: Float) -> Float {
  case salario <=. 1000.0 {
    True -> salario *. 0.05
    False ->
      case 1000.0 <. salario && salario <=. 5000.0 {
        True -> 50.0 +. { salario -. 1000.0 } *. 0.1
        False -> 450.0 +. { salario -. 5000.0 } *. 0.2
      }
  }
}

pub fn calcula_imposto_examples() {
  check.eq(calcula_imposto(1000.0), 50.0)
  check.eq(calcula_imposto(1050.0), 55.0)
  check.eq(calcula_imposto(4528.0), 402.8)
  check.eq(calcula_imposto(6790.0), 808.0)
}

// 25) Uma palavra duplicada é formada pela ocorrência de duas partes iguais, separadas ou não por hífen.
// Por exemplo, as palavras xixi, mimi, lero-lero e mata-mata são palavras duplicadas. Projete uma
// função que verifique se uma palavra é duplicada

/// Confere se uma palavra sem hifen é duplicada, ou seja, se a sua primeira metade é igual a segunda metade
/// Essa é uma função auxiliar para a função "confere_dup()" 
pub fn confere_dup_sem_hifen(palavra: String) -> Bool {
  string.slice(palavra, 0, string.length(palavra) / 2)
  == string.slice(
    palavra,
    string.length(palavra) / 2,
    string.length(palavra) / 2,
  )
}

pub fn confere_dup_sem_hifen_examples() {
  check.eq(confere_dup_sem_hifen("lerolero"), True)
  check.eq(confere_dup_sem_hifen("naonao"), True)
  check.eq(confere_dup_sem_hifen("sima"), False)
  check.eq(confere_dup_sem_hifen("soco"), False)
}

/// Confere se uma palavra com hifen é duplicada, ou seja, se a sua primeira metade é igual a segunda metade
/// Essa é uma função auxiliar para a função "confere_dup()"
pub fn confere_dup_com_hifen(palavra: String) -> Bool {
  string.slice(palavra, 0, { string.length(palavra) - 1 } / 2)
  == string.slice(
    palavra,
    { string.length(palavra) + 1 } / 2,
    { string.length(palavra) - 1 } / 2,
  )
}

pub fn confere_dup_com_hifen_examples() {
  check.eq(confere_dup_com_hifen("lero-lero"), True)
  check.eq(confere_dup_com_hifen("nao-nao"), True)
  check.eq(confere_dup_com_hifen("si-ma"), False)
  check.eq(confere_dup_com_hifen("so-co"), False)
}

/// Confere se uma palavra é duplicada, ex: mimi, lero-lero
/// caso a palavra tenha hifen, confere o que vem antes do hifen com o que vem depois
/// se não, confere o que está na primeira metade com o que está na segunda metade
/// a entrada da função é uma String e seu retorno é um booleano
pub fn confere_dup(palavra: String) -> Bool {
  case { string.length(palavra) % 2 } == 0 {
    True -> confere_dup_sem_hifen(palavra)
    False -> confere_dup_com_hifen(palavra)
  }
}

pub fn confere_dup_examples() {
  check.eq(confere_dup("lerolero"), True)
  check.eq(confere_dup("naonao"), True)
  check.eq(confere_dup("sima"), False)
  check.eq(confere_dup("nao-nao"), True)
  check.eq(confere_dup("si-ma"), False)
  check.eq(confere_dup("so-co"), False)
}


// 29) Um construtor precisa calcular a quantidade de azulejos necessários para azulejar uma determinada
// parede. Cada azulejo é quadrado e tem 20cm de lado. Ajude o construtor e defina uma função que
// receba como entrada o comprimento e a altura em metros de uma parede e calcule a quantidade de
// azulejos inteiros necessários para azulejar a parede. Considere que o construtor nunca perde um azulejo
// e que recortes de azulejos não são reaproveitados.

/// Converte um valor numérico de metros para centímetros
pub fn metro_cm(tam: Float) -> Int{
  float.round(tam *. 100.00)
}

/// Faz o arredondamento superior em uma divisão, ou seja,
/// caso x/y = z | z seja Float, o valor retornado é o inteiro sucessor de z
pub fn ceil(x: Int, y: Int) -> Int{
  case x%y == 0{
    True -> x/y
    False -> x/y + 1 
  }
}

pub fn ceil_examples(){
  check.eq(ceil(20, 10), 2)
  check.eq(ceil(14, 3), 5)
  check.eq(ceil(10, 3), 4)
}

/// Encontra a quantidade de azulejos necessários para revestir uma parede de "comprimento" metros de comprimento
/// e "altura" metros de altura, por definição prévia, cada azulejo tem 20cm, não há reaproveitamento de recortes,
/// logo são contabilizados somente quantidades inteiras de azulejo
pub fn qtde_azulejo(comprimento: Float, altura: Float){
  ceil(metro_cm(comprimento), 20) * ceil(metro_cm(altura), 20)
}

pub fn qtde_azulejo_examples(){
  check.eq(qtde_azulejo(2.3, 1.5), 96)
  check.eq(qtde_azulejo(1.0, 1.0), 25)
  check.eq(qtde_azulejo(2.0, 1.1), 60)
}

// 30) Rotacionar uma string n posições à direita significa mover os últimos n caracteres da string para as
// primeiras n posições da string. Por exemplo, rotacionar a string "marcelio" 5 posições à direita
// produz a string "celiomar". Projete uma função que receba como entrada uma string e um número
// n e produza uma nova string rotacionando a string de entrada n posições à direita.

/// move os "n" ultimos caracteres de uma string para o inicio dela
pub fn  move_str(palavra: String, n: Int){
  string.slice(palavra, -n, n) <> string.slice(palavra, 0, string.length(palavra) - n)
}

pub fn move_str_examples(){
  check.eq(move_str("Marte", 3), "rteMa")
  check.eq(move_str("Custo", 2), "toCus")
  check.eq(move_str("parafraseado", 3), "adoparafrase")
}

// 31) No período de 2015 a 2016 todos os números de telefones celulares no Brasil passaram a ter nove dígitos.
// Na época, os números de telefones que tinham apenas oito dígitos foram alterados, adicionando-se o
// 9 na frente do número. Embora oficialmente todos os número de celulares tenham nove dígitos, na
// agenda de muitas pessoas ainda é comum encontrar números registrados com apenas oito dígitos.
// Projete uma função que adicione o nono dígito em um dado número de telefone celular caso ele ainda
// não tenha o nono dígito. Considere que os números de entrada são dados com o DDD entre parênteses
// e com um hífen separando os últimos quatro dígitos. Exemplos de entradas: (44) 9787-1241, (51)
// 95872-9989, (41) 8876-1562. A saída deve ter o mesmo formato, mas garantindo que o número do
// telefone tenha 9 dígitos.

/// Confere se um número de telefone com o formato "(xx) xxxx-xxxx" tem o nono digito (9) "(xx) 9xxxx-xxxx"
/// caso o número de caracteres seja menor que o formato com nono digito, adiciona o digito "9" no começo do número
pub fn formata_telefone(num: String){
  case string.length(num) < 15{
    False -> num
    True -> string.slice(num, 0, 5) <> "9" <> string.slice(num, 5, string.length(num) - 5)
  }
}

pub fn formata_telefone_examples(){
  check.eq(formata_telefone("(44) 98801-8987"), "(44) 98801-8987")
  check.eq(formata_telefone("(44) 8801-8987"), "(44) 98801-8987")
  check.eq(formata_telefone("(44) 8975-5555"), "(44) 98975-5555")
}

// 32) Muitos letreiros exibem mensagens que têm mais caracteres do que eles podem exibir, para isso,
// eles exibem apenas uma porção da mensagem que é alterada com o passar do tempo. Por exemplo,
// em um letreiro de 20 caracteres, a mensagem "Promoção de sorvetes, pague 2 leve 3!" é exibida
// como "Promoção de sorvetes" no momento 0, como "romoção de sorvetes," no momento 1, como
// "omoção de sorvetes, " no momento 2, e assim por diante até que no momento 17 é exibido "tes,
// pague 2 leve 3!". O momento sempre aumenta, e após chegar no final da mensagem ela começa a
// ser exibida novamente, nesse caso, no momento 18 é exibido "es, pague 2 leve 3! " e no momento
// 19 é exibido "s, pague 2 leve 3! P", onde o P é o início da mensagem. Projete uma função que
// determine os caracteres de uma mensagem que devem ser exibidos em um determinado momento em
// um letreiro que pode exibir um determinado número de caracteres. Assuma que o número de caracteres
// da mensagem é maior do que o do letreiro.

/// A FAZER


// 33) Um número inteiro positivo é palíndromo se quando lido da direita para a esquerda ou da esquerda
// para a direita é idêntico. Ex: 9119, 1221, 5665, 7337. Projete uma função que verifique se um dado
// número inteiro de 4 dígitos é palíndromo, considere que o valor de entrada é o próprio número e não os
// quatro dígitos que compõem o número. É possível modificar a sua função de maneira que ela funcione
// para qualquer número de entrada e não apenas para números de 4 dígitos?

/// 