import 'dart:math' show Random;

import 'exception.dart';
import 'helper.dart';

sealed class Combinatorics<T> {
  /// The list of elements available.
  List<T> get elements;

  /// The number of arrangements "contained".
  BigInt get length => BigInt.zero;

  Iterable<List<T>> _range(BigInt from, BigInt to) sync* {
    do {
      yield this[adjustIndex(from, length)];
      from += BigInt.one;
    } while (adjustIndex(from, length) != adjustIndex(to, length));
  }

  Iterable<List<T>> call([Object? fromTo, Object? to]) {
    BigInt bFrom, bTo;
    if (fromTo == null && to == null) {
      bFrom = BigInt.zero;
      bTo = length;
    } else {
      if (fromTo is int) {
        bFrom = BigInt.from(fromTo);
      } else if (fromTo is BigInt) {
        bFrom = fromTo;
      } else {
        throw TrotterException('Expecting int or BigInt in range.');
      }
      if (to == null) {
        bTo = bFrom;
        bFrom = BigInt.zero;
      } else {
        if (to is int) {
          bTo = BigInt.from(to);
        } else if (to is BigInt) {
          bTo = to;
        } else {
          throw TrotterException('Expecting int or BigInt in range.');
        }
      }
    }

    return _range(bFrom, bTo);
  }

  /// Draws a random sample of arrangements.
  Iterable<List<T>> drawSample(
    int n, {
    int? seed,
    bool withReplacement = false,
  }) {
    final rand = Random(seed);
    BigInt indexGenerator() {
      var index = BigInt.zero, bits = length.bitLength + 1, i = 0;
      while (i < bits) {
        index += rand.nextBool() ? BigInt.one : BigInt.zero;
        if (i < bits - 1) {
          index <<= 1;
        }
        if (index > length - BigInt.one) {
          index = BigInt.zero;
          i = 0;
        } else {
          i++;
        }
      }
      return index;
    }

    if (withReplacement) {
      return List<BigInt>.generate(
        n,
        (_) => indexGenerator(),
      ).map((i) => this[i]);
    } else {
      if (BigInt.from(n) > length) {
        throw TrotterException(
          'Cannot draw more than $length arrangements '
          'without replacement; tried to draw $n.',
        );
      }
      final indices = <BigInt>{};
      while (indices.length < n) {
        indices.add(indexGenerator());
      }
      return indices.map((i) => this[i]);
    }
  }

  /// The [k]th arrangement.
  List<T> operator [](Object k);

  /// The index of [arrangement].
  BigInt indexOf(Iterable<T> arrangement, [BigInt? start]);

  /// Whether the structure contains [arrangement].
  bool contains(Iterable<T> arrangement);
}

/// A pseudo-list of compounds (permutations of unspecified length).
class Compounds<T> extends Combinatorics<T> {
  Compounds({required Iterable<T> items})
    : elements = List<T>.from(items, growable: false),
      length = (List<BigInt>.generate(
        items.length + 1,
        (r) => nPr(items.length, r),
      ).fold(BigInt.zero, (a, b) => a + b)) {
    if (!itemsAreUnique(elements)) {
      throw TrotterException('Items are not unique.');
    }
  }

  @override
  final List<T> elements;

  @override
  final BigInt length;

  @override
  List<T> operator [](Object k) {
    BigInt bK = makeBigInt(k);
    return findCompound(adjustIndex(bK, length), elements);
  }

  @override
  BigInt indexOf(Iterable<T> compound, [BigInt? start]) {
    final needle = compound.toList();
    start = start ?? BigInt.zero;
    if (contains(needle)) {
      BigInt result = findInverseCompound(needle, elements);
      if (result >= start) {
        return result;
      } else {
        return BigInt.from(-1);
      }
    } else {
      return BigInt.from(-1);
    }
  }

  @override
  bool contains(Iterable<T> x) {
    final arrangement = x.toList();
    return itemsExistInUniversal(arrangement, elements) &&
        itemsAreUnique(arrangement);
  }

