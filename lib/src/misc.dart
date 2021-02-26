part of trotter;

/// Splits string [x] into its characters.
List<String> characters(String x) => x.split('');

/// Creates a string from the characters in [x].
String string(List<String> x) => x.join('');

/// Convenience methods to create combinatorics instances from
/// lists of strings.
extension TrotterListStringCandy on List<String> {
  Amalgams<String> amalgams([int? take]) {
    take = take ?? this.length;
    return Amalgams<String>(take, this);
  }

  Combinations<String> combinations([int? take]) {
    take = take ?? this.length;
    return Combinations<String>(take, this);
  }

  Compositions<String> compositions([int? take]) {
    take = take ?? this.length;
    return Compositions<String>(take, this);
  }

  Compounds<String> compounds() => Compounds<String>(this);

  Permutations<String> permutations([int? take]) {
    take = take ?? this.length;
    return Permutations<String>(take, this);
  }

  Subsets<String> subsets() => Subsets<String>(this);
}

/// Convenience methods to create combinatorics instances from
/// lists of nums.
extension TrotterListNumCandy on List<num> {
  Amalgams<num> amalgams([int? take]) {
    take = take ?? this.length;
    return Amalgams<num>(take, this);
  }

  Combinations<num> combinations([int? take]) {
    take = take ?? this.length;
    return Combinations<num>(take, this);
  }

  Compositions<num> compositions([int? take]) {
    take = take ?? this.length;
    return Compositions<num>(take, this);
  }

  Compounds<num> compounds() => Compounds<num>(this);

  Permutations<num> permutations([int? take]) {
    take = take ?? this.length;
    return Permutations<num>(take, this);
  }

  Subsets<num> subsets() => Subsets<num>(this);
}

extension TrotterStringCandy on String {
  Amalgams<String> amalgams([int? take]) {
    take = take ?? this.length;
    return Amalgams<String>(take, characters(this));
  }

  Combinations<String> combinations([int? take]) {
    take = take ?? this.length;
    return Combinations<String>(take, characters(this));
  }

  Compositions<String> compositions([int? take]) {
    take = take ?? this.length;
    return Compositions<String>(take, characters(this));
  }

  Compounds<String> compounds() => Compounds<String>(characters(this));

  Permutations<String> permutations([int? take]) {
    take = take ?? this.length;
    return Permutations<String>(take, characters(this));
  }

  Subsets<String> subsets() => Subsets<String>(characters(this));
}
