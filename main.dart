import 'dart:async';
import 'dart:io';

class Token {
  String value;
  int start;
  int end;
  int type = null;
  bool isFaulty;

  Token(String value, int start, int end, bool isFaulty) {
    this.value = value;
    this.start = start;
    this.end = end;
    this.isFaulty = isFaulty;
  }
}

void main() {
  List<Token> lexer(path) {
    String fileString;
    var tokens = [];
    new File(path).readAsString().then((String contents) {
      fileString = contents;
      RegExp exp = new RegExp(
          "([a-zA-Z_]\\w*|[0-9.]|[:;(),\\[\\]=.<>\/*%+\n-])",
          multiLine: true);
      var matches = exp.allMatches(fileString).toList();

      for (var i = 0; i < matches.length; i++) {
        if (i > 0) {
          //Get tokens "in between"
          if (matches[i].start - matches[i - 1].end > 0) {
            tokens.add(new Token(
                fileString.substring(matches[i - 1].end, matches[i].start),
                matches[i].start,
                matches[i - 1].end,
                true));
          }
        }
        //Get correct Tokens
        tokens.add(new Token(
            fileString.substring(matches[i].start, matches[i].end),
            matches[i].start,
            matches[i].end,
            false));
      }
      /** Function that says if the given string has any character distinct from the whitespace */
      bool containsOnlySpaces(String str) {
        var arr = str.codeUnits;
        for (var i = 0; i < arr.length; i++) {
          if (arr[i] != 32) {
            return false;
          }
        }
        return true;
      }

      for (var i = 0; i < tokens.length; i++) {
        // Remove spaces from token list
        if (tokens[i].isFaulty && containsOnlySpaces(tokens[i].value))
          tokens.removeAt(i);
      }
      return tokens;
    });
  }

  List<Token> tokensList = lexer('./tests/bubble_sort.isc');
  tokensList.forEach((element) {
    print(element.value);
  });
}
