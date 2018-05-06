import 'dart:io';
import "package:trotter/trotter.dart";

main() async {
  var script = await new File("generate_readme.dart").readAsLines();

  var functions = new List<void Function()>();

  ///
  /// ![](https://bitbucket.org/ram6ler/dart_trotter/wiki/dart_trotter_banner.png)
  ///
  /// Welcome to `trotter`, a Dart library that simplifies working with meta-arrangements commonly
  /// encountered in combinatorics such as arrangements of combinations and permutations.
  ///
  /// `trotter` gives the developer access to pseudo-lists that "contain" an arrangement of
  /// all arrangements (combinations, permutations, etc.) of objects taken from a specified list of
  /// items.
  ///
  /// The order of arrangements is based on the the order produced by the  [Steinhaus–Johnson–Trotter algorithm](https://en.wikipedia.org/wiki/Steinhaus%E2%80%93Johnson%E2%80%93Trotter_algorithm)
  /// for ordering permutations, which has been generalized to combinations and arrangements
  /// that allow for replacement after item selection.
  ///
  /// The pseudo-list classes available are:
  /// * Combinations.
  /// * Permutations.
  /// * Compositions (combinations with replacement).
  /// * Amalgams (permutations with replacement).
  /// * Subsets (combinations of unspecified size).
  /// * Compounds (permutations of unspecified size).
  ///
  /// ## Using `trotter`
  ///
  /// For Dart 1, include the following line in your pubspec's dependencies:
  ///
  /// ```text
  /// trotter: 0.9.1
  /// ```
  ///
  /// For Dart 2, include the following line instead:
  ///
  /// ```text
  /// trotter: ^0.9.5
  /// ```
  ///
  /// If you would like to use the most recent version of the library that
  /// possibly has not been uploaded to [Dart Pub](https://pub.dartlang.org/)
  /// yet, include the following:
  ///
  /// ```text
  /// trotter:
  ///   git: https://ram6ler@bitbucket.org/ram6ler/dart_trotter.git
  /// ```
  ///
  /// Then, to import the library:
  ///
  /// ```dart
  /// import "package:trotter/trotter.dart";
  /// ```
  ///
  /// ## The basic classes
  ///
  /// ### Combinations
  ///
  /// A *combination* is a selection of items for which order is *not*
  /// important and items are *not* replaced after being selected.
  ///
  /// The `Combinations` class defines a pseudo-list that "contains" an
  /// arrangement of all combinations of a set of items.
  ///
  functions.add(() {
    List bagOfItems = characters("abcde");
    var combos = new Combinations(3, bagOfItems);
    for (var combo in combos()) {
      print(combo);
    }
  });

  ///
  /// ### Permutations
  ///
  /// A *permutation* is a selection of items for which order *is* important
  /// and items are *not* replaced after being selected.
  ///
  /// The `Permutations` class defines a pseudo-list that "contains" an
  /// arrangement of all permutations of a set of items.
  ///
  functions.add(() {
    List bagOfItems = characters("abcde");
    var perms = new Permutations(3, bagOfItems);
    for (var perm in perms()) {
      print(perm);
    }
  });

  ///
  /// (Notice that this library arranges permutations similarly to the way the
  /// [Steinhaus-Johnson-Trotter](https://en.wikipedia.org/wiki/Steinhaus%E2%80%93Johnson%E2%80%93Trotter_algorithm)
  /// algorithm arranges permutations. In fact, if we get the permutations of
  /// *all* the specified items, e.g. `var perms = new Permutations(5, bagOfItems);`
  /// in the above code, the arrangement of permutations is exactly what would
  /// have resulted from applying the S-J-T algorithm. The algorithms in this library
  /// have an advantage in that they do not iterate through all k - 1 permutations in
  /// order to determint the kth permutation, however.)
  ///
  /// ### Compositions
  ///
  /// A *composition* (or combination with replacement) is a selection of items for
  /// which order is *not* important and items *are* replaced after being selected.
  ///
  /// The `Compositions` class defines a pseudo-list that "contains" an arrangement
  /// of all compositions of a set of items.
  ///
  /// Here are all the compositions of three items taken from a bag of five items:
  ///
  functions.add(() {
    List bagOfItems = characters("abcde");
    var comps = new Compositions(3, bagOfItems);
    for (var comp in comps()) {
      print(comp);
    }
  });

  ///
  /// ### Amalgams
  ///
  /// An *amalgam* (or permutation with replacement) is a selection of items for
  /// which order *is* important and items *are* replaced after being selected.
  ///
  /// The `Amalgams` class defines a pseudo-list that "contains" an arrangement
  /// of all amalgams of a set of items.
  ///
  functions.add(() {
    List bagOfItems = characters("abcde");
    var amals = new Amalgams(3, bagOfItems);
    for (var amal in amals()) {
      print(amal);
    }
  });

  ///
  /// ### Subsets
  ///
  /// A *subset* (or combination of unspecified length) is a selection of items for
  /// which order is *not* important, items are *not* replaced and the number of
  /// items is not specified.
  ///
  /// The `Subsets` class defines a pseudo-list that "contains" an arrangement
  /// of all subsets of a set of items.
  ///
  functions.add(() {
    List bagOfItems = characters("abcde");
    var subs = new Subsets(bagOfItems);
    for (var sub in subs()) {
      print(sub);
    }
  });

  ///
  /// ### Compounds
  ///
  /// A *compound* (or permutation of unspecified length) is a selection of items for
  /// which order *is* important, items are *not* replaced and the number of
  /// items is not specified.
  ///
  /// The `Compounds` class defines a pseudo-list that "contains" an arrangement
  /// of all compounds of a set of items.
  ///
  functions.add(() {
    List bagOfItems = characters("abcde");
    var comps = new Compounds(bagOfItems);
    for (var comp in comps()) {
      print(comp);
    }
  });

  ///
  /// ## Large indices
  ///
  /// Arrangement numbers often grow very quickly. For example, consider the number
  /// of 10-permutations of the letters of the alphabet:
  ///
  functions.add(() {
    List largeBagOfItems = characters("abcdefghijklmnopqrstuvwxyz");
    var perms = new Permutations(10, largeBagOfItems);
    print(perms);
  });

  ///
  /// Wow! That's a lot of permutations! It's most likely a bad idea
  /// to iterate over them all!
  ///
  /// Notice that the word `algorithms` is a 10-permutation of the
  /// letters of the alphabet. What is the index of this permutation
  /// in our list of permutations?
  ///
  functions.add(() {
    List largeBagOfItems = characters("abcdefghijklmnopqrstuvwxyz");
    var perms = new Permutations(10, largeBagOfItems);
    List permutationOfInterest = characters("algorithms");
    BigInt index = perms.indexOf(permutationOfInterest);
    print("The index of $permutationOfInterest is $index.");
    print("perms[$index]: ${perms[index]}");
  });

  ///
  /// Wow! That's almost seven trillion! Luckily we didn't need to
  /// perform that search using brute force!
  ///
  /// Be aware that we sometimes can be working with indexes so large
  /// that they cannot be represented using Dart's 64 bit `int`, in
  /// which case we need to use `BigInt` objects.
  ///
  functions.add(() {
    var largeBagOfItems = characters("abcdefghijklmnopqrstuvwxyz");
    var comps = new Compounds(largeBagOfItems);
    print("There are ${comps.length} compounds of these letters!");
    BigInt lastCompoundIndex = comps.length - BigInt.one;
    print("The last compound is ${comps[lastCompoundIndex]}.");
  });

  ///
  /// Unless you're immortal, don't try to use `comps().last` to
  /// access the last compound in the previous example!
  ///
  /// ## `trotter` in Dart 2
  ///
  /// In Dart 1, at least on the Dart VM, `int` instances could be used to
  /// represent arbitrary precision integers, and the classes above could
  /// conveniently extend `ListBase`, which made the analogy with a list of
  /// arrangements very strong. As of Dart 2, `int` instances can
  /// only be used to represent up to 64 bit integers. Although Dart 2 does
  /// provide the `BigInt` class for dealing with very large integers, `BigInt`
  /// instances cannot be used to index `List` instances, and the classes
  /// above had to drop the extension.
  ///
  /// The first version of `trotter` that can be used for large structures
  /// in Dart 2 is *trotter 0.9.5*. In general, only slight modifications
  /// need be made to code written for previous versions. Here are some
  /// examples.
  ///
  /// ### Instances are no longer iterable
  ///
  /// Instances are no longer iterable, list-like structures. An
  /// `Iterable` "containing" all the arrangements is available through
  /// directly calling the instance, calling the `range` method or accessing
  /// the `iterable` property, however.
  ///
  /// **trotter < 0.9.5**
  ///
  /// ```dart
  /// var combos = new Combinations(3, characters("abcde"));
  /// for (var combo in combos) { // combos is iterable
  ///    ...
  /// }
  /// ```
  ///
  /// **trotter >= 0.9.5**
  ///
  /// ```dart
  /// var combos = new Combinations(3, characters("abcde"));
  /// for (var combo in combos()) { // combos is callable, returns an iterable
  ///    ...
  /// }
  /// ```
  ///
  /// Filters, mappings and other tasks associated with `Iterable` instances can
  /// no longer be applied directly to instances of the classes above, but can, of
  /// course be applied to the `Iterable` returned by direct calling, the `range`
  /// method or the `iterable` property.
  ///
  functions.add(() {
    var items = characters("abc");
    var subsets = new Subsets(items);
    print(subsets().where((subset) => subset.length == 2).join(" "));
  });

  ///
  /// ### The `Selections` class has been renamed
  ///
  /// In combinatorics literature the term *selection* is often used as a
  /// generic word that can refer to permutations or combinations in different
  /// contexts. The use of the term for combinations with replacement could
  /// thus be confusing. As of trotter 0.9.5, the class `Compositions` is used
  /// to represent combinations. I feel that *composition* is a fitting word:
  /// if a body is *composed* of items A, B and C then it is also composed of
  /// C, B and A, so *composition* suggests that order is not important. Further
  /// a body can be *composed* of two parts of A to one part of B, which
  /// suggests that items are replaced after being selected.
  ///
  /// ---
  ///
  /// `trotter` was written by [Richard Ambler](mailto:rambler@ibwya.net).
  ///
  /// Thanks for your interest in this library. Please file any bugs, issues
  /// and suggestions [here](https://bitbucket.org/ram6ler/dart_trotter/issues).
  ///

  bool write = false;
  int index = 0;
  for (String line in script.where((line) => line != "")) {
    if (line.trim()[0] == "/") {
      print(line.replaceAll("///", "").trimLeft());
    } else {
      if (line.trimLeft().length > 13 && line.trimLeft().substring(0, 13) == "functions.add") {
        print("\n**Example:**\n\n```dart");
        write = true;
      } else if (line.trimLeft() == "});") {
        print("```");
        print("\n**Output:**\n\n---\n```\n");
        functions[index]();
        print("```\n---\n");
        index++;
        write = false;
      } else if (write) {
        print(line);
      }
    }
  }
}
