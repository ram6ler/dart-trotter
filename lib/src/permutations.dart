import "combinatorics.dart" show Combinatorics;
import "helpers.dart"
    show
        nPr,
        itemsAreUnique,
        indexFromIntOrBigInt,
        permutation,
        adjustedIndex,
        inversePermutation,
        itemsExistInUniversal;

/// A pseudo-list of permutations.
///
/// A pseudo-list "containing" all the `r`-permutations of objects taken from
/// the list `items`.
///
/// _Example_
///
///     final p = Permutations(3, characters("abcd"));
///     print("There are ${p.length} 3-permutations of the objects");
///     print("in ${p.items}.");
///     print("The first permutation is ${p[0]}.");
///

class Permutations<T> extends Combinatorics<T> {
  Permutations(this.r, List<T> items)
      : _items = List<T>.from(items, growable: false),
        _length = nPr(items.length, r) {
    if (r < 0 || r > items.length) {
      throw Exception("Cannot take $r items from ${items.length}.");
    }
    if (!itemsAreUnique(items)) {
      throw Exception("Items are not unique.");
    }
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
    return permutation(adjustedIndex(biK, length), r, items);
  }

  /// Returns the index of `permutation` in the list of arranged permutations.
  @override
  BigInt indexOf(List<T> permutation, [BigInt? start]) {
    start = start ?? BigInt.zero;
    if (contains(permutation)) {
      BigInt result = inversePermutation(permutation, _items);
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
      "Pseudo-list containing all $length $r-permutations of items from $items.";
}
