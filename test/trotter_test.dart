// Comprehensive tests for all combinatorics classes, helper functions,
// extension methods, and the Storage class.
//
// Golden values are taken directly from the README examples; any
// discrepancy between a test and the README is a bug in the library.
//

import 'package:test/test.dart';
import 'package:trotter/trotter.dart';

void main() {
  group('factorial', () {
    test('factorial(0) = 1', () => expect(factorial(0), BigInt.one));
    test('factorial(1) = 1', () => expect(factorial(1), BigInt.one));
    test('factorial(5) = 120', () => expect(factorial(5), BigInt.from(120)));
    test(
      'factorial(10) = 3628800',
      () => expect(factorial(10), BigInt.from(3_628_800)),
    );
    test('factorial of a negative number throws TrotterException', () {
      expect(() => factorial(-1), throwsA(isA<TrotterException>()));
    });
  });

  group('nPr', () {
    test('nPr(5, 0) = 1', () => expect(nPr(5, 0), BigInt.one));
    test('nPr(5, 3) = 60', () => expect(nPr(5, 3), BigInt.from(60)));
    test('nPr(5, 5) = 120', () => expect(nPr(5, 5), BigInt.from(120)));
  });

  group('nCr', () {
    test('nCr(5, 0) = 1', () => expect(nCr(5, 0), BigInt.one));
    test('nCr(5, 3) = 10', () => expect(nCr(5, 3), BigInt.from(10)));
    test('nCr(5, 5) = 1', () => expect(nCr(5, 5), BigInt.one));
    test('nCr(7, 3) = 35', () => expect(nCr(7, 3), BigInt.from(35)));
  });

  group('Combinations', () {
    final items = ['a', 'b', 'c', 'd', 'e'];
    late Combinations<String> combos;
    setUp(() => combos = Combinations(take: 3, items: items));

    test('length is C(5,3) = 10', () => expect(combos.length, BigInt.from(10)));

    test('elements matches the supplied items list', () {
      expect(combos.elements, equals(items));
    });

    test('take is 3', () => expect(combos.take, equals(3)));

    test('complete enumeration matches README', () {
      expect(
        combos().toList(),
        equals([
          ['a', 'b', 'c'],
          ['a', 'b', 'd'],
          ['a', 'b', 'e'],
          ['a', 'c', 'd'],
          ['a', 'c', 'e'],
          ['a', 'd', 'e'],
          ['b', 'c', 'd'],
          ['b', 'c', 'e'],
          ['b', 'd', 'e'],
          ['c', 'd', 'e'],
        ]),
      );
    });

    test('int and BigInt indexing agree', () {
      for (var i = 0; i < 10; i++) {
        expect(combos[i], equals(combos[i]));
      }
    });

    test('negative index wraps around (index -1 == index length-1)', () {
      expect(combos[-1], equals(combos[9]));
      expect(combos[-1], equals(['c', 'd', 'e']));
    });

    // ── contains ────────────────────────────────────────────────────────────

    test('contains a valid combination', () {
      expect(combos.contains(['a', 'b', 'c']), isTrue);
      expect(combos.contains(['c', 'd', 'e']), isTrue);
    });

    test('does not contain an arrangement of wrong length', () {
      expect(combos.contains(['a', 'b']), isFalse);
      expect(combos.contains(['a', 'b', 'c', 'd']), isFalse);
    });

    test('does not contain an item outside elements', () {
      expect(combos.contains(['a', 'b', 'f']), isFalse);
    });

    test('does not contain duplicate items', () {
      expect(combos.contains(['a', 'a', 'b']), isFalse);
    });

    // ── call() / range ──────────────────────────────────────────────────────

    test('call() with no arguments returns all arrangements', () {
      expect(combos().toList().length, equals(10));
    });

    test('call(n) returns first n arrangements [0, n)', () {
      expect(
        combos(3).toList(),
        equals([
          ['a', 'b', 'c'],
          ['a', 'b', 'd'],
          ['a', 'b', 'e'],
        ]),
      );
    });

    test('call(from, to) returns arrangements in [from, to)', () {
      expect(
        combos(2, 5).toList(),
        equals([
          ['a', 'b', 'e'],
          ['a', 'c', 'd'],
          ['a', 'c', 'e'],
        ]),
      );
    });

    test('call() accepts BigInt arguments', () {
      expect(
        combos(BigInt.two, BigInt.from(5)).toList(),
        equals([
          ['a', 'b', 'e'],
          ['a', 'c', 'd'],
          ['a', 'c', 'e'],
        ]),
      );
    });

    test('call(from, to) wraps around when from > to', () {
      // Visits indices 8, 9, 0, 1, 2 (wrap-around at length = 10).
      expect(
        combos(8, 3).toList(),
        equals([
          ['b', 'd', 'e'],
          ['c', 'd', 'e'],
          ['a', 'b', 'c'],
          ['a', 'b', 'd'],
          ['a', 'b', 'e'],
        ]),
      );
    });

    test('call(a, a) iterates through all arrangements via wrap-around', () {
      // Design intent: "start at a, continue until just before a again"
      // is equivalent to traversing all length items starting at a.
      final all = combos(3, 3).toList();
      expect(all.length, equals(10));
      // The traversal starts at index 3.
      expect(all.first, equals(['a', 'c', 'd']));
    });

    test('indexOf returns -1 for an arrangement not in the structure', () {
      expect(combos.indexOf(['a', 'b', 'f']), equals(BigInt.from(-1)));
    });

    test('indexOf with start returns -1 when the index is before start', () {
      // ['a','b','c'] is at index 0; start = 1 → -1.
      expect(
        combos.indexOf(['a', 'b', 'c'], BigInt.one),
        equals(BigInt.from(-1)),
      );
    });

    test('indexOf with start returns the index when it is >= start', () {
      expect(combos.indexOf(['a', 'b', 'd'], BigInt.one), equals(BigInt.one));
    });

    test('take = 0 produces one empty combination', () {
      final c0 = Combinations(take: 0, items: items);
      expect(c0.length, equals(BigInt.one));
      expect(c0[0], equals(<String>[]));
    });

    test('constructor throws for non-unique items', () {
      expect(
        () => Combinations(take: 2, items: ['a', 'a', 'b']),
        throwsA(isA<TrotterException>()),
      );
    });
  });

  // ─── Permutations ─────────────────────────────────────────────────────────

  group('Permutations', () {
    final items = ['a', 'b', 'c', 'd', 'e'];
    late Permutations<String> perms;
    setUp(() => perms = Permutations(take: 3, items: items));

    test('length is P(5,3) = 60', () => expect(perms.length, BigInt.from(60)));

    test('first group of 6 (all permutations of {a,b,c}) matches README', () {
      expect(
        perms(0, 6).toList(),
        equals([
          ['a', 'b', 'c'],
          ['a', 'c', 'b'],
          ['c', 'a', 'b'],
          ['c', 'b', 'a'],
          ['b', 'c', 'a'],
          ['b', 'a', 'c'],
        ]),
      );
    });

    test('second group starts with [a, b, d] at index 6', () {
      expect(perms[6], equals(['a', 'b', 'd']));
    });

    test('contains a valid permutation', () {
      expect(perms.contains(['c', 'b', 'a']), isTrue);
    });

    test('does not contain an arrangement of wrong length', () {
      expect(perms.contains(['a', 'b']), isFalse);
    });

    test('does not contain duplicate items', () {
      expect(perms.contains(['a', 'a', 'b']), isFalse);
    });

    test('take = 0 produces one empty permutation', () {
      final p0 = Permutations(take: 0, items: items);
      expect(p0.length, equals(BigInt.one));
      expect(p0[0], equals(<String>[]));
    });

    test('constructor throws TrotterException for negative take', () {
      expect(
        () => Permutations(take: -1, items: items),
        throwsA(isA<TrotterException>()),
      );
    });

    test('constructor throws for non-unique items', () {
      expect(
        () => Permutations(take: 2, items: ['a', 'a', 'b']),
        throwsA(isA<TrotterException>()),
      );
    });
  });

  group('Compositions', () {
    final items = ['a', 'b', 'c', 'd', 'e'];
    late Compositions<String> comps;
    setUp(() => comps = Compositions(take: 3, items: items));

    test('length is C(7,3) = 35', () => expect(comps.length, BigInt.from(35)));

    test('first 15 compositions match README', () {
      expect(
        comps(0, 15).toList(),
        equals([
          ['a', 'a', 'a'],
          ['a', 'a', 'b'],
          ['a', 'a', 'c'],
          ['a', 'a', 'd'],
          ['a', 'a', 'e'],
          ['a', 'b', 'b'],
          ['a', 'b', 'c'],
          ['a', 'b', 'd'],
          ['a', 'b', 'e'],
          ['a', 'c', 'c'],
          ['a', 'c', 'd'],
          ['a', 'c', 'e'],
          ['a', 'd', 'd'],
          ['a', 'd', 'e'],
          ['a', 'e', 'e'],
        ]),
      );
    });

    test('last composition is [e, e, e]', () {
      expect(comps[34], equals(['e', 'e', 'e']));
    });

    test('contains a composition with repeated items', () {
      expect(comps.contains(['a', 'a', 'b']), isTrue);
      expect(comps.contains(['e', 'e', 'e']), isTrue);
    });

    test('does not contain an arrangement of wrong length', () {
      expect(comps.contains(['a', 'b']), isFalse);
    });

    test('does not contain an item outside elements', () {
      expect(comps.contains(['a', 'b', 'f']), isFalse);
    });

    test('take = 0 with non-empty items produces one empty composition', () {
      final c0 = Compositions(take: 0, items: items);
      expect(c0.length, equals(BigInt.one));
      expect(c0[0], equals(<String>[]));
    });
  });

  group('Amalgams', () {
    final items = ['a', 'b', 'c', 'd', 'e'];
    late Amalgams<String> amalgams;
    setUp(() => amalgams = Amalgams(take: 3, items: items));

    test('length is 5³ = 125', () => expect(amalgams.length, BigInt.from(125)));

    test('first 10 amalgams match README', () {
      expect(
        amalgams(0, 10).toList(),
        equals([
          ['a', 'a', 'a'],
          ['a', 'a', 'b'],
          ['a', 'a', 'c'],
          ['a', 'a', 'd'],
          ['a', 'a', 'e'],
          ['a', 'b', 'a'],
          ['a', 'b', 'b'],
          ['a', 'b', 'c'],
          ['a', 'b', 'd'],
          ['a', 'b', 'e'],
        ]),
      );
    });

    test('last amalgam is [e, e, e]', () {
      expect(amalgams[124], equals(['e', 'e', 'e']));
    });

    test('contains an amalgam with repeated items', () {
      expect(amalgams.contains(['a', 'a', 'a']), isTrue);
    });

    test('does not contain an arrangement of wrong length', () {
      expect(amalgams.contains(['a', 'b']), isFalse);
    });

    test('does not contain an item outside elements', () {
      expect(amalgams.contains(['a', 'b', 'f']), isFalse);
    });

    test('take = 0 produces one empty amalgam', () {
      final a0 = Amalgams(take: 0, items: items);
      expect(a0.length, equals(BigInt.one));
      expect(a0[0], equals(<String>[]));
    });

    test(
      'constructor throws TrotterException when take > 0 and items is empty',
      () {
        expect(
          () => Amalgams(take: 1, items: <String>[]),
          throwsA(isA<TrotterException>()),
        );
      },
    );
  });

  group('Subsets', () {
    final items = ['a', 'b', 'c', 'd', 'e'];
    late Subsets<String> subs;
    setUp(() => subs = Subsets(items: items));

    test('length is 2⁵ = 32', () => expect(subs.length, BigInt.from(32)));

    test('first 10 subsets match README', () {
      expect(
        subs(0, 10).toList(),
        equals([
          [],
          ['a'],
          ['b'],
          ['a', 'b'],
          ['c'],
          ['a', 'c'],
          ['b', 'c'],
          ['a', 'b', 'c'],
          ['d'],
          ['a', 'd'],
        ]),
      );
    });

    test('last subset contains all items', () {
      expect(subs[31], equals(['a', 'b', 'c', 'd', 'e']));
    });

    test('contains the empty subset', () => expect(subs.contains([]), isTrue));

    test('contains a valid non-empty subset', () {
      expect(subs.contains(['a', 'c', 'e']), isTrue);
    });

    test('does not contain duplicate items', () {
      expect(subs.contains(['a', 'a']), isFalse);
    });

    test('does not contain an item outside elements', () {
      expect(subs.contains(['a', 'f']), isFalse);
    });

    test('empty items list produces 1 subset (the empty set)', () {
      final s0 = Subsets(items: <String>[]);
      expect(s0.length, equals(BigInt.one));
      expect(s0[0], equals(<String>[]));
    });

    test('constructor throws TrotterException for non-unique items', () {
      expect(
        () => Subsets(items: ['a', 'a', 'b']),
        throwsA(isA<TrotterException>()),
      );
    });
  });

  group('Compounds', () {
    final items = ['a', 'b', 'c', 'd', 'e'];
    late Compounds<String> comps;
    setUp(() => comps = Compounds(items: items));

    test('length is Σ P(5,r) for r = 0..5 = 326', () {
      expect(comps.length, BigInt.from(326));
    });

    test('first 10 compounds match README', () {
      expect(
        comps(0, 10).toList(),
        equals([
          [],
          ['a'],
          ['b'],
          ['c'],
          ['d'],
          ['e'],
          ['a', 'b'],
          ['b', 'a'],
          ['a', 'c'],
          ['c', 'a'],
        ]),
      );
    });

    test('contains the empty compound', () {
      expect(comps.contains([]), isTrue);
    });

    test('contains a full-length compound', () {
      expect(comps.contains(['a', 'b', 'c', 'd', 'e']), isTrue);
    });

    test('does not contain duplicate items', () {
      expect(comps.contains(['a', 'a']), isFalse);
    });

    test('does not contain an item outside elements', () {
      expect(comps.contains(['a', 'f']), isFalse);
    });

    test('empty items list produces 1 compound (the empty compound)', () {
      final c0 = Compounds(items: <String>[]);
      expect(c0.length, equals(BigInt.one));
      expect(c0[0], equals(<String>[]));
    });

    test('constructor throws TrotterException for non-unique items', () {
      expect(
        () => Compounds(items: ['a', 'a', 'b']),
        throwsA(isA<TrotterException>()),
      );
    });
  });

  group('Large indices', () {
    late Permutations<String> perms;
    setUp(() {
      perms = Permutations(
        take: 10,
        items: 'abcdefghijklmnopqrstuvwxyz'.split(''),
      );
    });

    test('10-permutations of the alphabet has length 19,275,223,968,000', () {
      expect(perms.length, equals(BigInt.parse('19275223968000')));
    });

    test('"algorithms" is at the correct index', () {
      final needle = 'algorithms'.split('');
      expect(perms.indexOf(needle), equals(BigInt.parse('6831894769563')));
    });

    test('accessing the last arrangement via BigInt index', () {
      final lastIndex = perms.length - BigInt.one;
      expect(
        perms[lastIndex],
        equals(['r', 'q', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']),
      );
    });
  });

  group('IterableExtensions', () {
    final items = ['a', 'b', 'c', 'd', 'e'];

    test('toPermutations creates Permutations with the correct length', () {
      final p = items.toPermutations(take: 3);
      expect(p, isA<Permutations<String>>());
      expect(p.length, BigInt.from(60));
    });

    test('toCombinations creates Combinations with the correct length', () {
      final c = items.toCombinations(take: 3);
      expect(c, isA<Combinations<String>>());
      expect(c.length, BigInt.from(10));
    });

    test('toCompositions creates Compositions with the correct length', () {
      final c = ['a', 'b', 'c'].toCompositions(take: 2);
      expect(c, isA<Compositions<String>>());
      expect(c.length, BigInt.from(6)); // C(4,2) = 6
    });

    test('toAmalgams creates Amalgams with the correct length', () {
      final a = ['a', 'b', 'c'].toAmalgams(take: 2);
      expect(a, isA<Amalgams<String>>());
      expect(a.length, BigInt.from(9)); // 3² = 9
    });

    test('toSubsets creates Subsets with the correct length', () {
      final s = ['a', 'b', 'c'].toSubsets();
      expect(s, isA<Subsets<String>>());
      expect(s.length, BigInt.from(8)); // 2³ = 8
    });

    test('toCompounds creates Compounds with the correct length', () {
      final c = ['a', 'b', 'c'].toCompounds();
      expect(c, isA<Compounds<String>>());
      // 1 + 3 + 6 + 6 = 16
      expect(c.length, BigInt.from(16));
    });

    test('default take uses all items', () {
      final p = ['a', 'b', 'c'].toPermutations();
      expect(p.take, equals(3));
      expect(p.length, BigInt.from(6)); // 3! = 6
    });
  });

  group('StringExtensions', () {
    test('toPermutations from a string', () {
      final p = 'abcde'.toPermutations(take: 3);
      expect(p, isA<Permutations<String>>());
      expect(p.length, BigInt.from(60));
    });

    test('toCombinations from a string', () {
      final c = 'abcde'.toCombinations(take: 3);
      expect(c, isA<Combinations<String>>());
      expect(c.length, BigInt.from(10));
    });

    test('toSubsets from a string', () {
      final s = 'abc'.toSubsets();
      expect(s, isA<Subsets<String>>());
      expect(s.length, BigInt.from(8));
    });

    test('toCompounds from a string', () {
      final c = 'abc'.toCompounds();
      expect(c, isA<Compounds<String>>());
    });

    test('toAmalgams from a string', () {
      final a = 'abc'.toAmalgams(take: 2);
      expect(a, isA<Amalgams<String>>());
      expect(a.length, BigInt.from(9));
    });

    test('toCompositions from a string', () {
      final c = 'abc'.toCompositions(take: 2);
      expect(c, isA<Compositions<String>>());
      expect(c.length, BigInt.from(6));
    });

    test('a string with duplicate characters throws TrotterException', () {
      expect(
        () => 'aab'.toCombinations(take: 2),
        throwsA(isA<TrotterException>()),
      );
    });

    test('default take uses the full string length', () {
      final p = 'abc'.toPermutations();
      expect(p.take, equals(3));
    });
  });

  group('Storage', () {
    late Combinations<String> combos;
    late Storage<String> storage;

    setUp(() {
      combos = Combinations(take: 3, items: ['a', 'b', 'c', 'd', 'e']);
      storage = Storage(combos);
    });

    test('all selections are present on creation', () {
      for (final combo in combos()) {
        expect(storage.contains(combo), isTrue);
      }
    });

    test('contains returns false after remove', () {
      storage.remove(['a', 'b', 'c']);
      expect(storage.contains(['a', 'b', 'c']), isFalse);
    });

    test('contains returns true again after add', () {
      storage
        ..remove(['a', 'b', 'c'])
        ..add(['a', 'b', 'c']);
      expect(storage.contains(['a', 'b', 'c']), isTrue);
    });

    test('toggle flips the present / absent state', () {
      storage.toggle(['a', 'b', 'd']); // present -> absent
      expect(storage.contains(['a', 'b', 'd']), isFalse);
      storage.toggle(['a', 'b', 'd']); // absent -> present
      expect(storage.contains(['a', 'b', 'd']), isTrue);
    });

    test('firstRemaining returns the first present selection', () {
      expect(storage.firstRemaining(), equals(['a', 'b', 'c']));
    });

    test('firstRemaining skips removed selections', () {
      storage.remove(['a', 'b', 'c']);
      expect(storage.firstRemaining(), equals(['a', 'b', 'd']));
    });

    test('removeAll removes multiple selections', () {
      storage.removeAll([
        ['a', 'b', 'c'],
        ['a', 'b', 'd'],
      ]);
      expect(storage.contains(['a', 'b', 'c']), isFalse);
      expect(storage.contains(['a', 'b', 'd']), isFalse);
      expect(storage.contains(['a', 'b', 'e']), isTrue); // unaffected
    });

    test('removeWhere removes all selections matching a predicate', () {
      storage.removeWhere((c) => c.contains('a'));
      for (final combo in combos()) {
        expect(storage.contains(combo), equals(!combo.contains('a')));
      }
    });

    test('addAll re-adds multiple selections', () {
      for (final combo in combos()) {
        storage.remove(combo);
      }
      storage.addAll([
        ['a', 'b', 'c'],
        ['c', 'd', 'e'],
      ]);
      expect(storage.contains(['a', 'b', 'c']), isTrue);
      expect(storage.contains(['c', 'd', 'e']), isTrue);
      expect(storage.contains(['a', 'b', 'd']), isFalse); // not re-added
    });

    test('addWhere adds selections matching a predicate', () {
      for (final combo in combos()) {
        storage.remove(combo);
      }
      storage.addWhere((c) => c.contains('e'));
      for (final combo in combos()) {
        expect(storage.contains(combo), equals(combo.contains('e')));
      }
    });
  });
}
