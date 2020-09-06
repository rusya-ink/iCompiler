import 'declaration.dart';
import 'parameter.dart';
import 'var-type.dart';
import 'statement.dart';
import '../lexer.dart';
import '../print-utils.dart';

/// A routine declaration has [parameters], a [returnType] and a [body].
class RoutineDeclaration extends Declaration {
  List<Parameter> parameters;
  VarType returnType;
  List<Statement> body;

  RoutineDeclaration(name, this.parameters, this.returnType, this.body) : super(name);

  factory RoutineDeclaration.parse(Iterable<Token> tokens) {
    // TODO: write the actual parser body
    return RoutineDeclaration('dummy', null, null, null);
  }

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('${prefix}RoutineDeclaration("${this.name}")', depth)
      + drawDepth('parameters:', depth + 1)
      + this.parameters.map((node) => node?.toString(depth: depth + 2) ?? '').join('')
      + (this.returnType?.toString(depth: depth + 1, prefix: 'return type: ') ?? '')
      + drawDepth('body:', depth + 1)
      + this.body.map((node) => node?.toString(depth: depth + 2) ?? '').join('')
    );
  }
}
