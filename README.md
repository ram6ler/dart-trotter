# Trotter

Trotter is a Dart library containing definintions of several classes designed to make working with objects commonly encountered in combinatorics easier.


## Class: Permutations
 The `Permutations` class defines instances of pseudo-lists containing all possible permutations of a given number of objects taken from a group.


### Example

```
import "trotter.dart" as Trotter;

void main() {
  List<String> fruits = [
    "apple", "orange", "pineapple",
    "peach", "apricot", "pear",
    "strawberry", "blueberry", "cherry"
  ];
  
  var perm3 = new Trotter.Permutations(3, fruits);
  print("There are ${perm3.length} 3-permutations of the objects in\n$fruits.");
  print("The first permutation is ${perm3[0]}.");
  print("\nThe first ten permutations:");
  (new List.generate(10, (int i) => perm3[i]))
    .forEach((List perm) {print(perm);});
  print("\nThe last five permutations:");
  (new List.generate(5, (int i) => perm3[i - 5]))
    .forEach((List perm) {print(perm);});
}
```
### Output
```
There are 504 3-permutations of the objects in
[apple, orange, pineapple, peach, apricot, pear, strawberry, blueberry, cherry].
The first permutation is [apple, orange, pineapple].

The first ten permutations:
[apple, orange, pineapple]
[apple, pineapple, orange]
[pineapple, apple, orange]
[pineapple, orange, apple]
[orange, pineapple, apple]
[orange, apple, pineapple]
[apple, orange, peach]
[apple, peach, orange]
[peach, apple, orange]
[peach, orange, apple]

The last five permutations:
[strawberry, cherry, blueberry]
[cherry, strawberry, blueberry]
[cherry, blueberry, strawberry]
[blueberry, cherry, strawberry]
[blueberry, strawberry, cherry]
```

## Class: Combinations
 The `Combinations` class defines instances of pseudo-lists containing all possible combinations of a given number of objects taken from a group.


### Example

```
import "trotter.dart" as Trotter;

void main() {
  List<String> fruits = [
    "apple", "orange", "pineapple",
    "peach", "apricot", "pear",
    "strawberry", "blueberry", "cherry"
  ];
  
  var comb3 = new Trotter.Combinations(3, fruits);
  print("\nThere are ${comb3.length} 3-combinations of the objects in\n$fruits.");
  print("The first combination is ${comb3[0]}.");
  print("\nThe first ten combinations:");
  (new List.generate(10, (int i) => comb3[i]))
    .forEach((List comb) {print(comb);});
  print("\nThe last five combinations:");
  (new List.generate(5, (int i) => comb3[i - 5]))
    .forEach((List comb) {print(comb);});
}
```
### Output
```
There are 84 3-combinations of the objects in
[apple, orange, pineapple, peach, apricot, pear, strawberry, blueberry, cherry].
The first combination is [apple, orange, pineapple].

The first ten combinations:
[apple, orange, pineapple]
[apple, orange, peach]
[apple, orange, apricot]
[apple, orange, pear]
[apple, orange, strawberry]
[apple, orange, blueberry]
[apple, orange, cherry]
[apple, pineapple, peach]
[apple, pineapple, apricot]
[apple, pineapple, pear]

The last five combinations:
[apricot, blueberry, cherry]
[pear, strawberry, blueberry]
[pear, strawberry, cherry]
[pear, blueberry, cherry]
[strawberry, blueberry, cherry]
```

## Class: Pincodes
 The `Pincodes` class defines instances of pseudo-lists containing all possible _pincodes_ (permutations with replacement) of a given number of objects taken from a group.


### Example

```
import "trotter.dart" as Trotter;

void main() {
  List<String> fruits = [
    "apple", "orange", "pineapple",
    "peach", "apricot", "pear",
    "strawberry", "blueberry", "cherry"
  ];
  
  var pins3 = new Trotter.Pincodes(3, fruits); 
  print("\nThere are ${pins3.length} 3-pincodes of the objects in\n$fruits.");
  print("The first pincode is ${pins3[0]}.");
  print("\nThe first ten pincodes:");
  (new List.generate(10, (int i) => pins3[i]))
    .forEach((List pin) {print(pin);});
  print("\nThe last five pincodes:");
  (new List.generate(5, (int i) => pins3[i - 5]))
    .forEach((List pin) {print(pin);});
}
```
### Output
```
There are 729 3-pincodes of the objects in
[apple, orange, pineapple, peach, apricot, pear, strawberry, blueberry, cherry].
The first pincode is [apple, apple, apple].

The first ten pincodes:
[apple, apple, apple]
[apple, apple, orange]
[apple, apple, pineapple]
[apple, apple, peach]
[apple, apple, apricot]
[apple, apple, pear]
[apple, apple, strawberry]
[apple, apple, blueberry]
[apple, apple, cherry]
[apple, orange, apple]

The last five pincodes:
[cherry, cherry, apricot]
[cherry, cherry, pear]
[cherry, cherry, strawberry]
[cherry, cherry, blueberry]
[cherry, cherry, cherry]
```

## Class: Subsets
 The `Subsets ` class defines instances of pseudo-lists containing all possible Subsets of objects taken from a group.


### Example

```
import "trotter.dart" as Trotter;

void main() {
  List<String> fruits = [
    "apple", "orange", "pineapple",
    "peach", "apricot", "pear",
    "strawberry", "blueberry", "cherry"
  ];
  
  var subs = new Trotter.Subsets(fruits);
  print("\nThere are ${subs.length} subsets of the objects in\n$fruits.");
  print("The first subset is ${subs[0]}.");
  print("\nThe first ten subsets:");
  (new List.generate(10, (int i) => subs[i]))
    .forEach((List sub) {print(sub);});
  print("\nThe last five subsets:");
  (new List.generate(5, (int i) => subs[i - 5]))
    .forEach((List sub) {print(sub);});
}
```
### Output
```
There are 512 subsets of the objects in
[apple, orange, pineapple, peach, apricot, pear, strawberry, blueberry, cherry].
The first subset is [].

The first ten subsets:
[]
[apple]
[orange]
[apple, orange]
[pineapple]
[apple, pineapple]
[orange, pineapple]
[apple, orange, pineapple]
[peach]
[apple, peach]

The last five subsets:
[apple, orange, peach, apricot, pear, strawberry, blueberry, cherry]
[pineapple, peach, apricot, pear, strawberry, blueberry, cherry]
[apple, pineapple, peach, apricot, pear, strawberry, blueberry, cherry]
[orange, pineapple, peach, apricot, pear, strawberry, blueberry, cherry]
[apple, orange, pineapple, peach, apricot, pear, strawberry, blueberry, cherry]
```

## Ranges
Ranges of the combinatoric-lists stored in the various pseudo-lists can be accessed (created) via the `range` function.

### Example

```
import "trotter.dart" as Trotter;

void main() {
  List<String> fruits = [
    "apple", "orange", "pineapple",
    "peach", "apricot", "pear",
    "strawberry", "blueberry", "cherry"
  ];
  
  var perm3 = new Trotter.Permutations(3, fruits);
  print("Permutations 50 to 52 are:\n${perm3.range(50, 53)}");
}
```
### Output
```
Permutations 50 to 52 are:
[[apricot, apple, pineapple], [apricot, pineapple, apple], [pineapple, apricot, apple]]
```