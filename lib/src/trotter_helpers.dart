part of trotter;

/// Cache to store calculated factorials.
Map<int, BigInt> _factCache = {};

/// Calculates `n`!
BigInt _fact(int n) => _factCache.containsKey(n)
    ? _factCache[n]
    : (n < 2 ? BigInt.one : _factCache[n] = BigInt.from(n) * _fact(n - 1));

/// Calculates the number of permutations of `r` items taken from `n`.
BigInt _nPr(int n, int r) => _fact(n) ~/ _fact(n - r);

/// Calculates the number of combinations of `r` items taken from `n`.
BigInt _nCr(int n, int r) => _nPr(n, r) ~/ _fact(r);

/// Returns the items in `arrangement` in the same order as they appear in `items`.
List<T> _sortedArrangement<T>(List<T> arrangement, List<T> items) =>
    (List<T>.from(arrangement))
      ..sort((x, y) => items.indexOf(x).compareTo(items.indexOf(y)));

/// Checks whether the items in `items` are unique.
bool _itemsAreUnique<T>(List<T> items) => items.toSet().length == items.length;

/// Checks whether all items in `items` are in `universal`.
bool _itemsExistInUniversal<T>(List<T> items, List<T> universal) =>
    items.every((item) => universal.contains(item));

/// Gives `k`th permutation in the ordered list of permutations of
/// items taken from `items`.
List<T> _permutationWorker<T>(BigInt k, List<T> items) {
  int n = items.length;
  if (n <= 1) {
    return items;
  } else {
    BigInt biN = BigInt.from(n),
        group = k ~/ biN,
        mod = k % biN,
        position =
            group % BigInt.two == BigInt.zero ? biN - mod - BigInt.one : mod;

    return _permutationWorker<T>(group, items.sublist(0, n - 1))
      ..insert(position.toInt(), items[n - 1]);
  }
}

/// Gives the index of `permutation` in the ordered list of permutations of
/// items taken from `items`.
BigInt _inversePermutationWorker<T>(List<T> permutation, List<T> items) {
  if (permutation.length == 1) return BigInt.zero;
  int n = items.length;

  BigInt biN = BigInt.from(n),
      index = BigInt.from(permutation.indexOf(items.last)),
      group = _inversePermutationWorker<T>(
          permutation.where((x) => x != items.last).toList(),
          items.sublist(0, items.length - 1));
  return biN * group +
      (group % BigInt.two == BigInt.zero ? biN - index - BigInt.one : index);
}

/// Gives `k`th combination in the ordered list of combinations of
/// `r` items taken from `items`.
List<T> _combination<T>(BigInt k, int r, List<T> items) {
  if (r == 0) return [];
  int n = items.length, position = 0;
  BigInt d = _nCr(n - position - 1, r - 1);

  while (k >= d) {
    k -= d;
    position += 1;
    d = _nCr(n - position - 1, r - 1);
  }
  var tail = items.sublist(position.toInt() + 1);
  return [items[position.toInt()]]..addAll(_combination<T>(k, r - 1, tail));
}

/// Gives the index of `combination` in the ordered list of combinations of
/// items taken from `items`.
BigInt _inverseCombination<T>(List<T> combination, List<T> items) {
  BigInt helper<T>(List<T> combination, List<T> items) {
    if (combination.isEmpty) return BigInt.zero;
    int r = combination.length, n = items.length, itemIndex = 0;
    BigInt k = BigInt.zero;
    while (combination[0] != items[itemIndex.toInt()]) {
      k += _nCr(n - itemIndex - 1, r - 1);
      itemIndex += 1;
    }
    return k +
        _inverseCombination<T>(
            combination.sublist(1), items.sublist((itemIndex + 1).toInt()));
  }

  return helper<T>(_sortedArrangement<T>(combination, items), items);
}

/// Gives `k`th selection in the ordered list of selections of
/// `r` items taken from `items`.
List<T> _selection<T>(BigInt k, int r, List<T> items) {
  int n = items.length, position = 0;
  BigInt d = _nCr(n + r - position - 2, r - 1);
  while (k >= d) {
    k -= d;
    position += 1;
    d = _nCr(n + r - position - 2, r - 1);
  }
  if (r == 0) {
    return [];
  } else {
    var tail = items.sublist(position.toInt());
    return [items[position.toInt()]]..addAll(_selection<T>(k, r - 1, tail));
  }
}

