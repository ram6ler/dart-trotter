part of trotter;

/// A pseudo-list of amalgams (permutations with repetition).
///
/// A pseudo-list "containing" all the [r]-amalgams of objects taken from
/// the list [items].
///
/// _Example_
///
///     var a = Amalgams(3, characters("abcd"));
///     print("There are ${a.length} 3-amalgams of the objects");
///     print("in ${a.items}.");
///     print("The first amalgam is ${a[0]}.");
///

class Amalgams extends _Combinatorics {
  Amalgams(int r, List items) {
    if (r < 0) throw Exception("Cannot take $r items from ${items.length}.");
    if (!_itemsAreUnique(items)) throw Exception("Items are not unique.");

    _items = List.from(items);
    _r = r;
    _length = BigInt.from(items.length).pow(r); //math.pow(items.length, r).toInt();
  }

  int _r;

  /// The number of items taken from [items].
  int get r => _r;

  @override
  List operator [](dynamic k) {
    BigInt biK = _indexFromIntOrBigInt(k);
    return _amalgam(_adjustedIndex(biK, length), r, items);
  }

  /// Returns the index of [amalgam] in the list of arranged amalgams.
  BigInt indexOf(List amalgam, [BigInt start]) {
    start = start ?? BigInt.zero;
    if (contains(amalgam)) {
      BigInt result = _inverseAmalgam(amalgam, _items);
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
  String toString() => "Pseudo-list containing all $length $r-amalgams of items from $items.";
}
