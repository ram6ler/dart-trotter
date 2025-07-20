/// Cache to store calculated factorials.
final Map<int, BigInt> factCache = {};

/// Calculates `n`!
BigInt factorial(int n) => factCache.containsKey(n)
    ? factCache[n]!
    : (n < 2 ? BigInt.one : factCache[n] = BigInt.from(n) * factorial(n - 1));

/// Calculates the number of permutations of `r` items taken from `n`.
BigInt nPr(int n, int r) => factorial(n) ~/ factorial(n - r);

/// Calculates the number of combinations of `r` items taken from `n`.
BigInt nCr(int n, int r) => nPr(n, r) ~/ factorial(r);

/// Returns the items in `arrangement` in the same order as they
/// appear in `items`.
List<T> sortedArrangement<T>(List<T> arrangement, List<T> items) =>
    (List<T>.from(arrangement))
      ..sort((x, y) => items.indexOf(x).compareTo(items.indexOf(y)));

/// Checks whether the items in `items` are unique.
bool itemsAreUnique<T>(List<T> items) => items.toSet().length == items.length;

/// Checks whether all items in `items` are in `universal`.
bool itemsExistInUniversal<T>(List<T> items, List<T> universal) =>
    items.every((item) => universal.contains(item));

/// Gives `k`th permutation in the ordered list of permutations of
/// items taken from `items`.
List<T> permutationWorker<T>(BigInt k, List<T> items) {
  int n = items.length;
  if (n <= 1) {
    return items;
  } else {
    BigInt bN = BigInt.from(n),
        group = k ~/ bN,
        mod = k % bN,
        position =
            group % BigInt.two == BigInt.zero ? bN - mod - BigInt.one : mod;

    return permutationWorker<T>(group, items.sublist(0, n - 1))
      ..insert(position.toInt(), items[n - 1]);
  }
}

/// Gives the index of `permutation` in the ordered list of permutations of
/// items taken from `items`.
BigInt inversePermutationWorker<T>(List<T> permutation, List<T> items) {
  if (permutation.length == 1) {
    return BigInt.zero;
  }
  int n = items.length;

  BigInt bN = BigInt.from(n),
      index = BigInt.from(permutation.indexOf(items.last)),
      group = inversePermutationWorker<T>(
          permutation.where((x) => x != items.last).toList(),
          items.sublist(0, items.length - 1));
  return bN * group +
      (group % BigInt.two == BigInt.zero ? bN - index - BigInt.one : index);
}

/// Gives `k`th combination in the ordered list of combinations of
/// `r` items taken from `items`.
List<T> combination<T>(BigInt k, int r, List<T> items) {
  if (r == 0) {
    return [];
  }
  int n = items.length, position = 0;
  BigInt d = nCr(n - position - 1, r - 1);

  while (k >= d) {
    k -= d;
    position += 1;
    d = nCr(n - position - 1, r - 1);
  }
  final tail = items.sublist(position + 1);
  return [items[position], ...combination<T>(k, r - 1, tail)];
}

/// Gives the index of `combination` in the ordered list of combinations of
/// items taken from `items`.
BigInt inverseCombination<T>(List<T> combination, List<T> items) {
  BigInt helper(List<T> combination, List<T> items) {
    if (combination.isEmpty) {
      return BigInt.zero;
    }
    int r = combination.length, n = items.length, itemIndex = 0;
    BigInt k = BigInt.zero;
    while (combination[0] != items[itemIndex]) {
      k += nCr(n - itemIndex - 1, r - 1);
      itemIndex += 1;
    }
    return k + helper(combination.sublist(1), items.sublist(itemIndex + 1));
  }

  return helper(sortedArrangement<T>(combination, items), items);
}

/// Gives `k`th composition in the ordered list of compositions of
/// `r` items taken from `items`.
List<T> composition<T>(BigInt k, int r, List<T> items) {
  int n = items.length, position = 0;
  BigInt d = nCr(n + r - position - 2, r - 1);
  while (k >= d) {
    k -= d;
    position += 1;
    d = nCr(n + r - position - 2, r - 1);
  }
  if (r == 0) {
    return [];
  } else {
    final tail = items.sublist(position);
    return [items[position], ...composition<T>(k, r - 1, tail)];
  }
}

