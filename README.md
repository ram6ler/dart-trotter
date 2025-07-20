
![](https://bitbucket.org/ram6ler/dart_trotter/wiki/dart_trotter_banner.png)

Welcome to `trotter`, a library that simplifies working with meta-arrangements commonly
encountered in combinatorics, such as arrangements of combinations and permutations.

`trotter` gives the developer access to pseudo-lists that "contain" all selections
(combinations, permutations, etc.) of objects taken from a specified list of items.

The order of arrangements is based on the the order produced by the
[Steinhaus–Johnson–Trotter algorithm](https://en.wikipedia.org/wiki/Steinhaus%E2%80%93Johnson%E2%80%93Trotter_algorithm)
for ordering permutations, which I have generalized to combinations and arrangements
that allow for replacement after item selection.

The pseudo-list classes available are:

* Combinations.
* Permutations.
* Compositions (combinations with replacement).
* Amalgams (permutations with replacement).
* Subsets (combinations with unspecified number of items taken).
* Compounds (permutations with unspecified number of items taken).

# Demos

To see `trotter` in action:

* Play [Falco Shapes](https://falco-shapes.netlify.com/), a little puzzle
based on Marsha Falco's game of *Set*.

* Explore the *huge* number of permutations of letters of the alphabet with
[Permutation Products](https://permutation-products.netlify.com/).

# Using trotter

Include the following dependency in your `pubspec.yaml`:

```
dependencies:
  trotter: ^2.2.0
```

Then, to import the library:

```
import 'package:trotter/trotter.dart'
```

## The basic classes

### Combinations

A *combination* is a selection of items for which order is *not*
important and items are *not* replaced after being selected.

The `Combinations` class "contains" all combinations of a set of items.

**Example:**

```dart
final bagOfItems = characters('abcde'),
  combinations = Combinations(3, bagOfItems);
for (final (i, combination) in combinations().indexed) {
  print('[$i]: $combination');
}
```

```text
[0]: [a, b, c]
[1]: [a, b, d]
[2]: [a, b, e]
[3]: [a, c, d]
[4]: [a, c, e]
[5]: [a, d, e]
[6]: [b, c, d]
[7]: [b, c, e]
[8]: [b, d, e]
[9]: [c, d, e]
```

### Permutations

A *permutation* is a selection of items for which order *is* important
and items are *not* replaced after being selected.

The `Permutations` class "contains" all permutations of a set of items.

**Example:**

```dart
final bagOfItems = characters('abcde'), permutations = Permutations(3, bagOfItems);
for (final (i, permutation) in permutations().indexed) {
  print('[$i]: $permutation');
}
```

```text
[0]: [a, b, c]
[1]: [a, c, b]
[2]: [c, a, b]
[3]: [c, b, a]
[4]: [b, c, a]
[5]: [b, a, c]
[6]: [a, b, d]
[7]: [a, d, b]
[8]: [d, a, b]
[9]: [d, b, a]
[10]: [b, d, a]
[11]: [b, a, d]
[12]: [a, b, e]
[13]: [a, e, b]
[14]: [e, a, b]
[15]: [e, b, a]
[16]: [b, e, a]
[17]: [b, a, e]
[18]: [a, c, d]
[19]: [a, d, c]
[20]: [d, a, c]
[21]: [d, c, a]
[22]: [c, d, a]
[23]: [c, a, d]
[24]: [a, c, e]
[25]: [a, e, c]
[26]: [e, a, c]
[27]: [e, c, a]
[28]: [c, e, a]
[29]: [c, a, e]
[30]: [a, d, e]
[31]: [a, e, d]
[32]: [e, a, d]
[33]: [e, d, a]
[34]: [d, e, a]
[35]: [d, a, e]
[36]: [b, c, d]
[37]: [b, d, c]
[38]: [d, b, c]
[39]: [d, c, b]
[40]: [c, d, b]
[41]: [c, b, d]
[42]: [b, c, e]
[43]: [b, e, c]
[44]: [e, b, c]
[45]: [e, c, b]
[46]: [c, e, b]
[47]: [c, b, e]
[48]: [b, d, e]
[49]: [b, e, d]
[50]: [e, b, d]
[51]: [e, d, b]
[52]: [d, e, b]
[53]: [d, b, e]
[54]: [c, d, e]
[55]: [c, e, d]
[56]: [e, c, d]
[57]: [e, d, c]
[58]: [d, e, c]
[59]: [d, c, e]
```

(Notice that this library arranges permutations similarly to the way the
[Steinhaus-Johnson-Trotter](https://en.wikipedia.org/wiki/Steinhaus%E2%80%93Johnson%E2%80%93Trotter_algorithm)
algorithm arranges permutations. In fact, if we get the permutations of
*all* the specified items, e.g. `final permutations = Permutations(bagOfItems.length, bagOfItems);`
in the above code, the arrangement of permutations is exactly what would
have resulted from applying the S-J-T algorithm. The algorithms in this library
have an advantage in that they do not iterate through all k - 1 permutations in
order to determine the kth permutation, however.)

### Compositions

A *composition* (or combination with replacement) is a selection of items for
which order is *not* important and items *are* replaced after being selected.

The `Compositions` class "contains" all compositions of a set of items.

Here are all the compositions of three items taken from a bag of five items:

**Example:**

```dart
final bagOfItems = characters('abcde'), compositions = Compositions(3, bagOfItems);
for (final (i, composition) in compositions().indexed) {
  print('[$i]: $composition');
}
```

```text
[0]: [a, a, a]
[1]: [a, a, b]
[2]: [a, a, c]
[3]: [a, a, d]
[4]: [a, a, e]
[5]: [a, b, b]
[6]: [a, b, c]
[7]: [a, b, d]
[8]: [a, b, e]
[9]: [a, c, c]
[10]: [a, c, d]
[11]: [a, c, e]
[12]: [a, d, d]
[13]: [a, d, e]
[14]: [a, e, e]
[15]: [b, b, b]
[16]: [b, b, c]
[17]: [b, b, d]
[18]: [b, b, e]
[19]: [b, c, c]
[20]: [b, c, d]
[21]: [b, c, e]
[22]: [b, d, d]
[23]: [b, d, e]
[24]: [b, e, e]
[25]: [c, c, c]
[26]: [c, c, d]
[27]: [c, c, e]
[28]: [c, d, d]
[29]: [c, d, e]
[30]: [c, e, e]
[31]: [d, d, d]
[32]: [d, d, e]
[33]: [d, e, e]
[34]: [e, e, e]
```

### Amalgams

An *amalgam* (or permutation with replacement) is a selection of items for
which order *is* important and items *are* replaced after being selected.

The `Amalgams` class "contains" all amalgams of a set of items.

**Example:**

```dart
final bagOfItems = characters('abcde'), amalgams = Amalgams(3, bagOfItems);
for (final (i, amalgam) in amalgams().indexed) {
  print('[$i]: $amalgam');
}
```

```text
[0]: [a, a, a]
[1]: [a, a, b]
[2]: [a, a, c]
[3]: [a, a, d]
[4]: [a, a, e]
[5]: [a, b, a]
[6]: [a, b, b]
[7]: [a, b, c]
[8]: [a, b, d]
[9]: [a, b, e]
[10]: [a, c, a]
[11]: [a, c, b]
[12]: [a, c, c]
[13]: [a, c, d]
[14]: [a, c, e]
[15]: [a, d, a]
[16]: [a, d, b]
[17]: [a, d, c]
[18]: [a, d, d]
[19]: [a, d, e]
[20]: [a, e, a]
[21]: [a, e, b]
[22]: [a, e, c]
[23]: [a, e, d]
[24]: [a, e, e]
[25]: [b, a, a]
[26]: [b, a, b]
[27]: [b, a, c]
[28]: [b, a, d]
[29]: [b, a, e]
[30]: [b, b, a]
[31]: [b, b, b]
[32]: [b, b, c]
[33]: [b, b, d]
[34]: [b, b, e]
[35]: [b, c, a]
[36]: [b, c, b]
[37]: [b, c, c]
[38]: [b, c, d]
[39]: [b, c, e]
[40]: [b, d, a]
[41]: [b, d, b]
[42]: [b, d, c]
[43]: [b, d, d]
[44]: [b, d, e]
[45]: [b, e, a]
[46]: [b, e, b]
[47]: [b, e, c]
[48]: [b, e, d]
[49]: [b, e, e]
[50]: [c, a, a]
[51]: [c, a, b]
[52]: [c, a, c]
[53]: [c, a, d]
[54]: [c, a, e]
[55]: [c, b, a]
[56]: [c, b, b]
[57]: [c, b, c]
[58]: [c, b, d]
[59]: [c, b, e]
[60]: [c, c, a]
[61]: [c, c, b]
[62]: [c, c, c]
[63]: [c, c, d]
[64]: [c, c, e]
[65]: [c, d, a]
[66]: [c, d, b]
[67]: [c, d, c]
[68]: [c, d, d]
[69]: [c, d, e]
[70]: [c, e, a]
[71]: [c, e, b]
[72]: [c, e, c]
[73]: [c, e, d]
[74]: [c, e, e]
[75]: [d, a, a]
[76]: [d, a, b]
[77]: [d, a, c]
[78]: [d, a, d]
[79]: [d, a, e]
[80]: [d, b, a]
[81]: [d, b, b]
[82]: [d, b, c]
[83]: [d, b, d]
[84]: [d, b, e]
[85]: [d, c, a]
[86]: [d, c, b]
[87]: [d, c, c]
[88]: [d, c, d]
[89]: [d, c, e]
[90]: [d, d, a]
[91]: [d, d, b]
[92]: [d, d, c]
[93]: [d, d, d]
[94]: [d, d, e]
[95]: [d, e, a]
[96]: [d, e, b]
[97]: [d, e, c]
[98]: [d, e, d]
[99]: [d, e, e]
[100]: [e, a, a]
[101]: [e, a, b]
[102]: [e, a, c]
[103]: [e, a, d]
[104]: [e, a, e]
[105]: [e, b, a]
[106]: [e, b, b]
[107]: [e, b, c]
[108]: [e, b, d]
[109]: [e, b, e]
[110]: [e, c, a]
[111]: [e, c, b]
[112]: [e, c, c]
[113]: [e, c, d]
[114]: [e, c, e]
[115]: [e, d, a]
[116]: [e, d, b]
[117]: [e, d, c]
[118]: [e, d, d]
[119]: [e, d, e]
[120]: [e, e, a]
[121]: [e, e, b]
[122]: [e, e, c]
[123]: [e, e, d]
[124]: [e, e, e]
```

### Subsets

A *subset* (or combination of unspecified length) is a selection of items for
which order is *not* important, items are *not* replaced and the number of
items is not specified.

The `Subsets` class "contains" all subsets of a set of items.

**Example:**

```dart
final bagOfItems = characters('abcde'), subsets = Subsets(bagOfItems);
for (final (i, subset) in subsets().indexed) {
  print('[$i]: $subset');
}
```

```text
[0]: []
[1]: [a]
[2]: [b]
[3]: [a, b]
[4]: [c]
[5]: [a, c]
[6]: [b, c]
[7]: [a, b, c]
[8]: [d]
[9]: [a, d]
[10]: [b, d]
[11]: [a, b, d]
[12]: [c, d]
[13]: [a, c, d]
[14]: [b, c, d]
[15]: [a, b, c, d]
[16]: [e]
[17]: [a, e]
[18]: [b, e]
[19]: [a, b, e]
[20]: [c, e]
[21]: [a, c, e]
[22]: [b, c, e]
[23]: [a, b, c, e]
[24]: [d, e]
[25]: [a, d, e]
[26]: [b, d, e]
[27]: [a, b, d, e]
[28]: [c, d, e]
[29]: [a, c, d, e]
[30]: [b, c, d, e]
[31]: [a, b, c, d, e]
```

### Compounds

A *compound* (or permutation of unspecified length) is a selection of items for
which order *is* important, items are *not* replaced and the number of items is
not specified.

The `Compounds` class "contains" all compounds of a set of items.

**Example:**

```dart
final bagOfItems = characters('abcde'), compounds = Compounds(bagOfItems);
for (final (i, compound) in compounds().indexed) {
  print('[$i]: $compound');
}
```

```text
[0]: []
[1]: [a]
[2]: [b]
[3]: [c]
[4]: [d]
[5]: [e]
[6]: [a, b]
[7]: [b, a]
[8]: [a, c]
[9]: [c, a]
[10]: [a, d]
[11]: [d, a]
[12]: [a, e]
[13]: [e, a]
[14]: [b, c]
[15]: [c, b]
[16]: [b, d]
[17]: [d, b]
[18]: [b, e]
[19]: [e, b]
[20]: [c, d]
[21]: [d, c]
[22]: [c, e]
[23]: [e, c]
[24]: [d, e]
[25]: [e, d]
[26]: [a, b, c]
[27]: [a, c, b]
[28]: [c, a, b]
[29]: [c, b, a]
[30]: [b, c, a]
[31]: [b, a, c]
[32]: [a, b, d]
[33]: [a, d, b]
[34]: [d, a, b]
[35]: [d, b, a]
[36]: [b, d, a]
[37]: [b, a, d]
[38]: [a, b, e]
[39]: [a, e, b]
[40]: [e, a, b]
[41]: [e, b, a]
[42]: [b, e, a]
[43]: [b, a, e]
[44]: [a, c, d]
[45]: [a, d, c]
[46]: [d, a, c]
[47]: [d, c, a]
[48]: [c, d, a]
[49]: [c, a, d]
[50]: [a, c, e]
[51]: [a, e, c]
[52]: [e, a, c]
[53]: [e, c, a]
[54]: [c, e, a]
[55]: [c, a, e]
[56]: [a, d, e]
[57]: [a, e, d]
[58]: [e, a, d]
[59]: [e, d, a]
[60]: [d, e, a]
[61]: [d, a, e]
[62]: [b, c, d]
[63]: [b, d, c]
[64]: [d, b, c]
[65]: [d, c, b]
[66]: [c, d, b]
[67]: [c, b, d]
[68]: [b, c, e]
[69]: [b, e, c]
[70]: [e, b, c]
[71]: [e, c, b]
[72]: [c, e, b]
[73]: [c, b, e]
[74]: [b, d, e]
[75]: [b, e, d]
[76]: [e, b, d]
[77]: [e, d, b]
[78]: [d, e, b]
[79]: [d, b, e]
[80]: [c, d, e]
[81]: [c, e, d]
[82]: [e, c, d]
[83]: [e, d, c]
[84]: [d, e, c]
[85]: [d, c, e]
[86]: [a, b, c, d]
[87]: [a, b, d, c]
[88]: [a, d, b, c]
[89]: [d, a, b, c]
[90]: [d, a, c, b]
[91]: [a, d, c, b]
[92]: [a, c, d, b]
[93]: [a, c, b, d]
[94]: [c, a, b, d]
[95]: [c, a, d, b]
[96]: [c, d, a, b]
[97]: [d, c, a, b]
[98]: [d, c, b, a]
[99]: [c, d, b, a]
[100]: [c, b, d, a]
[101]: [c, b, a, d]
[102]: [b, c, a, d]
[103]: [b, c, d, a]
[104]: [b, d, c, a]
[105]: [d, b, c, a]
[106]: [d, b, a, c]
[107]: [b, d, a, c]
[108]: [b, a, d, c]
[109]: [b, a, c, d]
[110]: [a, b, c, e]
[111]: [a, b, e, c]
[112]: [a, e, b, c]
[113]: [e, a, b, c]
[114]: [e, a, c, b]
[115]: [a, e, c, b]
[116]: [a, c, e, b]
[117]: [a, c, b, e]
[118]: [c, a, b, e]
[119]: [c, a, e, b]
[120]: [c, e, a, b]
[121]: [e, c, a, b]
[122]: [e, c, b, a]
[123]: [c, e, b, a]
[124]: [c, b, e, a]
[125]: [c, b, a, e]
[126]: [b, c, a, e]
[127]: [b, c, e, a]
[128]: [b, e, c, a]
[129]: [e, b, c, a]
[130]: [e, b, a, c]
[131]: [b, e, a, c]
[132]: [b, a, e, c]
[133]: [b, a, c, e]
[134]: [a, b, d, e]
[135]: [a, b, e, d]
[136]: [a, e, b, d]
[137]: [e, a, b, d]
[138]: [e, a, d, b]
[139]: [a, e, d, b]
[140]: [a, d, e, b]
[141]: [a, d, b, e]
[142]: [d, a, b, e]
[143]: [d, a, e, b]
[144]: [d, e, a, b]
[145]: [e, d, a, b]
[146]: [e, d, b, a]
[147]: [d, e, b, a]
[148]: [d, b, e, a]
[149]: [d, b, a, e]
[150]: [b, d, a, e]
[151]: [b, d, e, a]
[152]: [b, e, d, a]
[153]: [e, b, d, a]
[154]: [e, b, a, d]
[155]: [b, e, a, d]
[156]: [b, a, e, d]
[157]: [b, a, d, e]
[158]: [a, c, d, e]
[159]: [a, c, e, d]
[160]: [a, e, c, d]
[161]: [e, a, c, d]
[162]: [e, a, d, c]
[163]: [a, e, d, c]
[164]: [a, d, e, c]
[165]: [a, d, c, e]
[166]: [d, a, c, e]
[167]: [d, a, e, c]
[168]: [d, e, a, c]
[169]: [e, d, a, c]
[170]: [e, d, c, a]
[171]: [d, e, c, a]
[172]: [d, c, e, a]
[173]: [d, c, a, e]
[174]: [c, d, a, e]
[175]: [c, d, e, a]
[176]: [c, e, d, a]
[177]: [e, c, d, a]
[178]: [e, c, a, d]
[179]: [c, e, a, d]
[180]: [c, a, e, d]
[181]: [c, a, d, e]
[182]: [b, c, d, e]
[183]: [b, c, e, d]
[184]: [b, e, c, d]
[185]: [e, b, c, d]
[186]: [e, b, d, c]
[187]: [b, e, d, c]
[188]: [b, d, e, c]
[189]: [b, d, c, e]
[190]: [d, b, c, e]
[191]: [d, b, e, c]
[192]: [d, e, b, c]
[193]: [e, d, b, c]
[194]: [e, d, c, b]
[195]: [d, e, c, b]
[196]: [d, c, e, b]
[197]: [d, c, b, e]
[198]: [c, d, b, e]
[199]: [c, d, e, b]
[200]: [c, e, d, b]
[201]: [e, c, d, b]
[202]: [e, c, b, d]
[203]: [c, e, b, d]
[204]: [c, b, e, d]
[205]: [c, b, d, e]
[206]: [a, b, c, d, e]
[207]: [a, b, c, e, d]
[208]: [a, b, e, c, d]
[209]: [a, e, b, c, d]
[210]: [e, a, b, c, d]
[211]: [e, a, b, d, c]
[212]: [a, e, b, d, c]
[213]: [a, b, e, d, c]
[214]: [a, b, d, e, c]
[215]: [a, b, d, c, e]
[216]: [a, d, b, c, e]
[217]: [a, d, b, e, c]
[218]: [a, d, e, b, c]
[219]: [a, e, d, b, c]
[220]: [e, a, d, b, c]
[221]: [e, d, a, b, c]
[222]: [d, e, a, b, c]
[223]: [d, a, e, b, c]
[224]: [d, a, b, e, c]
[225]: [d, a, b, c, e]
[226]: [d, a, c, b, e]
[227]: [d, a, c, e, b]
[228]: [d, a, e, c, b]
[229]: [d, e, a, c, b]
[230]: [e, d, a, c, b]
[231]: [e, a, d, c, b]
[232]: [a, e, d, c, b]
[233]: [a, d, e, c, b]
[234]: [a, d, c, e, b]
[235]: [a, d, c, b, e]
[236]: [a, c, d, b, e]
[237]: [a, c, d, e, b]
[238]: [a, c, e, d, b]
[239]: [a, e, c, d, b]
[240]: [e, a, c, d, b]
[241]: [e, a, c, b, d]
[242]: [a, e, c, b, d]
[243]: [a, c, e, b, d]
[244]: [a, c, b, e, d]
[245]: [a, c, b, d, e]
[246]: [c, a, b, d, e]
[247]: [c, a, b, e, d]
[248]: [c, a, e, b, d]
[249]: [c, e, a, b, d]
[250]: [e, c, a, b, d]
[251]: [e, c, a, d, b]
[252]: [c, e, a, d, b]
[253]: [c, a, e, d, b]
[254]: [c, a, d, e, b]
[255]: [c, a, d, b, e]
[256]: [c, d, a, b, e]
[257]: [c, d, a, e, b]
[258]: [c, d, e, a, b]
[259]: [c, e, d, a, b]
[260]: [e, c, d, a, b]
[261]: [e, d, c, a, b]
[262]: [d, e, c, a, b]
[263]: [d, c, e, a, b]
[264]: [d, c, a, e, b]
[265]: [d, c, a, b, e]
[266]: [d, c, b, a, e]
[267]: [d, c, b, e, a]
[268]: [d, c, e, b, a]
[269]: [d, e, c, b, a]
[270]: [e, d, c, b, a]
[271]: [e, c, d, b, a]
[272]: [c, e, d, b, a]
[273]: [c, d, e, b, a]
[274]: [c, d, b, e, a]
[275]: [c, d, b, a, e]
[276]: [c, b, d, a, e]
[277]: [c, b, d, e, a]
[278]: [c, b, e, d, a]
[279]: [c, e, b, d, a]
[280]: [e, c, b, d, a]
[281]: [e, c, b, a, d]
[282]: [c, e, b, a, d]
[283]: [c, b, e, a, d]
[284]: [c, b, a, e, d]
[285]: [c, b, a, d, e]
[286]: [b, c, a, d, e]
[287]: [b, c, a, e, d]
[288]: [b, c, e, a, d]
[289]: [b, e, c, a, d]
[290]: [e, b, c, a, d]
[291]: [e, b, c, d, a]
[292]: [b, e, c, d, a]
[293]: [b, c, e, d, a]
[294]: [b, c, d, e, a]
[295]: [b, c, d, a, e]
[296]: [b, d, c, a, e]
[297]: [b, d, c, e, a]
[298]: [b, d, e, c, a]
[299]: [b, e, d, c, a]
[300]: [e, b, d, c, a]
[301]: [e, d, b, c, a]
[302]: [d, e, b, c, a]
[303]: [d, b, e, c, a]
[304]: [d, b, c, e, a]
[305]: [d, b, c, a, e]
[306]: [d, b, a, c, e]
[307]: [d, b, a, e, c]
[308]: [d, b, e, a, c]
[309]: [d, e, b, a, c]
[310]: [e, d, b, a, c]
[311]: [e, b, d, a, c]
[312]: [b, e, d, a, c]
[313]: [b, d, e, a, c]
[314]: [b, d, a, e, c]
[315]: [b, d, a, c, e]
[316]: [b, a, d, c, e]
[317]: [b, a, d, e, c]
[318]: [b, a, e, d, c]
[319]: [b, e, a, d, c]
[320]: [e, b, a, d, c]
[321]: [e, b, a, c, d]
[322]: [b, e, a, c, d]
[323]: [b, a, e, c, d]
[324]: [b, a, c, e, d]
[325]: [b, a, c, d, e]
```

## Large indices

Arrangement numbers often grow very quickly. For example, consider the number
of 10-permutations of the letters of the alphabet:

**Example:**

```dart
final largeBagOfItems = characters('abcdefghijklmnopqrstuvwxyz'),
  permutations = Permutations(10, largeBagOfItems);
print(permutations);
```

```text
Pseudo-list containing all 19275223968000 10-permutations of items from [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z].
```

Wow! That's a lot of permutations! Don't iterate over them all!

Notice that the word `algorithms` is a 10-permutation of the letters of the
alphabet. What is the index of this permutation in our list of permutations?

**Example:**

```dart
final largeBagOfItems = characters('abcdefghijklmnopqrstuvwxyz'),
    permutations = Permutations(10, largeBagOfItems),
    permutationOfInterest = characters('algorithms'),
    index = permutations.indexOf(permutationOfInterest);
print('The index of $permutationOfInterest is $index.');
print('permutations[$index]: ${permutations[index]}');

```

```text
The index of [a, l, g, o, r, i, t, h, m, s] is 6831894769563.
permutations[6831894769563]: [a, l, g, o, r, i, t, h, m, s]
```

Wow! That's almost seven trillion! Luckily we didn't need to perform that
search using brute force!

Since we sometimes can be working with indices so large they cannot be
represented using a 64 bit `int`, indexing and length are implemented using `BigInt`.

**Example:**

```dart
final largeBagOfItems = characters('abcdefghijklmnopqrstuvwxyz'),
    compounds = Compounds(largeBagOfItems);
print('There are ${compounds.length} compounds of these letters!');
BigInt lastCompoundIndex = compounds.length - BigInt.one;
print('The last compound is ${compounds[lastCompoundIndex]}.');

```

```text
There are 1096259850353149530222034277 compounds of these letters!
The last compound is [b, a, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z].
```

Unless you're immortal, don't use `compounds().last` to access the last compound in the previous example!

## Syntactic sugar

### Lists

`trotter` provides extensions that allow us to generate combinatorics
arrangements directly from lists...

**Example:**

```dart
final subsets = [1, 2, 3, 4, 5].subsets();
for (final subset in subsets()) {
  print(subset);
}
```

```text
[]
[1]
[2]
[1, 2]
[3]
[1, 3]
[2, 3]
[1, 2, 3]
[4]
[1, 4]
[2, 4]
[1, 2, 4]
[3, 4]
[1, 3, 4]
[2, 3, 4]
[1, 2, 3, 4]
[5]
[1, 5]
[2, 5]
[1, 2, 5]
[3, 5]
[1, 3, 5]
[2, 3, 5]
[1, 2, 3, 5]
[4, 5]
[1, 4, 5]
[2, 4, 5]
[1, 2, 4, 5]
[3, 4, 5]
[1, 3, 4, 5]
[2, 3, 4, 5]
[1, 2, 3, 4, 5]
```

```dart
final combinations = [1, 2, 3, 4, 5].combinations(3);
for (final combination in combinations()) {
  print(combination);
}
```

```text
[1, 2, 3]
[1, 2, 4]
[1, 2, 5]
[1, 3, 4]
[1, 3, 5]
[1, 4, 5]
[2, 3, 4]
[2, 3, 5]
[2, 4, 5]
[3, 4, 5]
```

### Strings

... and strings, in which case it assumes we mean arrangements of the
characters in the string.

**Example:**

```dart
final subsets = 'abcde'.subsets();
for (final subset in subsets()) {
  print(subset);
}
```

```text
[]
[a]
[b]
[a, b]
[c]
[a, c]
[b, c]
[a, b, c]
[d]
[a, d]
[b, d]
[a, b, d]
[c, d]
[a, c, d]
[b, c, d]
[a, b, c, d]
[e]
[a, e]
[b, e]
[a, b, e]
[c, e]
[a, c, e]
[b, c, e]
[a, b, c, e]
[d, e]
[a, d, e]
[b, d, e]
[a, b, d, e]
[c, d, e]
[a, c, d, e]
[b, c, d, e]
[a, b, c, d, e]
```

```dart
final combinations = 'abcde'.combinations(3);
for (final combination in combinations()) {
  print(combination);
}
```

```text
[a, b, c]
[a, b, d]
[a, b, e]
[a, c, d]
[a, c, e]
[a, d, e]
[b, c, d]
[b, c, e]
[b, d, e]
[c, d, e]
```

---

`trotter` was written by [Richard Nathan Ambler](mailto:rambler@wya.top).

Thanks for your interest in this library. Please file any bugs, issues
and suggestions [here](https://github.com/ram6ler/dart-trotter/issues).
