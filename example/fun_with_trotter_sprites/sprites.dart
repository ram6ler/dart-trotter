import 'dart:js_interop';

import 'package:web/web.dart' as web;
import 'package:trotter/trotter.dart';

class Arrangement {
  Arrangement(this.combinatorics, this.html);
  Combinatorics<int> combinatorics;
  String html;
}

void main() {
  final sprites = web.HTMLImageElement()..src = 'images/sprites.png';

  void draw(Arrangement arrangement) {
    final combinatorics = arrangement.combinatorics,
        html = arrangement.html,
        n = combinatorics.length;

    web.HTMLCanvasElement illustrateFrom(BigInt from) {
      final base = 70,
          width = 5 * base + 23,
          height = ((n - from).toInt() * base),
          pPic = web.HTMLCanvasElement()
            ..width = width
            ..height = height;
      ;

      for (var row = from; row < n; row += BigInt.one) {
        for (var col = 0; col < combinatorics[row].length; col++) {
          pPic.context2D.drawImage(
              sprites,
              combinatorics[row][col] * 100,
              0,
              100,
              100,
              col * ((width - 25) ~/ 5) + 25,
              (row - from).toInt() * (height ~/ (n - from).toInt()),
              width ~/ 5,
              height ~/ (n - from).toInt());

          pPic.context2D.fillText('[$row]', 5,
              (row - from).toInt() * (height ~/ (n - from).toInt()) + 15);
        }
      }

      return pPic;
    }

    web.document.body!.appendChild(web.HTMLDivElement()
      ..className = 'cell'
      ..appendChild(web.HTMLDivElement()
        ..className = 'legend'
        ..innerHTML = html.toJS)
      ..appendChild(web.HTMLDivElement()
        ..className = 'illustration'
        ..appendChild(illustrateFrom(BigInt.zero))));
  }

  sprites.onLoad.listen((_) {
    final frames = [0, 1, 2, 3, 4];

    [
      Arrangement(Permutations(3, frames), '''
      <h2>3-Permutations</h2>
      <p>
        If we take three of the five trotters, <em>without replacement</em>,
        and arrange them so that <em>order is important</em>, then the possible
        arrangements are:
      </p>
      '''),
      Arrangement(Combinations(3, frames), '''
      <h2>3-Combinations</h2>
      <p>
        If we take three of the five trotters, <em>without replacement</em>,
        and arrange them so that <em>order is not important</em>, then the
        possible arrangements are:
      </p>
      '''),
      Arrangement(Amalgams(3, frames), '''
      <h2>3-Amalgams</h2>
      <p>
        If we take three of the five trotters, <em>with replacement</em>,
        and arrange them so that <em>order is important</em>, then the
        possible arrangements are:
      </p>
      '''),
      Arrangement(Compositions(3, frames), '''
      <h2>3-Compositions</h2>
      <p>
        If we take three of the five trotters, <em>with replacement</em>,
        and arrange them so that <em>order is not important</em>, then the
        possible arrangements are:
      </p>
      '''),
      Arrangement(Subsets(frames), '''
      <h2>Subsets</h2>
      <p>
        If we take <em>any number</em> of the five trotters, <em>without
        replacement</em>, and arrange them so that <em>order is not 
        important</em>, then the possible arrangements are:
      </p>
      '''),
      Arrangement(Compounds(frames), '''
      <h2>Compounds</h2>
      <p>
        If we take <em>any number</em> of the five trotters, <em>without
        replacement</em>, and arrange them so that <em>order is 
        important</em>, then the possible arrangements are:
      </p>
      ''')
    ].forEach(draw);
  });
}
