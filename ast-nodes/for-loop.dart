import 'statement.dart';
import 'variable.dart';
import 'range.dart';
import '../print-utils.dart';

/// A `for` loop.
class ForLoop implements Statement {
  Variable loopVariable;
  Range range;
  List<Statement> body;

  ForLoop(this.loopVariable, this.range, this.body);

  // TODO: implement .parse()

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('ForLoop', depth)
      + (this.loopVariable?.toString(depth: depth + 1, prefix: 'loop variable: ') ?? '')
      + (this.range?.toString(depth: depth + 1, prefix: 'range: ') ?? '')
      + drawDepth('body:', depth + 1)
      + this.body.map((node) => node?.toString(depth: depth + 2) ?? '').join('')
    );
  }
}
