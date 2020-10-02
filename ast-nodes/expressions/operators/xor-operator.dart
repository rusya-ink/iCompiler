import 'binary-relation.dart';
import '../literal.dart';
import '../boolean-literal.dart';
import '../expression.dart';
import '../../types/boolean-type.dart';
import '../../types/var-type.dart';

/// Logical XOR operator.
///
/// Casts both operands to `boolean` and returns a `boolean` value.
class XorOperator extends BinaryRelation {
  VarType resultType = BooleanType();
  bool isConstant;

  XorOperator(Expression leftOperand, Expression rightOperand)
      : super(leftOperand, rightOperand);

  Literal evaluate() {
    Literal leftLiteral = this.leftOperand.evaluate();
    Literal rightLiteral = this.rightOperand.evaluate();
    return BooleanLiteral(leftLiteral.booleanValue ^ rightLiteral.booleanValue);
  }

  void checkSemantics() {
    // TODO: implement
  }
}
