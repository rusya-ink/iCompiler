import 'node.dart';
import '../lexer.dart';

/// A type of a variable.
abstract class VarType implements Node {
  factory VarType.parse(Iterable<Token> tokens) {

  }
}
