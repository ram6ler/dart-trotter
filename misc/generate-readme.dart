import "dart:io";

final backgroundCodeTemplate = """
import 'package:trotter/trotter.dart';

void main() {
  [CODE]
}
""";

Future<void> main(List<String> args) async {
  const spew = 0, code = 1;
  var mode = spew,
      codeCollector = StringBuffer(),
      fileCollector = StringBuffer();

  Future<void> populateFile(String inPath, String outPath) async {
    for (final line in await File(inPath).readAsLines()) {
      switch (mode) {
        case spew:
          if (line == "```dart") {
            mode = code;
          }
          fileCollector.writeln(line);
        case code:
          if (line == "```") {
            fileCollector
              ..writeln(codeCollector)
              ..writeln(line)
              ..writeln("\n")
              ..writeln("```text");
            await File("temp.dart").writeAsString(backgroundCodeTemplate
                .replaceAll("[CODE]", codeCollector.toString()));
            fileCollector
                .writeln((await Process.run("dart", ["temp.dart"])).stdout);
            await File("temp.dart").delete();
            ;
            fileCollector.writeln("$line\n");

            codeCollector.clear();
            mode = spew;
          } else {
            codeCollector.writeln(line);
          }
      }
    }
    await File(outPath).writeAsString(fileCollector.toString());
  }

  // Readme
  fileCollector.clear();
  await populateFile("misc/readme_template.md", "README.md");
}
