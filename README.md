
![](https://bitbucket.org/ram6ler/dart_trotter/wiki/dart_trotter_banner.png)

Welcome to `trotter`, a Dart library that simplifies working with meta-arrangements commonly
encountered in combinatorics such as arrangements of combinations and permutations.

`trotter` gives the developer access to pseudo-lists that "contain" an arrangement of
all arrangements (combinations, permutations, etc.) of objects taken from a specified list of
items.

The order of arrangements is based on the the order produced by the  [Steinhaus–Johnson–Trotter algorithm](https://en.wikipedia.org/wiki/Steinhaus%E2%80%93Johnson%E2%80%93Trotter_algorithm)
for ordering permutations, which has been generalized to combinations and arrangements
that allow for replacement after item selection.

The pseudo-list classes available are:
* Combinations.
* Permutations.
* Compositions (combinations with replacement).
* Amalgams (permutations with replacement).
* Subsets (combinations of unspecified size).
* Compounds (permutations of unspecified size).

## Using `trotter`

For Dart 1, include the following line in your pubspec's dependencies:

```text
trotter: 0.9.1
```

For Dart 2, include the following line instead:

```text
trotter: ^0.9.5
```

If you would like to use the most recent version of the library that
possibly has not been uploaded to [Dart Pub](https://pub.dartlang.org/)
yet, include the following:

```text
trotter:
  git: https://ram6ler@bitbucket.org/ram6ler/dart_trotter.git
```

Then, to import the library:

```dart
import "package:trotter/trotter.dart";
```

## The basic classes

### Combinations

A *combination* is a selection of items for which order is *not*
important and items are *not* replaced after being selected.

The `Combinations` class defines a pseudo-list that "contains" an
arrangement of all combinations of a set of items.


**Example:**

```dart
    List bagOfItems = characters("abcde");
    var combos = new Combinations(3, bagOfItems);
    for (var combo in combos()) {
      print(combo);
    }
```

**Output:**

---
```

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
---


### Permutations

A *permutation* is a selection of items for which order *is* important
and items are *not* replaced after being selected.

The `Permutations` class defines a pseudo-list that "contains" an
arrangement of all permutations of a set of items.


**Example:**

```dart
    List bagOfItems = characters("abcde");
    var perms = new Permutations(3, bagOfItems);
    for (var perm in perms()) {
      print(perm);
    }
```

**Output:**

---
```

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
---


(Notice that this library arranges permutations similarly to the way the
[Steinhaus-Johnson-Trotter](https://en.wikipedia.org/wiki/Steinhaus%E2%80%93Johnson%E2%80%93Trotter_algorithm)
algorithm arranges permutations. In fact, if we get the permutations of
*all* the specified items, e.g. `var perms = new Permutations(5, bagOfItems);`
in the above code, the arrangement of permutations is exactly what would
have resulted from applying the S-J-T algorithm. The algorithms in this library
have an advantage in that they do not iterate through all k - 1 permutations in
order to determint the kth permutation, however.)

### Compositions

A *composition* (or combination with replacement) is a selection of items for
which order is *not* important and items *are* replaced after being selected.

The `Compositions` class defines a pseudo-list that "contains" an arrangement
of all compositions of a set of items.

Here are all the compositions of three items taken from a bag of five items:


**Example:**

```dart
    List bagOfItems = characters("abcde");
    var comps = new Compositions(3, bagOfItems);
    for (var comp in comps()) {
      print(comp);
    }
```

**Output:**

---
```

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
---


### Amalgams

An *amalgam* (or permutation with replacement) is a selection of items for
which order *is* important and items *are* replaced after being selected.

The `Amalgams` class defines a pseudo-list that "contains" an arrangement
of all amalgams of a set of items.


**Example:**

```dart
    List bagOfItems = characters("abcde");
    var amals = new Amalgams(3, bagOfItems);
    for (var amal in amals()) {
      print(amal);
    }
```

**Output:**

---
```

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
---


### Subsets

A *subset* (or combination of unspecified length) is a selection of items for
which order is *not* important, items are *not* replaced and the number of
items is not specified.

The `Subsets` class defines a pseudo-list that "contains" an arrangement
of all subsets of a set of items.


**Example:**

```dart
    List bagOfItems = characters("abcde");
    var subs = new Subsets(bagOfItems);
    for (var sub in subs()) {
      print(sub);
    }
```

**Output:**

---
```

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


### Compounds

A *compound* (or permutation of unspecified length) is a selection of items for
which order *is* important, items are *not* replaced and the number of
items is not specified.

The `Compounds` class defines a pseudo-list that "contains" an arrangement
of all compounds of a set of items.


**Example:**

```dart
    List bagOfItems = characters("abcde");
    var comps = new Compounds(bagOfItems);
    for (var comp in comps()) {
      print(comp);
    }
```

**Output:**

---
```

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
---


## Large indices

Arrangement numbers often grow very quickly. For example, consider the number
of 10-permutations of the letters of the alphabet:


**Example:**

```dart
    List largeBagOfItems = characters("abcdefghijklmnopqrstuvwxyz");
    var perms = new Permutations(10, largeBagOfItems);
    print(perms);
```

**Output:**

---
```

Pseudo-list containing all 19275223968000 10-permutations of items from [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z].
```
---


Wow! That's a lot of permutations! It's most likely a bad idea
to iterate over them all!

Notice that the word `algorithms` is a 10-permutation of the
letters of the alphabet. What is the index of this permutation
in our list of permutations?


**Example:**

```dart
    List largeBagOfItems = characters("abcdefghijklmnopqrstuvwxyz");
    var perms = new Permutations(10, largeBagOfItems);
    List permutationOfInterest = characters("algorithms");
    BigInt index = perms.indexOf(permutationOfInterest);
    print("The index of $permutationOfInterest is $index.");
    print("perms[$index]: ${perms[index]}");
```

**Output:**

---
```

The index of [a, l, g, o, r, i, t, h, m, s] is 6831894769563.
perms[6831894769563]: [a, l, g, o, r, i, t, h, m, s]
```
---


Wow! That's almost seven trillion! Luckily we didn't need to
perform that search using brute force!

Be aware that we sometimes can be working with indexes so large
that they cannot be represented using Dart's 64 bit `int`, in
which case we need to use `BigInt` objects.


**Example:**

```dart
    var largeBagOfItems = characters("abcdefghijklmnopqrstuvwxyz");
    var comps = new Compounds(largeBagOfItems);
    print("There are ${comps.length} compounds of these letters!");
    BigInt lastCompoundIndex = comps.length - BigInt.one;
    print("The last compound is ${comps[lastCompoundIndex]}.");
```

**Output:**

---
```

There are 1096259850353149530222034277 compounds of these letters!
The last compound is [b, a, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z].
```
---


Unless you're immortal, don't try to use `comps().last` to
access the last compound in the previous example!

## `trotter` in Dart 2

In Dart 1, at least on the Dart VM, `int` instances could be used to
represent arbitrary precision integers, and the classes above could
conveniently extend `ListBase`, which made the analogy with a list of
arrangements very strong. As of Dart 2, `int` instances can
only be used to represent up to 64 bit integers. Although Dart 2 does
provide the `BigInt` class for dealing with very large integers, `BigInt`
instances cannot be used to index `List` instances, and the classes
above had to drop the extension.

The first version of `trotter` that can be used for large structures
in Dart 2 is *trotter 0.9.5*. In general, only slight modifications
need be made to code written for previous versions. Here are some
examples.

### Instances are no longer iterable

Instances are no longer iterable, list-like structures. An
`Iterable` "containing" all the arrangements is available through
directly calling the instance, calling the `range` method or accessing
the `iterable` property, however.

**trotter < 0.9.5**

```dart
var combos = new Combinations(3, characters("abcde"));
for (var combo in combos) { // combos is iterable
...
}
```

**trotter >= 0.9.5**

```dart
var combos = new Combinations(3, characters("abcde"));
for (var combo in combos()) { // combos is callable, returns an iterable
...
}
```

Filters, mappings and other tasks associated with `Iterable` instances can
no longer be applied directly to instances of the classes above, but can, of
course be applied to the `Iterable` returned by direct calling, the `range`
method or the `iterable` property.


**Example:**

```dart
    var items = characters("abc");
    var subsets = new Subsets(items);
    print(subsets().where((subset) => subset.length == 2).join(" "));
```

**Output:**

---
```

[a, b] [a, c] [b, c]
```
---


### The `Selections` class has been renamed

In combinatorics literature the term *selection* is often used as a
generic word that can refer to permutations or combinations in different
contexts. The use of the term for combinations with replacement could
thus be confusing. As of trotter 0.9.5, the class `Compositions` is used
to represent combinations. I feel that *composition* is a fitting word:
if a body is *composed* of items A, B and C then it is also composed of
C, B and A, so *composition* suggests that order is not important. Further
a body can be *composed* of two parts of A to one part of B, which
suggests that items are replaced after being selected.

---

`trotter` was written by [Richard Ambler](mailto:rambler@ibwya.net).

Thanks for your interest in this library. Please file any bugs, issues
and suggestions [here](https://bitbucket.org/ram6ler/dart_trotter/issues).

