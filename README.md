
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

```text
[a, b, c]
[a, b, d]
[a, b, e]
[a, c, d]
[a, c, e]
[a, d, e]
[b, c, d]
[b, c, e]
[b, d, e]
[c, d, e]

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

```text
[a, b, c]
[a, c, b]
[c, a, b]
[c, b, a]
[b, c, a]
[b, a, c]
[a, b, d]
[a, d, b]
[d, a, b]
[d, b, a]
[b, d, a]
[b, a, d]
[a, b, e]
[a, e, b]
[e, a, b]
[e, b, a]
[b, e, a]
[b, a, e]
[a, c, d]
[a, d, c]
[d, a, c]
[d, c, a]
[c, d, a]
[c, a, d]
[a, c, e]
[a, e, c]
[e, a, c]
[e, c, a]
[c, e, a]
[c, a, e]
[a, d, e]
[a, e, d]
[e, a, d]
[e, d, a]
[d, e, a]
[d, a, e]
[b, c, d]
[b, d, c]
[d, b, c]
[d, c, b]
[c, d, b]
[c, b, d]
[b, c, e]
[b, e, c]
[e, b, c]
[e, c, b]
[c, e, b]
[c, b, e]
[b, d, e]
[b, e, d]
[e, b, d]
[e, d, b]
[d, e, b]
[d, b, e]
[c, d, e]
[c, e, d]
[e, c, d]
[e, d, c]
[d, e, c]
[d, c, e]

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

```text
[a, a, a]
[a, a, b]
[a, a, c]
[a, a, d]
[a, a, e]
[a, b, b]
[a, b, c]
[a, b, d]
[a, b, e]
[a, c, c]
[a, c, d]
[a, c, e]
[a, d, d]
[a, d, e]
[a, e, e]
[b, b, b]
[b, b, c]
[b, b, d]
[b, b, e]
[b, c, c]
[b, c, d]
[b, c, e]
[b, d, d]
[b, d, e]
[b, e, e]
[c, c, c]
[c, c, d]
[c, c, e]
[c, d, d]
[c, d, e]
[c, e, e]
[d, d, d]
[d, d, e]
[d, e, e]
[e, e, e]

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

```text
[a, a, a]
[a, a, b]
[a, a, c]
[a, a, d]
[a, a, e]
[a, b, a]
[a, b, b]
[a, b, c]
[a, b, d]
[a, b, e]
[a, c, a]
[a, c, b]
[a, c, c]
[a, c, d]
[a, c, e]
[a, d, a]
[a, d, b]
[a, d, c]
[a, d, d]
[a, d, e]
[a, e, a]
[a, e, b]
[a, e, c]
[a, e, d]
[a, e, e]
[b, a, a]
[b, a, b]
[b, a, c]
[b, a, d]
[b, a, e]
[b, b, a]
[b, b, b]
[b, b, c]
[b, b, d]
[b, b, e]
[b, c, a]
[b, c, b]
[b, c, c]
[b, c, d]
[b, c, e]
[b, d, a]
[b, d, b]
[b, d, c]
[b, d, d]
[b, d, e]
[b, e, a]
[b, e, b]
[b, e, c]
[b, e, d]
[b, e, e]
[c, a, a]
[c, a, b]
[c, a, c]
[c, a, d]
[c, a, e]
[c, b, a]
[c, b, b]
[c, b, c]
[c, b, d]
[c, b, e]
[c, c, a]
[c, c, b]
[c, c, c]
[c, c, d]
[c, c, e]
[c, d, a]
[c, d, b]
[c, d, c]
[c, d, d]
[c, d, e]
[c, e, a]
[c, e, b]
[c, e, c]
[c, e, d]
[c, e, e]
[d, a, a]
[d, a, b]
[d, a, c]
[d, a, d]
[d, a, e]
[d, b, a]
[d, b, b]
[d, b, c]
[d, b, d]
[d, b, e]
[d, c, a]
[d, c, b]
[d, c, c]
[d, c, d]
[d, c, e]
[d, d, a]
[d, d, b]
[d, d, c]
[d, d, d]
[d, d, e]
[d, e, a]
[d, e, b]
[d, e, c]
[d, e, d]
[d, e, e]
[e, a, a]
[e, a, b]
[e, a, c]
[e, a, d]
[e, a, e]
[e, b, a]
[e, b, b]
[e, b, c]
[e, b, d]
[e, b, e]
[e, c, a]
[e, c, b]
[e, c, c]
[e, c, d]
[e, c, e]
[e, d, a]
[e, d, b]
[e, d, c]
[e, d, d]
[e, d, e]
[e, e, a]
[e, e, b]
[e, e, c]
[e, e, d]
[e, e, e]

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

