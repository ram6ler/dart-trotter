import 'package:trotter/trotter.dart';

void main() {
  final items = [for (var i = 0; i < 5; i++) i],
      // Combinations of 3 items taken from 5...
      combinations = items.combinations(3),
      // Combinations of unspecified length...
      subsets = items.subsets(),
      // Combinations of 3 items taken from 5 with replacement...
      compositions = items.compositions(3),
      // Permutations of 3 items taken from 5...
      permutations = items.permutations(3),
      // Permutations of unspecified length...
      compounds = items.compounds(),
      // Permutations of 3 items taken from 5 with replacement...
      amalgams = items.amalgams(3);

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