  @override
  String toString() =>
      'Pseudo-list containing all ${addCommas(length)} '
      'compounds of items from $elements.';
}

/// A pseudo-list of subsets (combinations of unspecified length).
class Subsets<T> extends Combinatorics<T> {
  Subsets({required Iterable<T> items})
    : elements = List<T>.from(items, growable: false),
      length = BigInt.one << items.length {
    if (!itemsAreUnique(elements)) {
      throw TrotterException('Items are not unique.');
    }
  }

  @override
  final List<T> elements;

  @override
  final BigInt length;

  @override
  List<T> operator [](Object k) {
    BigInt bK = makeBigInt(k);
    return findSubset(adjustIndex(bK, length), elements);
  }

  @override
  BigInt indexOf(Iterable<T> subset, [BigInt? start]) {
    final needle = subset.toList();
    start = start ?? BigInt.zero;
    if (contains(needle)) {
      BigInt result = findInverseSubset(needle, elements);
      if (result >= start) {
        return result;
      } else {
        return BigInt.from(-1);
      }
    } else {
      return BigInt.from(-1);
    }
  }

  @override
  bool contains(Iterable<T> x) {
    final arrangement = x.toList();
    return itemsExistInUniversal(arrangement, elements) &&
        itemsAreUnique(arrangement);
  }

  @override
  String toString() =>
      'Pseudo-list containing all ${addCommas(length)} '
      'subsets of items from $elements.';
}

mixin Take {
  /// The number of elements to take at a time.
  int get take;
}

/// A pseudo-list of amalgams (permutations with repetition).
class Amalgams<T> extends Combinatorics<T> with Take {
  Amalgams({required this.take, required Iterable<T> items})
    : elements = List<T>.from(items, growable: false),
      length = switch (take) {
        >= 0 => BigInt.from(items.length).pow(take),
        _ => throw TrotterException(
          'Cannot take a negative number of elements.',
        ),
      } {
    if (take < 0 || (take != 0 && elements.isEmpty)) {
      throw TrotterException(
        'Cannot take $take items '
        'from ${elements.length}.',
      );
    }
    if (!itemsAreUnique(elements)) {
      throw TrotterException('Items are not unique.');
    }
  }

  @override
  final List<T> elements;

  @override
  final BigInt length;

  @override
  final int take;

  @override
  List<T> operator [](Object k) {
    BigInt bK = makeBigInt(k);
    return findAmalgam(adjustIndex(bK, length), take, elements);
  }

  @override
  BigInt indexOf(Iterable<T> amalgam, [BigInt? start]) {
    final needle = amalgam.toList();
    start = start ?? BigInt.zero;
    if (contains(needle)) {
      BigInt result = findInverseAmalgam(needle, elements);
      if (result >= start) {
        return result;
      } else {
        return BigInt.from(-1);
      }
    } else {
      return BigInt.from(-1);
    }
  }

  @override
  bool contains(Iterable<T> x) {
    final arrangement = x.toList();
    return arrangement.length == take &&
        itemsExistInUniversal(arrangement, elements);
  }

  @override
  String toString() =>
      'Pseudo-list containing all ${addCommas(length)} '
      '$take-amalgams of items from $elements.';
}

/// A pseudo-list of combinations.
class Combinations<T> extends Combinatorics<T> with Take {
  Combinations({required this.take, required Iterable<T> items})
    : elements = List<T>.from(items, growable: false),
      length = switch (take) {
        >= 0 => nCr(items.length, take),
        _ => throw TrotterException(
          'Cannot take a negative number of elements.',
        ),
      } {
    if (take < 0 || take > elements.length) {
      throw TrotterException(
        'Cannot take $take items '
        'from ${elements.length}.',
      );
    }
    if (!itemsAreUnique(elements)) {
      throw TrotterException('Items are not unique.');
    }
  }

  @override
  final int take;

  @override
  final List<T> elements;

  @override
  final BigInt length;

  @override
  List<T> operator [](Object k) {
    BigInt bK = makeBigInt(k);
    return findCombination(adjustIndex(bK, length), take, elements);
  }

