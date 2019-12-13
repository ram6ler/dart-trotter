part of trotter;

/// A pseudolist of subsets.
///
/// A pseudo-list 'containing' all the subsets of objects taken from
/// the list `elements`.
///
/// _Example_
///
///     var sub = Subsets(characters('abcd'));
///     print('There are ${sub.length} subsets of the objects');
///     print('in ${sub.items}.');
///     print('The first subset is ${sub[0]}.');
///

class Subsets extends Combinatorics {
  Subsets(List items) {
    if (!_itemsAreUnique(items)) throw Exception('Items are not unique.');

    _items = List.from(items);
    _length = BigInt.one << items.length;
  }

  @override
  List operator [](Object k) {
    BigInt biK = _indexFromIntOrBigInt(k);
    return _subset(_adjustedIndex(biK, length), items);
  }

  /// Returns the index of `subset` in the list of arranged subsets.
  BigInt indexOf(List subset, [BigInt start]) {
    start = start ?? BigInt.zero;
    if (contains(subset)) {
      BigInt result = _inverseSubset(subset, _items);
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
  bool contains(Object x) =>
      _itemsExistInUniversal(x, _items) && _itemsAreUnique(x);

  @override
  String toString() =>
      'Pseudo-list containing all $length subsets of items from $items.';
}
