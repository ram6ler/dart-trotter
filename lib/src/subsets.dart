import "combinatorics.dart" show Combinatorics;
import "helpers.dart"
    show
        itemsAreUnique,
        indexFromIntOrBigInt,
        subset,
        adjustedIndex,
        inverseSubset,
        itemsExistInUniversal;

/// A pseudolist of subsets.
///
/// A pseudo-list "containing" all the subsets of objects taken from
/// the list `elements`.
///
/// _Example_
///
///     final sub = Subsets(characters("abcd"));
///     print("There are ${sub.length} subsets of the objects");
///     print("in ${sub.items}.");
///     print("The first subset is ${sub[0]}.");
///

class Subsets<T> extends Combinatorics<T> {
  Subsets(List<T> items)
      : _items = List<T>.from(items, growable: false),
        _length = BigInt.one << items.length {
    if (!itemsAreUnique(items)) throw Exception("Items are not unique.");
  }

  final List<T> _items;
  @override
  List<T> get items => List<T>.from(_items, growable: false);

  final BigInt _length;
  @override
  BigInt get length => _length;

  @override
  List<T> operator [](Object k) {
    BigInt biK = indexFromIntOrBigInt(k);
    return subset(adjustedIndex(biK, length), items);
  }

  /// Returns the index of `subset` in the list of arranged subsets.
  @override
  BigInt indexOf(List<T> subset, [BigInt? start]) {
    start = start ?? BigInt.zero;
    if (contains(subset)) {
      BigInt result = inverseSubset(subset, _items);
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
      "Pseudo-list containing all $length subsets of items from $items.";
}
