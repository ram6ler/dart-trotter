part of trotter;

/// A pseudo-list of permutations.
///
/// A pseudo-list 'containing' all the `r`-permutations of objects taken from
/// the list `items`.
///
/// _Example_
///
///     final p = Permutations(3, characters('abcd'));
///     print('There are ${p.length} 3-permutations of the objects');
///     print('in ${p.items}.');
///     print('The first permutation is ${p[0]}.');
///

class Permutations<T> extends Combinatorics<T> {
  Permutations(this.r, List<T> items) {
    if (r < 0 || r > items.length) {
      throw Exception('Cannot take $r items from ${items.length}.');
    }
    if (!_itemsAreUnique(items)) {
      throw Exception('Items are not unique.');
    }

    _items = List<T>.from(items, growable: false);
    _length = _nPr(items.length, r);
  }

  /// The number of items taken from `items`.
  final int r;

  @override
  List<T> operator [](Object k) {
    BigInt biK = _indexFromIntOrBigInt(k);
    return _permutation(_adjustedIndex(biK, length), r, items);
  }

  /// Returns the index of `permutation` in the list of arranged permutations.
  @override
  BigInt indexOf(List<T> permutation, [BigInt? start]) {
    start = start ?? BigInt.zero;
    if (contains(permutation)) {
      BigInt result = _inversePermutation(permutation, _items);
      if (result >= start) {
        return result;
      } else {
        return BigInt.from(-1);
      }
    } else {
      return BigInt.from(-1);
    }
  }

  /// Returns whether `x` is in the pseudo-list.
  @override
  bool contains(List<T> x) =>
      _itemsExistInUniversal(x, _items) && _itemsAreUnique(x);

  @override
  String toString() =>
      'Pseudo-list containing all $length $r-permutations of items from $items.';
}
