part of trotter;

/// A pseudo-list of amalgams (permutations with repetition).
///
/// A pseudo-list "containing" all the [r]-amalgams of objects taken from
/// the list [items].
///
/// _Example_
///
///     var a = new Amalgams(3, characters("abcd"));
///     print("There are ${a.length} 3-amalgams of the objects");
///     print("in ${a.items}.");
///     print("The first amalgam is ${a[0]}.");
///

class Amalgams extends _Combinatorics {
  Amalgams(int r, List items) {
    if (r < 0) throw new Exception("Cannot take $r items from ${items.length}.");
    if (!_itemsAreUnique(items)) throw new Exception("Items are not unique.");

    _items = new List.from(items);
    _r = r;
    _length = math.pow(items.length, r).toInt();
  }

  int _r;

  /// The number of items taken from [items].
  int get r => _r;

  @override
  List operator [](int k) => _amalgam(_adjustedIndex(k, length), r, items);

  /// Returns the index of [amalgam] in the list of arranged amalgams.
  @override
  int indexOf(amalgam, [start = 0]) {
    if (contains(amalgam)) {
      int result = _inverseAmalgam(amalgam, _items);
      if (result >= start) {
        return result;
      } else {
        return -1;
      }
    } else {
      return -1;
    }
  }

  /// returns whether [x] is in the pseudo-list.
  @override
  bool contains(Object x) => _itemsExistInUniversal(x, _items);

  @override
  String toString() => "Pseudo-list containing all $length $r-amalgams of items from $items.";
}
