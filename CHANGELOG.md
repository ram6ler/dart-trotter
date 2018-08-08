# Change log

## 1.0.1

Made the abstract, parent class `Combinatorics` visible to the user for those cases in which the combinatorics type is not known at the time of declaration.

## 1.0.0

* Cleaned up code to be more in line with Dart 2.
* Added `example.dart` (and an example output, `fun-with-mastermind.md`) to `example/`. 

## 0.9.5

* As of Dart 2, `int` instances represent 64 bit, as opposed to arbitrary length, integers. Since *trotter* often works with very large integers, it needed an overhaul so as to incorporate the `BigInt` class. This resulted in several breaking changes, most notably that the base `_Combinatoric` class no longer extends `ListBase`. I have made the class instances callable, however, to address this: code that needs an instance of one of the classes to behave like an iterable just need to call the instance. For example, if `perms` is an instance of `Permutations`, we would now use something like `for (var p in perms())` (as opposed to `for (var p in perms)`, which worked in previous versions). The instances can still be thought of as pseudo-lists in that they can be indexed and have several properties and methods that might be expected in a list, such as `length` and `indexOf`.

* I took advantage of the necessity of making breaking changes mentioned above to make one more: I have renamed the `Selections` class `Compositions`. In combinatorics literature, the term *selection* is often use as a generic word to mean either combination or permutation. This might have caused confusion in the way I had used the term in previous versions of the library. I think that *composition* is more appropriate to mean a selection in which order is not important (if a body is composed of materials A, B and C then it is also composed of materials C, B and A) and items are "replaced" (it makes sense to say that a body is composed of two parts A to one part B, for example).

## 0.9.1

* Fixed an error introduced during the changes made for 0.9.0.

## 0.9.0

* Cleaned up and simplified the code so that the structures extend `List`s more naturally. (Structures extend `ListBase` now instead of `Iterable`.)
* Should be backwards compatible in that code that works in previous versions should also work in this version.
* Structures should now behave better with `List` methods like `map`, `where`, `every` and so on.

## 0.8.5

* Cleaned up the code so that the library may be used in strong mode.
* Added subset of the functionality associated with `Iterables` (`first`, `last`, `any`, `every`, `forEach` etc.). Some functionality that would be redundant (e.g. `isEmpty`) or less meaningful/useful (e.g. `fold`) neglected. Since structures we can represent can "contain" a huge number of arrangements, we need to be careful about using methods that iterate over the structures (like `any`, `every`, `forEach`).

## 0.8.1

* Added the `Compounds` class (permutations of unspecified size).
* Added the contains method for all classes.
* Corrected `indexOf` behaviour for when arrangements that don't exist are passed as arguments; returns -1 if the arrangement is not in the pseudo-list.

## 0.8.0

* Added inverses to all the functions so that we can look up arrangements non iteratively (now possible to look up values in arbitrarily large pseudo-lists; this library was incomplete without this functionality!).
* Made the code more readable. Made a few minor tweaks to the existing code.

## 0.5.1
Improved the documentation; minor bug fixes.

## 0.5.0

First Dart release: support for classes:

* Permutations
* Combinations
* Amalgams (permutations with replacement during arranging)
* Selections (combinations with replacement during arranging)
* Subsets
