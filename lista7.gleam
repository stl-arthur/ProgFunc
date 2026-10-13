import sgleam/check
import gleam/int

// 4) Projete uma função que receba como entrada um número natural n e um valor v e crie uma nova lista
// com n repetições do valor v.

/// Dada uma lista de valores inteiros e um número inteiro 'n', adiciona n ao final da lista
pub fn add_final(lista: List(Int), n: Int) -> List(Int){
    case lista{
        [] -> [n]
        [prim] -> [prim, n]
        [prim, ..resto] -> [prim, ..add_final(resto, n)]
    }
}


/// Recebe como parâmetro dois números inteiros 'n' e 'v', e cria uma lista de n repetições de v
pub fn repete_num(n: Int, v: Int) -> List(Int){
    case n{
        _ if n < 0 -> []
        _ if n == 0 -> []
        _ -> add_final(repete_num(n - 1, v), v)
    }
}

pub fn repete_num_examples(){
    check.eq(repete_num(4, 3), [3, 3, 3, 3])
    check.eq(repete_num(0, 5), [])
    check.eq(repete_num(-5, 0), [])
    check.eq(repete_num(3, 10), [10, 10, 10])
}

// 5) Projete uma função que receba como entrada um número a e um número natural n e calcule o valor
// a^n. A função deve ser total: se n for negativo, ela deve indicar um erro.

/// Recebe entradas de inteiros 'a' e 'n' e retorna o valor de a^n, caso o valor de n seja menor que zero
/// a função retorna erro
pub fn eleva_num(a: Int, n: Int) -> Result(Int, String){
    case n{
        _ if n < 0 -> Error("Expoente menor que zero")
        _ if n == 0 -> Ok(1)
        _ -> case eleva_num(a, n-1){
            Error(x) ->  Error(x)
            Ok(x) -> Ok(a * x)
        }
    }
}

pub fn eleva_num_examples(){
    check.eq(eleva_num(2, 3), Ok(8))
    check.eq(eleva_num(2, 1), Ok(2))
    check.eq(eleva_num(2, 0), Ok(1))
    check.eq(eleva_num(2, -1), Error("Expoente menor que zero"))
    check.eq(eleva_num(0, 3), Ok(0))
}

// 6) Projete uma função que receba como entrada um número natural n e calcule o produto dos números
// 1, 2, . . . , n.

/// Recebe um número inteiro 'n' e multiplica todos os números naturais até n (1*2*3*...*n)
/// caso a entrada seja negativa ou zero, retorna 0
pub fn mult_ate_n(n: Int) -> Int{
    case n{
        _ if n < 0 -> 0
        _ if n == 0 -> 0
        _ -> case mult_ate_n(n-1) != 0{
            True -> n * mult_ate_n(n-1)
            False -> 1
        }
    }
}

pub fn mult_ate_n_examples(){
    check.eq(mult_ate_n(6), 720)
    check.eq(mult_ate_n(3), 6)
    check.eq(mult_ate_n(2), 2)
    check.eq(mult_ate_n(1), 1)
    check.eq(mult_ate_n(0), 0)
    check.eq(mult_ate_n(-3), 0)
}

// 7) Recursão indireta é quando duas ou mais funções chamam uma à outra. Projete duas funções, par e
// impar, que recebam como entrada um número natural e determinem se ele é par ou ímpar, respecti-
// vamente. A função par deve chamar a impar, e a impar deve chamar a par. As funções devem ser
// totais: se a entrada for negativa, elas devem indicar um erro.

/// Retorna se um número natural (Inteiro) 'n' é Impar ou não, retorna Error para valores negativos
pub fn eh_impar(n: Int) -> Result(Bool, String){
    case n{
        _ if n < 0 -> Error("Valor Negativo")
        _ if n == 0 -> Ok(False)
        _ -> case eh_par(n-1){
            Ok(x) -> Ok(x)
            Error(_) -> Ok(False)
        }
    }
}

