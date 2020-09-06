import 'node.dart';
import 'var-type.dart';
import '../print-utils.dart';

/// A routine parameter, characterized by the [name] and the [type].
class Parameter implements Node {
  String name;
  VarType type;

  Parameter(this.name, this.type);

  // TODO: implement .parse()

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('${prefix}Parameter("${this.name}")', depth)
      + (this.type?.toString(depth: depth + 1, prefix: 'type: ') ?? '')
    );
  }
}
