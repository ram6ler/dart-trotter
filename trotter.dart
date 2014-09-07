library trotter;

Map<int, int> _factCache = {};
Map<int, int> _twoToCache = {};

class _Combinatoric {
  List _elements;
  int _length;
  List get elements => _elements;
  int get length => _length;
    
  static int _fact(int n) => 
      _factCache.containsKey(n) ? _factCache[n] : 
        (n < 2 ? 1 : _factCache[n] = n * _fact(n - 1));
  
  static int _twoTo(int n) =>
      _twoToCache.containsKey(n) ? _twoToCache[n] :
        (n < 1 ? 1 : _twoToCache[n] = 2 * _twoTo(n - 1));
  
  static int _nPr(int n, int r) => _fact(n) ~/ _fact(n - r);
  
  static int _nCr(int n, int r) => _nPr(n, r) ~/ _fact(r);
  
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
  
  static List _subset(int k, List elements) {
    k = _adjustedIndex(k, _twoTo(elements.length));
    List r = [];
    for (int i = 0; i < elements.length; i++)
      if (k & _twoTo(i) != 0) r.add(elements[i]);
    return r;
  }
  
  static int _adjustedIndex(int k, int n) {
    while (k < 0) k += n;
    k %= n;
    return k;
  }
}

class Permutations extends _Combinatoric {
  int _r;
  int get r => _r;

  Permutations(int r, List elements) {
    assert(r >= 0 && r <= elements.length);
    _elements = new List.from(elements);
    _r = r;
    _length = _Combinatoric._nPr(elements.length, r);
  }
  
  List operator [](int k) => _Combinatoric._permutation(
    _Combinatoric._adjustedIndex(k, length), 
    r, 
    elements
  );
}

class Combinations extends _Combinatoric {
  int _r;
  int get r => _r;
  
  Combinations(int r, List elements) {
    assert(r >= 0 && r <= elements.length);
    _elements = new List.from(elements);
    _r = r;
    _length = _Combinatoric._nCr(elements.length, r);
  }
    
  List operator [](int k) => _Combinatoric._combination(
    _Combinatoric._adjustedIndex(k, length), 
    r, 
    elements
  );
}

class Subsets extends _Combinatoric {

  Subsets(List elements) {
    _elements = new List.from(elements);
    _length = _Combinatoric._twoTo(elements.length);
  }
  
  List operator [](int k) => _Combinatoric._subset(
    _Combinatoric._adjustedIndex(k, length), elements);
}

