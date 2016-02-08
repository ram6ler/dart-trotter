import "trotter.dart";

void main() {

  print(characters("Hello!"));


  var items = ["[0]", "[1]", "[2]", "[3]", "[4]"];

  print(string(items));


  print("\n\nCombinations:");
  var combos = new Combinations(3, items);
  for (int i = 0; i < combos.length; i++) {
    print("$i\t${combos[i]}\t->\t${combos.indexOf(combos[i])}");
  }

  print("\n\nPermutations:");
  var permos = new Permutations(3, items);
  for (int i = 0; i < permos.length; i++) {
    print("$i\t${permos[i]}\t->\t${permos.indexOf(permos[i])}");
  }

  print("\n\nSelections:");
  var sels = new Selections(3, items);
  for (int i = 0; i < sels.length; i++) {
    print("$i\t${sels[i]}\t->\t${sels.indexOf(sels[i])}");
  }

  print("\n\nAmalgams:");
  var ams = new Amalgams(3, items);
  for (int i = 0; i < ams.length; i++) {
    print("$i\t${ams[i]}\t->\t${ams.indexOf(ams[i])}");
  }

  print("\n\nSubsets:");
  var subs = new Subsets(items);
  for (int i = 0; i < subs.length; i++) {
    print("$i\t${subs[i]}\t->\t${subs.indexOf(subs[i])}");
  }



 for (List x in new Selections(3, items)) print(x);
}