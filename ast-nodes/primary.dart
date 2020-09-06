import 'product.dart';
import '../lexer.dart';

/// An abstract value.
abstract class Primary implements Product {
  factory Primary.parse(Iterable<Token> tokens) {

  }
}
