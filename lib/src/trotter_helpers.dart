part of trotter;

Map<int, int> _factCache = {};

int _fact(int n) => 
  _factCache.containsKey(n) ? _factCache[n] : 
    (n < 2 ? 1 : _factCache[n] = n * _fact(n - 1));

int _nPr(int n, int r) => _fact(n) ~/ _fact(n - r);

int _nCr(int n, int r) => _nPr(n, r) ~/ _fact(r);

List _permWorker(int k, List elements) {
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

List _combination(int k, int r, List elements) {
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
  
  if (r == 0) return [];
  else {
    List tail = elements.sublist(position + 1);
    return [elements[position]]
      ..addAll(_combination(k, r - 1, tail));
  }
}

List _selection(int k, int r, List elements) {
  int
    n = elements.length,
    position = 0, 
    d = _nCr(n + r - position - 2, r - 1)
  ;
      
  while (k >= d) {
    k -= d;
    ++position;
    d = _nCr(n + r - position - 2, r - 1);
  }

  if (r == 0) return [];
  else {
    List tail = elements.sublist(position);
    return [elements[position]]
      ..addAll(_selection(k, r - 1, tail));
  }
}

List _permutation(int k, int r, List elements) {
  int
    n = elements.length,
    f = _fact(r),
    group = k ~/ f,
    item = k % f
  ;
  List comb = _combination(group, r, elements);
  return _permWorker(item, comb);
}
  
List _amalgam(int k, int r, List elements) =>
  new List.generate(r, (int i) {
    int 
      p = Math.pow(elements.length, r - i - 1).toInt(),
      index = k ~/ p
    ;
      
    k %= p;
    return elements[index];
  }
); 

  
List _subset(int k, List elements) {
  k = _adjustedIndex(k, 1 << elements.length);
  List r = [];
  for (int i = 0; i < elements.length; i++)
    if (k & (1 << i) != 0) r.add(elements[i]);
  return r;
}
  
int _adjustedIndex(int k, int n) {
  while (k < 0) k += n;
  k %= n;
  return k;
}