part of trotter;

/** An indexible pseudo-list of permutations.
 * 
 * A pseuso-list "containing" all the `r`-permutations of objects taken from
 * the list `elements`.
 * 
 * _Example_
 * ```
 * var p = new Permutations(3, "abcd".split(""));
 * print("There are ${p.length} 3-permutations of the objects");
 * print("in ${p.elements}.");
 * print("The first permutation is ${p[0]}.");
 * ```
 * 
 */
class Permutations extends _Combinatorics {
  int _r;
  
  /// The number of items taken from [elements].
  int get r => _r;


  Permutations(int r, List elements) {
    assert(r >= 0 && r <= elements.length);
    _items = new List.from(elements);
    _r = r;
    _length = _nPr(elements.length, r);
  }
  
  @override List operator [](int k) => _permutation(
    _adjustedIndex(k, length), 
    r, 
    elements
  );

  int indexOf(List permutation) => _inversePermutation(permutation, _items);
  
  @override String toString() =>
    "Pseudo-list containing all $length $r-permutations of items from $elements.";
}