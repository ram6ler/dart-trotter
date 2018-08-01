part of trotter;

/// A pseudolist of compounds.
///
/// A pseudo-list "containing" all the compounds (permutations of
/// unspecified length) of objects taken from the list `elements`.
///
/// _Example_
///
///     var com = Compounds(letters("abcd"));
///     print("There are ${com.length} subsets of the objects");
///     print("in ${com.items}.");
///     print("The first subset is ${com[0]}.");
///

class Compounds extends _Combinatorics {
  Compounds(List items) {
    if (!_itemsAreUnique(items)) throw Exception("Items are not unique.");

    _items = List.from(items);
    _length = (List.generate(items.length + 1, (r) => _nPr(items.length, r))
        .fold(BigInt.zero, (a, b) => a + b));
  }

  @override
  List operator [](dynamic k) {
    BigInt biK = _indexFromIntOrBigInt(k);
    return _compound(_adjustedIndex(biK, length), items);
  }

  /// Returns the index of [subset] in the list of arranged subsets.
  BigInt indexOf(List compound, [BigInt start]) {
    start = start ?? BigInt.zero;
    if (contains(compound)) {
      BigInt result = _inverseCompound(compound, _items);
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
      "Pseudo-list containing all $length compounds of items from $items.";
}
