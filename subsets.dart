part of trotter;

class Subsets extends _Combinatoric {
  
/** An indexible pseudolist of subsets.
 * 
 * A pseuso-list "containing" all the subsets of objects taken from 
 * the list `elements`.
 * 
 * _Example_
 * ...
 *     var sub = new Subsets("abcd".split(""));
 *     print("There are ${sub.length} subsets of the objects");
 *     print("in ${sub.elements}.");
 *     print("The first subset is ${sub[0]}.");
 * ...
 * 
 */
  Subsets(List elements) {
    _elements = new List.from(elements);
    _length = 1 << elements.length;
  }
  
  @override List operator [](int k) => _subset(
    _adjustedIndex(k, length), elements);
  
  @override String toString() =>
   "Pseudo-list containing all $length subsets of items from $elements.";
}
