import 'primary.dart';
import '../print-utils.dart';

/// A literal integer number in code.
class IntegerLiteral implements Primary {
  int value;

  IntegerLiteral(this.value);

  // TODO: implement .parse()

  String toString({int depth = 0, String prefix = ''}) {
    return drawDepth('${prefix}IntegerLiteral(${this.value})', depth);
  }
}
