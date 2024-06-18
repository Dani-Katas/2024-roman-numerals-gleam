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
  from_two(number, M)
}

fn from_two(number: Int, symbol: RomanSymbol) -> List(RomanSymbol) {
  let value = to_value(symbol)
  case number {
    _ if symbol == I -> I |> list.repeat(number)
    _ if number >= value -> [
      symbol,
      ..from(number - to_value(symbol))
    ]
    _ -> {
      let subtractive = subtractive_pair(symbol)
      let subtract_value = to_value(symbol) - to_value(subtractive)
      let can_subtract = number >= subtract_value

      case can_subtract {
        True -> [
          subtractive,
          symbol,
          ..from(number - subtract_value)
        ]
        False -> from_two(number, next(symbol))
      }
    }
  }
}

fn subtractive_pair(symbol: RomanSymbol) -> RomanSymbol {
  symbols
    |> list.filter(can_be_subtracted)
    |> list.filter(fn (x) { to_value(x) < to_value(symbol) })
    |> list.first
    |> result.unwrap(I)
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
