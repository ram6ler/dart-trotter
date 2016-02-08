part of trotter;

Map<int, int> _factCache = {};

int _fact(int n) =>
    _factCache.containsKey(n) ? _factCache[n] : (n < 2 ? 1 : _factCache[n] = n * _fact(n - 1));

int _nPr(int n, int r) => _fact(n) ~/ _fact(n - r);

// TODO: a more efficient counter? Recursive for large n? Keep _factCache smaller?
int _nCr(int n, int r) => _nPr(n, r) ~/ _fact(r);

List _sortedArrangement(List arrangement, List items) => (new List.from(arrangement))
    ..sort((x, y) => items.indexOf(x).compareTo(items.indexOf(y)));

bool _itemsUnique(List items) => items.toSet().length == items.length;

/// Returns kth permutation of items in `perm0`.
List _permutationWorker(int k, List items) {
  int n = items.length;
  if (n <= 1)
    return items;
  else {
    int group = k ~/ n, mod = k % n, position = group % 2 == 0 ? n - mod - 1 : mod;
    return _permutationWorker(group, items.sublist(0, n - 1))..insert(position, items[n - 1]);
  }
}

/// Returns the index of `perm` in the permutations of items in `perm0`.
int _inversePermutationWorker(List perm, List items) {
  if (perm.length == 1) return 0;

  int n = items.length,
      index = perm.indexOf(items.last),
      group = _inversePermutationWorker(
          perm.where((x) => x != items.last).toList(), items.sublist(0, items.length - 1));

  return n * group + (group % 2 == 0 ? n - index - 1 : index);
}

List _combination(int k, int r, List items) {
  int n = items.length, position = 0, d = _nCr(n - position - 1, r - 1);

  while (k >= d) {
    k -= d;
    ++position;
    d = _nCr(n - position - 1, r - 1);
  }

  // TODO: move to beginning?
  if (r == 0)
    return [];
  else {
    List tail = items.sublist(position + 1);
    return [items[position]]..addAll(_combination(k, r - 1, tail));
  }
}

int _inverseCombination(List combination, List items) {
  int helper(List combination, List items) {
    if (combination.isEmpty) return 0;
    int k = 0, r = combination.length, n = items.length, itemIndex = 0;
    while (combination[0] != items[itemIndex]) {
      k += _nCr(n - itemIndex - 1, r - 1);
      itemIndex++;
    }
    return k + _inverseCombination(combination.sublist(1), items.sublist(itemIndex + 1));
  }

  return helper(_sortedArrangement(combination, items), items);
}

List _selection(int k, int r, List items) {
  int n = items.length, position = 0, d = _nCr(n + r - position - 2, r - 1);

  while (k >= d) {
    k -= d;
    ++position;
    d = _nCr(n + r - position - 2, r - 1);
  }

  if (r == 0)
    return [];
  else {
    List tail = items.sublist(position);
    return [items[position]]..addAll(_selection(k, r - 1, tail));
  }
}

int _inverseSelection(List selection, List items) {
  int helper(List selection, List items) {
    if (selection.isEmpty) return 0;

    int k = 0,
        n = items.length,
        r = selection.length,
        itemIndex = 0;

    while (selection[0] != items[itemIndex]) {
      k += _nCr(n + r - itemIndex - 2, r - 1);
      itemIndex++;
    }

    return k + _inverseSelection(selection.sublist(1), items.sublist(itemIndex));
  }

  return helper(_sortedArrangement(selection, items), items);
}

List _permutation(int k, int r, List elements) {
  int f = _fact(r), group = k ~/ f, item = k % f;
  List comb = _combination(group, r, elements);
  return _permutationWorker(item, comb);
}

int _inversePermutation(List permutation, List items) {
  int r = permutation.length;
  List sortedPermutation = _sortedArrangement(permutation, items);
  int group = _inverseCombination(sortedPermutation, items);
  return group * _fact(r) + _inversePermutationWorker(permutation, sortedPermutation);
}

List _amalgam(int k, int r, List elements) => new List.generate(r, (int i) {
      int p = Math.pow(elements.length, r - i - 1).toInt(), index = k ~/ p;

      k %= p;
      return elements[index];
    });

int _inverseAmalgam(List amalgam, List items) {
  int
      k = 0,
      r = amalgam.length,
      n = items.length;

  var powers = new List.filled(n, 1, growable: false);
  for (int i = 1; i < powers.length; i++) powers[i] = powers[i - 1] * n;

  return new List.generate(
      r,
      (position) => items.indexOf(amalgam[position]) * powers[r - position - 1]
  ).fold(0, (a, b) => a + b);
}

List _subset(int k, List elements) {
  k = _adjustedIndex(k, 1 << elements.length);
  List r = [];
  for (int i = 0; i < elements.length; i++) if (k & (1 << i) != 0) r.add(elements[i]);
  return r;
}

int _inverseSubset(List subset, List items) {
  int helper(List subset, List items) {
    int k = 0, power = 1;
    for (int index = 0; index < items.length; index++) {
      if (subset.contains(items[index])) k += power;
      power *= 2;
    }
    return k;
  }
  return helper(_sortedArrangement(subset.toSet().toList(), items), items);
}

int _adjustedIndex(int k, int n) {
  // TODO: simply return k %= n?
  while (k < 0) k += n;
  k %= n;
  return k;
}
