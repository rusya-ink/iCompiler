import 'binary-relation.dart';
import '../literal.dart';
import '../real-literal.dart';
import '../integer-literal.dart';
import '../boolean-literal.dart';
import '../comparison.dart';
import '../expression.dart';
import '../../types/boolean-type.dart';
import '../../types/var-type.dart';

/// Universal _not equal to_ operator.
///
/// Requires both operands to be convertible to the same type.
class NeqOperator extends BinaryRelation implements Comparison {
  VarType resultType = BooleanType();
  bool isConstant;

  NeqOperator(Expression leftOperand, Expression rightOperand)
      : super(leftOperand, rightOperand);

  Literal evaluate() {
    var leftLiteral = this.leftOperand.evaluate();
    var rightLiteral = this.rightOperand.evaluate();

    if (leftLiteral is RealLiteral || rightLiteral is RealLiteral) {
      return BooleanLiteral(leftLiteral.realValue != rightLiteral.realValue);
    } else if (leftLiteral is IntegerLiteral ||
        rightLiteral is IntegerLiteral) {
      return BooleanLiteral(
          leftLiteral.integerValue != rightLiteral.integerValue);
    } else {
      return BooleanLiteral(
          leftLiteral.booleanValue != rightLiteral.booleanValue);
    }
  }

  void checkSemantics() {
    // TODO: implement
  }
}
