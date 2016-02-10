
![](https://bitbucket.org/ram6ler/dart_trotter/wiki/dart_trotter_banner.png)

Welcome to trotter, a Dart library that simplifies working with structures commonly
encountered in combinatorics such as combinations and permutations.

Trotter gives the developer access to pseuso-lists that "contain" all arrangements
(combinations, permutations, etc.) of objects taken from a specified list of items.
The order of arrangements is based on the
[Steinhaus–Johnson–Trotter algorithm](https://en.wikipedia.org/wiki/Steinhaus%E2%80%93Johnson%E2%80%93Trotter_algorithm)
for ordering permutations, which has been generalized to combinations and arrangements
that allow for replacement after item selection.

The pseudo-list classes available are:

* Combinations.
* Permutations.
* Selections (combinations with replacement).
* Amalgams (permutations with replacement).
* Subsets (combinations of unspecified size).
* Compounds (permutations of unspecified size).

For example, the following programme creates a pseudo-list "containing"
all the 3-combinations of the first five letters.

```dart

  print("Here is a bag of items:");

  var bagOfItems = characters("abcde");
  print(bagOfItems);

  print("\n\nHere are all the combinations of three items taken from this bag.");

  var combos = new Combinations(3, bagOfItems);

  for (List combo in combos) {
    print(combo);
  }
```

And here is the output:

```text

Here is a bag of items:
[a, b, c, d, e]


Here are all the combinations of three items taken from this bag.

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
Technically, the pseudo-list classes encapsulate *mappings* from integers to
various item arrangements and vice versa, and so it is possible for them to
"store" - and look up from - a very large number of item arrangements.

Here is an example that shows how we can work with a *huge* pseudo-list:

```dart

var largeBagOfItems = characters("abcdefghijklmnopqrstuvwxyz");
var hugePseudoList = new Permutations(10, largeBagOfItems);

print("\n\nThere are ${hugePseudoList.length} permutatations of 10 letters");
print("taken from the alphabet. Don't try to access them all!!!\n");
print("However, we can access whichever permutations in the pseudo-list");
print("we are interested in. For example, the billionth to the billion-tenth");
print("permutations of these letters are:\n");

for (List x in hugePseudoList.range(999999999, 1000000009)) print(x);

print("\n\nWe can also find the index of a given permutation...\n");

int algorithmsIndex = hugePseudoList.indexOf(
    ["a", "l", "g", "o", "r", "i", "t", "h", "m", "s"]);
print("The index of [a, l, g, o, r, i, t, h, m, s] is $algorithmsIndex.\n");

print("(That's almost seven trillion! Luckily we didn't have to search");
print("through all the permutations!)\n");

print("hugePseudoList[$algorithmsIndex] = ${hugePseudoList[algorithmsIndex]}.");
```

And here is the output:

```text
There are 19275223968000 permutatations of 10 letters
taken from the alphabet. Don't try to access them all!!!

However, we can access whichever permutations in the pseudo-list
we are interested in. For example, the billionth to the billion-tenth
permutations of these letters are:

[u, i, c, f, g, d, b, e, a, w]
[i, u, c, f, g, d, b, e, a, w]
[i, u, c, f, g, d, b, e, w, a]
[i, u, c, f, g, d, b, w, e, a]
[i, u, c, f, g, d, w, b, e, a]
[i, u, c, f, g, w, d, b, e, a]
[i, u, c, f, w, g, d, b, e, a]
[i, u, c, w, f, g, d, b, e, a]
[i, u, w, c, f, g, d, b, e, a]
[i, w, u, c, f, g, d, b, e, a]


We can also find the index of a given permutation...

The index of [a, l, g, o, r, i, t, h, m, s] is 6831894769563.

(That's almost seven trillion! Luckily we didn't have to search
through all the permutations!)

hugePseudoList[6831894769563] = [a, l, g, o, r, i, t, h, m, s].
```

For more information and examples of use, see the
[Trotter wiki](https://bitbucket.org/ram6ler/dart_trotter/wiki/Home.md).

Enjoy!