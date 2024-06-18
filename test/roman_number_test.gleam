import gleeunit
import gleeunit/should
import roman_number
import gleam/result
import simplifile
import gleam/string
import gleam/list
import gleam/int

pub fn main() {
  gleeunit.main()
}

pub fn hello_world_test() {
  read_romans() |> list.each(fn(x) {
    let #(arabic, roman) = x
    roman_number.from(arabic) |> roman_number.to_string |> should.equal(roman)
  })
}

fn read_romans() {
  simplifile.read(from: "./test/romans.csv")
    |> result.unwrap("")
    |> string.split("\n")
    |> list.drop(1)
    |> list.map(fn(x) { string.split(x, ",") })
    |> list.map(row_to_tuple)
}

fn row_to_tuple(row: List(String)) {
  #(row |> list.first |> result.unwrap("1") |> int.parse |> result.unwrap(1), row |> list.last |> result.unwrap("1"))
}
