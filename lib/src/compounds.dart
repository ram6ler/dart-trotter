import "combinatorics.dart" show Combinatorics;
import "helpers.dart"
    show
        nPr,
        itemsAreUnique,
        indexFromIntOrBigInt,
        compound,
        adjustedIndex,
        inverseCompound,
        itemsExistInUniversal;

/// A pseudo-list of compounds.
///
/// A pseudo-list "containing" all the compounds (permutations of
/// unspecified length) of objects taken from the list `elements`.
///
/// _Example_
///
///     final com = Compounds(letters("abcd"));
///     print("There are ${com.length} subsets of the objects");
///     print("in ${com.items}.");
///     print("The first subset is ${com[0]}.");
///

class Compounds<T> extends Combinatorics<T> {
  Compounds(List<T> items)
      : _items = List<T>.from(items, growable: false),
        _length = (List<BigInt>.generate(
                items.length + 1, (r) => nPr(items.length, r))
            .fold<BigInt>(BigInt.zero, (a, b) => a + b)) {
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
    return compound(adjustedIndex(biK, length), items);
  }

  /// Returns the index of `subset` in the list of arranged subsets.
  @override
  BigInt indexOf(List<T> compound, [BigInt? start]) {
    start = start ?? BigInt.zero;
    if (contains(compound)) {
      BigInt result = inverseCompound(compound, _items);
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
      "Pseudo-list containing all $length compounds of items from $items.";
}
