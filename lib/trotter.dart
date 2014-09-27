/**
 * Classes for representing _structures_ commonly encountered in combinatorics.
 * 
 * The `trotter` library contains class definitions for [Permutations], 
 * [Combinations], [Amalgams] (permutations with repetition), [Selections]
 * (combinations with repetition) and [Subsets] of objects taken 
 * from a list. These classes define instances that are moderately analagous 
 * to lists containing all possible respective arrangements.
 *
 */

library trotter;
import "dart:math" as Math;
part 'src/trotter_helpers.dart';
part 'src/combinatorics.dart';
part 'src/permutations.dart';
part 'src/combinations.dart';
part 'src/amalgams.dart';
part 'src/selections.dart';
part 'src/subsets.dart';