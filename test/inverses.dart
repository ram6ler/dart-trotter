import 'package:trotter/trotter.dart';

void main() {
  {
    print('\nCombinations...');
    final bagOfItems = characters('abcde'),
        combos = Combinations(3, bagOfItems);
    for (final (i, combo) in combos().indexed) {
      print('$i\t$combo\t${combos.indexOf(combo)}');
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
    for (final (i, perm) in perms().indexed) {
      print('$i\t$perm\t${perms.indexOf(perm)}');
    }
  }

  {
    print('\nCompositions...');
    final bagOfItems = characters('abcde'), comps = Compositions(3, bagOfItems);
    for (final (i, comp) in comps().indexed) {
      print('$i\t$comp\t${comps.indexOf(comp)}');
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
    final bagOfItems = characters('abcde'), amalgams = Amalgams(3, bagOfItems);
    for (final (i, amalgam) in amalgams().indexed) {
      print('$i\t$amalgam\t${amalgams.indexOf(amalgam)}');
    }
  }

  {
    print('\nSubsets...');
    final bagOfItems = characters('abcde'), subs = Subsets(bagOfItems);
    for (final (i, sub) in subs().indexed) {
      print('$i\t$sub\t${subs.indexOf(sub)}');
    }
    for (final sub in [
      ['e', 'c', 'a'],
      ['a', 'c', 'e']
    ]) {
      print('... $sub -> ${subs.indexOf(sub)}');
    }
  }

  {
    print('\nCompounds...');
    final bagOfItems = characters('abcde'), comps = Compounds(bagOfItems);
    for (final (i, comp) in comps().indexed) {
      print('$i\t$comp\t${comps.indexOf(comp)}');
    }
  }
}
