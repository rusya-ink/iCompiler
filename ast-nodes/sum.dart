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
    List<Token> product1;
    // Check if our sum starts with a sign
    if (['+', '-'].contains(iter.current.value)) {
      product1.add(iter.current);
      iter.moveNext();
    }
    final productBuffer = consumeUntil(iter, RegExp('^[+-]\$'));
    if (productBuffer.isEmpty) {
      throw SyntaxError(tokens.first, 'Summond is expected');
    }
    product1 = product1..addAll(productBuffer);
    if (iter.current?.value == '+') {
      iter.moveNext();
      if (iter.current?.value == '-') {
        // If the second summond is negative, simplify to substracrtion
        iter.moveNext();
        return SubOperator(
            Product.parse(product1), Sum.parse(consumeFull(iter)));
      } else if (iter.current?.value == '+') {
        iter.moveNext();
      }
      return AddOperator(Product.parse(product1), Sum.parse(consumeFull(iter)));
    } else if (iter.current?.value == '-') {
      iter.moveNext();
      if (iter.current?.value == '-') {
        // If the second summond is negative, simplify to addition
        iter.moveNext();
        return AddOperator(
            Product.parse(product1), Sum.parse(consumeFull(iter)));
      } else if (iter.current?.value == '+') {
        iter.moveNext();
      }
      return SubOperator(Product.parse(product1), Sum.parse(consumeFull(iter)));
    } else {
      return Product.parse(product1);
    }
  }
}
