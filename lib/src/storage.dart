import 'dart:typed_data' show ByteData;

import 'exception.dart';
import 'combinatorics.dart' show Combinatorics;

/// A storage wrapper for a combinatorics instance.
///
/// This allows us to remove selections from the structure and
/// keep track of the remaining selections in a memory efficient
/// way (one bit per selection).
///
/// (Only meant for small to moderate sized combinatorics structures.)
///
class Storage<T> {
  Storage(this.combinatorics)
    : _data = (combinatorics.length ~/ BigInt.from(8) + BigInt.one).isValidInt
          ? ByteData(
              (combinatorics.length ~/ BigInt.from(8) + BigInt.one).toInt(),
            )
          : throw TrotterException('Storage class too large.');

  /// The combinatorics object being wrapped.
  final Combinatorics<T> combinatorics;

  /// The data storing whether each selection is contained.
  final ByteData _data;

  void _checkSelection(List<T> selection) {
    if (!combinatorics.contains(selection)) {
      throw Exception(
        'Combinatorics structure:\n  $combinatorics'
        'does not contain:\n  $selection',
      );
    }
  }

  /// Whether [selection] is still in the storage structure.
  bool contains(List<T> selection) {
    _checkSelection(selection);
    final index = combinatorics.indexOf(selection).toInt(),
        byte = index ~/ 8,
        bit = index % 8,
        mask = 1 << bit;

    return _data.getUint8(byte) & mask == 0;
  }

  /// Toggle whether selection is still in the storage structure.
  void toggle(List<T> selection) {
    _checkSelection(selection);
    final index = combinatorics.indexOf(selection).toInt(),
        byte = index ~/ 8,
        bit = index % 8,
        mask = 1 << bit;
    _data.setUint8(byte, _data.getUint8(byte) ^ mask);
  }

  /// Remove [selection] from the storage structure.
  void remove(List<T> selection) {
    _checkSelection(selection);
    if (contains(selection)) {
      toggle(selection);
    }
  }

  /// Remove [selections] from the storage structure.
  void removeAll(List<List<T>> selections) {
    for (final selection in selections) {
      remove(selection);
    }
  }

  /// Remove selections matching [predicate] from the storage structure.
  void removeWhere(bool Function(List<T>) predicate) {
    for (final selection in combinatorics().where(predicate)) {
      remove(selection);
    }
  }

  /// Add [selection] to the storage structure.
  void add(List<T> selection) {
    _checkSelection(selection);
    if (!contains(selection)) {
      toggle(selection);
    }
  }

  /// Add [selections] to the storage structure.
  void addAll(List<List<T>> selections) {
    for (final selection in selections) {
      add(selection);
    }
  }

  /// Add selections matching [predicate] to the storage selection.
  void addWhere(bool Function(List<T>) predicate) {
    for (final selection in combinatorics().where(predicate)) {
      add(selection);
    }
  }

  /// The first remaining selection in the storage structure.
  ///
  /// Returns null if there is no remaining selection.
  ///
  List<T>? firstRemaining() {
    int byte = 0, mask = 1, bit = 0;
    while (byte < _data.lengthInBytes && _data.getUint8(byte) == 255) {
      byte++;
    }
    if (byte == _data.lengthInBytes) {
      return null;
    }

    while (_data.getUint8(byte) & mask != 0) {
      mask <<= 1;
      bit++;
    }

    final index = BigInt.from(8 * byte + bit);
    return index >= combinatorics.length ? null : combinatorics[index];
  }
}
