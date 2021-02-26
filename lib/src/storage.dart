part of trotter;

/// A storage wrapper for a combinatorics instance.
///
/// This allows us to remove selections from the structure and
/// keep track of the remaining selectsions in a memory efficient
/// way (one bit per selection).
///
/// (Only meant for small to moderate sized combinatorics structures.)
///
class Storage<T> {
  Storage(this.combinatorics) {
    final bitsInByte = BigInt.from(8),
        numberOfBytes =
            (combinatorics.length ~/ bitsInByte + BigInt.one).toInt();
    _data = ByteData(numberOfBytes);
  }

  /// The combinatorics object being wrapped.
  late Combinatorics<T> combinatorics;

  /// The data storing whether each selection is contained.
  late ByteData _data;

  void _checkselection(List<T> selection) {
    if (!combinatorics.contains(selection)) {
      throw Exception('''
Combinatorics structure:
  $combinatorics
does not contain:
  $selection
''');
    }
  }

  /// Whether a selection is still in the storage structure.
  bool contains(List<T> selection) {
    _checkselection(selection);
    final index = combinatorics.indexOf(selection).toInt(),
        byte = index ~/ 8,
        bit = index % 8,
        mask = 1 << bit;

    return _data.getUint8(byte) & mask == 0;
  }

  /// Toggle whether a selection is still in the storage structure.
  void toggle(List<T> selection) {
    _checkselection(selection);
    final index = combinatorics.indexOf(selection).toInt(),
        byte = index ~/ 8,
        bit = index % 8,
        mask = 1 << bit;
    _data.setUint8(byte, _data.getUint8(byte) ^ mask);
  }

  /// Remove a selection from the storage structure.
  void remove(List<T> selection) {
    _checkselection(selection);
    if (contains(selection)) {
      toggle(selection);
    }
  }

  /// Remove some selections from the storage structure.
  void removeAll(List<List<T>> selections) {
    for (final selection in selections) {
      remove(selection);
    }
  }

  /// Remove selections matching a predicate from the storage structure.
  void removeWhere(bool Function(List<T>) predicate) {
    for (final selection in combinatorics().where(predicate)) {
      remove(selection);
    }
  }

  /// Add a selection to the storage structure.
  void add(List<T> selection) {
    _checkselection(selection);
    if (!contains(selection)) {
      toggle(selection);
    }
  }

  /// Add some selections to the storage structure.
  void addAll(List<List<T>> selections) {
    for (final selection in selections) {
      add(selection);
    }
  }

  /// Add selections matching a predicate to the storage selection.
  void addWhere(bool Function(List<T>) predicate) {
    for (final selection in combinatorics().where(predicate)) {
      add(selection);
    }
  }

  /// The first remaining selection in the storage structure.
  List<T> firstRemaining() {
    int byte = 0, mask = 1, bit = 0;
    while (byte < _data.lengthInBytes && _data.getUint8(byte) == 255) {
      byte++;
    }
    if (byte == _data.lengthInBytes) {
      return <T>[];
    }

    while (_data.getUint8(byte) & mask != 0) {
      mask <<= 1;
      bit++;
    }

    return combinatorics[BigInt.from(8 * byte + bit)];
  }
}
