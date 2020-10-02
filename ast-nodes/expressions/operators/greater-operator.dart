import 'binary-relation.dart';
import '../literal.dart';
import '../real-literal.dart';
import '../boolean-literal.dart';
import '../comparison.dart';
import '../expression.dart';
import '../../types/boolean-type.dart';
import '../../types/var-type.dart';

/// Numeric _greater than_ operator.
///
/// Casts both operands to a numeric type and returns a boolean value.
class GreaterOperator extends BinaryRelation implements Comparison {
  VarType resultType = BooleanType();
  bool isConstant;

  GreaterOperator(Expression leftOperand, Expression rightOperand)
      : super(leftOperand, rightOperand);

  Literal evaluate() {
    var leftLiteral = this.leftOperand.evaluate();
    var rightLiteral = this.rightOperand.evaluate();

    if (leftLiteral is RealLiteral || rightLiteral is RealLiteral) {
      return BooleanLiteral(leftLiteral.realValue > rightLiteral.realValue);
    } else {
      return BooleanLiteral(
          leftLiteral.integerValue > rightLiteral.integerValue);
    }
  }

  void checkSemantics() {
    // TODO: implement
  }
}
