// Arthur Henrique da Silva RA144346

import gleam/option.{type Option, None, Some}
import sgleam/check

// ======================== Questão 1  ========================

// Periodo: Tipo Enum (Manha, Tarde)
// Serviços: Tipo União (Economico,Expresso, Agendado(Periodo))
// Cada serviço tem sua taxa, Economico: R$0.80, Expresso e Agendado: R$1.50
// No serviço agendado existe taxa de agendamento sendo R$25.0 para a Manha e R$15.0 para Tarde
// Cada serviço tem uma distancia maxima, Economico: 300km, Expresso: 150km e Agendado: 80km

// ----------------- (1 a) -----------------

/// Tipo enumerado relacionado aos periodos em que um serviço de entrega pode ser agendado
pub type Periodo {
  Manha
  Tarde
}

/// Tipo união que representa as possibilidades de serviços a serem escolhidos
pub type Servico {
  Economico
  Expresso
  Agendado(p: Periodo)
}

// ----------------- (1 b) -----------------

// A função deverá cobrir todos os casos, ou seja, deverá ser definida para todos os tipos de serviços
// e todas as distancias de entrega, para isso, deveremos ter uma saída Result para cobrirmos os casos
// em que os valores e tipos de serviço são válidos e para os valores e tipo que não são,
// o Result deverá conter duas possibilidades, um Float para o valor total do frete e uma String
// sendo ela um "Distancia ultrapassa o limite" ou "Distancia Invalida" para valor zerado ou negativo
// para serviços 'Economico' deve ser multiplicado distancia por 0.80 
// Expresso e Agendado deve ser multiplicado distancia por 1.50 
// e caso seja Agendado, o valor final deverá ter um acrescimo de 25 caso o periodo seja Manha
// e 15 caso o periodo seja Tarde 

/// Função que recebe como entrada as informações de uma entrega (tipo de Serviço 
/// e distancia da entrega em Km)
/// saída é um Result(Float, String) sendo Float o valor do frete a ser pago e String a mensagem de erro
/// caso a distancia seja maior que o limite permitido por categoria de serviço
/// serviço Economico é calculado através de distancia * 0.80 
/// serviços Expressos e Agendados são calculados através de distancia * 1.5
/// o Agendado tem acrescimo de 25 caso seja no periodo da manha e 15 caso seja no periodo da tarde 
pub fn valor_frete(servico: Servico, distancia: Float) -> Result(Float, String) {
  case servico {
    Economico ->
      case distancia >. 300.0 {
        True -> Error("Distancia ultrapassa o limite")
        False ->
          case distancia <=. 0.0 {
            True -> Error("Distancia inválida")
            False -> Ok(distancia *. 0.8)
          }
      }
    Expresso ->
      case distancia >. 150.0 {
        True -> Error("Distancia ultrapassa o limite")
        False ->
          case distancia <=. 0.0 {
            True -> Error("Distancia inválida")
            False -> Ok(distancia *. 1.5)
          }
      }
    Agendado(p) ->
      case distancia >. 80.0 {
        True -> Error("Distancia ultrapassa o limite")
        False ->
          case distancia <=. 0.0 {
            True -> Error("Distancia inválida")
            False ->
              case p {
                Manha -> Ok({ distancia *. 1.5 } +. 25.0)
                Tarde -> Ok({ distancia *. 1.5 } +. 15.0)
              }
          }
      }
  }
}

pub fn valor_frete_examples() {
  check.eq(valor_frete(Economico, 100.0), Ok(80.0))
  check.eq(
    valor_frete(Economico, 350.0),
    Error("Distancia ultrapassa o limite"),
  )
  check.eq(valor_frete(Economico, -100.0), Error("Distancia inválida"))
  check.eq(valor_frete(Expresso, 100.0), Ok(150.0))
  check.eq(valor_frete(Expresso, 152.0), Error("Distancia ultrapassa o limite"))
  check.eq(valor_frete(Expresso, 0.0), Error("Distancia inválida"))
  check.eq(valor_frete(Agendado(Manha), 50.0), Ok(100.0))
  check.eq(
    valor_frete(Agendado(Manha), 88.0),
    Error("Distancia ultrapassa o limite"),
  )
  check.eq(valor_frete(Agendado(Manha), -10.0), Error("Distancia inválida"))
  check.eq(valor_frete(Agendado(Tarde), 50.0), Ok(90.0))
  check.eq(
    valor_frete(Agendado(Tarde), 88.0),
    Error("Distancia ultrapassa o limite"),
  )
  check.eq(valor_frete(Agendado(Tarde), -10.0), Error("Distancia inválida"))
}

