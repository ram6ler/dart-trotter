part of trotter;

abstract class _Combinatorics {
  List _items;
  int _length;

  /// The list from which the objects are selected
  List get items => new List.from(_items, growable: false);

  /// The number of arrangements "contained" in this pseudo-list.
  int get length => _length;

  /// The kth arrangement.
  List operator [](int k);

  /// Returns whether [x] is in the pseudo-list.
  bool contains(List x);

  /// Iterator support.
  get iterator => new List.generate(_length, (i) => this[i]).iterator;

/**
 * Returns a range of arrangements.
 *
 * The arrangements "stored" in this pseudo-list from index [from]
 * up to but not including [to].
 *
 */

  List range([int from = 0, int to = -1]) {
    if (to == -1) to = length;
    return new List.generate(to - from, (int i) => this[from + i]);
  }
}
