import 'statement.dart';
import 'expression.dart';
import '../print-utils.dart';

/// A `while` loop.
class WhileLoop implements Statement {
  Expression condition;
  List<Statement> body;

  WhileLoop(this.condition, this.body);

  // TODO: implement .parse()

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('${prefix}WhileLoop', depth)
      + (this.condition?.toString(depth: depth + 1, prefix: 'condition: ') ?? '')
      + drawDepth('body:', depth + 1)
      + this.body.map((node) => node?.toString(depth: depth + 2) ?? '').join('')
    );
  }
}
