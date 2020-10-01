import 'binary-relation.dart';
import '../literal.dart';
import '../real-literal.dart';
import '../integer-literal.dart';
import '../product.dart';
import '../expression.dart';
import '../../types/var-type.dart';

/// Numeric modulo operator.
///
/// Casts both operands to a numeric type and returns a numeric value.
class ModOperator extends BinaryRelation implements Product {
  VarType resultType;
  bool isConstant;

  ModOperator(Expression leftOperand, Expression rightOperand)
      : super(leftOperand, rightOperand);

  Literal evaluate() {
    var leftLiteral = this.leftOperand.evaluate();
    var rightLiteral = this.rightOperand.evaluate();

    if (leftLiteral is RealLiteral || rightLiteral is RealLiteral) {
      return RealLiteral(leftLiteral.realValue % rightLiteral.realValue);
    } else {
      return IntegerLiteral(
          leftLiteral.integerValue % rightLiteral.integerValue);
    }
  }

  void checkSemantics() {
    // TODO: implement
  }
}
