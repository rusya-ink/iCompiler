import 'unary-relation.dart';
import '../literal.dart';
import '../real-literal.dart';
import '../integer-literal.dart';
import '../primary.dart';
import '../expression.dart';
import '../../types/var-type.dart';

/// Numeric unary plus operator.
///
/// Casts the operand to a numeric type and returns a numeric value.
class PosOperator extends UnaryRelation implements Primary {
  VarType resultType;
  bool isConstant;

  PosOperator(Expression operand) : super(operand);

  Literal evaluate() {
    var literal = this.operand.evaluate();
    if (literal is RealLiteral) {
      return RealLiteral(literal.realValue);
    } else {
      return IntegerLiteral(literal.integerValue);
    }
  }

  void checkSemantics() {
    // TODO: implement
  }
}
