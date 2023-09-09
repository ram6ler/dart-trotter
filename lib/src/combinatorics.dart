import "dart:math" show Random;
import "helpers.dart" show adjustedIndex, indexFromIntOrBigInt;

/// The base class for the other classes in this library.
abstract class Combinatorics<T> {
  //late final List<T> _items;
  //late final BigInt _length;

  /// The list from which the objects are selected
  List<T> get items; // => List<T>.from(_items, growable: false);

  /// The number of arrangements "contained" in this pseudo-list.
  BigInt get length => BigInt.zero;

  Iterable<List<T>> _range(BigInt from, BigInt to) sync* {
    do {
      yield this[adjustedIndex(from, length)];
      from += BigInt.one;
    } while (adjustedIndex(from, length) != adjustedIndex(to, length));
  }

  /// Returns a range of arrangements.
  ///
  /// The arrangements "stored" in this pseudo-list from index `from`
  /// up to but not including `to`.
  ///
  Iterable<List<T>> range(Object fromTo, [Object? to]) {
    BigInt biFrom = indexFromIntOrBigInt(fromTo), biTo;

    if (to == null) {
      biTo = biFrom;
      biFrom = BigInt.zero;
    } else {
      biTo = indexFromIntOrBigInt(to);
    }

    if (biFrom == biTo) {
      return Iterable.empty();
    }

    return _range(biFrom, biTo);
  }

  Iterable<List<T>> call([Object? fromTo, Object? to]) {
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

  /// An `Iterable` object that "contains" all the arrangements.
  ///
  /// Example:
  ///
  ///     final permutations = Permutations(3, characters("abcd"));
  ///     for (final permutation in permutations.iterable) {
  ///       print(permutation);
  ///     }
  ///
  /// The `iterable` property can also be obtained by simply calling the
  /// combinatoric object. For example, the above code is equivalent to:
  ///
  ///     final permutations = Permutations(3, characters("abcd"));
  ///     for (final permutation in permutations()) {
  ///       print(permutation);
  ///     }
  ///
  Iterable get iterable => this();

  /// Generates a random sample of arrangements from this pseudo-list.
  Iterable sample(int n, {int? seed, bool withReplacement = false}) {
    final length = this.length;
    BigInt indexGenerator() {
      final rand = seed == null ? Random() : Random(seed);
      var index = BigInt.zero, bits = length.bitLength + 1;
      for (var i = 0; i < bits; i++) {
        index += rand.nextBool() ? BigInt.one : BigInt.zero;
        if (i < bits - 1) {
          index <<= 1;
        }
        if (index > length - BigInt.one) {
          index = BigInt.zero;
          i = 0;
        }
      }
      return index;
    }

    if (withReplacement) {
      return List<BigInt>.generate(n, (_) => indexGenerator())
          .map((i) => this[i]);
    } else {
      if (BigInt.from(n) > length) {
        throw Exception("Cannot take more than $length without replacement.");
      }
      final indices = <BigInt>{};
      while (indices.length < n) {
        indices.add(indexGenerator());
      }
      return indices.map((i) => this[i]);
    }
  }

  /// The `k`th arrangement.
  List<T> operator [](Object k) {
    throw Error();
  }

  /// The index of  `arrangement`.
  BigInt indexOf(List<T> arrangement, [BigInt? start]);

  /// Whether the structure contains `arrangement`.
  bool contains(List<T> arrangement);
}
