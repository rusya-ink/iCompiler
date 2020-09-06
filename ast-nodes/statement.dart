import 'node.dart';
import '../lexer.dart';

/// An abstract statement.
abstract class Statement implements Node {
  factory Statement.parse(Iterable<Token> tokens) {

  }
}
