part of trotter;

/// A pseudo-list of Compositions (combinations with repetition).
///
/// A pseudo-list 'containing' all the `r`-Compositions of objects taken from
/// the list `items`.
///
/// _Example_
///
///     final s = Compositions(3, characters('abcd'));
///     print('There are ${s.length} 3-Compositions of the objects');
///     print('in ${s.items}.');
///     print('The first selection is ${c[0]}.');
///

class Compositions<T> extends Combinatorics<T> {
  Compositions(this.r, List<T> items) {
    if (r < 0) throw Exception('Cannot take $r items from ${items.length}.');
    if (!_itemsAreUnique(items)) throw Exception('Items are not unique.');

    _items = List<T>.from(items);

    _length = _nCr(items.length + r - 1, r);
  }

  /// The number of items taken from `items`.
  final int r;

  @override
  List<T> operator [](Object k) {
    BigInt biK = _indexFromIntOrBigInt(k);
    return _composition(_adjustedIndex(biK, length), r, items);
  }

  /// Returns the index of `selection` in the list of arranged Compositions.
  @override
  BigInt indexOf(List<T> selection, [BigInt? start]) {
    start = start ?? BigInt.zero;
    if (contains(selection)) {
      BigInt result = _inverseComposition(selection, _items);
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
      'Pseudo-list containing all $length $r-Compositions of items from $items.';
}
