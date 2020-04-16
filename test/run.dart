import 'package:trotter/trotter.dart';

void main() {
  {
    print('\nCombinations...');
    final bagOfItems = characters('abcde'),
        combos = Combinations(3, bagOfItems);
    for (final combo in combos()) {
      print('$combo (${combos.indexOf(combo)})');
    }

    for (final combo in [
      ['e', 'c', 'a'],
      ['a', 'c', 'e']
    ]) {
      print('... $combo -> ${combos.indexOf(combo)}');
    }
  }

  {
    print('\nPermutations...');
    final bagOfItems = characters('abcde'), perms = Permutations(3, bagOfItems);
    for (final perm in perms()) {
      print('$perm (${perms.indexOf(perm)})');
    }
  }

  {
    print('\nCompositions...');
    final bagOfItems = characters('abcde'), comps = Compositions(3, bagOfItems);
    for (final comp in comps()) {
      print('$comp (${comps.indexOf(comp)})');
    }
    for (final comp in [
      ['e', 'c', 'a'],
      ['a', 'c', 'e']
    ]) {
      print('... $comp -> ${comps.indexOf(comp)}');
    }
  }

  {
    print('\nAmalgams...');
    final bagOfItems = characters('abcde'), amals = Amalgams(3, bagOfItems);
    for (final amal in amals()) {
      print('$amal (${amals.indexOf(amal)})');
    }
  }

  {
    print('\nSubsets...');
    final bagOfItems = characters('abcde'), subs = Subsets(bagOfItems);
    for (final sub in subs()) {
      print('$sub (${subs.indexOf(sub)})');
    }
  }

  {
    print('\nCompounds...');
    final bagOfItems = characters('abcde'), comps = Compounds(bagOfItems);
    for (final comp in comps()) {
      print('$comp (${comps.indexOf(comp)})');
    }
  }
}
