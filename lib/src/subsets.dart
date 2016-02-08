part of trotter;

/** An indexible pseudolist of subsets.
 * 
 * A pseuso-list "containing" all the subsets of objects taken from 
 * the list `elements`.
 * 
 * _Example_
 * ```
 * var sub = new Subsets("abcd".split(""));
 * print("There are ${sub.length} subsets of the objects");
 * print("in ${sub.elements}.");
 * print("The first subset is ${sub[0]}.");
 * ```
 * 
 */
class Subsets extends _Combinatorics {
  

  Subsets(List elements) {
    _items = new List.from(elements);
    _length = 1 << elements.length;
  }
  
  @override List operator [](int k) => _subset(
    _adjustedIndex(k, length), elements);

  int indexOf(List subset) => _inverseSubset(subset, _items);

  @override String toString() =>
   "Pseudo-list containing all $length subsets of items from $elements.";
}
