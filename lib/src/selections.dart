part of trotter;

/// A pseudo-list of selections (combinations with repetition).
///
/// A pseudo-list "containing" all the [r]-selections of objects taken from
/// the list [items].
///
/// _Example_
///
///     var s = new Selections(3, characters("abcd"));
///     print("There are ${s.length} 3-selections of the objects");
///     print("in ${s.items}.");
///     print("The first selection is ${c[0]}.");
///

class Selections extends _Combinatorics {
  Selections(int r, List items) {
    if (r < 0) throw new Exception("Cannot take $r items from ${items.length}.");
    if (!_itemsAreUnique(items)) throw new Exception("Items are not unique.");

    _items = new List.from(items);
    _r = r;
    _length = _nCr(items.length + r - 1, r);
  }

  int _r;

  /// The number of items taken from [items].
  int get r => _r;

  @override
  List operator [](int k) => _selection(_adjustedIndex(k, length), r, items);

  /// Returns the index of [selection] in the list of arranged selections.
  @override
  int indexOf(selection, [start = 0]) {
    if (contains(selection)) {
      int result = _inverseSelection(selection, _items);
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
  String toString() => "Pseudo-list containing all $length $r-selections of items from $items.";
}
