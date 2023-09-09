
![](https://bitbucket.org/ram6ler/dart_trotter/wiki/dart_trotter_banner.png)

Welcome to `trotter`, a library that simplifies working with meta-arrangements commonly
encountered in combinatorics, such as arrangements of combinations and permutations.

`trotter` gives the developer access to pseudo-lists that "contain" all selections
(combinations, permutations, etc.) of objects taken from a specified list of items.

The order of arrangements is based on the the order produced by the
[Steinhaus–Johnson–Trotter algorithm](https://en.wikipedia.org/wiki/Steinhaus%E2%80%93Johnson%E2%80%93Trotter_algorithm)
for ordering permutations, which I have generalized to combinations and arrangements
that allow for replacement after item selection.

The pseudo-list classes available are:

* Combinations.
* Permutations.
* Compositions (combinations with replacement).
* Amalgams (permutations with replacement).
* Subsets (combinations with unspecified number of items taken).
* Compounds (combinations with unspecified number of items taken).

# Demos

To see `trotter` in action:

* Play [Falco Shapes](https://falco-shapes.netlify.com/), a little puzzle
based on Marsha Falco"s game of *Set*.

* Explore the *huge* number of permutations of letters of the alphabet with
[Permutation Products](https://permutation-products.netlify.com/).

# Using `trotter`

Include the following dependency in your `pubspec.yaml``:

```text
trotter: ^2.2.0
```

Then, to import the library:

```text
import "package:trotter/trotter.dart";
```

## The basic classes

### Combinations

A *combination* is a selection of items for which order is *not*
important and items are *not* replaced after being selected.

The `Combinations` class "contains" all combinations of a set of items.

**Example:**

```dart
final bagOfItems = characters("abcde"),
  combinations = Combinations(3, bagOfItems);
for (final combination in combinations()) {
  print(combination);
}
```

### Permutations

A *permutation* is a selection of items for which order *is* important
and items are *not* replaced after being selected.

The `Permutations` class "contains" all permutations of a set of items.

**Example:**

```dart
final bagOfItems = characters("abcde"), permutations = Permutations(3, bagOfItems);
for (final permutation in permutations()) {
  print(permutation);
}
```

(Notice that this library arranges permutations similarly to the way the
[Steinhaus-Johnson-Trotter](https://en.wikipedia.org/wiki/Steinhaus%E2%80%93Johnson%E2%80%93Trotter_algorithm)
algorithm arranges permutations. In fact, if we get the permutations of
*all* the specified items, e.g. `final permutations = Permutations(bagOfItems.length, bagOfItems);`
in the above code, the arrangement of permutations is exactly what would
have resulted from applying the S-J-T algorithm. The algorithms in this library
have an advantage in that they do not iterate through all k - 1 permutations in
order to determine the kth permutation, however.)

### Compositions

A *composition* (or combination with replacement) is a selection of items for
which order is *not* important and items *are* replaced after being selected.

The `Compositions` class "contains" all compositions of a set of items.

Here are all the compositions of three items taken from a bag of five items:

**Example:**

```dart
final bagOfItems = characters("abcde"), compositions = Compositions(3, bagOfItems);
for (final composition in compositions()) {
  print(composition);
}
```

### Amalgams

An *amalgam* (or permutation with replacement) is a selection of items for
which order *is* important and items *are* replaced after being selected.

The `Amalgams` class "contains" all amalgams of a set of items.

**Example:**

```dart
final bagOfItems = characters("abcde"), amalgams = Amalgams(3, bagOfItems);
for (final amalgam in amalgams()) {
  print(amalgam);
}
```

### Subsets

A *subset* (or combination of unspecified length) is a selection of items for
which order is *not* important, items are *not* replaced and the number of
items is not specified.

The `Subsets` class "contains" all subsets of a set of items.

**Example:**

```dart
final bagOfItems = characters("abcde"), subsets = Subsets(bagOfItems);
for (final subset in subs()) {
  print(subset);
}
```

### Compounds

A *compound* (or permutation of unspecified length) is a selection of items for
which order *is* important, items are *not* replaced and the number of items is
not specified.

The `Compounds` class "contains" all compounds of a set of items.

**Example:**

```dart
final bagOfItems = characters("abcde"), compounds = Compounds(bagOfItems);
for (final compound in compounds()) {
  print(compound);
}
```

## Large indices

Arrangement numbers often grow very quickly. For example, consider the number
of 10-permutations of the letters of the alphabet:

**Example:**

```dart
final largeBagOfItems = characters("abcdefghijklmnopqrstuvwxyz"),
  permutations = Permutations(10, largeBagOfItems);
print(permutations);
```

Wow! That"s a lot of permutations! Don"t iterate over them all!

Notice that the word `algorithms` is a 10-permutation of the letters of the
alphabet. What is the index of this permutation in our list of permutations?

**Example:**

```dart
final largeBagOfItems = characters("abcdefghijklmnopqrstuvwxyz"),
    permutations = Permutations(10, largeBagOfItems),
    permutationOfInterest = characters("algorithms"),
    index = permutations.indexOf(permutationOfInterest);
print("The index of $permutationOfInterest is $index.");
print("permutations[$index]: ${permutations[index]}");
```

Wow! That"s almost seven trillion! Luckily we didn"t need to perform that
search using brute force!

Since we sometimes can be working with indexes so large they cannot be
represented using a 64 bit `int`, indexing and length are implemented using `BigInt`.

**Example:**

```dart
final largeBagOfItems = characters("abcdefghijklmnopqrstuvwxyz"),
    compounds = Compounds(largeBagOfItems);
print("There are ${compounds.length} compounds of these letters!");
BigInt lastCompoundIndex = compounds.length - BigInt.one;
print("The last compound is ${compounds[lastCompoundIndex]}.");
```

Unless you"re immortal, don"t use `compounds().last` to access the last compound in the previous example!

## Syntactic sugar

### Lists

`trotter` provides extensions that allow us to generate combinatoric
arrangements directly from lists...

**Example:**

```dart
final subsets = [1, 2, 3, 4, 5].subsets();
for (final subset in subsets()) {
  print(subset);
}
```

### Strings

... and strings, in which case it assumes we mean arrangements of the
characters in the string.

**Example:**

```dart
final subsets = "abcde".subsets();
for (final subset in subsets()) {
  print(subset);
}
```

---

`trotter` was written by [Richard Nathan Ambler](mailto:rambler@wya.top).

Thanks for your interest in this library. Please file any bugs, issues
and suggestions [here](https://github.com/ram6ler/dart-trotter/issues).
