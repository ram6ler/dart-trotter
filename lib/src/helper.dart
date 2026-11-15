import 'exception.dart';

/// Cache to store calculated factorials.
final Map<int, BigInt> factCache = {};

/// Calculates [n]! iteratively with cache optimization.
BigInt factorial(int n) {
  if (n < 0) {
    throw TrotterException('Factorial of a negative number encountered.');
  }
  if (factCache.containsKey(n)) return factCache[n]!;

  // Find the highest cached factorial to start from, avoiding redundant work
  int start = 1;
  BigInt result = BigInt.one;
  for (int i = n; i >= 1; i--) {
    if (factCache.containsKey(i)) {
      start = i + 1;
      result = factCache[i]!;
      break;
    }
  }

  for (int i = start; i <= n; i++) {
    result *= BigInt.from(i);
  }

  return factCache[n] = result;
}

/// Calculates the number of permutations of [r] items taken from [n].
/// Optimized to O(r) without computing massive factorials.
BigInt nPr(int n, int r) {
  if (r < 0 || r > n) return BigInt.zero;
  if (r == 0) return BigInt.one;

  BigInt result = BigInt.one;
  for (int i = 0; i < r; i++) {
    result *= BigInt.from(n - i);
  }
  return result;
}

/// Calculates the number of combinations of [r] items taken from [n].
/// Optimized to O(r) using multiplicative formula and symmetry.
BigInt nCr(int n, int r) {
  if (r < 0 || r > n) return BigInt.zero;
  if (r == 0 || r == n) return BigInt.one;

  // Use symmetry to minimize loop iterations: C(n, r) == C(n, n-r)
  r = r < (n - r) ? r : (n - r);

  BigInt result = BigInt.one;
  for (int i = 0; i < r; i++) {
    // Multiply by (n - i), then divide by (i + 1)
    // This is guaranteed to be an integer at every step.
    result = result * BigInt.from(n - i) ~/ BigInt.from(i + 1);
  }
  return result;
}

/// Returns the items in [arrangement] in the same order as they appear in [items].
List<T> orderArrangement<T>(List<T> arrangement, List<T> items) =>
    (List<T>.from(arrangement))
      ..sort((x, y) => items.indexOf(x).compareTo(items.indexOf(y)));

/// Checks whether the items in [items] are unique.
bool itemsAreUnique<T>(List<T> items) => items.toSet().length == items.length;

/// Checks whether all items in [items] are in [universal].
bool itemsExistInUniversal<T>(List<T> items, List<T> universal) =>
    items.every((item) => universal.contains(item));

/// Gives [k]th permutation in the ordered list of permutations of items taken from [items].
/// Converted from recursive to iterative to prevent stack overflow on large [n].
List<T> permutationWorker<T>(BigInt k, List<T> items) {
  int n = items.length;
  if (n <= 1) return List.from(items);

  // Pre-calculate the insertion positions from top-down
  List<int> positions = [];
  BigInt curr = k;
  for (int i = n; i > 1; i--) {
    BigInt bI = BigInt.from(i);
    BigInt mod = curr % bI;
    BigInt group = curr ~/ bI;
    int pos = (group % BigInt.two == BigInt.zero)
        ? i - mod.toInt() - 1
        : mod.toInt();
    positions.add(pos);
    curr = group;
  }

  // Build the permutation bottom-up
  List<T> result = [items[0]];
  for (int i = 0; i < positions.length; i++) {
    int pos = positions[positions.length - 1 - i];
    result.insert(pos, items[i + 1]);
  }
  return result;
}

/// Gives the index of [permutation] in the ordered list of permutations.
/// Converted to iterative to avoid deep recursion and sublist allocations.
BigInt inversePermutationWorker<T>(List<T> permutation, List<T> items) {
  int n = items.length;
  if (n <= 1) return BigInt.zero;

  List<int> indices = [];
  List<T> currentPerm = List.from(permutation);
  List<T> currentItems = List.from(items);

  // Collect indices top-down
  for (int i = n; i >= 1; i--) {
    int index = currentPerm.indexOf(currentItems[i - 1]);
    indices.add(index);
    currentPerm.removeAt(index);
    currentItems.removeLast();
  }

  // Compute the final index bottom-up
  BigInt k = BigInt.zero;
  for (int i = 1; i <= n; i++) {
    int index = indices[n - i]; // Reversed access
    BigInt bI = BigInt.from(i);
    BigInt offset = (k % BigInt.two == BigInt.zero)
        ? bI - BigInt.from(index) - BigInt.one
        : BigInt.from(index);
    k = bI * k + offset;
  }

  return k;
}

