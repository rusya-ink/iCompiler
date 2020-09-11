import 'primary.dart';
import '../lexer.dart';
import '../iterator-utils.dart';
import 'field-access.dart';
import 'variable.dart';
import 'index-access.dart';
import '../syntax-error.dart';
import 'expression.dart';

/// An abstract writable entity – something that can appear in the LHS of the assignment.
///
/// For example, a variable, a record field or an array slot.
abstract class ModifiablePrimary implements Primary {
  factory ModifiablePrimary.parse(Iterable<Token> tokens) {
    var iterator = tokens.iterator;
    ModifiablePrimary result;
    checkNext(iterator, RegExp('[a-zA-Z_]\\w*\$'), "Expected identifier");
    result = Variable(iterator.current.value);

    while (iterator.moveNext()) {
      if (iterator.current.value == ".") {
        checkNext(iterator, RegExp('[a-zA-Z_]\\w*\$'), "Expected identifier");
        result = FieldAccess(iterator.current.value, result);
      } else if (iterator.current.value == "[") {
        var exp = Expression.parse(
            consumeStackUntil(iterator, RegExp('\\[\$'), RegExp('\\]\$')));
        result = IndexAccess(exp, result);
      } else {
        throw SyntaxError(iterator.current, "Unexpected token");
      }
    }
    return result;
  }
}
