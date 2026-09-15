import gleam/string
import sgleam/check
import gleam/float
import gleam/int
import gleam/option.{type Option, Some, None}

// 8) Projete uma união para representar um espectador de uma sala de cinema, que pode ser uma criança,
// um jovem, um adulto ou um idoso. Um jovem pode opcionalmente apresentar sua carteirinha com um
// código numérico de estudante. Em seguida,
// a) Projete uma função que retorne o número da carteirinha de estudante, caso o espectador a tenha.
// b) Projete uma função que retorne um valor booleano indicando se o espectador tem direito ou não
// a um desconto no ingresso. Crianças e idosos sempre têm desconto. Um adulto não tem desconto.
// E um jovem só tem desconto se tiver uma carteirinha de estudante.

/// Tipo união que contém as categorias de idades de espectadores e seus atributos (caso hajam atributos)
pub type Espectador{
    Crianca
    Jovem(Option(Int))
    Adulto
    Idoso
}

/// Retorna o número da carteirinha de estudante de um espectador jovem caso o mesmo a tenha
pub fn carteirinha(cliente: Espectador) -> Option(Int){
    case cliente{
        Crianca | Adulto | Idoso -> None
        Jovem(a) -> case a{
            None -> None
            Some(a) -> Some(a)
        }
    }
}

pub fn carteirinha_examples(){
    check.eq(carteirinha(Crianca), None)
    check.eq(carteirinha(Adulto), None)
    check.eq(carteirinha(Idoso), None)
    check.eq(carteirinha(Jovem(None)), None)
    check.eq(carteirinha(Jovem(Some(54321))), Some(54321))
}


/// Retorna um valor booleano referente ao direito de desconto no ingresso do cinema
/// somente crianças e idosos tem garantia de desconto, adultos não possuem desconto
/// e jovens só recebem desconto caso possuam carteirinha de estudante
pub fn tem_desconto(cliente: Espectador) -> Bool{
    case cliente{
        Crianca | Idoso -> True
        Adulto -> False
        Jovem(a) -> case carteirinha(Jovem(a)){
            None -> False
            Some(_) -> True
        }
    }
}

pub fn tem_desconto_examples(){
    check.eq(tem_desconto(Crianca), True)
    check.eq(tem_desconto(Idoso), True)
    check.eq(tem_desconto(Adulto), False)
    check.eq(tem_desconto(Jovem(None)), False)
    check.eq(tem_desconto(Jovem(Some(4321))), True)
}

// 8) Projete uma função que receba dois Option(Int) e devolva Some da soma dos dois valores apenas se
// os dois estiverem presentes, e None caso contrário.

/// Realiza a soma entre dois números somente caso haja dois números a serem somados na entrada,
/// as entradas são do tipo Option(Int), podendo trazer valor nulo ou inteiro
/// A função retornará um Option equivalente a soma dos dois valores
pub fn soma(a: Option(Int), b: Option(Int)) -> Option(Int){
    case a{
        None -> None
        Some(a) -> case b{
            None -> None
            Some(b) -> Some(a + b)
        } 
    }
}

pub fn soma_examples(){
    check.eq(soma(None, None), None)
    check.eq(soma(None, Some(1)), None)
    check.eq(soma(Some(3), None), None)
    check.eq(soma(Some(7), Some(3)), Some(10))
}

// 10) Projete uma função que receba o número de um mês em forma de string e devolva a quantidade de dias
// desse mês, considerando um ano não bissexto. A função deve falhar se a string não representar um
// número ou se o número não estiver entre 1 e 12. Em seguida, defina um tipo de erro com as variantes
// NaoNumero e ForaDaFaixa e modifique a função para devolver esse tipo em vez de Nil.

/// Tipo enumerado relacionado a erros de entrada de número do mês, caso seja um número fora do limite do ano
///  mes < 1 ou 12 < mes
/// e caso a entrada seja uma string não númerica
pub type ErroMes{
    NaoNumero
    ForaDaFaixa
}