/// Gives [k]th combination in the ordered list of combinations.
///
/// Time complexity: O(r log n)
///
List<T> findCombination<T>(BigInt k, int r, List<T> items) {
  final result = <T>[], n = items.length;

  int currentR = r;
  BigInt currentK = k;
  int absolutePosition = 0;

  while (currentR > 0) {
    int remainingN = n - absolutePosition;

    // Binary search for the correct position
    // We want the largest pos where cumulative skipped <= currentK
    // Cumulative skipped for position p = nCr(remainingN, currentR) - nCr(remainingN - p, currentR)
    int low = 0;
    int high = remainingN - currentR;
    int bestPos = 0;

    while (low <= high) {
      int mid = low + (high - low) ~/ 2;

      // Calculate cumulative combinations skipped if we choose position mid
      BigInt skipped =
          nCr(remainingN, currentR) - nCr(remainingN - mid, currentR);

      if (skipped <= currentK) {
        bestPos = mid;
        low = mid + 1; // Try to find a larger position
      } else {
        high = mid - 1; // skipped is too large, need smaller position
      }
    }

    // Add the selected item
    absolutePosition += bestPos;
    result.add(items[absolutePosition]);
    absolutePosition += 1; // Move past the selected item

    // Subtract the skipped combinations
    if (bestPos > 0) {
      BigInt skipped =
          nCr(remainingN, currentR) - nCr(remainingN - bestPos, currentR);
      currentK -= skipped;
    }

    currentR -= 1;
  }
  return result;
}

/// Gives the index of [combination] in the ordered list of combinations.
/// Optimized to O(r) time complexity using combinatorial identities.
BigInt findInverseCombination<T>(List<T> combination, List<T> items) {
  final ordered = orderArrangement<T>(combination, items);
  BigInt k = BigInt.zero;
  int currentItemIndex = 0;
  int currentR = ordered.length;
  int currentN = items.length;

  for (int i = 0; i < ordered.length; i++) {
    T target = ordered[i];

    // Find the target directly (O(n) worst case, but typically fast,
    // or O(1) if you use a Map for item indices in your class setup)
    int targetIndex = items.indexOf(target);
    int gap = targetIndex - currentItemIndex;

    if (gap > 0) {
      // Add skipped combinations in O(1) using the identity:
      // Sum of nCr(currentN - j - 1, currentR - 1) for j=0 to gap-1
      // equals nCr(currentN, currentR) - nCr(currentN - gap, currentR)
      BigInt skipped = nCr(currentN, currentR) - nCr(currentN - gap, currentR);
      k += skipped;
    }

    currentItemIndex = targetIndex + 1;
    currentN = items.length - currentItemIndex;
    currentR -= 1;
  }
  return k;
}

