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
    var exprs = [];
    var argExpected =
        false; // Flag that is set after encountering a comma (to detect cases like func(arg, ))
    exprs = consumeStackUntil(iter, RegExp('^[(]\$'), RegExp('^[)]\$'));
    checkNext(iter, RegExp('^[)]\$'), 'Expected ")"');
    final exprIter = exprs.iterator;
    while (exprIter.moveNext()) {
      final tokenBuff = consumeUntil(iter, RegExp("^[,]\$"));
      if (tokenBuff.isEmpty && exprIter.moveNext() ||
          tokenBuff.isEmpty && argExpected) {
        throw SyntaxError(exprIter.current, 'Expected an argument');
      } else if (!tokenBuff.isEmpty) {
        exprs.add(Expression.parse(tokenBuff));
      }
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
