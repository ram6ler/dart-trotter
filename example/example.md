# Example

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
