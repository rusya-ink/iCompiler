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
    String operator;
    var iterator = tokens.iterator;

    if (tokens.isEmpty) {
      throw SyntaxError(iterator.current, "Empty token");
    }
    notFlag = tokens.first.value == "not";

    if (notFlag) {
      // 'not' expression
      iterator.moveNext(); // skip 'not' token
      if (!iterator.moveNext()) {
        throw SyntaxError(iterator.current, "Empty token");
      }
      final expression = Expression.parse(consumeFull(iterator));
      return NotOperator(expression);
    } else {
      // comparison [and/or/xor expression]
      if (!iterator.moveNext()) {
        throw SyntaxError(iterator.current, "Empty token");
      }
      final comparisonBuffer =
          consumeUntil(iterator, RegExp("^(xor|or|and)\$"));

      // Store operand
      String opType = iterator.current.value;
      if (opType == "and" || opType == "or" || opType == "xor") {
        operator = opType;
      } else {
        return Comparison.parse(comparisonBuffer);
      }
      var expressionBuffer;
      if (!iterator.moveNext()) {
        throw SyntaxError(iterator.current, "Empty token");
      } else {
        expressionBuffer = consumeFull(iterator);
      }

      // Evaluate expression
      var expression;
      if (operator == "or") {
        expression = OrOperator(Comparison.parse(comparisonBuffer),
            Expression.parse(expressionBuffer));
      } else if (operator == "xor") {
        expression = XorOperator(Comparison.parse(comparisonBuffer),
            Expression.parse(expressionBuffer));
      } else if (operator == "and") {
        expression = AndOperator(Comparison.parse(comparisonBuffer),
            Expression.parse(expressionBuffer));
      }

      checkNoMore(iterator);
      return expression;
    }
  }

  factory Expression.parsePrioritized(Iterable<Token> tokens) {
    var iterator = tokens.iterator;

    if (iterator.moveNext()) {
      // distinguish between Expression and Primary
      if (iterator.current.value == "(" && iterator.moveNext()) {
        final expressionBuffer =
            consumeUntil(iterator, RegExp("^" + RegExp.escape(")") + "\$"));
        if (iterator.current.value != ")") {
          throw SyntaxError(iterator.current, "')' expected");
        }

        checkNoMore(iterator);
        return Expression.parse(expressionBuffer);
      } else if (iterator.current != "(") {
        final primaryBuffer = consumeFull(iterator);
        return Primary.parse(primaryBuffer);
      } else {
        throw SyntaxError(iterator.current, "')' expected");
      }
    } else {
      throw SyntaxError(iterator.current, "Empty token");
    }
  }
}
