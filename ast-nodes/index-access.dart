import '../iterator-utils.dart';
import '../lexer.dart';
import '../syntax-error.dart';
import 'modifiable-primary.dart';
import 'expression.dart';
import '../print-utils.dart';

/// An array element access by [index] – for either reading or writing.
///
/// Chained element access requires several [IndexAccess] objects:
/// ```dart
/// // "a[0][1]" is represented with
/// IndexAccess(
///   IntegerLiteral(1),
///   IndexAccess(
///     IntegerLiteral(0),
///     Variable("a"),
///   ),
/// )
/// ```
class IndexAccess implements ModifiablePrimary {
  Expression index;
  ModifiablePrimary object;

  IndexAccess(this.index, this.object);

  factory IndexAccess.parse(Iterable<Token> tokens) {
    final tokenList = tokens.toList();
    final len = tokenList.length; // Just as a shorthand
    if (tokenList[len - 1].value != ']') // Parsing from the end of line
      throw SyntaxError(tokenList[len - 1], 'Expected "]"');
    var i = 2;
    List<Token> exprBuff = [];
    while (tokenList[len - i].value != '[' ||
        tokenList[len - i].value != ']' ||
        i <= len) {
      exprBuff.add(tokenList[len - i]);
      i++;
    }
    if (exprBuff.isEmpty)
      throw SyntaxError(tokenList[len - i], "Specify the index value");
    if (tokenList[len - i].value == ']' || i > len)
      throw SyntaxError(tokenList[0], 'Expected "["');
    if (tokenList[len - i - 1].value == ']') {
      return IndexAccess(Expression.parse(exprBuff.reversed.toList()),
          IndexAccess.parse(tokenList.sublist(0, len - i)));
    } else {
      return IndexAccess(Expression.parse(exprBuff),
          ModifiablePrimary.parse(tokenList.sublist(0, len - i)));
    }
  }

  String toString({int depth = 0, String prefix = ''}) {
    return (drawDepth('${prefix}IndexAccess', depth) +
        (this.index?.toString(depth: depth + 1, prefix: 'index: ') ?? '') +
        (this.object?.toString(depth: depth + 1, prefix: 'object: ') ?? ''));
  }
}
