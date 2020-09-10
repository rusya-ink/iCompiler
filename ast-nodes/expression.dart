import 'boolean-literal.dart';
import 'index.dart';
import 'statement.dart';
import 'and-operator.dart';
import '../lexer.dart';
import '../iterator-utils.dart';
import '../syntax-error.dart';

/// An abstract expression that returns a value.
abstract class Expression implements Statement {
  factory Expression.parse(Iterable<Token> tokens) {
    bool notFlag = false;
    String operand;
    var iterator = tokens.iterator;

    if (tokens.isEmpty) {
      return AndOperator(BooleanLiteral(!notFlag), Comparison.parse([]));
    }
    notFlag = tokens.first.value == "not";
    if (notFlag) {
      checkNext(iterator, RegExp("\^not\$"), "internal error");
    }
    if (!iterator.moveNext()) {
      return AndOperator(BooleanLiteral(!notFlag), Comparison.parse([]));
    }
    final comparisonBuffer = consumeUntil(iterator, RegExp("\^(xor|or|and)\$"));

    // Store operand
    String opType = iterator.current.value;
    if (opType == "and" || opType == "or" || opType == "xor") {
      operand = opType;
    } else {
      return AndOperator(
          BooleanLiteral(!notFlag), Comparison.parse(comparisonBuffer));
    }
    var expressionBuffer;
    if (!iterator.moveNext()) {
      expressionBuffer = [];
    } else {
      expressionBuffer = consumeFull(iterator);
    }

    // Evaluate expression
    var expression;
    if (operand == "or") {
      expression = OrOperator(Comparison.parse(comparisonBuffer),
          Expression.parse(expressionBuffer));
    } else if (operand == "xor") {
      expression = XorOperator(Comparison.parse(comparisonBuffer),
          Expression.parse(expressionBuffer));
    } else if (operand == "and") {
      expression = AndOperator(Comparison.parse(comparisonBuffer),
          Expression.parse(expressionBuffer));
    }

    checkNoMore(iterator);
    return AndOperator(BooleanLiteral(!notFlag), expression);
  }

  factory Expression.parsePrioritized(Iterable<Token> tokens) {
    var iterator = tokens.iterator;

    if (iterator.moveNext()) {
      // distinguish between Expression and Primary
      if (iterator.current.value == "(" && iterator.moveNext()) {
        final expressionBuffer =
            consumeUntil(iterator, RegExp("\^" + RegExp.escape(")") + "\$"));
        if (iterator.current.value != ")") {
          throw SyntaxError(iterator.current, "')' expected");
        }

        checkNoMore(iterator);
        return AndOperator(
            BooleanLiteral(true), Expression.parse(expressionBuffer));
      } else if (iterator.current != "(") {
        final primaryBuffer = consumeFull(iterator);
        return AndOperator(BooleanLiteral(true), Primary.parse(primaryBuffer));
      } else {
        throw SyntaxError(iterator.current, "')' expected");
      }
    } else {
      return AndOperator(BooleanLiteral(true), Primary.parse([]));
    }
  }
}
