import gleam/string
import gleam/int
import gleam/list

pub fn area_retangulo(largura: Float, altura: Float) -> Float{
    largura *. altura
}


pub fn prod_ant_post(n: Int) -> Int{
    {n-1}*n*{n+1}
}

pub fn eh_par(n: Int) -> Bool{
    n%2 == 0
}

pub fn abs(n: Int) -> Int{
    case n >= 0{
        True -> n
        False -> -n
    }
}

pub fn tres_dig_negpos(n: Int) -> Bool{
    abs(n) > 99 && abs(n) < 1000
}

pub fn tres_dig(n: Int) -> Bool{
    n > 99 && n < 1000
}

pub fn maximo(x: Int, y: Int) -> Int{
    case x > y{
        True -> x
        False -> y
    }
}

pub fn ordem(a: Int, b: Int, c: Int) -> String{
    case a < b && b < c{
        True -> "crescente"
        False ->
        case c < b && b < a{
            True -> "Decrescrente"
            False -> "Sem Ordem"
        }
    }
}

pub fn pega_primeira_letra(palavra: String) -> String{
    string.slice(palavra, 0, 1)
}

pub fn pega_resto_palavra(palavra: String) -> String{
    string.slice(palavra, 1, 90)
}

pub fn prim_maiusc(palavra: String) -> String{
    string.uppercase(pega_primeira_letra(palavra)) <> string.lowercase(pega_resto_palavra(palavra))
}

pub fn a_plus_abs_b(a: Int, b: Int) -> Int{
    case b > 0{
        True -> int.add
        False -> int.subtract
    }(a, b)
}

pub fn p(){
    p()
}

pub fn teste(x, y) {
    case x == 0 {
        True -> 0
        False -> y
    }
}


// EXERCICIOS EXTRAS

pub fn pega_ultima_letra(palavra: String) -> String{
    string.slice(palavra, -1, 1)
}

pub fn inverte_ini(nome: String, sobrenome: String) -> String{
    string.uppercase(pega_primeira_letra(sobrenome)) <> "." <> string.uppercase(pega_primeira_letra(nome)) <> "."
}

pub fn esconde_meio(palavra: String) -> String{
    case string.length(palavra) <= 2{
        False -> pega_primeira_letra(palavra) <> string.repeat("*", string.length(palavra) - 2) <> pega_ultima_letra(palavra)
        True -> string.repeat("*", string.length(palavra))
    }
}
