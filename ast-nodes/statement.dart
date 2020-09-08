import '../syntax-error.dart';
import 'node.dart';
import '../lexer.dart';
import 'while-loop.dart';
import 'for-loop.dart';
import 'if-statement.dart';
import 'routine-call.dart';
import 'assignment.dart';

/// An abstract statement.
abstract class Statement implements Node {
  factory Statement.parse(Iterable<Token> tokens) {
    if (tokens.isEmpty) {
      throw SyntaxError(tokens?.first, 'Expected a statement');
    }

    if (tokens.first.value == 'while')
      return WhileLoop.parse(tokens);
    else if (tokens.first.value == 'for')
      return ForLoop.parse(tokens);
    else if (tokens.first.value == 'if') return IfStatement.parse(tokens);
    var iter = tokens.iterator;
    iter.moveNext();
    if (iter.current.value == '(')
      return RoutineCall.parse(tokens);
    else if (iter.current.value == ':') {
      iter.moveNext();
      if (iter.current.value == '=')
        return Assignment.parse(tokens);
      else
        throw SyntaxError(
            iter.current, 'Expected "=", found "${iter.current.value}"');
    } else
      throw SyntaxError(tokens.first, 'Expected a statement');
  }
}
