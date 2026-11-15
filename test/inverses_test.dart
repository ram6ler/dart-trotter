// Tests that for every index i in [0, length) the inverse mapping
// (indexOf) correctly identifies the arrangement at that index, i.e.
// that `structure.indexOf(structure[i]) == i` for all i.
//
// Also verifies that the order-agnostic classes (Combinations,
// Compositions, Subsets) treat equivalent arrangements as the same
// regardless of the order in which their items are supplied to indexOf.
//

import 'package:test/test.dart';
import 'package:trotter/trotter.dart';

void main() {
  final items = 'abcde'.split('');

  group('Combinations - indexOf is inverse of operator[]', () {
    final combos = Combinations(take: 3, items: items);

    test('indexOf round-trips for every arrangement', () {
      for (var i = BigInt.zero; i < combos.length; i += BigInt.one) {
        expect(
          combos.indexOf(combos[i]),
          equals(i),
          reason: 'indexOf(combos[$i]) returned wrong value',
        );
      }
    });

    test('indexOf is order-invariant', () {
      // ['a','c','e'] is at index 4 (verified against README listing).
      expect(combos.indexOf(['a', 'c', 'e']), equals(BigInt.from(4)));
      // Any reordering should map to the same index.
      expect(
        combos.indexOf(['e', 'c', 'a']),
        equals(combos.indexOf(['a', 'c', 'e'])),
      );
    });
  });

  group('Permutations - indexOf is inverse of operator[]', () {
    final perms = Permutations(take: 3, items: items);

    test('indexOf round-trips for every arrangement', () {
      for (var i = BigInt.zero; i < perms.length; i += BigInt.one) {
        expect(
          perms.indexOf(perms[i]),
          equals(i),
          reason: 'indexOf(perms[$i]) returned wrong value',
        );
      }
    });
  });

  group('Compositions - indexOf is inverse of operator[]', () {
    final comps = Compositions(take: 3, items: items);

    test('indexOf round-trips for every arrangement', () {
      for (var i = BigInt.zero; i < comps.length; i += BigInt.one) {
        expect(
          comps.indexOf(comps[i]),
          equals(i),
          reason: 'indexOf(comps[$i]) returned wrong value',
        );
      }
    });

    test('indexOf is order-invariant', () {
      // ['a','c','e'] is at index 11 (verified against README listing).
      expect(comps.indexOf(['a', 'c', 'e']), equals(BigInt.from(11)));
      expect(
        comps.indexOf(['e', 'c', 'a']),
        equals(comps.indexOf(['a', 'c', 'e'])),
      );
    });
  });

  group('Amalgams - indexOf is inverse of operator[]', () {
    final amalgams = Amalgams(take: 3, items: items);

    test('indexOf round-trips for every arrangement', () {
      for (var i = BigInt.zero; i < amalgams.length; i += BigInt.one) {
        expect(
          amalgams.indexOf(amalgams[i]),
          equals(i),
          reason: 'indexOf(amalgams[$i]) returned wrong value',
        );
      }
    });
  });

  group('Subsets - indexOf is inverse of operator[]', () {
    final subs = Subsets(items: items);

    test('indexOf round-trips for every arrangement', () {
      for (var i = BigInt.zero; i < subs.length; i += BigInt.one) {
        expect(
          subs.indexOf(subs[i]),
          equals(i),
          reason: 'indexOf(subs[$i]) returned wrong value',
        );
      }
    });

    test('indexOf is order-invariant', () {
      expect(subs.indexOf(['a', 'c', 'e']), equals(BigInt.from(21)));
      expect(
        subs.indexOf(['e', 'c', 'a']),
        equals(subs.indexOf(['a', 'c', 'e'])),
      );
    });
  });

  group('Compounds - indexOf is inverse of operator[]', () {
    final comps = Compounds(items: items);

    test('indexOf round-trips for every arrangement', () {
      for (var i = BigInt.zero; i < comps.length; i += BigInt.one) {
        expect(
          comps.indexOf(comps[i]),
          equals(i),
          reason: 'indexOf(comps[$i]) returned wrong value',
        );
      }
    });
  });
}
