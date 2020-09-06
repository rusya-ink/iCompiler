import 'expression.dart';
import '../print-utils.dart';

/// An abstract binary relation with two operands.
abstract class BinaryRelation implements Expression {
  Expression leftOperand;
  Expression rightOperand;

  BinaryRelation(this.leftOperand, this.rightOperand);

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth(prefix + this.runtimeType.toString(), depth)
      + (this.leftOperand?.toString(depth: depth + 1, prefix: 'left operand: ') ?? '')
      + (this.rightOperand?.toString(depth: depth + 1, prefix: 'right operand: ') ?? '')
    );
  }
}