/// Tem como entrada uma String numérica representando algum mês do ano, e, de acordo com esse valor 
/// diz quantos dias aquele mês tem, a função cobre casos de entradas inválidas, sejam elas valores numéricos
/// que não correspondam com o intervalo de meses ou entradas não numéricas, a função também desconsidera a possibilidade
/// de ano bissexto. O retorno da função é um Result que pode ser tanto a quantidade de dias do mês ou então do erro de entrada
pub fn dias_no_mes(mes: String) -> Result(Int, ErroMes){
    let mes_parse = int.parse(mes)
    case mes_parse{
        Error(_) -> Error(NaoNumero)
        Ok(a) -> case {a <= 12 && a >= 1}{
            False -> Error(ForaDaFaixa)
            True -> case a == 2{
                True -> Ok(28)
                False -> case a == 1 || a == 3 || a == 5 || a == 7 || a == 8 || a == 10 || a == 12{
                    True -> Ok(31)
                    False -> Ok(30)
                }
            }
        }
    }
}

pub fn dias_no_mes_examples(){
    check.eq(dias_no_mes("ab"), Error(NaoNumero))
    check.eq(dias_no_mes("0"), Error(ForaDaFaixa))
    check.eq(dias_no_mes("14"), Error(ForaDaFaixa))
    check.eq(dias_no_mes("1"), Ok(31))
    check.eq(dias_no_mes("3"), Ok(31))
    check.eq(dias_no_mes("5"), Ok(31))
    check.eq(dias_no_mes("7"), Ok(31))
    check.eq(dias_no_mes("8"), Ok(31))
    check.eq(dias_no_mes("10"), Ok(31))
    check.eq(dias_no_mes("12"), Ok(31))
    check.eq(dias_no_mes("4"), Ok(30))
    check.eq(dias_no_mes("6"), Ok(30))
    check.eq(dias_no_mes("9"), Ok(30))
    check.eq(dias_no_mes("11"), Ok(30))
    check.eq(dias_no_mes("2"), Ok(28))
}

// 11) Projete uma função que receba duas strings e, se as duas representarem inteiros e o segundo não for
// zero, devolva o resultado da divisão do primeiro pelo segundo em forma de string. Em seguida, defina
// um tipo de erro que distinga as três causas de falha e modifique a função para devolver esse tipo em
// vez de Nil.

/// Tipo de dado enumerado que se refere a tipos de erros de entrada
pub type Erros{
    UmNaoInt
    AmbosNaoInt
    DivisorZero
}

/// Recebe dua Strings, a String deve representar um valor inteiro, realiza a divisão
/// do primeiro elemento pelo segundo (se o segundo elemento for diferente de 0), e retorna o Result(Int, Erro) com o Int
/// sendo o valor retornado pela divisão, e o Erro sendo um tipo enumerado que identifica o tipo de erro de entrada da função, sendo elas:
/// Erro de valor que não representa Int e Valor do segundo elemento igual à 0
pub fn divide_str(a: String, b: String) -> Result(Int, Erros){
    let a_parse = int.parse(a)
    let b_parse = int.parse(b)
    case a_parse, b_parse{
        Error(_), Error(_) -> Error(AmbosNaoInt)
        Error(_), Ok(_) -> Error(UmNaoInt)
        Ok(_), Error(_) -> Error(UmNaoInt)
        Ok(a), Ok(b) -> case b == 0{
            True -> Error(DivisorZero)
            False -> Ok(a / b)
        }
        }
    }


pub fn divide_str_examples(){
    check.eq(divide_str("10", "2"), Ok(5))
    check.eq(divide_str("10", "b"), Error(UmNaoInt))
    check.eq(divide_str("a", "7"), Error(UmNaoInt))
    check.eq(divide_str("a", "b"), Error(AmbosNaoInt))
    check.eq(divide_str("10", "0"), Error(DivisorZero))

}

