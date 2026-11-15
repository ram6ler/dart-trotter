import 'combinatorics.dart';

/// Convenience methods to create combinatorics instances from
/// lists of strings.
extension IterableExtensions<T> on Iterable<T> {
  /// The amalgams of length [take] taken from the items.
  Amalgams<T> toAmalgams({int? take}) =>
      Amalgams<T>(take: take ?? length, items: this);

  /// The combinations of length [take] taken from the items.
  Combinations<T> toCombinations({int? take}) =>
      Combinations<T>(take: take ?? length, items: this);

  /// The compositions of length [take] taken from the items.
  Compositions<T> toCompositions({int? take}) =>
      Compositions<T>(take: take ?? length, items: this);

  /// The compounds taken from the items.
  Compounds<T> toCompounds() => Compounds<T>(items: this);

  /// The permutations of length [take] taken from the items.
  Permutations<T> toPermutations({int? take}) =>
      Permutations<T>(take: take ?? length, items: this);

  /// The subsets taken from the items.
  Subsets<T> toSubsets() => Subsets<T>(items: this);
}

extension StringExtensions on String {
  /// The amalgams of length [take] of the characters in the string.
  Amalgams<String> toAmalgams({int? take}) {
    take = take ?? length;
    return Amalgams<String>(take: take, items: split(''));
  }

  /// The combinations of length [take] of the characters in the string.
  Combinations<String> toCombinations({int? take}) {
    take = take ?? length;
    return Combinations<String>(take: take, items: split(''));
  }

  /// The compositions of length [take] of the characters in the string.
  Compositions<String> toCompositions({int? take}) {
    take = take ?? length;
    return Compositions<String>(take: take, items: split(''));
  }

  /// The compounds of the characters in the string.
  Compounds<String> toCompounds() => Compounds<String>(items: split(''));

  /// The permutations of length [take] of the characters in the string.
  Permutations<String> toPermutations({int? take}) {
    take = take ?? length;
    return Permutations<String>(take: take, items: split(''));
  }

  /// The subsets of the characters in the string.
  Subsets<String> toSubsets() => Subsets<String>(items: split(''));
}
