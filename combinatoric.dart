part of trotter;

abstract class _Combinatoric {
  List _elements;
  int _length;
  
  /// The list from which the objects are selected
  List get elements => new List.from(_elements, growable: false);
  
  /// The number of arrangements "contained" in this pseudo-list.
  int get length => _length;

  List operator [](int k);
  
/**
 * Returns a range of arrangements.
 * 
 * The arrangements "stored" in this pseudo-list from index `[from]`
 * up to but not including `[to]`.
 * 
 */ 
  List range([int from = 0, int to = -1]) { 
    if (to == -1) to = length;
    return new List.generate(to - from, (int i) => this[from + i]);
  }
  
  List toList({bool growable: true}) => 
    new List.from(_elements, growable: growable);
  
  Set toSet() => (new List.from(_elements, growable: false)).toSet();
}
