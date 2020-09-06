import 'expression.dart';
import '../print-utils.dart';

/// An abstract unary relation with one [operand].
abstract class UnaryRelation implements Expression {
  Expression operand;

  UnaryRelation(this.operand);

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth(prefix + this.runtimeType.toString(), depth)
      + (this.operand?.toString(depth: depth + 1) ?? '')
    );
  }
}
