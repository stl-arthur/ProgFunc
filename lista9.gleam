import sgleam/check

// 3) Projete uma função que verifique se todos os elementos de uma lista estão presentes em outra lista.


/// Verifica se todos os elementos de uma lista 'alist' estão presentes em uma outra lista 'blist'
pub fn verifica_lista(alist: List(a), blist: List(a)) -> Bool{
    case alist, blist{
        [], _ -> True
        _, [] -> False
        [a, ..ar], [b, ..br] -> case a == b{
            True -> True && verifica_lista(ar, blist)
            False -> case verifica_lista([a], br){
                True -> True && verifica_lista(ar, blist)
                False -> False
            } 
        }
    }
}

pub fn verifica_lista_examples(){
    check.eq(verifica_lista([1, 2, 3], []), False)
    check.eq(verifica_lista([], [1, 2, 3]), True)
    check.eq(verifica_lista([], []), True)
    check.eq(verifica_lista([1, 2, 3], [1, 2, 3]), True)
    check.eq(verifica_lista([1, 2, 3], [4, 1, 6, 7, 2, 3]), True)
    check.eq(verifica_lista([1, 56, 3], [6, 4, 1, 4, 4, 56, 8, 3]), True)
}

// 4) Projete uma função que calcule todos os possíveis pares entre os elementos de duas listas. Dica: projete
// uma função auxiliar que crie os pares entre um elemento e os elementos de uma lista.
// > pares([3, 1, 8], [7, 4])
// [[3, 7], [3, 4], [1, 7], [1, 4], [8, 7], [8, 4]]

/// Cria pares entre um elemento 'elem' e os elementos de uma lista 'lista'
/// retorna uma lista de lista, com as listas de dentro sendo os pares criados
pub fn cria_par(elem: a, lista: List(a)) -> List(List(a)){
    case lista{
        [] -> [[]]
        [a] -> [[elem, a]]
        [prim, ..resto] -> [[elem, prim], ..cria_par(elem, resto)]
    }
}

pub fn cria_par_examples(){
    check.eq(cria_par(1, [1, 2, 3]), [[1, 1], [1, 2], [1, 3]])
    check.eq(cria_par(0, []), [[]])
    check.eq(cria_par(2, [1]), [[2, 1]])
}

/// Cria pares entre todos os elementos de uma lista 'alist' e uma lista 'blist'
/// retorna uma lista de listas, sendo as listas internas todas os pares entre os elementos
/// das listas
pub fn cria_par_listas(alist: List(a), blist: List(b)) -> List(List(a)){
    case alist, blist{
        [], _ -> [[]]
        _, [] -> [[]]
        [a, ..ar], [b, ..br] ->
    }
}

pub fn cria_par_listas_examples(){
    check.eq(cria_par_listas([], []), [[]])
    check.eq(cria_par_listas([], [1, 2, 3]), [[]])
    check.eq(cria_par_listas([1, 2, 3], []), [[]])
    check.eq(cria_par_listas([1, 2], [5, 6, 7]), [[1, 5], [1, 6], [1, 7], [2, 5], [2, 6], [2, 7]])
}