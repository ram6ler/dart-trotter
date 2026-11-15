import 'package:trotter/trotter.dart';

void main() {
  final items = [for (var i = 0; i < 5; i++) i],
      // Combinations of 3 items taken from 5...
      combinations = items.toCombinations(take: 3),
      // Combinations of unspecified length...
      subsets = items.toSubsets(),
      // Combinations of 3 items taken from 5 with replacement...
      compositions = items.toCompositions(take: 3),
      // Permutations of 3 items taken from 5...
      permutations = items.toPermutations(take: 3),
      // Permutations of unspecified length...
      compounds = items.toCompounds(),
      // Permutations of 3 items taken from 5 with replacement...
      amalgams = items.toAmalgams(take: 3);

  for (final (message, combinatorics) in [
    ('Subsets', subsets),
    ('Combinations', combinations),
    ('Permutations', permutations),
    ('Compounds', compounds),
    ('Compositions', compositions),
    ('Amalgams', amalgams)
  ]) {
    print('\n$message:\n');
    for (final (i, arrangement) in combinatorics().indexed) {
      print('$i -> $arrangement -> ${combinatorics.indexOf(arrangement)}');
    }
  }
}
