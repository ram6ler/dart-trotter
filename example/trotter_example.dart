import "package:trotter/trotter.dart";

void main() {
  print("\n" * 10);
  print("Welcome to trotter, a library for working with structures");
  print("commonly encoundered in combinatorics.\n\n");

  print("Here is a bag of items:");
  var bagOfItems = characters("abcde");
  print(bagOfItems);

  print("\n\nHere are all the combinations of three items taken from this bag.");
  print("(For combinations, order is NOT important and items are NOT replaced.)\n");
  var combos = new Combinations(3, bagOfItems);
  for (int i = 0; i < combos.length; i++) {
    print("$i\t${combos[i]}");
  }

  print("\n\nHere are all the permutations of three items taken from this bag.");
  print("(For permutations, order IS important and items are NOT replaced.)\n");
  var permos = new Permutations(3, bagOfItems);
  for (int i = 0; i < permos.length; i++) {
    print("$i\t${permos[i]}");
  }

  print("\n\nHere are all the 'selections' of three items taken from this bag.");
  print("(For selections, order is NOT important and items ARE replaced.)\n");
  var sels = new Selections(3, bagOfItems);
  for (int i = 0; i < sels.length; i++) {
    print("$i\t${sels[i]}");
  }

  print("\n\nHere are all the 'amalgams' of three items taken from this bag.");
  print("(For amalgams, order IS important and items ARE replaced.)\n");
  var ams = new Amalgams(3, bagOfItems);
  for (int i = 0; i < ams.length; i++) {
    print("$i\t${ams[i]}");
  }

  print("\n\nHere are all the subsets of three items taken from this bag.");
  print("(For subsets, order is NOT important, items are NOT replaced and the");
  print("number of items taken is not specified.)\n");
  var subs = new Subsets(bagOfItems);
  for (int i = 0; i < subs.length; i++) {
    print("$i\t${subs[i]}");
  }

  print("\n\nItems can be accessed using the 'in' keyword. Take care not to do this");
  print("when dealing with large pseudo-lists! There is only so much time and");
  print("memory in this universe!\n");
  for (List x in new Selections(3, bagOfItems)) print(x);

  print("\n\nBetter to be more specific using the `range` method:\n");
  var largeBagOfItems = characters("abcdefghijklmnopqrstuvwxyz");
  var hugePseudoList = new Permutations(10, largeBagOfItems);

  print("\n\nThere are ${hugePseudoList.length} permutatations of 10 letters");
  print("taken from the alphabet. Don't try to access them all!!!\n");
  print("However, we can access whichever permutations in the pseudo-list");
  print("that we are interested in. For example, the billionth to the billion-tenth");
  print("permutations of these letters are:\n");

  for (List x in hugePseudoList.range(999999999, 1000000009)) print(x);

  print("\n\nWe can also find the index of a given permutation...\n");

  int algorithmsIndex = hugePseudoList.indexOf(["a", "l", "g", "o", "r", "i", "t", "h", "m", "s"]);
  print("The index of [a, l, g, o, r, i, t, h, m, s] is $algorithmsIndex.\n");

  print("(That's almost seven trillion! Luckily we're only working with pseudo-lists!)\n");

  print("hugePseudoList[$algorithmsIndex] = ${hugePseudoList[algorithmsIndex]}.");

  print("\n\nEnjoy!\n\n");

}