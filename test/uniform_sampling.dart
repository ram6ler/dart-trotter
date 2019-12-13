import 'package:trotter/trotter.dart';

void main() {
  final combos = 'abcde'.combinations(3);
  print(combos);
  final sampleSize = 10000,
      p = 1 / sampleSize,
      map = Map<String, num>.fromIterable(combos(),
          key: (combo) => combo.join(''), value: (_) => 0.0);

  for (final combo in combos.sample(sampleSize, withReplacement: true)) {
    map[combo.join('')] += p;
  }

  for (final combo in combos()) {
    final key = combo.join('');
    print('$key\t${map[key]}');
  }
}
