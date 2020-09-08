import '../iterator-utils.dart';
import '../syntax-error.dart';
import 'add-operator.dart';
import 'comparison.dart';
import '../lexer.dart';
import 'product.dart';
import 'sub-operator.dart';

/// An abstract summing operator.
abstract class Sum implements Comparison {
  factory Sum.parse(Iterable<Token> tokens) {
    final iter = tokens.iterator;
    iter.moveNext();
    final productBuffer = consumeUntil(iter, RegExp('^[+-]\$'));
    if (productBuffer.isEmpty)
      throw SyntaxError(tokens.first, 'Expected A Product');
    if (iter?.current?.value == '+') {
      iter.moveNext();
      return AddOperator(
          Product.parse(productBuffer), Sum.parse(consumeFull(iter)));
    } else if (iter?.current?.value == '-') {
      iter.moveNext();
      return SubOperator(
          Product.parse(productBuffer), Sum.parse(consumeFull(iter)));
    } else {
      return Product.parse(productBuffer);
    }
  }
}
