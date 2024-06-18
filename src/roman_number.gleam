import gleam/list
import gleam/string
import roman_symbol

pub type RomanNumber {
  RomanNumber(digits: List(roman_symbol.RomanSymbol))
}

pub fn from(number: Int) {
  RomanNumber(roman_symbol.from(number))
}

pub fn to_string(roman_number: RomanNumber) {
  roman_number.digits |> list.map(roman_symbol.to_string) |> string.join("")
}
