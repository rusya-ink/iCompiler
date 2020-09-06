import 'comparison.dart';
import '../lexer.dart';

/// An abstract summing operator.
abstract class Sum implements Comparison {
  factory Sum.parse(Iterable<Token> tokens) {

  }
}
