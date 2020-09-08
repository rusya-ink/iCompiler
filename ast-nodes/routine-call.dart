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
    final tempName = tokens.first.value;
    final iter = tokens.iterator;
    iter.moveNext(); // Skip the identifier
    iter.moveNext(); // The opening bracket will always be there, cause it triggers this function to be run
    var exprs = [];
    var argExpected =
        false; // Flag that is set after encountering a comma (to detect cases like func(arg, ))
    if (!iter.moveNext()) throw SyntaxError(tokens.first, 'Expected ")"');
    do {
      final tokenBuff = consumeUntil(iter, RegExp("^[,)]\$"));
      if (tokenBuff.isEmpty && argExpected)
        throw SyntaxError(iter.current, 'Expected an argument');
      else if (!tokenBuff.isEmpty) exprs.add(Expression.parse(tokenBuff));
      if (iter?.current?.value == ')')
        return RoutineCall(tempName, exprs.isEmpty ? null : exprs);
      else if (iter?.current?.value == ',')
        argExpected = true;
      else
        throw SyntaxError(iter.current, 'Expected ")"');
    } while (iter.moveNext());
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