// 12) Ao ler os dados de um formulário, um campo pode estar vazio, ter um valor inválido, ou ter um valor
// válido. Projete uma união parametrizada Campo(a) que represente essas três situações, guardando o
// texto digitado no caso inválido e o valor no caso válido. Em seguida,
// a) Projete uma função que receba uma string e devolva o Campo(Int) correspondente, considerando
// que a string vazia representa o campo vazio.
// b) Projete uma função que receba um Campo(a) e devolva Some do valor se o campo for válido, e
// None caso contrário.

/// Tipo união parametrizado, para entradas de String vazia, inválida e válida
pub type Campo(a){
    Vazio
    Invalido(String)
    Valido(a)
}

/// Confere se a entrada de um formulário como String é válida, ou seja, é um valor inteiro
/// a saída deve ser do tipo Campo, cobrindo todas as possíbilidades de entrada na String
pub fn formulario(a: String) -> Campo(Int){
    let a_parse = int.parse(a)
    case a == ""{
        True -> Vazio
        False -> case a_parse{
            Error(_) -> Invalido(a)
            Ok(a) -> Valido(a)
        }

    }
}

pub fn formulario_examples(){
    check.eq(formulario("Teste"), Invalido("Teste"))
    check.eq(formulario(""), Vazio)
    check.eq(formulario("5"), Valido(5))
}

pub fn some_forms(entrada: Campo(a)) -> Option(a){
    case entrada{
        Vazio | Invalido(_) -> None
        Valido(a) -> Some(a)
    }
}

pub fn some_forms_examples(){
    check.eq(some_forms(Vazio), None)
    check.eq(some_forms(Invalido("Parte")), None)
    check.eq(some_forms(Invalido("5")), None)
    check.eq(some_forms(Valido(5)), Some(5))
    check.eq(some_forms(Valido("teste")), Some("teste"))


}

// 13) Projete um tipo opaco para representar uma data com dia, mês e ano, com uma função construtora
// que valide o valor e devolva um Result. Em seguida,
// a) Projete uma função que receba como entrada uma string que representa uma data no formato
// “dd/mm/aaaa” e a converta para a data equivalente. A validação inicial na função construtora
// deve verificar apenas se as partes são números.
// b) Projete uma função que verifique se uma data corresponde ao último dia do ano.
// c) Projete uma função que receba duas datas e devolva True se a primeira data ocorrer antes da
// segunda.
// d) (Desafio) Modifique a função construtora de maneira que ela verifique se uma data é válida.
// Considere que, em anos bissextos, fevereiro tem 29 dias e que um ano é bissexto se for múltiplo
// de 400 ou se for múltiplo de 4, mas não de 100.

/// Tipo de dado opaco que contém uma data, sendo dia mes e ano
pub opaque type Data{
    Data(dia: Int, mes: Int, ano: Int)
}

/// Vê se uma String de data dd/mm/aaaa tem valores numéricos válidos para transformar 
/// para um tipo de dado com esses valores
pub fn confere_dt(data: String) -> Result(Data, Nil){
    let dia = int.parse(string.slice(data, 0, 2))
    let mes = int.parse(string.slice(data, 3, 2))
    let ano = int.parse(string.slice(data, 6, 4))
    case dia, mes, ano{
        Ok(d), Ok(m), Ok(a) -> Ok(Data(d, m, a))
        _, _, _ -> Error(Nil)
    }
} 

pub fn confere_dt_examples(){
    check.eq(confere_dt("25/07/4000"), Ok(Data(25, 07, 4000)))
    check.eq(confere_dt("25/07/4cc0"), Error(Nil))
    check.eq(confere_dt("25/v7/1240"), Error(Nil))
    check.eq(confere_dt("w5/07/4cc0"), Error(Nil))
    check.eq(confere_dt("125/07/4cc0"), Error(Nil))
    check.eq(confere_dt("25/107/4cc0"), Error(Nil))
}