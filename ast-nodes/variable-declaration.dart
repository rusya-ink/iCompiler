import 'declaration.dart';
import 'var-type.dart';
import 'expression.dart';
import '../lexer.dart';
import '../print-utils.dart';

/// A variable declaration contains a [type] and the initial [value].
///
/// Both of these can be set to [null].
class VariableDeclaration extends Declaration {
  VarType type;
  Expression value;

  VariableDeclaration(name, this.type, this.value) : super(name);

  factory VariableDeclaration.parse(Iterable<Token> tokens) {
    // TODO: write the actual parser body
    return VariableDeclaration('dummy', null, Expression.parse(tokens));
  }

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('${prefix}VariableDeclaration("${this.name}")', depth)
      + (this.type?.toString(depth: depth + 1, prefix: 'type: ') ?? '')
      + (this.value?.toString(depth: depth + 1, prefix: 'value: ') ?? '')
    );
  }
}
