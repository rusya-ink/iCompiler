import 'expression.dart';
import '../lexer.dart';

/// An abstract comparison operator.
abstract class Comparison implements Expression {
  factory Comparison.parse(Iterable<Token> tokens) {

  }
}
