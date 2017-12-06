part of trotter;

abstract class _Combinatorics extends ListBase<List<dynamic>> {
  List _items;
  int _length;

  /// The list from which the objects are selected
  List get items => new List.from(_items, growable: false);

  /// Returns a range of arrangements.
  ///
  /// The arrangements "stored" in this pseudo-list from index [from]
  /// up to but not including [to].
  ///
  List range([int from = 0, int to = -1]) {
    if (to == -1) to = length;
    return new List.generate(to - from, (int i) => this[from + i]);
  }

  /// The number of arrangements "contained" in this pseudo-list.
  @override
  int get length => _length;

  /// Cannot set length...
  @override
  void set length(int length) {
    throw ("Length of structure determined at creation.");
  }

  /// The [k]th arrangement.
  List operator [](int k);

  /// Cannot set an element...
  /// @override
  void operator []=(int i, List<dynamic> list) {
    throw ("Items determined at creation.");
  }
}
