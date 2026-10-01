import sgleam/check
import gleam/int

// 7) Projete uma função que concatene todos os elementos de uma lista de strings.

/// Concatena todos os elementos de uma lista de strings, transformando-os em uma unica string
pub fn concat_lista(lista: List(String)) -> String{
    case lista{
        [] -> ""
        [primeiro, ..resto] -> 
        primeiro <> concat_lista(resto)
    }
}

pub fn concat_lista_examples(){
    check.eq(concat_lista(["1", "2", "3"]), "123")
    check.eq(concat_lista([]), "")
    check.eq(concat_lista(["1", "3"]), "13")
    check.eq(concat_lista(["1"]), "1")
}

// 8) Projete uma função que determine a quantidade de elementos de uma lista de números

/// Dado uma lista de números inteiros, retorna a quantidade de elementos que essa lista possui
pub fn conta_num(lista: List(Int)) -> Int{
    case lista{
        [] -> 0
        [_, ..resto] ->
        1 + conta_num(resto)
    }
} 

pub fn conta_num_examples(){
    check.eq(conta_num([1, 2, 3, 4]), 4)
    check.eq(conta_num([4, 8, 12, 87, 34, -34]), 6)
    check.eq(conta_num([2]), 1)
    check.eq(conta_num([]), 0)
}

// 9) Projete uma função que converta uma lista de números para uma lista de strings (use a função
// int.to_string).

/// Constrói uma nova lista de strings através de uma lista de inteiros convertendo os valores inteiros em string e os atribuindo
/// a nova lista
pub fn transf_lista(lista: List(Int)) -> List(String){
    case lista{
        [] -> []
        [prim, ..resto] ->
        [int.to_string(prim), ..transf_lista(resto)]
    }
}

pub fn transf_lista_examples(){
    check.eq(transf_lista([1, 2, 3, 4]), ["1", "2", "3", "4"])
    check.eq(transf_lista([2]), ["2"])
    check.eq(transf_lista([]), [])
}

// 10) Projete uma função que crie uma nova lista removendo as strings vazias de uma lista de strings.

/// Remove todas as Strings vazias de uma lista de Strings
pub fn rem_vazio(lista: List(String)) -> List(String){
    case lista{
        [] -> []
        [prim, ..resto] ->
        case prim != ""{
            True -> [prim, .. rem_vazio(resto)]
            False -> rem_vazio(resto)
        }
    }
}

pub fn rem_vazio_examples(){
    check.eq(rem_vazio(["a", "b"]), ["a", "b"])
    check.eq(rem_vazio(["", "b"]), ["b"])
    check.eq(rem_vazio(["a", ""]), ["a"])
    check.eq(rem_vazio(["a", "b", ""]), ["a", "b"])
    check.eq(rem_vazio(["", "a", "b", "", "c", "d", ""]), ["a", "b", "c", "d"])
    check.eq(rem_vazio([""]), [])
    check.eq(rem_vazio([]), [])
}

// 11) Projete uma função que verifique se todos os elementos de uma lista de booleanos são verdadeiros. Se
// a sua implementação inicial utilizar condicional para fazer a chamada recursiva, faça uma versão que
// não utilize condicional.

pub fn verifica_true(lista: List(Bool)) -> Bool{
    case lista{
        [] -> True
        [prim, ..resto] ->
        prim && verifica_true(resto)
    }
}

pub fn verifica_true_examples(){
    check.eq(verifica_true([True, True]), True)
    check.eq(verifica_true([True, False]), False)
    check.eq(verifica_true([False, True]), False)
    check.eq(verifica_true([False, False]), False)
    check.eq(verifica_true([False, True, True, False, True, False]), False)
    check.eq(verifica_true([]), True)
}
