import 'node.dart';
import 'expression.dart';
import '../print-utils.dart';

/// An iteration range for the `for` loop.
class Range implements Node {
  Expression start;
  Expression end;

  Range(this.start, this.end);

  // TODO: implement .parse()

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('${prefix}Range', depth)
      + (this.start?.toString(depth: depth + 1, prefix: 'start: ') ?? '')
      + (this.end?.toString(depth: depth + 1, prefix: 'end: ') ?? '')
    );
  }
}
