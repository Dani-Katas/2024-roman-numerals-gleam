import gleam/string

pub type RomanNumber {
  RomanNumber(digits: List(String))
}

pub fn from(number: Int) {
  RomanNumber(digits: ["I"])
}

pub fn to_string(roman_number: RomanNumber) {
    string.join(roman_number.digits, "")
}
