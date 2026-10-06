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

/// Recebe uma lista de números inteiros e retorna se a lista está ordenada em ordem não decrescente ou não
pub fn nao_dec(lista: List(Int)) -> Bool{
    case lista{
        [] -> True
        [_] -> True
        [primeiro, segundo] -> case primeiro <= segundo{
            True -> True
            False -> False
        }
        [primeiro, segundo, ..resto] -> case {primeiro <= segundo} && {nao_dec(resto) == True}{
            True -> True
            False -> False
        } 
    }
}

pub fn nao_dec_examples(){
    check.eq(nao_dec([1, 2, 3]), True)
    check.eq(nao_dec([]), True)
    check.eq(nao_dec([1]), True)
    check.eq(nao_dec([1, 1, 4, 1]), False)
    check.eq(nao_dec([3, 2, 1]), False)
}


// 13) Projete uma função que receba como entrada uma lista e devolva uma lista com os mesmos elementos
// da entrada mas em ordem contrária. Dica: projete uma função auxiliar para adicionar um elemento
// no final de uma lista

// Para solucionar essa questão precisaremos de uma nova lista, a atribuição de elementos é feita recursivamente
// do final da lista para o começo, o ultimo elemento da lista original será adicionado na nova lista como sendo o primeiro
// até então conseguimos fazer sem utilização de funções auxiliares, a partir do penúltimo deveremos adicionar os elementos ao final desta lista
// temos que levar em consideração que a lista é feita no início da recursão, ou seja, de algum modo o primeiro valor deve ser inserido num escopo assim:
// [resto, primeiro]

/// Dada uma lista de valores inteiros e um número inteiro 'n', adiciona n ao final da lista
pub fn add_final(lista: List(Int), n: Int) -> List(Int){
    case lista{
        [] -> [n]
        [prim] -> [prim, n]
        [prim, ..resto] -> [prim, ..add_final(resto, n)]
    }
}

pub fn add_final_examples(){
    check.eq(add_final([1, 2, 3], 4), [1, 2, 3, 4])
    check.eq(add_final([1], 4), [1, 4])
    check.eq(add_final([], 5), [5])
}


/// Inverte a ordem de uma lista de números inteiros
pub fn inverte_lista(lista: List(Int)) -> List(Int){
    case lista{
        [] -> []
        [prim] -> [prim]
        [prim, seg] -> [seg, prim]
        [prim, seg, ..resto] -> add_final(inverte_lista([seg, ..resto]), prim)
    }
}

pub fn inverte_lista_examples(){
    check.eq(inverte_lista([1, 2, 3, 4]), [4, 3, 2, 1])
    check.eq(inverte_lista([]), [])
    check.eq(inverte_lista([1]), [1])
    check.eq(inverte_lista([1, 2]), [2, 1])
}

// 14) Nas notas de aula, vimos como fazer uma busca por chave em uma lista de associações de strings com
// números. Agora você deve projetar uma função que receba como parâmetro uma lista de associações,
// uma chave (string) e um valor (inteiro) e atualize a lista de associações, isto é, adicione a associação se
// a chave não estiver presente ou atualize o valor associado com a chave se a chave já estiver presente.

/// Representa um par de valores associados, uma chave de String com um valor numérico Int
pub type Par{
    Par(chave: String, valor: Int)
} 


/// Adiciona um novo par de associação em uma lista de associações caso o par ainda não esteja presente na lista
/// se o par já estiver na lista não faz nada, caso a chave exista mas o valor associado seja diferente, atualiza o valor 
/// realcionado a chave
pub fn atualiza_listapar(lista: List(Par), chave: String, valor: Int) -> List(Par){
    
} 



// 15) Projete uma função que determine o valor máximo de uma lista de inteiros.

/// Retorna o valor máximo dentro de uma lista de inteiros
pub fn max_lista(lista: List(Int)) -> Int{
    case lista{
        [] -> 0
        [n] -> n
        [prim, seg] if prim >= seg -> prim 
        [prim, seg] if seg > prim -> seg
        [prim, ..resto] -> case prim > max_lista(resto){
            True -> prim
            False -> max_lista(resto)
        }
    }
}


pub fn max_lista_examples(){
    check.eq(max_lista([1, 2, 5, 6]), 6)
    check.eq(max_lista([1, 2, -1]), 2)
    check.eq(max_lista([2]), 2)
    check.eq(max_lista([1, 2]), 2)
    check.eq(max_lista([]), 0)
}

// 16) Projete uma função que crie uma lista de números a partir de uma lista de strings convertendo cada
// string para um número (use a função int.parse).

/// Retorna uma lista de números a partir de uma lista de Strings
pub fn conv_string_num(lista: List(String)) -> List(Int){
    case lista{
        [] -> []
        [num] -> case int.parse(num){
            Error(_) -> []
            Ok(n) -> [n]
        }
        [prim, ..resto] -> case int.parse(prim){
            Error(_) -> conv_string_num(resto)
            Ok(n) -> [n, ..conv_string_num(resto)]
        }
    }
} 

pub fn conv_string_num_examples(){
    check.eq(conv_string_num(["1", "2", "a", "3"]), [1, 2, 3])
    check.eq(conv_string_num(["1"]), [1])
    check.eq(conv_string_num(["a", "b", "c"]), [])
    check.eq(conv_string_num(["1", "2"]), [1, 2])
}


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

// 19) O mestrando em física Alberto está tendo problemas com o equipamento que ele está usando para
// medir a temperatura de um material. O equipamento faz uma leitura a cada 10 segundos, mas, em
// vez de gerar apenas um número (temperatura), por vez, ele está gerando o mesmo número diversas
// vezes a cada leitura. Como o Alberto não tem verba para consertar o equipamento, ele está contando
// com a sua ajuda para fazer um programa que corrige os dados lidos pelo equipamento. Note que ele
// espera que cada leitura seja maior que a anterior, então se o equipamento ler os valores 3, 3, 7, 7, 7,
// 10 a leitura estará errada, pois o correto seria 3, 7, 10.

// Para realizar esse problema precisaremos de uma função auxiliar para conferir se um determinando número está dentro da lista,
// só adicionaremos na lista nova os elementos cujo não estão dentro da lista nova, para isso dividiremos a lista original e veremos elemento
// a elemento

/// Função que dado uma lista numérica de inteiros 'lista' e um numero inteiro 'n', confere se n já está na dentro da lista
/// o retorno da função é um booleano, respondendo se o número está ou não presente
pub fn confere_num(lista: List(Int), n: Int) -> Bool{
    case lista{
        [] -> False
        [prim, ..resto] ->
        case prim == n{
            True -> True
            False -> confere_num(resto, n)
        }
    }
}

pub fn confere_num_examples(){
    check.eq(confere_num([4, 3, 1], 1), True)
    check.eq(confere_num([4, 3, 1], 3), True)
    check.eq(confere_num([4, 3, 1], 4), True)
    check.eq(confere_num([4, 3, 1], 2), False)
    check.eq(confere_num([4], 4), True)
    check.eq(confere_num([], 3), False)
}

/// Função remove os números repetidos de uma lista de inteiros e retorna uma nova lista sem as repetições
pub fn remove_repet(lista: List(Int)) -> List(Int){
    case lista{
        [] -> []
        [primeiro, ..resto] ->
        case confere_num(resto, primeiro){
            True -> remove_repet(resto)
            False -> [primeiro, ..remove_repet(resto)]
        }
    }
}