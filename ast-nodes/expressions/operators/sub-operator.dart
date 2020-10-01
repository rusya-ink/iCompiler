import 'binary-relation.dart';
import '../literal.dart';
import '../real-literal.dart';
import '../integer-literal.dart';
import '../sum.dart';
import '../expression.dart';
import '../../types/var-type.dart';

/// Numeric subtraction operator.
///
/// Casts both operands to a numeric type and returns a numeric value.
class SubOperator extends BinaryRelation implements Sum {
  VarType resultType;
  bool isConstant;

  SubOperator(Expression leftOperand, Expression rightOperand)
      : super(leftOperand, rightOperand);

  Literal evaluate() {
    var leftLiteral = this.leftOperand.evaluate();
    var rightLiteral = this.rightOperand.evaluate();

    if (leftLiteral is RealLiteral || rightLiteral is RealLiteral) {
      return RealLiteral(leftLiteral.realValue - rightLiteral.realValue);
    } else {
      return IntegerLiteral(
          leftLiteral.integerValue - rightLiteral.integerValue);
    }
  }

  void checkSemantics() {
    // TODO: implement
  }
}
