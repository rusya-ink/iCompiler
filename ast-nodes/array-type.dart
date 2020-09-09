import 'expression.dart';
import 'var-type.dart';
import 'variable-declaration.dart';
import '../lexer.dart';
import '../syntax-error.dart';
import '../iterator-utils.dart';
import '../print-utils.dart';

/// An array type with optional [size].
class ArrayType implements VarType {
  Expression size;
  VarType elementType;

  ArrayType(this.size, this.elementType);

  // TODO: implement .parse()

  factory ArrayType.parse(Iterable<Token> tokens) {
    var iterator = tokens.iterator;
    checkNext(iterator, RegExp('array\$'), "Expected 'array'");
    checkNext(iterator, RegExp('\\[\$'), "Expected '['");
    List<Token> expressionBody = consumeStackUntil(iterator, RegExp("\\["), RegExp("\\]"));
    checkNext(iterator, RegExp('\\]\$'), "Expected ']'");
    iterator.moveNext();
    List<Token> theType = consumeFull(iterator);
    
    if (theType.isEmpty) {
      throw SyntaxError(iterator.current, "Expected an array size");
    }

    var sizeParsed = Expression.parse(expressionBody);
    var typeParsed = VarType.parse(theType);

    return ArrayType(sizeParsed, typeParsed);
  }

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('${prefix}ArrayType(size = ${this.size})', depth)
      + (this.elementType?.toString(depth: depth + 1, prefix: 'element type: ') ?? '')
    );
  }
}
