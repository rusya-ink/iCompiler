import 'dart:async';
import 'dart:io';

void main() {
  void lexer(path) {
    String fileString;
    new File(path).readAsString().then((String contents) {
      fileString = contents;
      RegExp exp = new RegExp(
          "([a-zA-Z_]\\w*|[0-9.]|[:;(),\\[\\]=.<>\/*%+\n-])",
          multiLine: true);
      Iterable<RegExpMatch> matches = exp.allMatches(fileString);
      matches.forEach((element) {
        print(fileString.substring(element.start, element.end));
      });
    });
  }

  lexer('./tests/bubble_sort.isc');
}
