import 'index.dart';
import '../lexer/token.dart';
import '../utils/index.dart';
import '../errors/index.dart';

/// An abstract statement.
abstract class Statement implements Node {
  factory Statement.parse(Iterable<Token> tokens) {
    var iter = tokens.iterator;
    if (!iter.moveNext()) {
      throw SyntaxError(iter.current, 'Expected a statement');
    }

    if (iter.current.value == 'while') {
      return WhileLoop.parse(tokens);
    } else if (iter.current.value == 'for') {
      return ForLoop.parse(tokens);
    } else if (iter.current.value == 'if') {
      return IfStatement.parse(tokens);
    } else if (iter.current.value == 'return') {
      return ReturnStatement.parse(tokens);
    } else if (iter.current.value == 'var') {
      return VariableDeclaration.parse(tokens);
    } else if (iter.current.value == 'type') {
      return TypeDeclaration.parse(tokens);
    }
    if (!iter.moveNext()) {
      throw SyntaxError(iter.current, 'Expected a statement');
    }
    if (iter.current.value == '(') {
      return RoutineCall.parse(tokens);
    }
    consumeUntil(iter, RegExp(':=\$'));
    if (iter.current?.value == ':=') {
      return Assignment.parse(tokens);
    } else {
      throw SyntaxError(iter.current, 'Expected a statement');
    }
  }

  static List<Statement> parseBody(Iterable<Token> tokens) {
    var iterator = tokens.iterator;
    var statements = <Statement>[];

    var hadSemicolonBefore = false;
    var blockStarters = ['record', 'if', 'while', 'for'];
    while (iterator.moveNext()) {
      var statementTokens = <Token>[];
      var blockCount = 0;
      do {
        if (blockStarters.contains(iterator.current.value)) {
          blockCount++;
        } else if (iterator.current.value == 'end') {
          blockCount--;
        }
        if ((iterator.current.value == ';' || iterator.current.value == '\n') &&
            blockCount == 0) {
          break;
        }

        statementTokens.add(iterator.current);
      } while (iterator.moveNext());

      if (statementTokens.isEmpty) {
        if (iterator.current.value == ';' && hadSemicolonBefore) {
          throw SyntaxError(iterator.current, 'Expected statement');
        } else {
          continue;
        }
      }

      statements.add(Statement.parse(statementTokens));
    }

    return statements;
  }
}
