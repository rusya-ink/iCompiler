import 'dart:async';
import 'dart:io';

class Token {
  String value;
  int start;
  int end;
  int type = null;
  bool isFaulty;

  Token(this.value, this.start, this.end, {this.isFaulty}) {}
}

RegExp langTokenPtn = new RegExp(
  "([a-zA-Z_]\\w*|[0-9.]|[:;(),\\[\\]=.<>\/*%+\n-])",
  multiLine: true,
);

Future<List<Token>> lexer(path) async {
  var tokens = <Token>[];
  var fileContents = await new File(path).readAsString();
  var matches = langTokenPtn.allMatches(fileContents);
  var previousMatch = null;

  for (var match in matches) {
    if (previousMatch != null && previousMatch.end != match.start) {
      tokens.add(new Token(
        fileContents.substring(previousMatch.end, match.start),
        previousMatch.end,
        match.start,
        isFaulty: true,
      ));
    }

    tokens.add(new Token(
      match.group(1),
      match.start,
      match.end,
      isFaulty: false,
    ));

    previousMatch = match;
  }

  return tokens;
}

void main() async {
  List<Token> tokensList = await lexer('./tests/bubble_sort.isc');
  tokensList.forEach((element) {
    print(
        'Token "${element.value == '\n' ? '\\n' : element.value}", ${element.start}–${element.end}');
  });
}
