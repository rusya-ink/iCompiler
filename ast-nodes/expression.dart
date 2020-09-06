import 'statement.dart';
import 'and-operator.dart';
import '../lexer.dart';

/// An abstract expression that returns a value.
abstract class Expression implements Statement {
  factory Expression.parse(Iterable<Token> tokens) {
    // TODO: write the actual parser body
    return AndOperator(null, null);
  }

  factory Expression.parsePrioritized(Iterable<Token> tokens) {
    // TODO: write the actual parser body
    return AndOperator(null, null);
  }
}
