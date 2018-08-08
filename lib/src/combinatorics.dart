part of trotter;

/// The abstract parent to the other classes defined in this library.
abstract class Combinatorics {
  List _items;
  BigInt _length;

  /// The list from which the objects are selected
  List get items => List.from(_items, growable: false);

  Iterable _range(BigInt from, BigInt to) sync* {
    do {
      yield this[_adjustedIndex(from, length)];
      from += BigInt.one;
    } while (_adjustedIndex(from, length) != _adjustedIndex(to, length));
  }

  /// Returns a range of arrangements.
  ///
  /// The arrangements "stored" in this pseudo-list from index [from]
  /// up to but not including [to].
  ///
  Iterable<List> range(Object fromTo, [Object to]) {
    BigInt biFrom = _indexFromIntOrBigInt(fromTo), biTo;

    if (to == null) {
      biTo = biFrom;
      biFrom = BigInt.zero;
    } else {
      biTo = _indexFromIntOrBigInt(to);
    }

    if (biFrom == biTo) {
      return Iterable.empty();
    }

    return _range(biFrom, biTo);
  }

  Iterable<List> call([Object fromTo, Object to]) {
    BigInt biFrom, biTo;
    if (fromTo == null && to == null) {
      biFrom = BigInt.zero;
      biTo = length;
    } else {
      if (fromTo is int) {
        biFrom = BigInt.from(fromTo);
      } else if (fromTo is BigInt) {
        biFrom = fromTo;
      } else {
        throw Exception("Expecting int or BigInt in range.");
      }
      if (to == null) {
        biTo = biFrom;
        biFrom = BigInt.zero;
      } else {
        if (to is int) {
          biTo = BigInt.from(to);
        } else if (to is BigInt) {
          biTo = to;
        } else {
          throw Exception("Expecting int or BigInt in range.");
        }
      }
    }

    return _range(biFrom, biTo);
  }

  /// An [Iterable] object that "contains" all the arrangements.
  ///
  /// Example:
  ///
  ///     var permutations = Permutations(3, characters("abcd"));
  ///     for (var permutation in permutations.iterable) {
  ///       print(permutation);
  ///     }
  ///
  /// The [iterable] property can also be obtained by simply calling the
  /// combinatoric object. For example, the above code is equivalent to:
  ///
  ///     var permutations = Permutations(3, characters("abcd"));
  ///     for (var permutation in permutations()) {
  ///       print(permutation);
  ///     }
  ///
  Iterable get iterable => this();

  /// The number of arrangements "contained" in this pseudo-list.
  BigInt get length => _length;

  /// The [k]th arrangement.
  List operator [](Object k);
}
