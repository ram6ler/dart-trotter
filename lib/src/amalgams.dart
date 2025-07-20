import 'combinatorics.dart' show Combinatorics;
import 'helpers.dart'
    show
        itemsAreUnique,
        indexFromIntOrBigInt,
        amalgam,
        adjustedIndex,
        inverseAmalgam,
        itemsExistInUniversal;

/// A pseudo-list of amalgams (permutations with repetition).
///
/// A pseudo-list "containing" all the `r`-amalgams (order important,
/// repetition allowed) of objects taken from the list `items`.
///
class Amalgams<T> extends Combinatorics<T> {
  Amalgams(this.r, List<T> items)
      : _items = List<T>.from(items, growable: false),
        _length = BigInt.from(items.length).pow(r) {
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
    return amalgam(adjustedIndex(bK, length), r, items);
  }

  /// Returns the index of `amalgam` in the list of arranged amalgams.
  @override
  BigInt indexOf(List<T> amalgam, [BigInt? start]) {
    start = start ?? BigInt.zero;
    if (contains(amalgam)) {
      BigInt result = inverseAmalgam(amalgam, _items);
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
      'Pseudo-list containing all $length $r-amalgams of items from $items.';
}
