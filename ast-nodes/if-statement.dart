import 'statement.dart';
import 'expression.dart';
import '../print-utils.dart';

/// A conditional statement.
class IfStatement implements Statement {
  Expression condition;
  List<Statement> blockTrue;
  List<Statement> blockFalse;

  IfStatement(this.condition, this.blockTrue, this.blockFalse);

  // TODO: implement .parse()

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('${prefix}IfStatement', depth)
      + (this.condition?.toString(depth: depth + 1, prefix: 'condition: ') ?? '')
      + drawDepth('true block:', depth + 1)
      + this.blockTrue.map((node) => node?.toString(depth: depth + 2) ?? '').join('')
      + drawDepth('false block:', depth + 1)
      + this.blockFalse.map((node) => node?.toString(depth: depth + 2) ?? '').join('')
    );
  }
}
