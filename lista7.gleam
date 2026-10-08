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