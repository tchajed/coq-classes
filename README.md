# A few Coq typeclasses

[![Build Status](https://travis-ci.org/tchajed/coq-classes.svg?branch=master)](https://travis-ci.org/tchajed/coq-classes)

Includes the following typeclasses, as well as several instances for standard datatypes:
- `EqualDec` for decidable equality
- `Default` for inhabited types, with witness `default`.
- `Ordering` for totally ordered types, which includes instances for `list` and `string`.

This dependency is mainly so multiple projects share the same typeclass definitions.

## Installation

`git submodule add https://github.com/tchajed/coq-classes vendor/classes`
