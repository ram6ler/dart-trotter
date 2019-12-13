import 'dart:io' show stdout, stdin;
import 'package:trotter/trotter.dart';

final indices = List<int>.generate(10, (i) => i);

void main() {
  final permutations = indices.permutations();

  print("There are ${permutations.length} permutations of the digits 0-9.");
  print(
      "\nHere are the first, middle and last ten in the Johnson-Trotter ordering:\n");

  print(row("Index", "Permutation", "Cyclic Notation", 10, 35));
  void table(BigInt start, BigInt end, [BigInt mark]) {
    for (BigInt i = start; i < end; i += BigInt.one) {
      print("  " +
          row("$i", permutations[i].toString(),
              cyclic(List<int>.from(permutations[i])), 10, 35) +
          (i == mark ? " <---- Here!" : ""));
    }
  }

  table(BigInt.zero, BigInt.from(10));
  print("...");
  table(permutations.length ~/ BigInt.from(2),
      permutations.length ~/ BigInt.from(2) + BigInt.from(10));
  print("...");
  table(permutations.length - BigInt.from(10), permutations.length);

  stdout.write("\nInput permutation p in cyclic notation: ");

  final p = interpret();

  print("...");
  table(permutations.indexOf(p) - BigInt.from(5),
      permutations.indexOf(p) + BigInt.from(5), permutations.indexOf(p));

  stdout.write("\nInput permutation q in cyclic notation: ");

  final q = interpret();

  print("...");
  table(permutations.indexOf(q) - BigInt.from(5),
      permutations.indexOf(q) + BigInt.from(5), permutations.indexOf(q));

  final prod = product(p, q);

  print("The product of p and q is ${cyclic(product(p, q))}:");

  print("...");
  table(permutations.indexOf(prod) - BigInt.from(5),
      permutations.indexOf(prod) + BigInt.from(5), permutations.indexOf(prod));
}

String row(String col1, String col2, String col3, int w1, int w2) =>
    col1.padRight(w1) + col2.padRight(w2) + col3;

List<int> interpret() {
  var permutation = stdin.readLineSync();
  final split =
      permutation.split(RegExp(r'[^0-9]')).where((string) => string.isNotEmpty);
  var result = List<int>.from(indices);
  if (split.isNotEmpty) {
    for (final string in split) {
      final digits = characters(string).map((x) => int.parse(x)).toList(),
          length = digits.length;
      for (var i = 0; i < length; i++) {
        result[digits[i]] = digits[(i + 1) % length];
      }
    }
  }
  return result;
}

String cyclic(List<int> permutation) {
  var digits = <int>{}, buffer = StringBuffer();
  for (var i = 0; i < 10; i++) {
    buffer.write('(');
    var j = i;
    while (!digits.contains(j)) {
      buffer.write(j);
      digits.add(j);
      j = permutation[j];
    }
    buffer.write(')');
  }
  final result =
      buffer.toString().replaceAll('()', '').replaceAll(RegExp(r'\(.\)'), '');
  return result == '' ? '()' : result;
}

List<int> product(List<int> p, List<int> q) {
  var result = List<int>.from(indices);
  for (var i = 0; i < 10; i++) {
    result[i] = p[q[i]];
  }
  return result;
}

String display(List<int> permutation) {
  String spread(List<int> list) => list.map((x) => x.toString()).join(' ');
  return spread(indices) + '\n' + spread(permutation);
}
