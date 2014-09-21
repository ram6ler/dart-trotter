part of trotter;

class Permutations extends _Combinatoric {
  int _r;
  int get r => _r;

/** An indexible pseudo-list of permutations.
 * 
 * A pseuso-list "containing" all the `r`-permutations of objects taken from
 * the list `elements`.
 * 
 * _Example_
 * ...
 *     var p = new Permutations(3, "abcd".split(""));
 *     print("There are ${p.length} 3-permutations of the objects");
 *     print("in ${p.elements}.");
 *     print("The first permutation is ${p[0]}.");
 * ...
 * 
 */
  Permutations(int r, List elements) {
    assert(r >= 0 && r <= elements.length);
    _elements = new List.from(elements);
    _r = r;
    _length = _nPr(elements.length, r);
  }
  
  @override List operator [](int k) => _permutation(
    _adjustedIndex(k, length), 
    r, 
    elements
  );
  
  @override String toString() =>
    "Pseudo-list containing all $length $r-permutations of items from $elements.";
}