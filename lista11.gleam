import sgleam/check
import gleam/list

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
 
// ---------------------------------------------------------------------------------------------------------------

/// Insere um elemento de maneira ordenada em uma lista
pub fn insere_ordenado(list: List(Int), a: Int) -> List(Int){
    case list{
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