/// Gives the index of `composition` in the ordered list of compositions of
/// items taken from `items`.
BigInt inverseComposition<T>(List<T> composition, List<T> items) {
  BigInt helper(List<T> composition, List<T> items) {
    if (composition.isEmpty) {
      return BigInt.zero;
    }
    int n = items.length, r = composition.length, itemIndex = 0;
    BigInt k = BigInt.zero;
    while (composition[0] != items[itemIndex]) {
      k += nCr(n + r - itemIndex - 2, r - 1);
      itemIndex += 1;
    }

    return k + helper(composition.sublist(1), items.sublist(itemIndex));
  }

  return helper(sortedArrangement<T>(composition, items), items);
}

/// Gives `k`th permutation in the ordered list of permutations of
/// `r` items taken from `items`.
List<T> permutation<T>(BigInt k, int r, List<T> items) {
  BigInt f = factorial(r), group = k ~/ f, item = k % f;
  List<T> comb = combination<T>(group, r, items);
  return permutationWorker<T>(item, comb);
}

/// Gives the index of `permutation` in the ordered list of permutations of
/// items taken from `items`.
BigInt inversePermutation<T>(List<T> permutation, List<T> items) {
  int r = permutation.length;
  if (r == 0) {
    return BigInt.zero;
  }
  final sortedPermutation = sortedArrangement<T>(permutation, items);
  BigInt group = inverseCombination<T>(sortedPermutation, items);
  return group * factorial(r) +
      inversePermutationWorker<T>(permutation, sortedPermutation);
}

/// Gives `k`th amalgam in the ordered list of amalgams of
/// `r` items taken from `items`.
List<T> amalgam<T>(BigInt k, int r, List<T> items) {
  T item(int i) {
    BigInt p = BigInt.from(items.length).pow(r - i - 1), index = k ~/ p;
    k %= p;
    return items[index.toInt()];
  }

  return [for (var i = 0; i < r; i++) item(i)];
}

/// Gives the index of `amalgam` in the ordered list of amalgams of
/// items taken from `items`.
BigInt inverseAmalgam<T>(List<T> amalgam, List<T> items) {
  int r = amalgam.length;
  final n = BigInt.from(items.length),
      powers = [for (final _ in Iterable.generate(r)) BigInt.one];

  for (int i = 1; i < powers.length; i++) {
    powers[i] = powers[i - 1] * n;
  }

  return [
    for (var position = 0; position < r; position++)
      BigInt.from(items.indexOf(amalgam[position])) * powers[r - position - 1]
  ].fold(BigInt.zero, (a, b) => a + b);
}

/// Gives `k`th subset in the ordered list of subsets of items taken from `items`.
List<T> subset<T>(BigInt k, List<T> items) {
  k = adjustedIndex(k, BigInt.one << items.length);
  return [
    for (var i = 0; i < items.length; i++)
      if (k & (BigInt.one << i) != BigInt.zero) items[i]
  ];
}

/// Gives the index of `subset` in the ordered list of subsets of
/// items taken from `items`.
BigInt inverseSubset<T>(List<T> subset, List<T> items) {
  BigInt helper(List<T> subset, List<T> items) {
    BigInt k = BigInt.zero, power = BigInt.one;
    for (int index = 0; index < items.length; index++) {
      if (subset.contains(items[index])) {
        k += power;
      }
      power *= BigInt.two;
    }
    return k;
  }

  return helper(sortedArrangement<T>(subset.toSet().toList(), items), items);
}

/// Gives `k`th compound in the ordered list of compounds of
/// items taken from `items`.
List<T> compound<T>(BigInt k, List<T> items) {
  int n = items.length, r;
  for (r = 0; r < n; r++) {
    BigInt groupSize = nPr(n, r);
    if (k >= groupSize) {
      k -= groupSize;
    } else {
      break;
    }
  }
  return permutation<T>(k, r, items);
}

/// Gives the index of `compound` in the ordered list of compounds of
/// items taken from `items`.
BigInt inverseCompound<T>(List<T> compound, List<T> items) =>
    [for (var r = 0; r < compound.length; r++) nPr(items.length, r)]
        .fold(BigInt.zero, (a, b) => a + b) +
    inversePermutation(compound, items);

/// Returns an index in the domain [0, n[.
BigInt adjustedIndex(BigInt k, BigInt n) => k % n;

/// Ensures an index is of type BigInt.
BigInt indexFromIntOrBigInt(Object k) => switch (k) {
      int k => BigInt.from(k),
      BigInt k => k,
      _ => throw Exception('Index must be an int or BigInt.')
    };

/// Splits string [x] into its characters.
List<String> characters(String x) => x.split('');

/// Creates a string from the items in [x].
///
/// The optional argument [process] generates a string from each element.
///
String string<T>(List<T> x, {String Function(T)? process}) =>
    [for (final t in x) process == null ? t.toString() : process(t)].join(' ');