/// Gives [k]th composition in the ordered list of compositions.
/// Optimized with Binary Search to guarantee O(r log n) time complexity.
List<T> findComposition<T>(BigInt k, int r, List<T> items) {
  List<T> result = [];
  int absolutePosition = 0;
  int currentR = r;
  BigInt currentK = k;
  int currentN = items.length;

  while (currentR > 0) {
    int low = 0;
    int high = currentN - 1;
    int bestPos = 0;

    while (low <= high) {
      int mid = low + (high - low) ~/ 2;

      // Cumulative skipped using the multiset hockey-stick identity:
      // Total compositions of currentR from currentN MINUS
      // compositions of currentR from the remaining (currentN - mid) items.
      BigInt skipped =
          nCr(currentN + currentR - 1, currentR) -
          nCr((currentN - mid) + currentR - 1, currentR);

      if (skipped <= currentK) {
        bestPos = mid;
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }

    absolutePosition += bestPos;
    result.add(items[absolutePosition]);

    if (bestPos > 0) {
      BigInt skipped =
          nCr(currentN + currentR - 1, currentR) -
          nCr((currentN - bestPos) + currentR - 1, currentR);
      currentK -= skipped;
    }

    // For compositions, the item can be reused, so the pool only shrinks by bestPos
    currentN = items.length - absolutePosition;
    currentR -= 1;
  }
  return result;
}

/// Gives the index of [composition] in the ordered list of compositions.
/// Converted from tail-recursive to iterative.
BigInt findInverseComposition<T>(List<T> composition, List<T> items) {
  final ordered = orderArrangement<T>(composition, items);
  BigInt k = BigInt.zero;
  int absoluteItemIndex = 0;
  int currentR = ordered.length;
  int currentN = items.length;

  for (int i = 0; i < ordered.length; i++) {
    T target = ordered[i];
    int localIndex = 0;
    while (items[absoluteItemIndex + localIndex] != target) {
      k += nCr(currentN + currentR - localIndex - 2, currentR - 1);
      localIndex += 1;
    }
    absoluteItemIndex += localIndex;
    currentN = items.length - absoluteItemIndex;
    currentR -= 1;
  }
  return k;
}

/// Gives [k]th permutation in the ordered list of permutations of [r] items.
/// (Relies on the now-iterative findCombination and permutationWorker)
List<T> findPermutation<T>(BigInt k, int r, List<T> items) {
  BigInt f = factorial(r), group = k ~/ f, item = k % f;
  List<T> comb = findCombination<T>(group, r, items);
  return permutationWorker<T>(item, comb);
}

/// Gives the index of [permutation] in the ordered list of permutations of [r] items.
/// (Relies on the now-iterative findInverseCombination and inversePermutationWorker)
BigInt findInversePermutation<T>(List<T> permutation, List<T> items) {
  int r = permutation.length;
  if (r == 0) return BigInt.zero;

  final sortedPermutation = orderArrangement<T>(permutation, items);
  BigInt group = findInverseCombination<T>(sortedPermutation, items);
  return group * factorial(r) +
      inversePermutationWorker<T>(permutation, sortedPermutation);
}

/// Gives [k]th amalgam in the ordered list of amalgams of
/// [r] items taken from [items].
///
List<T> findAmalgam<T>(BigInt k, int r, List<T> items) {
  T item(int i) {
    BigInt p = BigInt.from(items.length).pow(r - i - 1), index = k ~/ p;
    k %= p;
    return items[index.toInt()];
  }

  return [for (var i = 0; i < r; i++) item(i)];
}

/// Gives the index of [amalgam] in the ordered list of amalgams of
/// items taken from [items].
///
BigInt findInverseAmalgam<T>(List<T> amalgam, List<T> items) {
  int r = amalgam.length;
  final n = BigInt.from(items.length),
      powers = [for (final _ in Iterable.generate(r)) BigInt.one];

  for (int i = 1; i < powers.length; i++) {
    powers[i] = powers[i - 1] * n;
  }

  return [
    for (var position = 0; position < r; position++)
      BigInt.from(items.indexOf(amalgam[position])) * powers[r - position - 1],
  ].fold(BigInt.zero, (a, b) => a + b);
}

/// Gives [k]th subset in the ordered list of subsets of [items].
List<T> findSubset<T>(BigInt k, List<T> items) {
  k = adjustIndex(k, BigInt.one << items.length);
  return [
    for (var i = 0; i < items.length; i++)
      if (k & (BigInt.one << i) != BigInt.zero) items[i],
  ];
}

/// Gives the index of [subset] in the ordered list of subsets of [items].
BigInt findInverseSubset<T>(List<T> subset, List<T> items) {
  BigInt helper(List<T> subset, List<T> items) {
    BigInt k = BigInt.zero, power = BigInt.one;
    for (int index = 0; index < items.length; index++) {
      if (subset.contains(items[index])) {
        k += power;
      }
      power *= BigInt.two;
    }
    return k;
  }

  return helper(subset, items);
}

/// Gives [k]th compound in the ordered list of compounds of [items].
List<T> findCompound<T>(BigInt k, List<T> items) {
  int n = items.length, r;
  for (r = 0; r < n; r++) {
    BigInt groupSize = nPr(n, r);
    if (k >= groupSize) {
      k -= groupSize;
    } else {
      break;
    }
  }
  return findPermutation<T>(k, r, items);
}

/// Gives the index of [compound] in the ordered list of compounds of [items].
BigInt findInverseCompound<T>(List<T> compound, List<T> items) =>
    [for (var r = 0; r < compound.length; r++) nPr(items.length, r)]
        .fold(BigInt.zero, (a, b) => a + b) +
    findInversePermutation(compound, items);

/// Returns an index in the domain [0, n[.
BigInt adjustIndex(BigInt k, BigInt n) => k % n;

/// Ensures an index is of type [BigInt].
BigInt makeBigInt(Object k) => switch (k) {
  final int k => BigInt.from(k),
  final BigInt k => k,
  _ => throw Exception('Index must be an int or BigInt.'),
};

final _pattern = RegExp(r'\d(\d\d\d)$');

/// Expresses [x] as a string with digits separated by commas where appropriate.
String addCommas(Object x) {
  if (x is int || x is BigInt) {
    var s = x.toString();
    final parts = <String>[];
    while (_pattern.hasMatch(s)) {
      parts.add(',${_pattern.firstMatch(s)!.group(1)}');
      s = s.substring(0, s.length - 3);
    }
    return '$s${(parts.reversed.join(''))}';
  }
  throw TrotterException('Expecting an int or BigInt.');
}
