part of trotter;

/** A pseudo-list of amalgams (permutations with repetition).
 *
 * A pseudo-list "containing" all the [r]-amalgams of objects taken from
 * the list [items].
 * 
 * _Example_
 *
 * ```
 * var a = new Amalgams(3, "abcd".split(""));
 * print("There are ${a.length} 3-amalgams of the objects");
 * print("in ${a.elements}.");
 * print("The first amalgam is ${a[0]}.");
 * ```
 * 
 */

class Amalgams extends _Combinatorics {
  int _r;

  /// The number of items taken from [items].
  int get r => _r;

  Amalgams(int r, List items) {
    if (r < 0)
      throw new Exception("Cannot take $r items from ${items.length}.");
    if (!_itemsAreUnique(items)) throw new Exception("Items are not unique.");

    _items = new List.from(items);
    _r = r;
    _length = Math.pow(items.length, r).toInt();
  }

  @override List operator [](int k) =>
      _amalgam(_adjustedIndex(k, length), r, items);

  /// Returns the index of [amalgam] in the list of arranged amalgams.
  int indexOf(amalgam) => 
  contains(amalgam) ? _inverseAmalgam(amalgam, _items): -1;

  /// returns whether [x] is in the pseudo-list.
  bool contains(List x) => _itemsExistInUniversal(x, _items);

  @override String toString() =>
      "Pseudo-list containing all $length $r-amalgams of items from $items.";
}
