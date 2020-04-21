part of trotter;

/// A pseudo-list of combinations.
///
/// A pseudo-list 'containing' all the `r`-combinations of objects taken from
/// the list `items`.
///
/// _Example_
///
///     var c = Combinations(3, characters('abcd'));
///     print('There are ${c.length} 3-combinations of the objects');
///     print('in ${c.items}.');
///     print('The first combination is ${c[0]}.');
///

class Combinations<T> extends Combinatorics<T> {
  Combinations(int r, List<T> items) {
    if (r < 0 || r > items.length) {
      throw Exception('Cannot take $r items from ${items.length}.');
    }
    if (!_itemsAreUnique(items)) throw Exception('Items are not unique.');

    _items = List<T>.from(items, growable: false);
    _r = r;
    _length = _nCr(items.length, r);
  }

  int _r;

  /// The number of items taken from `items`.
  int get r => _r;

  @override
  List<T> operator [](Object k) {
    BigInt biK = _indexFromIntOrBigInt(k);
    return _combination(_adjustedIndex(biK, length), r, items);
  }

  /// Returns the index of `combination` in the list of
  /// arranged combinations.
  @override
  BigInt indexOf(List<T> combination, [BigInt start]) {
    start = start ?? BigInt.zero;
    if (contains(combination)) {
      BigInt result = _inverseCombination(combination, _items);
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
  bool contains(Object x) =>
      _itemsExistInUniversal(x, _items) && _itemsAreUnique(x);

  @override
  String toString() =>
      'Pseudo-list containing all $length $r-combinations of items from $items.';
}