/// Gives the index of `selection` in the ordered list of selections of
/// items taken from `items`.
BigInt _inverseSelection<T>(List<T> selection, List<T> items) {
  BigInt helper<T>(List<T> selection, List<T> items) {
    if (selection.isEmpty) {
      return BigInt.zero;
    }
    int n = items.length, r = selection.length, itemIndex = 0;
    BigInt k = BigInt.zero;
    while (selection[0] != items[itemIndex]) {
      k += _nCr(n + r - itemIndex - 2, r - 1);
      itemIndex += 1;
    }

    return k +
        _inverseSelection<T>(
            selection.sublist(1), items.sublist(itemIndex.toInt()));
  }

  return helper<T>(_sortedArrangement<T>(selection, items), items);
}

/// Gives `k`th permutation in the ordered list of permutations of
/// `r` items taken from `items`.
List<T> _permutation<T>(BigInt k, int r, List<T> items) {
  BigInt f = _fact(r), group = k ~/ f, item = k % f;
  List<T> comb = _combination<T>(group, r, items);
  return _permutationWorker<T>(item, comb);
}

/// Gives the index of `permutation` in the ordered list of permutations of
/// items taken from `items`.
BigInt _inversePermutation<T>(List<T> permutation, List<T> items) {
  int r = permutation.length;
  if (r == 0) return BigInt.zero;
  var sortedPermutation = _sortedArrangement<T>(permutation, items);
  BigInt group = _inverseCombination<T>(sortedPermutation, items);
  return group * _fact(r) +
      _inversePermutationWorker<T>(permutation, sortedPermutation);
}

/// Gives `k`th amalgam in the ordered list of amalgams of
/// `r` items taken from `items`.
List<T> _amalgam<T>(BigInt k, int r, List<T> items) {
  return List<T>.generate(r.toInt(), (i) {
    BigInt p = BigInt.from(items.length).pow(r - i - 1), index = k ~/ p;
    k %= p;
    return items[index.toInt()];
  });
}

/// Gives the index of `amalgam` in the ordered list of amalgams of
/// items taken from `items`.
BigInt _inverseAmalgam<T>(List<T> amalgam, List<T> items) {
  int r = amalgam.length;
  var n = BigInt.from(items.length);
  var powers = List<BigInt>.filled(r, BigInt.one, growable: false);
  for (int i = 1; i < powers.length; i++) {
    powers[i] = powers[i - 1] * n;
  }
  return List<BigInt>.generate(
      r,
      (position) =>
          BigInt.from(items.indexOf(amalgam[position])) *
          powers[r - position - 1]).fold<BigInt>(BigInt.zero, (a, b) => a + b);
}

/// Gives `k`th subset in the ordered list of subsets of
/// items taken from `items`.
List<T> _subset<T>(BigInt k, List<T> items) {
  k = _adjustedIndex(k, BigInt.one << items.length);
  List<T> r = [];
  for (int i = 0; i < items.length; i++) {
    if (k & (BigInt.one << i) != BigInt.zero) {
      r.add(items[i]);
    }
  }
  return r;
}

/// Gives the index of `subset` in the ordered list of subsets of
/// items taken from `items`.
BigInt _inverseSubset<T>(List<T> subset, List<T> items) {
  BigInt helper<T>(List<T> subset, List<T> items) {
    BigInt k = BigInt.zero, power = BigInt.one;
    for (int index = 0; index < items.length; index++) {
      if (subset.contains(items[index])) k += power;
      power *= BigInt.two;
    }
    return k;
  }

  return helper<T>(
      _sortedArrangement<T>(subset.toSet().toList(), items), items);
}

/// Gives `k`th compound in the ordered list of compounds of
/// items taken from `items`.
List<T> _compound<T>(BigInt k, List<T> items) {
  int n = items.length, r;
  for (r = 0; r < n; r++) {
    BigInt groupSize = _nPr(n, r);
    if (k >= groupSize) {
      k -= groupSize;
    } else {
      break;
    }
  }
  return _permutation<T>(k, r, items);
}

/// Gives the index of `compound` in the ordered list of compounds of
/// items taken from `items`.
BigInt _inverseCompound<T>(List<T> compound, List<T> items) {
  BigInt k =
      (List<BigInt>.generate(compound.length, (r) => _nPr(items.length, r)))
          .fold<BigInt>(BigInt.zero, (a, b) => a + b);
  k += _inversePermutation<T>(compound, items);
  return k;
}

/// Returns an index in the domain [0, n[.
BigInt _adjustedIndex(BigInt k, BigInt n) => k % n;

BigInt _indexFromIntOrBigInt(Object k) {
  BigInt biK;
  if (k is int) {
    biK = BigInt.from(k);
  } else if (k is BigInt) {
    biK = k;
  } else {
    throw Exception('Index must be an int or BigInt.');
  }
  return biK;
}
