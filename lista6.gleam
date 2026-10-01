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


// 12) Projete uma função que verifique se uma lista de números está em ordem não decrescente. Dica: use
// dois casos base



// 17) O Miguel é doutorando em física e precisa coletar dados de um experimento, mas ele só tem à sua dis-
// posição um equipamento precário que produz algumas leituras incorretas. O equipamento não deveria
// produzir valores negativos, mas em um teste preliminar o Miguel percebeu que o equipamento está
// produzindo números negativos. A boa notícia é que todos os números não negativos produzidos pelo
// equipamento estão corretos. Projete uma função que elimine os valores incorretos de uma sequência
// de valores produzidos pelo equipamento.

/// Função que dado uma lista de valores inteiros, remove todos os valores não positivos e retorna a lista
/// somente com valores inteiros positivos
pub fn rem_neg(lista: List(Int)) -> List(Int){
    case lista{
        [] -> []
        [prim, ..resto] -> 
        case prim < 0{
            True -> rem_neg(resto)
            False -> [prim, ..rem_neg(resto)]
        }
    }
}

pub fn rem_neg_examples(){
    check.eq(rem_neg([1, 2, -1, -5, 4]), [1, 2, 4])
    check.eq(rem_neg([]), [])
    check.eq(rem_neg([-1, -6]), [])
    check.eq(rem_neg([-1]), [])
    check.eq(rem_neg([1]), [1])
}

// 18) Júlia tem uma pequena empresa de sorvetes que vende três sabores diferentes: manga, uva e morango.
// Cada sorvete é vendido por 10 reais, mas o custo de produção de cada sorvete depende do sabor: o de
// manga custa 6, o de uva 7 e o de morango 8. Toda vez que a Júlia vende um sorvete ela anota o sabor
// em uma lista. Após ter anotado os sabores dos sorvetes vendidos em uma lista, é hora de calcular
// quanto foi o ganho, e para isso a Júlia precisa da sua ajuda. Projete uma função que receba como
// entrada uma lista com os sabores dos sorvetes vendidos e calcule qual foi o ganho da Júlia vendendo
// os sorvetes.


/// Tipo enumerado respectivo aos sabores de sorvete em uma sorveteria
pub type Sabor{
    Manga
    Uva
    Morango
}


/// Recebe como parametro uma lista de sabores, os sabores são do tipo enumerado 'Sabor',
/// a função retorna o valor total recebido através dos sabores presentes na lista
/// cada sabor tem um valor relacionado a ser somado no total recebido
/// Manga > 4
/// Uva > 3
/// Morango > 2

pub fn lucro_sorvete(vendas: List(Sabor)) -> Int{
    case vendas{
        [] -> 0
        [sabor, ..resto] ->
        case sabor{
            Manga -> 4 + lucro_sorvete(resto)
            Uva -> 3 + lucro_sorvete(resto)
            Morango -> 2 + lucro_sorvete(resto)
        }
    }
}

pub fn lucro_sorvete_examples(){
    check.eq(lucro_sorvete([Morango, Morango]), 4)
    check.eq(lucro_sorvete([Morango, Uva]), 5)
    check.eq(lucro_sorvete([Uva, Morango]), 5)
    check.eq(lucro_sorvete([Manga, Manga, Manga]), 12)
    check.eq(lucro_sorvete([]), 0)
    check.eq(lucro_sorvete([Uva, Morango, Manga, Manga, Uva, Morango]), 18)
}