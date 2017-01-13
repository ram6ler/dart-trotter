part of trotter;

abstract class _Combinatorics implements Iterable {
  List _items;
  int _length;

  /// The list from which the objects are selected
  List get items => new List.from(_items, growable: false);

  /// Returns a range of arrangements.
  ///
  /// The arrangements "stored" in this pseudo-list from index [from]
  /// up to but not including [to].
  /// 

  List range([int from = 0, int to = -1]) {
    if (to == -1) to = length;
    return new List.generate(to - from, (int i) => this[from + i]);
  }

  /// The number of arrangements "contained" in this pseudo-list.
  @override
  int get length => _length;

  /// The [k]th arrangement.
  List operator [](int k);

  /// Returns the [k]th arrangement.
  @override
  dynamic elementAt(int k) => this[k];

  /// Returns whether [x] is in the pseudo-list.
  @override
  bool contains(Object x);

  /// Iterator support.
  @override
  Iterator<List<dynamic>> get iterator => 
    new List.generate(_length, (i) => this[i]).iterator;
  
  /// Returns the first element.
  @override
  List<dynamic> get first => this[0];

  /// Returns the last element.
  @override
  List<dynamic> get last => this[-1];

  /// Returns whether there exists an arrangement that satisfies `predicate`. 
  /// (Use with care on large structures!)
  @override
  bool any(bool predicate(dynamic element)) {
    for (dynamic element in this) {
      if (predicate(element)) return true;
    }
    return false;
  }

  /// Returns whether every arrangement contained satisfies `predicate`. 
  /// (Use with care on large structures!)
  @override
  bool every(bool f(dynamic element)) {
    for (dynamic element in this) {
      if (!f(element)) return false;
    }
    return true;
  }

  /// Returns the first element that satisfies `predicate`.
  /// (Use with care on large structures!)
  @override
  dynamic firstWhere(bool test(dynamic element), {dynamic orElse()}) {
    for (dynamic element in this) {
      if (test(element)) return element;
    }
    if (orElse != null) return orElse();
    throw new StateError("No items match predicate: $this");
  }

  /// Returns the last element that satisfies `predicate`.
  /// (Use with care on large structures!)
  @override
  dynamic lastWhere(bool test(dynamic element), {dynamic orElse()}) {
    dynamic result;
    bool foundMatching = false;
    for (dynamic element in this) {
      if (test(element)) {
        result = element;
        foundMatching = true;
      }
    }
    if (foundMatching) return result;
    if (orElse != null) return orElse();
    throw new StateError("No items match predicate: $this");
  }

  /// Applies function `f` to each element in this structure.
  /// (Use with care on large structures!)
  @override
  void forEach(void f(dynamic element)) {
    for (dynamic element in this) f(element);
  }

  /// Converts each element to a [String] and concatenates the strings.
  /// (Use with care on large structures!)
  @override
  String join([String separator = ""]) {
    Iterator iterator = this.iterator;
    if (!iterator.moveNext()) return "";
    StringBuffer buffer = new StringBuffer();
    if (separator == null || separator == "") {
      do {
        buffer.write("${iterator.current}");
      } while (iterator.moveNext());
    } else {
      buffer.write("${iterator.current}");
      while (iterator.moveNext()) {
        buffer.write(separator);
        buffer.write("${iterator.current}");
      }
    }
    return buffer.toString();
  }

  /// Creates a [List] containing the elements in this structure.
  /// (Use with care on large structures!)
  @override
  List<List<dynamic>> toList({bool growable: true}) {
    return new List<List<dynamic>>.from(this, growable: growable);
  }

  @override
  void noSuchMethod(Invocation invocation) {
    throw new NoSuchMethodError(this, invocation.memberName,
        invocation.positionalArguments, invocation.namedArguments);
  }
}
