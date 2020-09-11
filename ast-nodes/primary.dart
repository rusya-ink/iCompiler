import 'product.dart';
import '../lexer.dart';
import '../syntax-error.dart';
import 'node.dart';
import '../iterator-utils.dart';
import 'boolean-literal.dart';
import 'integer-literal.dart';
import 'real-literal.dart';
import 'modifiable-primary.dart';
/// An abstract value.
abstract class Primary implements Product {
  factory Primary.parse(Iterable<Token> tokens) {
    if (tokens.isEmpty) {
      throw SyntaxError(tokens.first, 'Expected a primary');
    }
    var iter = tokens.iterator;
    iter.moveNext();
    if (iter.current.value == 'true') {
      checkNoMore(iter);
      var bLBuffer = new BooleanLiteral(true)
      return bLBuffer;

    } else if (iter.current.value == 'false') {
      checkNoMore(iter);
      var bLBuffer = new BooleanLiteral(false)
      return bLBuffer;

    } else {
      var tempToken = consumeUntil(iter, RegExp('\D'));
      if (!tempToken.isEmpty && !RegExp('\D').hasMatch(iter.current.value)) {
        var iLBuffer = new IntegerLiteral(int.parse(tempToken));
        return iLBuffer;

      } else if (!tempToken.isEmpty && iter.current.value == '.') {
        checkNext(iter, RegExp('\d*\$'), "Expected real variable");
        var rLBuffer = new RealLiteral(double.parse(tempToken + '.' + iter.current.value));
        checkNoMore(iter);
        return rLBuffer;

      } else {
        return ModifiablePrimary.parse(tokens);
      }
    }
  }
}

