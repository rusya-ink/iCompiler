import 'comparison.dart';
import 'binary-relation.dart';
import 'expression.dart';
import 'boolean-type.dart';
import 'var-type.dart';

/// Numeric _greater than_ operator.
///
/// Casts both operands to a numeric type and returns a boolean value.
class GreaterOperator extends BinaryRelation implements Comparison {
  VarType resultType = BooleanType();
  bool isConstant;

  GreaterOperator(Expression leftOperand, Expression rightOperand)
    : super(leftOperand, rightOperand);
}
