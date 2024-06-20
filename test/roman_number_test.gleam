import gleam/int
import gleam/list
import gleam/result
import gleam/string
import gleeunit
import gleeunit/should
import roman_number
import simplifile

pub fn main() {
  gleeunit.main()
}

pub fn hello_world_test() {
  read_romans()
  |> list.each(fn(x) {
    let #(arabic, roman) = x
    roman_number.from(arabic) |> roman_number.to_string |> should.equal(roman)
  })
}

fn read_romans() {
  simplifile.read(from: "./test/romans.csv")
  |> result.unwrap("")
  |> string.split("\n")
  |> list.drop(1)
  |> list.map(string.split(_, ","))
  |> list.map(row_to_tuple)
}

fn row_to_tuple(row: List(String)) {
  #(row |> parse_arabic_column, row |> parse_roman_column)
}

fn parse_arabic_column(row: List(String)) {
  row |> list.first |> result.unwrap("1") |> int.parse |> result.unwrap(1)
}

fn parse_roman_column(row: List(String)) {
  row |> list.last |> result.unwrap("I")
}
