part of trotter;

/// A pseudo-list of permutations.
///
/// A pseudo-list "containing" all the [r]-permutations of objects taken from
/// the list [items].
///
/// _Example_
///
///     var p = Permutations(3, characters("abcd"));
///     print("There are ${p.length} 3-permutations of the objects");
///     print("in ${p.items}.");
///     print("The first permutation is ${p[0]}.");
///

class Permutations extends _Combinatorics {
  Permutations(int r, List items) {
    if (r < 0 || r > items.length) {
      throw Exception("Cannot take $r items from ${items.length}.");
    }
    if (!_itemsAreUnique(items)) {
      throw Exception("Items are not unique.");
    }

    _items = List.from(items, growable: false);
    _r = r;
    _length = _nPr(items.length, r);
  }

  int _r;

  /// The number of items taken from [items].
  int get r => _r;

  @override
  List operator [](dynamic k) {
    BigInt biK = _indexFromIntOrBigInt(k);
    return _permutation(_adjustedIndex(biK, length), r, items);
  }

  /// Returns the index of [permutation] in the list of arranged permutations.
  BigInt indexOf(List permutation, [BigInt start]) {
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

  /// returns whether [x] is in the pseudo-list.
  bool contains(Object x) =>
      _itemsExistInUniversal(x, _items) && _itemsAreUnique(x);

  @override
  String toString() =>
      "Pseudo-list containing all $length $r-permutations of items from $items.";
}
