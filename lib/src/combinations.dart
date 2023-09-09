import "combinatorics.dart" show Combinatorics;
import "helpers.dart"
    show
        nCr,
        itemsAreUnique,
        indexFromIntOrBigInt,
        combination,
        adjustedIndex,
        inverseCombination,
        itemsExistInUniversal;

/// A pseudo-list of combinations.
///
/// A pseudo-list "containing" all the `r`-combinations of objects taken from
/// the list `items`.
///
/// _Example_
///
///     final c = Combinations(3, characters("abcd"));
///     print("There are ${c.length} 3-combinations of the objects");
///     print("in ${c.items}.");
///     print("The first combination is ${c[0]}.");
///

class Combinations<T> extends Combinatorics<T> {
  Combinations(this.r, List<T> items)
      : _items = List<T>.from(items, growable: false),
        _length = nCr(items.length, r) {
    if (r < 0 || r > items.length) {
      throw Exception("Cannot take $r items from ${items.length}.");
    }
    if (!itemsAreUnique(items)) throw Exception("Items are not unique.");
  }

  /// The number of items taken from `items`.
  final int r;

  final List<T> _items;
  @override
  List<T> get items => List<T>.from(_items, growable: false);

  final BigInt _length;
  @override
  BigInt get length => _length;

  @override
  List<T> operator [](Object k) {
    BigInt biK = indexFromIntOrBigInt(k);
    return combination(adjustedIndex(biK, length), r, items);
  }

  /// Returns the index of `combination` in the list of
  /// arranged combinations.
  @override
  BigInt indexOf(List<T> combination, [BigInt? start]) {
    start = start ?? BigInt.zero;
    if (contains(combination)) {
      BigInt result = inverseCombination(combination, _items);
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
  bool contains(List<T> x) =>
      itemsExistInUniversal(x, _items) && itemsAreUnique(x);

  @override
  String toString() =>
      "Pseudo-list containing all $length $r-combinations of items from $items.";
}
