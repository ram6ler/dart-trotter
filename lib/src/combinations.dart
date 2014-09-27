part of trotter;

/** An indexible pseudo-list of combinations.
 * 
 * A pseuso-list "containing" all the `r`-combinations of objects taken from 
 * the list `elements`.
 * 
 * _Example_
 * ```
 * var c = new Combinations(3, "abcd".split(""));
 * print("There are ${c.length} 3-combinations of the objects");
 * print("in ${c.elements}.");
 * print("The first combination is ${c[0]}.");
 * ```
 * 
 */
class Combinations extends _Combinatorics {
  int _r;
  
  /// The number of items taken from [elements].
  int get r => _r;
  

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