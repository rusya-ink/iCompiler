import 'binary-relation.dart';
import '../literal.dart';
import '../boolean-literal.dart';
import '../expression.dart';
import '../../types/boolean-type.dart';
import '../../types/var-type.dart';

/// Logical OR operator.
///
/// Casts both operands to `boolean` and returns a `boolean` value.
class OrOperator extends BinaryRelation {
  VarType resultType = BooleanType();
  bool isConstant;

  OrOperator(Expression leftOperand, Expression rightOperand)
      : super(leftOperand, rightOperand);

  Literal evaluate() {
    var leftLiteral = this.leftOperand.evaluate();
    var rightLiteral = this.rightOperand.evaluate();
    return BooleanLiteral(
        leftLiteral.booleanValue || rightLiteral.booleanValue);
  }

  void checkSemantics() {
    // TODO: implement
  }
}
