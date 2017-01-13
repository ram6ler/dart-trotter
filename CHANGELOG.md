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

* Added inverses to all the functions so that we can look up arrangements non iteratively (now possible to look up values in arbitrarily large pseudo-lists; this library was incomplete without this functionality!).
* Made the code more readable. Made a few minor tweaks to the existing code.

## 0.8.1

* Added the `Compounds` class (permutations of unspecified size).
* Added the contains method for all classes.
* Corrected indexOf behaviour for when arrangements that don't exist are passed as arguments; returns -1 if the arrangement is not in the pseudo-list.

## 0.8.5

* Cleaned up the code so that the library may be used in strong mode.
* Added subset of the functionality associated with `Iterables` (`first`, `last`, `any`, `every`, `forEach` etc.). Some functionality that would be redundant (e.g. `isEmpty`) or less meaningful/useful (e.g. `fold`) neglected. Since structures we can represent can "contain" a huge number of arrangements, we need to be careful about using methods that iterate over the structures (like `any`, `every`, `forEach`).
