import 'combinatorics.dart' show Combinatorics;
import 'helpers.dart'
    show
        nCr,
        itemsAreUnique,
        indexFromIntOrBigInt,
        composition,
        adjustedIndex,
        inverseComposition,
        itemsExistInUniversal;

/// A pseudo-list of Compositions (combinations with repetition).
///
/// A pseudo-list "containing" all the `r`-Compositions of objects taken from
/// the list `items`.
///
class Compositions<T> extends Combinatorics<T> {
  Compositions(this.r, List<T> items)
      : _items = List<T>.from(items, growable: false),
        _length = nCr(items.length + r - 1, r) {
    if (r < 0) throw Exception('Cannot take $r items from ${items.length}.');
    if (!itemsAreUnique(items)) throw Exception('Items are not unique.');
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
    BigInt bK = indexFromIntOrBigInt(k);
    return composition(adjustedIndex(bK, length), r, items);
  }

  /// Returns the index of `selection` in the list of arranged Compositions.
  @override
  BigInt indexOf(List<T> selection, [BigInt? start]) {
    start = start ?? BigInt.zero;
    if (contains(selection)) {
      BigInt result = inverseComposition(selection, _items);
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
  bool contains(List<T> x) => itemsExistInUniversal(x, _items);

  @override
  String toString() =>
      'Pseudo-list containing all $length $r-Compositions of items from $items.';
}
