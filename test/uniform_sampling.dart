import "package:trotter/trotter.dart";

void main() {
  final combos = "abcde".combinations(3);
  print(combos);
  String createKey(List<String> combo) => combo.join("");
  final sampleSize = 10000,
      p = 1 / sampleSize,
      map = {for (final combo in combos()) createKey(combo): 0.0};

  for (final combo in combos.sample(sampleSize, withReplacement: true)) {
    final key = createKey(combo);
    map[key] = map[key]! + p;
  }

  for (final combo in combos()) {
    final key = combo.join("");
    print("$key\t${map[key]}");
  }
}
