part of trotter;

class Combinations extends _Combinatoric {
  int _r;
  int get r => _r;
  
/** An indexible pseudo-list of combinations.
 * 
 * A pseuso-list "containing" all the `r`-combinations of objects taken from 
 * the list `elements`.
 * 
 * _Example_
 * ...
 *     var c = new Combinations(3, "abcd".split(""));
 *     print("There are ${c.length} 3-combinations of the objects");
 *     print("in ${c.elements}.");
 *     print("The first combination is ${c[0]}.");
 * ...
 * 
 */
  Combinations(int r, List elements) {
    assert(r >= 0 && r <= elements.length);
    _elements = new List.from(elements);
    _r = r;
    _length = _nCr(elements.length, r);
  }
    
  @override List operator [](int k) => _combination(
    _adjustedIndex(k, length), 
    r, 
    elements
  );
  
  @override String toString() =>
   "Pseudo-list containing all $length $r-combinations of items from $elements.";
}