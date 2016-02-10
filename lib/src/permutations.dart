part of trotter;

/** A pseudo-list of permutations.
 *
 * A pseudo-list "containing" all the [r]-permutations of objects taken from
 * the list [items].
 *
 * _Example_
 *
 * ```
 * var p = new Permutations(3, characters("abcd"));
 * print("There are ${p.length} 3-permutations of the objects");
 * print("in ${p.items}.");
 * print("The first permutation is ${p[0]}.");
 * ```
 * 
 */

class Permutations extends _Combinatorics {
  int _r;

  /// The number of items taken from [items].
  int get r => _r;

  Permutations(int r, List items) {
    if (r < 0 || r > items.length)
      throw new Exception("Cannot take $r items from ${items.length}.");
    if (!_itemsAreUnique(items)) throw new Exception("Items are not unique.");

    _items = new List.from(items, growable: false);
    _r = r;
    _length = _nPr(items.length, r);
  }

  @override List operator [](int k) =>
      _permutation(_adjustedIndex(k, length), r, items);

  /// Returns the index of [permutation] in the list of arranged permutations.
  int indexOf(List permutation) =>
      contains(permutation) ? _inversePermutation(permutation, _items) : -1;

  /// returns whether [x] is in the pseudo-list.
  bool contains(List x) =>
      _itemsExistInUniversal(x, _items) && _itemsAreUnique(x);

  @override String toString() =>
      "Pseudo-list containing all $length $r-permutations of items from $items.";
}
