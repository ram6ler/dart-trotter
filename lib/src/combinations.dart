part of trotter;

/// A pseudo-list of combinations.
/// 
/// A pseudo-list "containing" all the [r]-combinations of objects taken from
/// the list [items].
/// 
/// _Example_
/// 
///     var c = new Combinations(3, characters("abcd"));
///     print("There are ${c.length} 3-combinations of the objects");
///     print("in ${c.items}.");
///     print("The first combination is ${c[0]}.");
/// 

class Combinations extends _Combinatorics {
  Combinations(int r, List items) {
    if (r < 0 || r > items.length)
      throw new Exception("Cannot take $r items from ${items.length}.");
    if (!_itemsAreUnique(items)) throw new Exception("Items are not unique.");

    _items = new List.from(items, growable: false);
    _r = r;
    _length = _nCr(items.length, r);
  }

  int _r;

  /// The number of items taken from [items].
  int get r => _r;

  @override List operator [](int k) =>
      _combination(_adjustedIndex(k, length), r, items);

  /// Returns the index of [combination] in the list of arranged combinations.
  int indexOf(List combination) =>
      contains(combination) ? _inverseCombination(combination, _items) : -1;

  /// returns whether [x] is in the pseudo-list.
  @override
  bool contains(Object x) =>
      _itemsExistInUniversal(x, _items) && _itemsAreUnique(x);

  @override String toString() =>
      "Pseudo-list containing all $length $r-combinations of items from $items.";


  
}
