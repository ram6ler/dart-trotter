// Tests that drawSample:
//   - generates an approximately uniform distribution when sampling with
//     replacement over many trials
//   - returns only valid arrangements in every case
//   - returns exactly n distinct valid items when sampling without
//     replacement
//

import 'package:test/test.dart';
import 'package:trotter/trotter.dart';

void main() {
  group('drawSample', () {
    final combos = {'a', 'b', 'c', 'd', 'e'}.toCombinations(take: 3);

    group('with replacement', () {
      test('distribution is approximately uniform over many draws', () {
        // 10,000 draws from 10 equally likely arrangements → ~1,000 each.
        // Tolerance of ±300 (10 σ) is chosen to avoid flakiness while still
        // catching a systematic bias.
        //
        String key(List<String> c) => c.join();
        const sampleSize = 10_000;
        final counts = {for (final c in combos()) key(c): 0};

        for (final combo in combos.drawSample(
          sampleSize,
          seed: 0,
          withReplacement: true,
        )) {
          counts[key(combo)] = counts[key(combo)]! + 1;
        }

        for (final entry in counts.entries) {
          expect(
            entry.value,
            inInclusiveRange(700, 1300),
            reason:
                '"${entry.key}" appeared ${entry.value} times; '
                'expected ~1000',
          );
        }
      });

      test('every returned item is a valid arrangement', () {
        for (final combo in combos.drawSample(
          200,
          seed: 0,
          withReplacement: true,
        )) {
          expect(combos.contains(combo), isTrue);
        }
      });

      test('the requested number of items is returned', () {
        expect(
          combos.drawSample(7, seed: 0, withReplacement: true).toList().length,
          equals(7),
        );
      });
    });

    group('without replacement', () {
      test('returns exactly n distinct valid arrangements', () {
        final sample = combos.drawSample(5, seed: 0).toList();

        expect(sample.length, equals(5));

        // All items must be distinct.
        final keys = {for (final c in sample) c.join()};
        expect(keys.length, equals(5));

        // All items must be valid combinations.
        for (final combo in sample) {
          expect(combos.contains(combo), isTrue);
        }
      });

      test('drawing more than length throws TrotterException', () {
        // combos.length == 10; asking for 11 without replacement is impossible.
        expect(
          () => combos.drawSample(11).toList(),
          throwsA(isA<TrotterException>()),
        );
      });

      test('drawing exactly length returns all arrangements', () {
        final sample = combos.drawSample(10, seed: 7).toList();
        expect(sample.length, equals(10));
        final keys = {for (final c in sample) c.join()}.length;
        expect(keys, equals(10));
      });
    });
  });
}