```text

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

```text
[]
[a]
[b]
[c]
[d]
[e]
[a, b]
[b, a]
[a, c]
[c, a]
[a, d]
[d, a]
[a, e]
[e, a]
[b, c]
[c, b]
[b, d]
[d, b]
[b, e]
[e, b]
[c, d]
[d, c]
[c, e]
[e, c]
[d, e]
[e, d]
[a, b, c]
[a, c, b]
[c, a, b]
[c, b, a]
[b, c, a]
[b, a, c]
[a, b, d]
[a, d, b]
[d, a, b]
[d, b, a]
[b, d, a]
[b, a, d]
[a, b, e]
[a, e, b]
[e, a, b]
[e, b, a]
[b, e, a]
[b, a, e]
[a, c, d]
[a, d, c]
[d, a, c]
[d, c, a]
[c, d, a]
[c, a, d]
[a, c, e]
[a, e, c]
[e, a, c]
[e, c, a]
[c, e, a]
[c, a, e]
[a, d, e]
[a, e, d]
[e, a, d]
[e, d, a]
[d, e, a]
[d, a, e]
[b, c, d]
[b, d, c]
[d, b, c]
[d, c, b]
[c, d, b]
[c, b, d]
[b, c, e]
[b, e, c]
[e, b, c]
[e, c, b]
[c, e, b]
[c, b, e]
[b, d, e]
[b, e, d]
[e, b, d]
[e, d, b]
[d, e, b]
[d, b, e]
[c, d, e]
[c, e, d]
[e, c, d]
[e, d, c]
[d, e, c]
[d, c, e]
[a, b, c, d]
[a, b, d, c]
[a, d, b, c]
[d, a, b, c]
[d, a, c, b]
[a, d, c, b]
[a, c, d, b]
[a, c, b, d]
[c, a, b, d]
[c, a, d, b]
[c, d, a, b]
[d, c, a, b]
[d, c, b, a]
[c, d, b, a]
[c, b, d, a]
[c, b, a, d]
[b, c, a, d]
[b, c, d, a]
[b, d, c, a]
[d, b, c, a]
[d, b, a, c]
[b, d, a, c]
[b, a, d, c]
[b, a, c, d]
[a, b, c, e]
[a, b, e, c]
[a, e, b, c]
[e, a, b, c]
[e, a, c, b]
[a, e, c, b]
[a, c, e, b]
[a, c, b, e]
[c, a, b, e]
[c, a, e, b]
[c, e, a, b]
[e, c, a, b]
[e, c, b, a]
[c, e, b, a]
[c, b, e, a]
[c, b, a, e]
[b, c, a, e]
[b, c, e, a]
[b, e, c, a]
[e, b, c, a]
[e, b, a, c]
[b, e, a, c]
[b, a, e, c]
[b, a, c, e]
[a, b, d, e]
[a, b, e, d]
[a, e, b, d]
[e, a, b, d]
[e, a, d, b]
[a, e, d, b]
[a, d, e, b]
[a, d, b, e]
[d, a, b, e]
[d, a, e, b]
[d, e, a, b]
[e, d, a, b]
[e, d, b, a]
[d, e, b, a]
[d, b, e, a]
[d, b, a, e]
[b, d, a, e]
[b, d, e, a]
[b, e, d, a]
[e, b, d, a]
[e, b, a, d]
[b, e, a, d]
[b, a, e, d]
[b, a, d, e]
[a, c, d, e]
[a, c, e, d]
[a, e, c, d]
[e, a, c, d]
[e, a, d, c]
[a, e, d, c]
[a, d, e, c]
[a, d, c, e]
[d, a, c, e]
[d, a, e, c]
[d, e, a, c]
[e, d, a, c]
[e, d, c, a]
[d, e, c, a]
[d, c, e, a]
[d, c, a, e]
[c, d, a, e]
[c, d, e, a]
[c, e, d, a]
[e, c, d, a]
[e, c, a, d]
[c, e, a, d]
[c, a, e, d]
[c, a, d, e]
[b, c, d, e]
[b, c, e, d]
[b, e, c, d]
[e, b, c, d]
[e, b, d, c]
[b, e, d, c]
[b, d, e, c]
[b, d, c, e]
[d, b, c, e]
[d, b, e, c]
[d, e, b, c]
[e, d, b, c]
[e, d, c, b]
[d, e, c, b]
[d, c, e, b]
[d, c, b, e]
[c, d, b, e]
[c, d, e, b]
[c, e, d, b]
[e, c, d, b]
[e, c, b, d]
[c, e, b, d]
[c, b, e, d]
[c, b, d, e]
[a, b, c, d, e]
[a, b, c, e, d]
[a, b, e, c, d]
[a, e, b, c, d]
[e, a, b, c, d]
[e, a, b, d, c]
[a, e, b, d, c]
[a, b, e, d, c]
[a, b, d, e, c]
[a, b, d, c, e]
[a, d, b, c, e]
[a, d, b, e, c]
[a, d, e, b, c]
[a, e, d, b, c]
[e, a, d, b, c]
[e, d, a, b, c]
[d, e, a, b, c]
[d, a, e, b, c]
[d, a, b, e, c]
[d, a, b, c, e]
[d, a, c, b, e]
[d, a, c, e, b]
[d, a, e, c, b]
[d, e, a, c, b]
[e, d, a, c, b]
[e, a, d, c, b]
[a, e, d, c, b]
[a, d, e, c, b]
[a, d, c, e, b]
[a, d, c, b, e]
[a, c, d, b, e]
[a, c, d, e, b]
[a, c, e, d, b]
[a, e, c, d, b]
[e, a, c, d, b]
[e, a, c, b, d]
[a, e, c, b, d]
[a, c, e, b, d]
[a, c, b, e, d]
[a, c, b, d, e]
[c, a, b, d, e]
[c, a, b, e, d]
[c, a, e, b, d]
[c, e, a, b, d]
[e, c, a, b, d]
[e, c, a, d, b]
[c, e, a, d, b]
[c, a, e, d, b]
[c, a, d, e, b]
[c, a, d, b, e]
[c, d, a, b, e]
[c, d, a, e, b]
[c, d, e, a, b]
[c, e, d, a, b]
[e, c, d, a, b]
[e, d, c, a, b]
[d, e, c, a, b]
[d, c, e, a, b]
[d, c, a, e, b]
[d, c, a, b, e]
[d, c, b, a, e]
[d, c, b, e, a]
[d, c, e, b, a]
[d, e, c, b, a]
[e, d, c, b, a]
[e, c, d, b, a]
[c, e, d, b, a]
[c, d, e, b, a]
[c, d, b, e, a]
[c, d, b, a, e]
[c, b, d, a, e]
[c, b, d, e, a]
[c, b, e, d, a]
[c, e, b, d, a]
[e, c, b, d, a]
[e, c, b, a, d]
[c, e, b, a, d]
[c, b, e, a, d]
[c, b, a, e, d]
[c, b, a, d, e]
[b, c, a, d, e]
[b, c, a, e, d]
[b, c, e, a, d]
[b, e, c, a, d]
[e, b, c, a, d]
[e, b, c, d, a]
[b, e, c, d, a]
[b, c, e, d, a]
[b, c, d, e, a]
[b, c, d, a, e]
[b, d, c, a, e]
[b, d, c, e, a]
[b, d, e, c, a]
[b, e, d, c, a]
[e, b, d, c, a]
[e, d, b, c, a]
[d, e, b, c, a]
[d, b, e, c, a]
[d, b, c, e, a]
[d, b, c, a, e]
[d, b, a, c, e]
[d, b, a, e, c]
[d, b, e, a, c]
[d, e, b, a, c]
[e, d, b, a, c]
[e, b, d, a, c]
[b, e, d, a, c]
[b, d, e, a, c]
[b, d, a, e, c]
[b, d, a, c, e]
[b, a, d, c, e]
[b, a, d, e, c]
[b, a, e, d, c]
[b, e, a, d, c]
[e, b, a, d, c]
[e, b, a, c, d]
[b, e, a, c, d]
[b, a, e, c, d]
[b, a, c, e, d]
[b, a, c, d, e]

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

