part of trotter;

/// A pseudo-list of Compositions (combinations with repetition).
///
/// A pseudo-list "containing" all the [r]-Compositions of objects taken from
/// the list [items].
///
/// _Example_
///
///     var s = Compositions(3, characters("abcd"));
///     print("There are ${s.length} 3-Compositions of the objects");
///     print("in ${s.items}.");
///     print("The first selection is ${c[0]}.");
///

class Compositions extends _Combinatorics {
  Compositions(int r, List items) {
    if (r < 0) throw Exception("Cannot take $r items from ${items.length}.");
    if (!_itemsAreUnique(items)) throw Exception("Items are not unique.");

    _items = List.from(items);
    _r = r;
    _length = _nCr(items.length + r - 1, r);
  }

  int _r;

  /// The number of items taken from [items].
  int get r => _r;

  @override
  List operator [](dynamic k) {
    BigInt biK = _indexFromIntOrBigInt(k);
    return _selection(_adjustedIndex(biK, length), r, items);
  }

  /// Returns the index of [selection] in the list of arranged Compositions.
  BigInt indexOf(List selection, [BigInt start]) {
    start = start ?? BigInt.zero;
    if (contains(selection)) {
      BigInt result = _inverseSelection(selection, _items);
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
  bool contains(Object x) => _itemsExistInUniversal(x, _items);

  @override
  String toString() => "Pseudo-list containing all $length $r-Compositions of items from $items.";
}
