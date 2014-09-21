part of trotter;

class Amalgams extends _Combinatoric {
  int _r;
  int get r => _r;
  
/** An indexible collection of amalgams (permutations with repitition allowed).
 * 
 * A pseuso-list "containing" all the `r`-amalgams of objects taken from 
 * the list `elements`.
 * 
 * _Example_
 * ...
 *     var a = new Amalgams(3, "abcd".split(""));
 *     print("There are ${a.length} 3-amalgams of the objects");
 *     print("in ${a.elements}.");
 *     print("The first amalgam is ${a[0]}.");
 * ...
 * 
 */
  Amalgams(int r, List elements) {
    assert(r >= 0 && r <= elements.length);
    _elements = new List.from(elements);
    _r = r;
    _length = Math.pow(elements.length, r).toInt();
  }
  
  @override List operator [](int k) => _amalgam(
    _adjustedIndex(k, length), 
    r, 
    elements
  );
  
  @override String toString() =>
   "Pseudo-list containing all $length $r-amalgams of items from $elements.";
}