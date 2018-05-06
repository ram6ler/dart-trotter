// Copyright (c) 2017, Richard Ambler. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// Classes for representing _structures_ commonly encountered in combinatorics.
///
/// The `trotter` library contains class definitions for [Permutations],
/// [Combinations], [Amalgams] (permutations with repetition), [Selections]
/// (combinations with repetition), [Subsets] and [Compounds] (permutations of
/// unspecified length) of objects taken from a list. These classes define objects
/// that are moderately analogous to lists containing all possible respective arrangements.
///

library trotter;

part 'src/trotter_helpers.dart';
part 'src/combinatorics.dart';
part 'src/permutations.dart';
part 'src/combinations.dart';
part 'src/amalgams.dart';
part 'src/compositions.dart';
part 'src/subsets.dart';
part 'src/compounds.dart';
part 'src/misc.dart';
