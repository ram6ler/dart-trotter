import 'package:trotter/trotter.dart';

void main() {
  final permutations = Permutations(3, characters('abcd')),
      storage = Storage(permutations);

  void show() {
    for (final permutation in permutations()) {
      print('$permutation\t${storage.contains(permutation)}');
    }
  }

  storage.removeWhere((x) => x.contains('a'));
  show();
  print("...");
}
