import 'declaration.dart';
import 'var-type.dart';
import '../lexer.dart';
import '../print-utils.dart';

/// A type declaration gives a name to some type [value].
class TypeDeclaration extends Declaration {
  VarType value;

  TypeDeclaration(name, this.value) : super(name);

  factory TypeDeclaration.parse(Iterable<Token> tokens) {
    // TODO: write the actual parser body
    return TypeDeclaration('dummy', null);
  }

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('${prefix}TypeDeclaration("${this.name}")', depth)
      + (this.value?.toString(depth: depth + 1) ?? '')
    );
  }
}
