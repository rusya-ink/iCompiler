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
    List<Token> product;
    Token prevToken = null;
    while (iter.moveNext()) {
      if (['+', '-'].contains(iter.current.value) &&
          !['(', '%', '*', '/', null].contains(prevToken.value)) {
        break;
      }
      product.add(iter.current);
      prevToken = iter.current;
    }
    if (iter.current?.value == '+') {
      iter.moveNext();
      return AddOperator(
          Product.parse(product), Product.parse(consumeFull(iter)));
    } else if (iter.current?.value == '-') {
      iter.moveNext();
      return SubOperator(
          Product.parse(product), Product.parse(consumeFull(iter)));
    } else {
      return Product.parse(product);
    }
  }
}
