import gleam/list

pub type RomanSymbol {
  M
  D
  C
  L
  X
  V
  I
}

pub const symbols = [M, D, C, L, X, V, I]

pub fn from(number: Int) {
  case number {
    _ if number >= 10 -> [X, ..from(number - 10)]
    9 -> [I, X]
    _ if number >= 5 -> [V, ..from(number - 5)]
    4 -> [I, V]
    _ -> I |> list.repeat(times: number)
  }
}

pub fn to_string(symbol: RomanSymbol) {
  case symbol {
    M -> "M"
    D -> "D"
    C -> "C"
    L -> "L"
    X -> "X"
    V -> "V"
    I -> "I"
  }
}

pub fn to_value(symbol: RomanSymbol) {
  case symbol {
    M -> 1000
    D -> 500
    C -> 100
    L -> 50
    X -> 10
    V -> 5
    I -> 1
  }
}
