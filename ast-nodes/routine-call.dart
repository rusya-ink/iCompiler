import 'primary.dart';
import 'expression.dart';
import '../print-utils.dart';

/// A routine call by [name], passing zero or more [arguments].
class RoutineCall implements Primary {
  String name;
  List<Expression> arguments;

  RoutineCall(this.name, this.arguments);

  // TODO: implement .parse()

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('${prefix}RoutineCall("${this.name}")', depth)
      + drawDepth('arguments:', depth + 1)
      + this.arguments.map((node) => node?.toString(depth: depth + 2) ?? '').join('')
    );
  }
}