// ======================== Questão 2  ========================

// Bateria: Capacidade = qtde max de energia armazenavel, Carga = qtde de energia armazenada no momento
// capacidade é sempre positiva e carga nunca pode ser negativa nem maior que a capacidade

// ----------------- (2 a) -----------------

/// Tipo de dado que representa o estado de uma bateria
pub opaque type Bateria {
  Bateria(capacidade: Int, carga: Int)
}

// A função recebe valores de entrada inteiros quaisquer para as variaveis capacidade e carga
// ela deve garantir que os valores não sejam negativos e que a carga da bateria não ultrapasse
// o valor da capacidade antes de criar um tipo 'Bateria' com esses valores, o retorno da função deverá
// ser um Result(Bateria, Erro), com bateria sendo a nova bateria com os valores de entrada e 'Erro'
// um tipo enumerado com as possibilidades de entradas inválidas

/// Tipo enumerado que contem as possibilidades de entradas inválidas para os valores de 
/// capacidade e carga de uma bateria
pub type Erro {
  CapacidadeNula
  CargaNegativa
  CargaMaiorqueCapacidade
}

/// Função que dado valores inteiros positivos de capacidade e carga (carga não sendo maior que capacidade)
/// retorna uma 'Bateria'' com as informações de entrada 
pub fn nova_bateria(capacidade: Int, carga: Int) -> Result(Bateria, Erro) {
  case capacidade <= 0 {
    True -> Error(CapacidadeNula)
    False ->
      case carga < 0 {
        True -> Error(CargaNegativa)
        False ->
          case carga > capacidade {
            True -> Error(CargaMaiorqueCapacidade)
            False -> Ok(Bateria(capacidade, carga))
          }
      }
  }
}

pub fn nova_bateria_examples() {
  check.eq(nova_bateria(5000, 4440), Ok(Bateria(5000, 4440)))
  check.eq(nova_bateria(5000, 6000), Error(CargaMaiorqueCapacidade))
  check.eq(nova_bateria(5000, -10), Error(CargaNegativa))
  check.eq(nova_bateria(0, 6000), Error(CapacidadeNula))
  check.eq(nova_bateria(-5000, 6000), Error(CapacidadeNula))
}

/// Recebe como entrada uma Bateria e retorna seu estado (carga)
pub fn consulta_estado(bateria: Bateria) -> Int {
  bateria.carga
}

pub fn consulta_estado_examples() {
  check.eq(consulta_estado(Bateria(500, 200)), 200)
  check.eq(consulta_estado(Bateria(500, 0)), 0)
  check.eq(consulta_estado(Bateria(13_500, 1200)), 1200)
}

// ----------------- (2 b) -----------------

// Para que possamos determinar o nivel da carga, teremos que criar um tipo enumerado contendo as
// possibilidades informadas, a funçaõ que determina o nivel de bateria deverá receber o Result 
// proveniente da função nova_bateria e retornara um outro Result com dois tipos Result(Nivel, String)
// sendo nivel o tipo nivel comentado anteriormente e String para informar que aquela bateria não é válida

/// Tipo enumerado que contem as possibilidades de tipo de carga
pub type Nivel {
  Critico
  Baixo
  Normal
}

/// Função que dado uma bateria com valores válidos (através de um Result) retorna o nivel em que a bateria
/// está caso seja uma bateria válida
pub fn det_nivel(bateria: Result(Bateria, Erro)) -> Result(Nivel, String) {
  case bateria {
    Error(_) -> Error("Bateria Invalida")
    Ok(a) ->
      case { a.capacidade / 10 } > a.carga {
        True -> Ok(Critico)
        False ->
          case { { a.capacidade / 10 } * 3 } > a.carga {
            True -> Ok(Baixo)
            False -> Ok(Normal)
          }
      }
  }
}

pub fn det_nivel_examples() {
  check.eq(det_nivel(Error(CargaMaiorqueCapacidade)), Error("Bateria Invalida"))
  check.eq(det_nivel(Error(CargaNegativa)), Error("Bateria Invalida"))
  check.eq(det_nivel(Error(CapacidadeNula)), Error("Bateria Invalida"))

  check.eq(det_nivel(Ok(Bateria(100, 7))), Ok(Critico))
  check.eq(det_nivel(Ok(Bateria(100, 25))), Ok(Baixo))
  check.eq(det_nivel(Ok(Bateria(100, 40))), Ok(Normal))
}