pub fn eh_impar_examples(){
    check.eq(eh_impar(3), Ok(True))
    check.eq(eh_impar(-3), Error("Valor Negativo"))
    check.eq(eh_impar(0), Ok(False))
    check.eq(eh_impar(2), Ok(False))
    check.eq(eh_impar(6), Ok(False))
}

/// Retorna se um número natural (Inteiro) 'n' é par ou não, retorna Error para valores negativos 
pub fn eh_par(n: Int) -> Result(Bool, String){
    case n{
        _ if n < 0 -> Error("Valor Negativo")
        _ if n == 0 -> Ok(True)
        _ -> case eh_impar(n-1){
            Ok(x) -> Ok(x)
            Error(_) -> Ok(True) 
        }
    }
}

pub fn eh_par_examples(){
    check.eq(eh_par(2), Ok(True))
    check.eq(eh_par(1), Ok(False))
    check.eq(eh_par(-1), Error("Valor Negativo"))
    check.eq(eh_par(0), Ok(True))
    check.eq(eh_par(6), Ok(True))
}

// 8) Projete uma função que receba como entrada dois inteiros a e b e devolva a lista com os inteiros
// a, a + 1, . . . , b. Se b < a, a função deve devolver a lista vazia. Use o modelo para inteiros maiores ou
// iguais a a.

/// Retorna uma lista de números inteiros do intervalo de [a, b], onde a e b são valores inteiros
/// informados como parâmetro. Trataremos de dois casos, a < b -> retorna a lista no intervalo;
/// b < a -> retorna lista vazia
pub fn intervalo(a: Int, b) -> List(Int){
    case a{
        _ if a > b -> []
        _ if a == b -> [b]
        _ -> [a, ..intervalo(a+1, b)]
        
        
    }
}

pub fn intervalo_examples(){
    check.eq(intervalo(5, 8), [5, 6, 7, 8])
    check.eq(intervalo(7, 4), [])
    check.eq(intervalo(2, 4), [2, 3, 4])
    check.eq(intervalo(2, 2), [2])
}

// 9) Em um determinado jogo de construção de itens, cada item tem uma classe que varia de 1 a 10. Os
// itens de classe 1 surgem conforme o jogador explora os baús. Um item de classe 2 ou superior precisa
// ser construído unindo dois itens da classe anterior. Por exemplo, para construir um item de classe 2
// é necessário unir dois itens de classe 1. Para construir um item de classe 10 é necessário unir dois
// itens de classe 9. Projete uma função total que receba como entrada a classe de um item e determine
// quantos itens de classe 1 são necessários para construí-lo. Suponha que as únicas operações aritméticas
// disponíveis sejam a soma e a multiplicação.

/// Retorna a quantidade de itens de nível 1 necessários para construir um item de nivel 'n', tal que 'n' é o valor
/// do nível a ser construído informado como parâmetro.
/// As construções seguem uma regra, para cada nível a ser construído são necessários dois itens do nível anterior, ou seja,
/// para construir um item de nível 10, são necessários dois itens de nível 9, para construir um item de nível 9, são necessários
/// dois itens de nível 8, e assim por diante até chegar no nível 1
pub fn num_um_para_n(nivel: Int) -> Result(Int, String){
    case nivel{
        _ if nivel <= 0 -> Error("Nível Não Existente!")
        _ if nivel <= 10 -> eleva_num(2, nivel - 1)
        _ -> Error("Nível Não Existente!")


    }
} 

pub fn num_um_para_n_examples(){
    check.eq(num_um_para_n(3), Ok(4))
    check.eq(num_um_para_n(6), Ok(32))
    check.eq(num_um_para_n(2), Ok(2))
    check.eq(num_um_para_n(1), Ok(1))
    check.eq(num_um_para_n(0), Error("Nível Não Existente!"))
    check.eq(num_um_para_n(-5), Error("Nível Não Existente!"))
    check.eq(num_um_para_n(20), Error("Nível Não Existente!"))
}