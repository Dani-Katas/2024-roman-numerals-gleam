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
    _ if number >= 1000 -> [M, ..from(number - 1000)]
    _ if number >= 900 -> [C, M, ..from(number - 900)]
    _ if number >= 500 -> [D, ..from(number - 500)]
    _ if number >= 400 -> [C, D, ..from(number - 400)]
    _ if number >= 100 -> [C, ..from(number - 100)]
    _ if number >= 90 -> [X, C, ..from(number - 90)]
    _ if number >= 50 -> [L, ..from(number - 50)]
    _ if number >= 40 -> [X, L, ..from(number - 40)]
    _ if number >= 10 -> [X, ..from(number - 10)]
    _ if number >= 9 -> [I, X, ..from(number - 9)]
    _ if number >= 5 -> [V, ..from(number - 5)]
    _ if number >= 4 -> [I, V, ..from(number - 4)]
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
