import 'statement.dart';
import 'modifiable-primary.dart';
import 'expression.dart';
import '../print-utils.dart';

/// An assignment of the value on the right hand side ([rhs]) to the left hand side ([lhs]).
class Assignment implements Statement {
  ModifiablePrimary lhs;
  Expression rhs;

  Assignment(this.lhs, this.rhs);

  // TODO: implement .parse()

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('${prefix}Assignment', depth)
      + (this.lhs?.toString(depth: depth + 1, prefix: 'lhs: ') ?? '')
      + (this.rhs?.toString(depth: depth + 1, prefix: 'rhs: ') ?? '')
    );
  }
}
