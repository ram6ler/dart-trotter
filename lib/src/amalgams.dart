part of trotter;

/// A pseudo-list of amalgams (permutations with repetition).
///
/// A pseudo-list 'containing' all the `r`-amalgams (order important,
/// repetition allowed) of objects taken from the list `items`.
///
/// *Example*
///
///     final a = Amalgams(3, characters('abcd'));
///     print('There are ${a.length} 3-amalgams of the objects');
///     print('in ${a.items}.');
///     print('The first amalgam is ${a[0]}.');
///

class Amalgams<T> extends Combinatorics<T> {
  Amalgams(this.r, List<T> items) {
    if (r < 0) throw Exception('Cannot take $r items from ${items.length}.');
    if (!_itemsAreUnique(items)) throw Exception('Items are not unique.');
    _items = List<T>.from(items);
    _length = BigInt.from(items.length).pow(r);
  }

  /// The number of items taken from `items`.
  final int r;

  @override
  List<T> operator [](Object k) {
    BigInt biK = _indexFromIntOrBigInt(k);
    return _amalgam(_adjustedIndex(biK, length), r, items);
  }

  /// Returns the index of `amalgam` in the list of arranged amalgams.
  @override
  BigInt indexOf(List<T> amalgam, [BigInt? start]) {
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

  /// Returns whether `x` is in the pseudo-list.
  @override
  bool contains(List<T> x) => _itemsExistInUniversal(x, _items);

  @override
  String toString() =>
      'Pseudo-list containing all $length $r-amalgams of items from $items.';
}