```text
Pseudo-list containing all 19275223968000 10-permutations of items from [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z].

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

```text
The index of [a, l, g, o, r, i, t, h, m, s] is 6831894769563.
permutations[6831894769563]: [a, l, g, o, r, i, t, h, m, s]

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

```text
There are 1096259850353149530222034277 compounds of these letters!
The last compound is [b, a, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z].

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

```text
[]
[1]
[2]
[1, 2]
[3]
[1, 3]
[2, 3]
[1, 2, 3]
[4]
[1, 4]
[2, 4]
[1, 2, 4]
[3, 4]
[1, 3, 4]
[2, 3, 4]
[1, 2, 3, 4]
[5]
[1, 5]
[2, 5]
[1, 2, 5]
[3, 5]
[1, 3, 5]
[2, 3, 5]
[1, 2, 3, 5]
[4, 5]
[1, 4, 5]
[2, 4, 5]
[1, 2, 4, 5]
[3, 4, 5]
[1, 3, 4, 5]
[2, 3, 4, 5]
[1, 2, 3, 4, 5]

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

```text
[]
[a]
[b]
[a, b]
[c]
[a, c]
[b, c]
[a, b, c]
[d]
[a, d]
[b, d]
[a, b, d]
[c, d]
[a, c, d]
[b, c, d]
[a, b, c, d]
[e]
[a, e]
[b, e]
[a, b, e]
[c, e]
[a, c, e]
[b, c, e]
[a, b, c, e]
[d, e]
[a, d, e]
[b, d, e]
[a, b, d, e]
[c, d, e]
[a, c, d, e]
[b, c, d, e]
[a, b, c, d, e]

```

---

`trotter` was written by [Richard Nathan Ambler](mailto:rambler@wya.top).

Thanks for your interest in this library. Please file any bugs, issues
and suggestions [here](https://github.com/ram6ler/dart-trotter/issues).
