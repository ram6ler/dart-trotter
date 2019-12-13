import 'dart:math' show Random;
import 'package:trotter/trotter.dart';

void main() {
  print([1, 2, 3].runtimeType);
  final rand = Random(),
      perms = ['Steinhaus', 'Johnson', 'Trotter'].permutations(),
      dissent = [
    'No, no, no!',
    'I disagree.',
    'That\'s absurd!',
    'Preposterous!'
  ],
      exclaim = () => dissent[rand.nextInt(dissent.length)],
      title = (List<String> names) => names.join('-') + ' ordering';

  print(
      'Gentlemen, I propose we call the ordering of permutations the ${title(perms().first)}.');

  for (final perm in perms().skip(1)) {
    print("${exclaim()} It should be the ${title(perm)}!");
  }
  print("\nOkay then... we'll vote on it!");
}