  @override
  BigInt indexOf(Iterable<T> combination, [BigInt? start]) {
    final needle = combination.toList();
    start = start ?? BigInt.zero;
    if (contains(needle)) {
      BigInt result = findInverseCombination(needle, elements);
      if (result >= start) {
        return result;
      } else {
        return BigInt.from(-1);
      }
    } else {
      return BigInt.from(-1);
    }
  }

  @override
  bool contains(Iterable<T> x) {
    final arrangement = x.toList();
    return arrangement.length == take &&
        itemsExistInUniversal(arrangement, elements) &&
        itemsAreUnique(arrangement);
  }

  @override
  String toString() =>
      'Pseudo-list containing all ${addCommas(length)} '
      '$take-combinations of items from $elements.';
}

/// A pseudo-list of compositions (combinations with repetition).
class Compositions<T> extends Combinatorics<T> with Take {
  Compositions({required this.take, required Iterable<T> items})
    : elements = List<T>.from(items, growable: false),
      length = switch (take) {
        == 0 => BigInt.one,
        > 0 => nCr(items.length + take - 1, take),
        _ => throw TrotterException(
          'Cannot take a negative number of elements.',
        ),
      } {
    if (take < 0 || (take != 0 && elements.isEmpty)) {
      throw TrotterException(
        'Cannot take $take items '
        'from ${elements.length}.',
      );
    }
    if (!itemsAreUnique(elements)) {
      throw TrotterException('Items are not unique.');
    }
  }

  @override
  final List<T> elements;

  @override
  final BigInt length;

  @override
  final int take;

  @override
  List<T> operator [](Object k) {
    BigInt bK = makeBigInt(k);
    return findComposition(adjustIndex(bK, length), take, elements);
  }

  @override
  BigInt indexOf(Iterable<T> selection, [BigInt? start]) {
    final needle = selection.toList();
    start = start ?? BigInt.zero;
    if (contains(needle)) {
      BigInt result = findInverseComposition(needle, elements);
      if (result >= start) {
        return result;
      } else {
        return BigInt.from(-1);
      }
    } else {
      return BigInt.from(-1);
    }
  }

  @override
  bool contains(Iterable<T> x) {
    final arrangement = x.toList();
    return arrangement.length == take &&
        itemsExistInUniversal(arrangement, elements);
  }

  @override
  String toString() =>
      'Pseudo-list containing all ${addCommas(length)} '
      '$take-Compositions of items from $elements.';
}

/// A pseudo-list of permutations.
class Permutations<T> extends Combinatorics<T> with Take {
  Permutations({required this.take, required Iterable<T> items})
    : elements = List<T>.from(items, growable: false),
      length = switch (take) {
        >= 0 => nPr(items.length, take),
        _ => throw TrotterException(
          'Cannot take a negative number of elements.',
        ),
      } {
    if (take < 0 || take > elements.length) {
      throw TrotterException(
        'Cannot take $take items '
        'from ${elements.length}.',
      );
    }
    if (!itemsAreUnique(elements)) {
      throw TrotterException('Items are not unique.');
    }
  }

  @override
  final List<T> elements;

  @override
  final BigInt length;

  @override
  final int take;

  @override
  List<T> operator [](Object k) {
    BigInt bK = makeBigInt(k);
    return findPermutation(adjustIndex(bK, length), take, elements);
  }

  @override
  BigInt indexOf(Iterable<T> permutation, [BigInt? start]) {
    final needle = permutation.toList();
    start = start ?? BigInt.zero;
    if (contains(needle)) {
      BigInt result = findInversePermutation(needle, elements);
      if (result >= start) {
        return result;
      } else {
        return BigInt.from(-1);
      }
    } else {
      return BigInt.from(-1);
    }
  }

  @override
  bool contains(Iterable<T> x) {
    final arrangement = x.toList();
    return arrangement.length == take &&
        itemsExistInUniversal(arrangement, elements) &&
        itemsAreUnique(arrangement);
  }

  @override
  String toString() =>
      'Pseudo-list containing all ${addCommas(length)} '
      '$take-permutations of items from $elements.';
}
