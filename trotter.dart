library trotter;

Map<int, int> _factCache = {};

class _Combinatoric {
  List _elements;
  int _r, _length;
  List get elements => _elements;
  int get r => _r;
  int get length => _length;
    
  static int _fact(int n) => 
      _factCache.containsKey(n) ? _factCache[n] : 
        (n < 2 ? 1 : _factCache[n] = n * _fact(n - 1));
  
  static int _nPr(int n, int r) => _fact(n) ~/ _fact(n - r);
  
  static int _nCr(int n, int r) => _nPr(n, r) ~/ _fact(r);
 
  /**
   * Returns _k_th permutation in a pseudo-list
   * "containing" all possible permutations of the objects
   * in _elements_.
   * 
   * */
  
  static List _permWorker(int k, List elements) {
    int n = elements.length;
    if (n <= 1) return elements;
    else {
      int
        group = k ~/ n,
        item = k % n,
        position = group % 2 == 0 ? n - item - 1 : item
      ;
      return _permWorker(
          group,
          elements.sublist(0, n - 1)
      )..insert(position, elements[n - 1]);
    }
  }
  
  /**
   * Returns _k_th _r_-combination in a pseudo-list
   * "containing" all possible _r_-combinations of the objects
   * in _elements_.
   * 
   * */
  
  static List _combination(int k, int r, List elements) {
    int
      n = elements.length,
      position = 0, 
      d = _nCr(n - position - 1, r - 1)
    ;
    
    while (k >= d) {
      k -= d;
      ++position;
      d = _nCr(n - position - 1, r - 1);
    }
    
    if (r <= 1) return [elements[position]];
    else {
      List tail = elements.sublist(position + 1);
      return [elements[position]]
        ..addAll(_combination(k, r - 1, tail));
    }
  }
  
  /**
     * Returns _k_th _r_-permutation in a pseudo-list
     * "containing" all possible _r_-permutations of the objects
     * in _elements_.
     * 
     * */
  
  static List _permutation(int k, int r, List elements) {
    int
      n = elements.length,
      f = _fact(r),
      group = k ~/ f,
      item = k % f
    ;
    List comb = _combination(group, r, elements);
    return _permWorker(item, comb);
  }
  
  
  
  static int _adjustedIndex(int k, int n) {
    while (k < 0) k += n;
    k %= n;
    return k;
  }
}

class Permutations extends _Combinatoric {
  Permutations(int r, List elements) {
    assert(r >= 0 && r <= elements.length);
    _elements = new List.from(elements);
    _r = r;
    _length = _Combinatoric._nPr(elements.length, r);
  }
  
  // returns the kth permutation
  List operator [](int k) => _Combinatoric._permutation(
    _Combinatoric._adjustedIndex(k, length), 
    r, 
    elements
  );
}

class Combinations extends _Combinatoric {
  Combinations(int r, List elements) {
    assert(r >= 0 && r <= elements.length);
    _elements = new List.from(elements);
    _r = r;
    _length = _Combinatoric._nCr(elements.length, r);
  }
    
  // returns the kth combination
  List operator [](int k) => _Combinatoric._combination(
    _Combinatoric._adjustedIndex(k, length), 
    r, 
    elements
  );
}