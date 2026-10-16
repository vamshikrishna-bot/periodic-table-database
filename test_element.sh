#!/bin/bash
set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
script="$script_dir/element.sh"

assert_output() {
  local expected="$1"
  shift
  local actual
  actual=$("$script" "$@")
  if [[ "$actual" != "$expected" ]]; then
    printf 'Expected: %s\nActual: %s\n' "$expected" "$actual" >&2
    exit 1
  fi
}

hydrogen="The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."
assert_output 'Please provide an element as an argument.'
assert_output "$hydrogen" 1
assert_output "$hydrogen" H
assert_output "$hydrogen" Hydrogen
assert_output "The element with atomic number 9 is Fluorine (F). It's a nonmetal, with a mass of 18.998 amu. Fluorine has a melting point of -220 celsius and a boiling point of -188.1 celsius." 9
assert_output "The element with atomic number 10 is Neon (Ne). It's a nonmetal, with a mass of 20.18 amu. Neon has a melting point of -248.6 celsius and a boiling point of -246.1 celsius." Neon
assert_output 'I could not find that element in the database.' Unobtainium

printf 'All element script tests passed.\n'