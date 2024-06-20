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
  to_roman(number, symbols)
}

fn to_roman(number: Int, symbols: List(RomanSymbol)) -> List(RomanSymbol) {
  case symbols {
    [I] -> I |> list.repeat(number)
    [symbol, ..symbols] -> non_unit_to_roman(number, symbol, symbols)
    _ -> []
  }
}

fn non_unit_to_roman(number: Int, symbol: RomanSymbol, symbols: List(RomanSymbol)) -> List(RomanSymbol) {
  case number |> greater_than(_, symbol), has_subtractive_pair(number, symbol) {
    True, _ -> [symbol, ..from(number - to_value(symbol))]
    _, True -> [subtractive_pair(symbol), symbol, ..from(number - subtractive_pair_delta(symbol))]
    _, _ -> to_roman(number, symbols)
  }
}

fn greater_than(number: Int, symbol: RomanSymbol) -> Bool {
  number >= to_value(symbol)
}

fn subtractive_pair_value(symbol: RomanSymbol) -> Int {
  symbol |> subtractive_pair |> to_value
}

fn has_subtractive_pair(number: Int, symbol: RomanSymbol) -> Bool {
  number >= subtractive_pair_delta(symbol)
}

fn subtractive_pair(symbol: RomanSymbol) -> RomanSymbol {
  symbols
  |> list.filter(can_be_subtracted)
  |> list.filter(is_less_than(symbol))
  |> list.first
  |> result.unwrap(I)
}

fn subtractive_pair_delta(symbol: RomanSymbol) -> Int {
  to_value(symbol) - subtractive_pair_value(symbol)
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
