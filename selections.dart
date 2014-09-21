part of trotter;

class Selections extends _Combinatoric {
  int _r;
  int get r => _r;
  
/** An indexible pseudo-list of selections (combinations with repitition allowed).
 * 
 * A pseuso-list "containing" all the `r`-selections of objects taken from 
 * the list `elements`.
 * 
 * _Example_
 * ...
 *     var s = new Selections(3, "abcd".split(""));
 *     print("There are ${s.length} 3-selections of the objects");
 *     print("in ${s.elements}.");
 *     print("The first selection is ${c[0]}.");
 * ...
 * 
 */
  Selections(int r, List elements) {
    assert(r >= 0 && r <= elements.length);
    _elements = new List.from(elements);
    _r = r;
    _length = _nCr(elements.length + r - 1, r);
  }
  
  @override List operator [](int k) => _selection(
    _adjustedIndex(k, length), 
    r, 
    elements
  );
  
  @override String toString() =>
   "Pseudo-list containing all $length $r-selections of items from $elements.";
}