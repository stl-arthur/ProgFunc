import sgleam/check
import gleam/list
import gleam/int
import gleam/float

// ------------------------------------- EXEMPLOS DOS SLIDES -------------------------------------

pub fn define_sinal(a: Int) -> Int{
    case a{
        _ if a < 0 -> -1
        _ if a > 0 -> 1
        _ -> 0
    }
}

pub fn define_sinal_examples(){
    check.eq(define_sinal(-4), -1)
    check.eq(define_sinal(4), 1)
    check.eq(define_sinal(0), 0)
}

pub fn sinal_lista(l: List(Int)) -> List(Int){
    list.map(l, define_sinal)
}

pub fn sinal_lista_examples(){
    check.eq(sinal_lista([-1, -5, 1, 5, 6, 0]), [-1, -1, 1, 1, 1, 0])
    check.eq(sinal_lista([]), [])
}

pub type Ponto{
    Ponto(x: Int, y: Int)
}

fn no_eixo(p: Ponto) -> Bool{
    p.x == 0 || p.y == 0
} 

pub fn eixo(lst: List(Ponto)){
    list.filter(lst, no_eixo)
}

pub fn eixo_examples(){
    check.eq(eixo([Ponto(2, 0), Ponto(1, 1), Ponto(0, 0), Ponto(5, 0)]), [Ponto(2, 0), Ponto(0, 0), Ponto(5, 0)])
}

pub fn ordena(lst: List(Int)) -> List(Int){
    list.fold_right(lst, [], insere_ordenado)
}


pub fn ordena_examples(){
    check.eq(ordena([4, 2, 7, 8]), [2, 4, 7, 8])
    check.eq(ordena([]), [])
    check.eq(ordena([1, 5, -1]), [-1, 1, 5])
}
 
// ------------------------------------------ EXERCÍCIOS ------------------------------------------

/// Insere um elemento de maneira ordenada em uma lista
pub fn insere_ordenado(lst: List(Int), a: Int) -> List(Int){
    case lst{
        [] -> [a]
        [prim, ..r] -> case prim > a{
            True -> [a, prim, ..r]
            False -> [prim, ..insere_ordenado(r, a)]
        }
    }
}

pub fn insere_ordenado_examples(){
    check.eq(insere_ordenado([], 5), [5])
    check.eq(insere_ordenado([6], 5), [5, 6])
    check.eq(insere_ordenado([4], 5), [4, 5])
    check.eq(insere_ordenado([4, 6], 5), [4, 5, 6])
}

// Use as funções list.map, list.filter e list.fold_right (diretamente ou com uma combinação dessas
// funções) sempre que for apropriado.
// 10) Uma loja virtual mostra, na tela de finalização da compra, o valor total do carrinho. Cada item do
// carrinho tem o nome do produto, o preço unitário e a quantidade comprada. Projete uma função que
// calcule o valor total de um carrinho.

/// Representa as informações de um item de um carrinho de compra
pub type Item{
    Item(nome: String, preco: Float, qtde: Int)
}

/// Retorna o preço total de um item comprado baseando-se no preço unitário e a quantidade comprada
pub fn total_item(it: Item) -> Float{
    it.preco *. int.to_float(it.qtde)
}

pub fn total_item_examples(){
    check.eq(total_item(Item("Maçã", 1.50, 4)), 6.0)
    check.eq(total_item(Item("Pão de Queijo", 2.50, 5)), 12.5)
    check.eq(total_item(Item("Maçã", 1.50, 0)), 0.0)
}

pub fn total_carrinho(vals: List(Item)) -> Float{
    let total_prod = list.map(vals, total_item)
    list.fold_right(total_prod, 0.0, float.add)
}

pub fn total_carrinho_examples(){
    check.eq(total_carrinho([Item("Maçã", 1.50, 4), Item("Pão de Queijo", 2.50, 5), Item("Maçã", 1.50, 0)]), 18.5)
}

// 11) Ao final do semestre, a secretaria do curso precisa publicar a lista de alunos aprovados em uma
// disciplina. Um aluno é aprovado se a sua nota é maior ou igual a 6,0. Projete uma função que, a
// partir do nome e da nota de cada aluno da turma, produza a lista com o nome dos alunos aprovados.

/// Representação dos dados de um aluno genérico de uma escola
pub type Aluno{
    Aluno(nome: String, nota: Float)
}

/// Confere se um aluno teve média acima ou igual a 6.0, garantindo que o aluno passou
pub fn passou(al: Aluno) -> Bool{
    al.nota >=. 6.0
}

pub fn passou_examples(){
    check.eq(passou(Aluno("Teste", 6.0)), True)
    check.eq(passou(Aluno("Teste2", 5.9)), False)
    check.eq(passou(Aluno("Teste3", 7.7)), True)
}


/// Retorna, através de uma lista de alunos, a lista de alunos aprovados na série atual
pub fn lst_passou(alunos: List(Aluno)) -> List(Aluno){
    list.filter(alunos, passou)
}

pub fn lst_passou_examples(){
    check.eq(lst_passou([Aluno("Teste", 6.0), Aluno("Teste2", 5.9), Aluno("Teste3", 7.7)]), [Aluno("Teste", 6.0), Aluno("Teste3", 7.7)])
}