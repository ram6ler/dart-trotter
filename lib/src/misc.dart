part of trotter;

/// Splits string [x] into its characters.
List characters(String x) => x.split('');

/// Creates a string from the characters in [x].
String string(List x) => x.join('');

/// Convenience methods to create combinatorics instances.
extension TrotterListCandy on List {
  Amalgams amalgams([int take]) {
    take = take ?? this.length;
    return Amalgams(take, this);
  }

  Combinations combinations([int take]) {
    take = take ?? this.length;
    return Combinations(take, this);
  }

  Compositions compositions([int take]) {
    take = take ?? this.length;
    return Compositions(take, this);
  }

  Compounds compounds() => Compounds(this);

  Permutations permutations([int take]) {
    take = take ?? this.length;
    return Permutations(take, this);
  }

  Subsets subsets() => Subsets(this);
}

extension TrotterStringCandy on String {
  Amalgams amalgams([int take]) {
    take = take ?? this.length;
    return Amalgams(take, characters(this));
  }

  Combinations combinations([int take]) {
    take = take ?? this.length;
    return Combinations(take, characters(this));
  }

  Compositions compositions([int take]) {
    take = take ?? this.length;
    return Compositions(take, characters(this));
  }

  Compounds compounds() => Compounds(characters(this));

  Permutations permutations([int take]) {
    take = take ?? this.length;
    return Permutations(take, characters(this));
  }

  Subsets subsets() => Subsets(characters(this));
}
