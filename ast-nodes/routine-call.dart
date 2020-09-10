import '../iterator-utils.dart';
import '../lexer.dart';
import '../syntax-error.dart';
import 'primary.dart';
import 'expression.dart';
import '../print-utils.dart';

/// A routine call by [name], passing zero or more [arguments].
class RoutineCall implements Primary {
  String name;
  List<Expression> arguments;

  RoutineCall(this.name, this.arguments);

  factory RoutineCall.parse(Iterable<Token> tokens) {
    final iter = tokens.iterator;
    checkNext(iter, RegExp('[a-zA-Z_]\w*\$'), "Expected identifier");
    final tempName = iter.current.value;
    checkNext(iter, RegExp('^[(]\$'), 'Expected "("');
    var exprs = []; // Final array of parsed Expressions
    var expBuffer = []; // Array of Tokens that are located between main braces
    var argExpected =
        false; // Flag that is set after encountering a comma (to detect missing arguments)
    String
        lastToken; // Store the last Token in the expBuffer in order to prevent trailing comma
    expBuffer = consumeStackUntil(iter, RegExp('^[(]\$'), RegExp('^[)]\$'));
    if (iter.current?.value != ')') {
      throw SyntaxError(null, 'Expected ")"');
    }
    final exprIter = expBuffer.iterator;
    while (exprIter.moveNext()) {
      final tokenBuff = consumeUntil(exprIter, RegExp("^[,]\$"));
      // Check for the case with missing argument
      if (tokenBuff.isEmpty && argExpected) {
        throw SyntaxError(null, 'Expected an argument');
      } else if (!tokenBuff.isEmpty) {
        exprs.add(Expression.parse(tokenBuff));
      }
      if (exprIter.current?.value == ',') {
        argExpected = true;
      }
      lastToken = exprIter.current?.value;
    }
    // Check for the trailing comma
    if (lastToken == ',') {
      throw SyntaxError(null, 'Expected an argument');
    }
    return RoutineCall(tempName, exprs.isEmpty ? null : exprs);
  }

  String toString({int depth = 0, String prefix = ''}) {
    return (drawDepth('${prefix}RoutineCall("${this.name}")', depth) +
        drawDepth('arguments:', depth + 1) +
        this
            .arguments
            .map((node) => node?.toString(depth: depth + 2) ?? '')
            .join(''));
  }
}
