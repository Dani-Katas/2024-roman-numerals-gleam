import gleam/list
import gleam/result

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

pub fn from(number: Int) -> List(RomanSymbol) {
  from_arabic_to(number, M)
}

fn from_arabic_to(number: Int, symbol: RomanSymbol) -> List(RomanSymbol) {
  let value = to_value(symbol)
  let subtractive = subtractive_pair(symbol)
  let subtract_value = value - to_value(subtractive)
  let can_subtract = number >= subtract_value

  case symbol {
    I -> I |> list.repeat(number)
    _ if number >= value -> [symbol, ..from(number - value)]
    _ if can_subtract -> [subtractive, symbol, ..from(number - subtract_value)]
    _ -> from_arabic_to(number, next(symbol))
  }
}

fn subtractive_pair(symbol: RomanSymbol) -> RomanSymbol {
  symbols
  |> list.filter(can_be_subtracted)
  |> list.filter(is_less_than(symbol))
  |> list.first
  |> result.unwrap(I)
}

pub fn is_less_than(a: RomanSymbol) {
  fn(b: RomanSymbol) {
    to_value(b) < to_value(a)
  }
}

fn can_be_subtracted(symbol: RomanSymbol) -> Bool {
  case symbol {
    I | X | C -> True
    _ -> False
  }
}

fn next(symbol: RomanSymbol) -> RomanSymbol {
  case symbol {
    M -> D
    D -> C
    C -> L
    L -> X
    X -> V
    V -> I
    I -> I
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
