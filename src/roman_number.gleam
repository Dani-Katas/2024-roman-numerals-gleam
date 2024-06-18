import gleam/string
import roman_symbol
import gleam/list

pub type RomanNumber {
  RomanNumber(digits: List(roman_symbol.RomanSymbol))
}

pub fn from(number: Int) {
  let digits = roman_symbol.I |> list.repeat(times: number)
  RomanNumber(digits)
}

pub fn to_string(roman_number: RomanNumber) {
    roman_number.digits |> list.map(fn(x) { roman_symbol.to_string(x) }) |> string.join("")
}
