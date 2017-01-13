part of trotter;

/// A pseudolist of compounds.
/// 
/// A pseudo-list "containing" all the compounds (permutations of 
/// unspecified length) of objects taken from the list `elements`.
/// 
/// _Example_
/// 
///     var com = new Compounds(letters("abcd"));
///     print("There are ${com.length} subsets of the objects");
///     print("in ${com.items}.");
///     print("The first subset is ${com[0]}.");
/// 

class Compounds extends _Combinatorics {
  Compounds(List items) {
    if (!_itemsAreUnique(items)) throw new Exception("Items are not unique.");

    _items = new List.from(items);
    _length = (new List.generate(
      items.length + 1,
      (r) => _nPr(items.length, r)
    ).fold(0, (a, b) => a + b));
  }

  @override List operator [](int k) =>
      _compound(_adjustedIndex(k, length), items);

  /// Returns the index of [subset] in the list of arranged subsets.
  int indexOf(List compound) =>
      contains(compound) ? _inverseCompound(compound, _items) : -1;

  /// returns whether [x] is in the pseudo-list.
  @override
  bool contains(Object x) =>
      _itemsExistInUniversal(x, _items) && _itemsAreUnique(x);

  @override String toString() =>
      "Pseudo-list containing all $length compounds of items from $items.";
}
