# Changelog

## 0.5.0

First Dart release: support for classes:

* Permutations
* Combinations
* Amalgams (permutations with replacement during arranging)
* Selections (combinations with replacement during arranging)
* Subsets

## 0.5.1
Improved the documentation; minor bug fixes.

## 0.8.0

* Added inverses to all the functions so that we can look up arrangements non iteratively (now possible to look up values in arbitrarily large pseudo-listsi; this library was incomplete without this functionality!).
* Made the code more readable. Made a few minor tweaks to the existing code.

## 0.8.1

* Added the contains method.
* Corrected indexOf behaviour for when an arrangement that doesn't exist is passed as an argument; returns -1 if the arrangement is not in the pseudo-list.