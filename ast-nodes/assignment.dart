import 'statement.dart';
import 'modifiable-primary.dart';
import 'expression.dart';
import '../print-utils.dart';
import '../lexer.dart';
import '../iterator-utils.dart';
import '../syntax-error.dart';



/// An assignment of the value on the right hand side ([rhs]) to the left hand side ([lhs]).
class Assignment implements Statement {
  ModifiablePrimary lhs;
  Expression rhs;

  Assignment(this.lhs, this.rhs);

  factory Assignment.parse(Iterable<Token> tokens) {
    var iter = tokens.iterator;

    if (tokens.isEmpty) {
      throw SyntaxError(iter.current, "Expected an assignment");
    }

    var tempLhs = consumeUntil(iter, RegExp(":\$"));

    if (tempLhs.isEmpty) {
      throw SyntaxError(iter.current, "Expected an identifier");
    }

    checkThis(iter, RegExp(':\$'), 'Expected ":="');
    checkNext(iter, RegExp('=\$'), 'Expected ":="');
    iter.moveNext();
    return Assignment(ModifiablePrimary.parse(tempLhs), Expression.parse(consumeFull(iter)));
  }

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('${prefix}Assignment', depth)
      + (this.lhs?.toString(depth: depth + 1, prefix: 'lhs: ') ?? '')
      + (this.rhs?.toString(depth: depth + 1, prefix: 'rhs: ') ?? '')
    );
  }
}