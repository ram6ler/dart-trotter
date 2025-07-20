import 'amalgams.dart' show Amalgams;
import 'combinations.dart' show Combinations;
import 'compositions.dart' show Compositions;
import 'compounds.dart' show Compounds;
import 'permutations.dart' show Permutations;
import 'subsets.dart' show Subsets;
import 'helpers.dart' show characters;

/// Convenience methods to create combinatorics instances from
/// lists of strings.
extension ListExtensions<T> on List<T> {
  /// The amalgams of length `take` taken from the items.
  Amalgams<T> amalgams([int? take]) => Amalgams<T>(take ?? length, this);

  /// The combinations of length `take` taken from the items.
  Combinations<T> combinations([int? take]) =>
      Combinations<T>(take ?? length, this);

  /// The compositions of length `take` taken from the items.
  Compositions<T> compositions([int? take]) =>
      Compositions<T>(take ?? length, this);

  /// The compounds taken from the items.
  Compounds<T> compounds() => Compounds<T>(this);

  /// The permutations of length `take` taken from the items.
  Permutations<T> permutations([int? take]) =>
      Permutations<T>(take ?? length, this);

  /// The subsets taken from the items.
  Subsets<T> subsets() => Subsets<T>(this);
}

extension StringExtensions on String {
  /// The amalgams of length `take` of the characters in the string.
  Amalgams<String> amalgams([int? take]) {
    take = take ?? length;
    return Amalgams<String>(take, characters(this));
  }

  /// The combinations of length `take` of the characters in the string.
  Combinations<String> combinations([int? take]) {
    take = take ?? length;
    return Combinations<String>(take, characters(this));
  }

  /// The compositions of length `take` of the characters in the string.
  Compositions<String> compositions([int? take]) {
    take = take ?? length;
    return Compositions<String>(take, characters(this));
  }

  /// The compounds of the characters in the string.
  Compounds<String> compounds() => Compounds<String>(characters(this));

  /// The permutations of length `take` of the characters in the string.
  Permutations<String> permutations([int? take]) {
    take = take ?? length;
    return Permutations<String>(take, characters(this));
  }

  /// The subsets of the characters in the string.
  Subsets<String> subsets() => Subsets<String>(characters(this));
}
